package com.example.loginbackend.Mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.example.loginbackend.Entiy.Admin;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface AdminMapper extends BaseMapper<Admin> {
}
