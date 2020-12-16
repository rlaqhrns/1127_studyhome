package com.green.service;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;
import lombok.extern.slf4j.Slf4j;

@RunWith(SpringJUnit4ClassRunner.class)
@Slf4j
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
public class SampleServiceTests {
	
	@Setter(onMethod_=@Autowired)
	private SampleService service;
	
	@Test
	public void testClass() {
		log.info("" + service); //서비스 객체 생성 완료 / INFO : com.green.service.SampleServiceTests - com.green.service.SampleServiceImpl@7ceb3185
		log.info("" + service.getClass().getName()); //proxy 생성 /INFO : com.green.service.SampleServiceTests - com.sun.proxy.$Proxy20
	}
	
	@Test
	public void testAdd() throws Exception{
		log.info("" + service.doAdd("123", "465"));
		//doAdd 메서드 실행(jointPoint)와
		//advice(log.info("================"); 를 결합한 proxy생성되어 로직과 코드를 분리함 
		//advice는 한번 만들어 놓고 로지막만 집중할 수 있어 코드 관리가 수월함 
		//매번 log.info를 비즈니스 로직에 추가하면 코드 가독성이 떨어지고 코드 관리가 어려움
	
	}
	
	@Test
	public void testAddError() throws Exception {
		log.info("" + service.doAdd("123", "ABC")); //이 때 숫자로 변환하지 못하면 예외가 던져짐 
	}
	

}
