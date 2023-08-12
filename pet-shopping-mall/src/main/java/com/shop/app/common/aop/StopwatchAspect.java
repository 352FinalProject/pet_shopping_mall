package com.shop.app.common.aop;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.stereotype.Component;
import org.springframework.util.StopWatch;

import lombok.extern.slf4j.Slf4j;

/**
 * todo 할일 생성 기능의 소요시간을 측정할 수 있는 aspect를 작성하세요.
 * - spring이 제공하는 StopWatch 클래스 사용할 것.
 * 
 */
@Aspect
@Component
@Slf4j
public class StopwatchAspect {

	@Pointcut("execution(* com.shop.app..*Controller.create*(..))")
	public void pointcut() {}
	
	@Around("pointcut()")
	public Object advice(ProceedingJoinPoint joinPoint) throws Throwable {
		// 조인포인트 실행전 Start
		StopWatch stopwatch = new StopWatch();
		stopwatch.start();
		// 조인포인트 실행
		Object returnValue = joinPoint.proceed();
		// 조인포인트 실행후 Stop 
		// 소요시간 계산
		stopwatch.stop();
		long millis = stopwatch.getTotalTimeMillis();
		log.debug("실행시간 = {}ms", millis);
		
		return returnValue;
	}
}
