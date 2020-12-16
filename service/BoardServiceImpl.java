package com.green.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.green.domain.BoardVO;
import com.green.domain.Criteria;
import com.green.mapper.BoardMapper;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@AllArgsConstructor
public class BoardServiceImpl  implements BoardService{
	private BoardMapper mapper;

//	@Override
//	public List<BoardVO> getList() { 
//		log.info("여러개의 목록 가져오기 ........" );
//		return mapper.getList(); 
//	}

	@Override
	public void register(BoardVO board) {
		log.info("서비스에서 등록 ....." +board);
		mapper.insertSelectKey(board); //확인
	}

	@Override
	public BoardVO get(Long bno) {
		log.info("서비스에서 하나얻어오기 ....." +bno);
		return mapper.read(bno);
	}

	@Override
	public boolean modify(BoardVO board) {
		log.info("서비스에서 수정 ....." +board);
		return mapper.update(board) ==1;
	}

	@Override
	public boolean remove(Long bno) {
		log.info("서비스에서 삭제 ....." +bno);
		return mapper.delete(bno) == 1; 
	}

	@Override
	public List<BoardVO> getList(Criteria cri) {
		// TODO Auto-generated method stub
		log.info("Criteria로 서비스에서 데이터 전체 조회" + cri);
		return mapper.getListWithPaging(cri);
	}

}
