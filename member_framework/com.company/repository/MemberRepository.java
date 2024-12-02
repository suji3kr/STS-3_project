package com.company.repository;

import org.springframework.stereotype.Repository;

import com.company.dto.MemberDTO;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class MemberRepository {
	public int save(MemberDTO memberDTO) {
		System.out.println("memberDTO =" + memberDTO);
		return 0;
	}

}
