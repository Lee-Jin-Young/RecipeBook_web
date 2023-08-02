package com.young.recipebook.users.dao;

import com.young.recipebook.users.dto.UsersDto;

public interface UsersDao {
	public int isExist(String id);
	public void insert(UsersDto dto);
	public UsersDto getData(String id);
	public void updatePwd(UsersDto dto);
	public void update(UsersDto dto);
	public void delete(String id);
}
