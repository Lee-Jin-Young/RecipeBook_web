package com.young.recipebook.users.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.young.recipebook.users.dto.UsersDto;

@Repository
public class UsersDaoImpl implements UsersDao {
	@Autowired
	private SqlSession session;
	
	// 중복확인
	@Override
	public int isExist(String id) {
		//DB에 저장된 같은 아이디가 0이면 존재하지 않는 아이디
		return session.selectOne("users.isExist", id);
	}

	// 회원 정보 저장
	@Override
	public void insert(UsersDto dto) {
		session.insert("users.insert", dto);	
	}

	// 아이디에 해당하는 정보 리턴
	@Override
	public UsersDto getData(String id) {
		return session.selectOne("users.getData", id);
	}

	// 비밀번호 수정
	@Override
	public void updatePwd(UsersDto dto) {
		session.update("users.updatePwd", dto);
	}

	// 개인정보 수정
	@Override
	public void update(UsersDto dto) {
		session.update("users.update", dto);
	}

	// 회원정보 삭제
	@Override
	public void delete(String id) {
		session.delete("users.delete", id);
	}

}
