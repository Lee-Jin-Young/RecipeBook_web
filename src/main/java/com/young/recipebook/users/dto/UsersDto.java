package com.young.recipebook.users.dto;

import org.apache.ibatis.type.Alias;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data //setter, getter
@Builder //chain형태로 값을 넣을수 있게 함
@NoArgsConstructor // 디폴트 생성자
@AllArgsConstructor // 모든 값을 인자로 가지는 생성자
@Alias("usersDto")
public class UsersDto {
	private String id;
	private String pwd;
	private String email;
	private String profile;
	private String regdate;
	private String newPwd;
}
