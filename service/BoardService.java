package com.green.service;

import java.util.List;

import com.green.domain.BoardVO;
import com.green.domain.Criteria;

public interface BoardService {
	public void register(BoardVO board); //insert(mapper)
	public BoardVO get(Long bno);// read(mapper) 
	public boolean modify(BoardVO board);// update(mapper)
	public boolean remove(Long bno);// delete(mapper) 
	//public List<BoardVO> getList(); //동일 
	public List<BoardVO> getList(Criteria cri);
}
