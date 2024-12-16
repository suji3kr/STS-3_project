<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
    /* 업로드 결과 스타일 */
	.uploadResult {
		width: 100%;
		background-color: skyblue;
	}
	
	/* 업로드된 파일 목록 스타일 */
	.uploadResult ul {
		display: flex;
		flex-flow: row;
		justify-content: center;
		align-items: center;
	}
	
	/* 업로드된 파일 항목 스타일 */
	.uploadResult ul li {
		list-style: none;
		padding: 10px;
		align-content: center;
		text-align: center;
	}
	
	/* 업로드된 이미지 크기 스타일 */
	.uploadResult ul li img {
		width: 100px;
	}
	
	/* 업로드된 파일 이름과 삭제 버튼 스타일 */
	.uploadResult ul li span {
		color: white;
	}

	/* 이미지 클릭 시 확대되는 영역 스타일 */
	.bigPictureWrapper {
		position: absolute;
		display: none;
		justify-content: center;
		align-content: center;
		top: 0%;
		width: 100%;
		height: 100%;
		background-color: gray;
		z-index: 100;
		background: rgba(255,255,255,0.5);
	}

	/* 확대된 이미지 스타일 */
	.bigPicture {
		position: relative;
		display: flex;
		justify-content: center;
		align-item: center;
	}
	
	/* 확대된 이미지 크기 설정 */
	.bigPicture img {
		width:600px;
	}
	
</style>

