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
public class SampleServiceTxTests {
	
	@Setter(onMethod_=@Autowired)
	private SampleTxService service;
	
	@Test
	public void testClass() {
		log.info("" + service); //서비스 객체 생성 완료 / INFO : com.green.service.SampleServiceTests - com.green.service.SampleServiceImpl@7ceb3185
		log.info("" + service.getClass().getName()); //proxy 생성 /INFO : com.green.service.SampleServiceTests - com.sun.proxy.$Proxy20
	}
	
	@Test
	public void testLong() {
		String str = "Starry\r\n" +
	"Starry night\r\n" +
	"Paint your palette blue and grey\r\n" +
	"Look out a summer's day" ;
		
		//log.info("" + str.getBytes().length);
		log.info(str);
		
		service.addData(str);
	}

}
