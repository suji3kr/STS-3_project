package com.company.service;

import org.springframework.stereotype.Service;

import com.company.dto.MemberDTO;
import com.company.repository.MemberRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MemberService {
	private final MemberRepository memberRepository;
	
	public int save(MemberDTO memberDTO) {
		return memberRepository.save(memberDTO);
	}

}
