package com.company.aop;

import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.stereotype.Component;

import lombok.extern.log4j.Log4j;

@Aspect
@Log4j
@Component
public class LogAdvice {
	
	                    /* 괄호안에 공백 중요 */
	@Before( "execution(* com.company.service.SampleService*.*(..))")
	public void logBefore() {
		log.info("===================================");
	}

}
