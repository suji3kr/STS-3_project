
--------------------------------------------------------------------------------------------------------------
</br></br>
## ***.Spring Framework***
####  -> 트라이 앵글 
![화면 캡처 2024-11-27 120341](https://github.com/user-attachments/assets/d47319f0-da15-49e6-9bef-bd14303ee5f9)

DI / IoC  <br>
PSA <br>
AOP(관점지향)   -  OOP(객체지향프로그래밍) <br> 

</br></br><br>



### 1. 제어 역전 (IoC, Inversion of Control)
<br><br>
>*  IoC 컨테이너는 ApplicationContext와 BeanFactory를 통해 Bean(스프링 IoC 컨테이너가 관리하는 객체)을 관리합니다. <br>
빈 설정 소스를 읽어 빈을 정의하고, 의존 관계를 설정하여 객체를 주입합니다. <br><br>
>* 싱글톤 빈 관리: 기본적으로 빈을 싱글톤으로 제공하여, 동일한 객체가 여러 번 생성되지 않도록 하고 서버의 부담을 줄입니다.<br>
>* 생명 주기 관리: 스프링 IoC 컨테이너가 빈의 생명 주기를 관리하며, 이를 통해 객체의 생성, 초기화, 소멸 과정에서 부가적인 처리를 할 수 있습니다.<br>

<br>

개발자가 객체를 생성하고 사용

          @Service
          public class PostService {
          	private final PostRepository postRepository = new PostRepository();
          
          	public void test() {
          		postRepository.findById(1L);
          	}
          }

<br>

스프링이 객체를 생성/관리하고, @Autowired를 통해 객체를 주입 -의존성


          @Repository
          public class PostRepository {
          }
          @Service
          public class PostService {
          	private final PostRepository postRepository;
          
          	@Autowired
          	public PostService(PostRepository postRepository) {
          		this.postRepository = postRepository;
          	}
          }

<br><br>

constructor 주입 → 권장

처음 애플리케이션이 실행되는 시점에 의존성이 한 번에 주입되고 끝난다.
생성자가 1개만 있으면 @Autowired는 생략 가능하다.


#### 프레임워크와 라이브러리 <br>
>* 프레임워크는 애플리케이션의 흐름을 프레임워크가 주도하며, 개발자는 그 흐름에 맞춰 애플리케이션을 작성합니다. <br>
즉, 제어의 역전(IoC) 개념이 적용되어, 개발자가 아닌 프레임워크가 애플리케이션의 흐름을 관리합니다. 이를 통해 소프트웨어 생산성과 품질을 높일 수 있습니다.
>* 라이브러리는 개발자가 직접 제어하는 애플리케이션 흐름에서 필요한 기능을 필요할 때 호출하는 도구들의 모음입니다. <br>
라이브러리는 애플리케이션 흐름을 방해하지 않고 필요한 시점에만 기능을 제공합니다.

<br><br><br><br><br>

     
### 2. 관점 지향 프로그래밍 (AOP, Aspect Oriented Programming) <br>
>* 로직이나 기능을 하나의 aspect(관점)으로 보고 이 관심사을 각각 모듈화하여 프로그래밍한다. <br>
부가 기능을 핵심 비즈니스 로직으로부터 분리하여 하나의 별도의 모듈로 만들고 필요한 곳에 조립하여 사용한다. <br> 
Transaction, Logging, Security 같은 여러 모듈에서 공통적으로 사용하는 기능 <br>
코드를 단순하고 깔끔하게 작성할 수 있다. <br>


![화면 캡처 2024-11-27 121129](https://github.com/user-attachments/assets/a769e3e1-d3ba-4692-a299-325e0c2d5cf9)
<br>

트랜잭션 @Transactional 어노테이션
          Connection connection = dataSource.getConnection();
          
          public sendMoney() {
          	try (connection) {
          
          		connection.setAutoCommit(false);
          
          		// business logic
          
          		connection.commit();
          
          	} catch (SQLException e) {
          		connection.rollback();
          	}
          }
          
  <br><br>

  
          @Transactional
          public sendMoney() {
          	// business logic
          }

          
- 메서드 실행시간 재기 <br>
모든 메서드의 시작과 끝에 시간, 로깅 관련 코드를 삽입해주어야하지만 별도의 애너테이션으로 분리하여 각 메서드가 중복 코드 없이 핵심 로직만을 가지고 할 수 있다.


<br><br><br><br><br>

### 3. 추상화 서비스(PSA, Portable Service Abstraction) <br>

####
* ##### Service Abstraction: <br>
   추상화 계층을 사용해 어떤 기술을 내부에 숨기고 개발자에게 편의성을 제공하는 것 <br>
* ##### PSA: <br>
  service abstraction으로 제공되는 기술을 다른 기술 스택으로 간편하게 바꿀 수 있는 확장성을 가졌다. <br> <br>

<br>

>* Service Abstraction: 추상화 계층을 사용해 어떤 기술을 내부에 숨기고 개발자에게 편의성을 제공하는 것 <br>
PSA: service abstraction으로 제공되는 기술을 다른 기술 스택으로 간편하게 바꿀 수 있는 확장성을 가졌다. <br>
특정 기술에 직접적 영향을 받지 않도록 스프링에서 동작하는 라이브러리들은 POJO 원칙을 기반으로 추상화된 layer를 가진다. <br> 
서로 다른 외부 라이브러리들에 대해 스프링은 동일한 인터페이스로 동일한 구동이 가능하게끔 설계되어서 의존성을 고려할 필요가 없다. <br>

<br>

![화면 캡처 2024-11-27 121058](https://github.com/user-attachments/assets/79ffc525-cd28-4c0d-94b8-62d2ba1a576f)

<br>

##### Spring Web MVC
servlet을 로우 레벨에서 직접 구현할 필요가 없다. <br>
HttpServlet의 doGet(), doPost() 대신 @GettMapping, @PostMapping을 통해 요청을 처리한다. <br>
로직 변경 없이 web에서 webflux로 의존성만 바꿈으로써 Tomcat이 아닌 netty 로 서버를 실행할 수 있다. <br>
<br>
##### Spring Transaction
commit(), rollback()을 명시적으로 호출하지 않아도 어노테이션을 붙이면 트랜잭션 처리가 이루어진다. <br>
기존 코드 변경 없이 트랜잭션을 처리하는 구현체를 JDBC, JPA, Hibernate 등으로 유연하게 바꿀 수 있다.  <br>
##### Spring Cache
@Cacheable

<br><br>

--------------------------------------------------------------------------------------------------------------
</br></br>
## ***.Anotation @***
####  클래스/메서드 주입 
  @Bean
  @Component
  
#### 필드 주입
  @Autowried

<br>

* ##### org.mybatis.spring은 mybatis를 스프링에서 POJO로 사용할 수 있게끔 추상화한 패키지이다. <br>
* ##### spring mvc에서의 service abstraction : @Controller,@RequestMapping,,, <br>
* ##### @Transactional : 트랜잭션의 대표 속성 all or nothing 기능을 이 어노테이션으로 트랜잭션 처리가 가능. <br>
* ##### 스프링 캐시 @Cacheable , @CacheEvict,,, <br> 
* ##### 네티, 톰캣,제티,언더토우,, <br>
* ##### Servlet, Reactive,,, <br>


<br><br>

---------------------------------------------------------------------------------------------------------------
</br></br>
### ***.버전 정리***

####
* ##### JSP:
8090  8005    /  톰캣10  -> 자바 17  <br>
* ##### Spring: 
8092  8007  /  톰캣 9  -> 자바 11 <br>
* ##### Spring Boot: 
8094   8009  /  자체톰캣  -> 자바 17  / 부트 3.x <br> 

윈도우 11 -> 64bit - 유니코드 -> 보안성 향상


<br><br><br> 

* #### 단위 테스트 <br>
##### xUnit -> jUnit
##### given  -  when -  then
##### 모키토 - Mock


<br><br>