<title>Upload with Ajax</title>
</head>
<body>
	<h1>Upload with Ajax</h1>
	
	<!-- 파일 업로드 입력란 -->
	<div class='uploadDiv'>
		<input type='file' name='uploadFile' multiple> <!-- multiple 속성으로 여러 파일 선택 가능 -->
	 </div>
	
	<!-- 업로드 결과를 표시할 영역 -->
	 <div class='uploadResult'>
	 	<ul>
	 	</ul>
	 </div>
	 <!-- 업로드 버튼 -->
	<button id='uploadBtn'>Upload</button>
	
	<!-- 이미지 클릭 시 확대될 영역 -->
	<div class='bigPictureWrapper'>
		<div class ='bigPicture'>
		</div>
	</div>
	
	
	
	<!-- jQuery 라이브러리 불러오기 -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	
	<script>
	
		// 이미지 확대 보기 기능
		function showImage(fileCallPath){
			// 화면에 이미지 확대 영역을 표시
			$(".bigPictureWrapper").css("display","flex").show();
		
			// 확대된 이미지를 클릭하면 다시 원래 크기로 축소
			$(".bigPictureWrapper").on("click", function(e){
				$(".bigPicture").animate({width: '0%', height: '0%'}, 1000);
				setTimeout(() => {
					$(this).hide();
				}, 1000);
			});   
			
			$(".bigPicture")
			.html("<img src='/display?fileName="+ encodeURI(fileCallPath)+"'>")
			.animate({width:'50%', height: '50%'}, 1000); // 1초 안에 이미지 확대
		}
		
		$(document).ready(function(){
			
			// 업로드 가능한 파일 확장자 및 최대 크기 설정
			let regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$"); // 특정 확장자는 제외
            let maxSize = 5242880; // 최대 파일 크기: 5MB
			
			// 파일 확장자와 크기 체크 함수
			function checkExtension(fileName, fileSize){
				if(fileSize >= maxSize){
					alert("파일 사이즈 초과");
					return false;
				}
				if(regex.test(fileName)){
					alert("해당 종류의 파일은 업로드할 수 없습니다.");
					return false;
				}
				return true;
			}
            
            // 업로드된 파일을 다시 선택할 수 있도록 하는 기능
            let cloneObj =$(".uploadDiv").clone();
		
			// 업로드 버튼 클릭 시 실행되는 코드
			$("#uploadBtn").on("click", function(e){
				
				// FormData 객체 생성 (파일 전송을 위한 객체)
				let formData  = new FormData();
				
				// 업로드 파일 입력 요소 선택
				let inputFile = $("input[name='uploadFile']");
			
				// 선택된 파일들
				let files = inputFile[0].files;
				
				console.log(files);
				
				// 파일을 FormData에 추가
				for(let i=0; i<files.length; i++){
 					// 확장자와 크기 체크
					if(!checkExtension(files[i].name, files[i].size)){
						return false;
					} 
					
					console.log(files[i].name);
					
					// 파일을 FormData에 추가
					formData.append("uploadFile", files[i]);
				}
				
				// Ajax를 이용하여 파일 업로드
				  $.ajax({ 
					    url: '/uploadAjaxAction',  // 파일을 보낼 URL
					    processData: false,  // 데이터 처리 방식을 false로 설정
					    contentType: false,  // 콘텐츠 타입을 false로 설정 (FormData는 자동으로 설정)
		                data: formData,  // 보낼 데이터
		                type: 'POST',  // 요청 방식: POST
		                datatype:'json',  // 응답 타입
		                success : function(result){
		                	
	              console.log("result", result);
	                	
	                	// 업로드된 파일 리스트 화면에 표시
	              showUploadedFile(result);
	                	
	                	// 업로드 후 파일 선택 영역 초기화
	              $(".uploadDiv").html(cloneObj.html());
	                 alert("Uploaded");  // 업로드 완료 알림
		          }
			   }); //$.ajax

			});
			
			// 업로드된 파일 리스트에서 삭제 버튼 클릭 시 실행되는 코드
			$(".uploadResult").on("click","span", function(e){
				
				// 삭제할 파일의 경로와 타입
				let targetFile = $(this).data("file");
				let type = $(this).data("type");
				console.log(targetFile);
				
				// Ajax로 파일 삭제 요청
				$.ajax({
					url: '/deleteFile',
					data: {fileName: targetFile, type: type},
					dataType: 'text',
					type: 'POST',
						success: function(result){
							alert(result);  // 삭제 결과 알림
						}
				}); //$.ajax
			});
			
			// 업로드된 파일을 화면에 표시하는 함수
			let uploadResult = $(".uploadResult ul");
			
			function showUploadedFile(uploadResultArr) {
					
				let str = "";
					
					// 업로드된 파일 목록을 순차적으로 처리
				$(uploadResultArr).each(function(i, obj){
						
				    if(!obj.image){
				        // 이미지가 아닌 파일의 경우
				        let fileCallPath = encodeURIComponent(obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName);
				        
				        let fileLink = fileCallPath.replace(new RegExp(/\\/g),"/");  // 경로 구분자를 /로 변경
				        
				        // 파일 목록에 항목 추가
				        str += "<li><div><a href='/download?fileName=" + fileCallPath + "'>"
				            + "<img src='/resources/img/attach.png'>"  // 파일 아이콘
				            + obj.fileName + "</a>" + "<span data-file=\'"+fileCallPath+"\' data-type='file'> x </span>"
				        	+"</div></li>";
				    } else {
				        // 이미지 파일인 경우, 썸네일과 원본 파일 경로 처리
				        let fileCallPath = encodeURIComponent(obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName); 
				        
				        let originPath = obj.uploadPath + "\\" + obj.uuid + "_" + obj.fileName;
				        originPath = originPath.replace(new RegExp(/\\/g),"/");  // 경로 구분자를 /로 변경
				        
				        // 이미지 파일 클릭 시 확대 보기 함수 호출
				        str +="<li><a href=\"javascript:showImage(\'" + originPath + "\')\">"
				        	+"<img src='/display?fileName="+ fileCallPath +"'></a>" + "<span data-file=\'"+ fileCallPath +"\'data-type='image'> x </span>" + "</li>";
				    }
				});
					// 화면에 업로드된 파일 표시
					uploadResult.append(str);
			}
		});
	</script>
	
</body>
</html>
