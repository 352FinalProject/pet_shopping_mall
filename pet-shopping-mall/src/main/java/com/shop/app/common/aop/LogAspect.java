package com.shop.app.common.aop;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.Signature;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Pointcut;

import lombok.extern.slf4j.Slf4j;

/**
 * 
 * Aspect
 *  - advice와 pointcut을 작성하는 클래스
 *  
 * Advice종류
 * - @Around joinPoint 앞뒤
 * - @Before joinPoint 앞
 * - @AfterReturning joinPoint뒤(반환값에 접근 가능)
 * - @After joinPoint뒤 (정상처리/오류발생시 모두 실행)
 * - @AfterThrowing joinPoint에서 예외가 발생한 경우만 실행
 *
 */
// @Component
// @Aspect 
@Slf4j
public class LogAspect {
	
	/**
	 * joinPoint 지정하는 표현식
	 */
	@Pointcut("execution(* com.shop.app..*(..))")
	public void pointcut() {} 
	
	/**
	 * Advice 실행될 부가로직
	 * 
	 * @param joinPoint
	 * @return
	 * @throws Throwable
	 */
	@Around("pointcut()")
	public Object log(ProceedingJoinPoint joinPoint) throws Throwable {
		// joinPoint 정보 가져오기
		Signature signature = joinPoint.getSignature();
		String type = signature.getDeclaringTypeName(); // 클래스이름
		String methodName = signature.getName(); // 메소드 이름
		
		// joinPoint 실행전
		log.debug("[Before] {}.{}", type, methodName);
		
		Object returnValue = joinPoint.proceed();
		// joinPoint 실행후
		log.debug("[After] {}.{}", type, methodName);
		
		return returnValue;
	}
	
}
