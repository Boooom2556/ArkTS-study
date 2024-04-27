package com.example.loginbackend.Service.Impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.example.loginbackend.Entiy.Admin;
import com.example.loginbackend.Mapper.AdminMapper;
import com.example.loginbackend.Service.AdminService;
import org.springframework.stereotype.Service;

@Service
public class AdminServiceImpl extends ServiceImpl<AdminMapper, Admin> implements AdminService {
}
