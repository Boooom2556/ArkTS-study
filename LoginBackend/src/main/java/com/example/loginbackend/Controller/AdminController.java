package com.example.loginbackend.Controller;

import com.example.loginbackend.Entiy.Admin;
import com.example.loginbackend.Entiy.Result;
import com.example.loginbackend.Mapper.AdminMapper;
import com.example.loginbackend.Service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/admin")
public class AdminController {
    @Autowired
    private AdminService adminService;
    //查询
    @GetMapping("/list")
    public List<Admin> list(){
        return adminService.list();
    }

    //新增
    @PostMapping("/save")
    public Result save(@RequestBody Admin admin) {
        return adminService.save(admin) ? Result.suc() : Result.fail();
    }
    //登录
    @PostMapping("/login")
    public Result login( Admin admin){
        List list = adminService.lambdaQuery()
                .eq(Admin::getUsername,admin.getUsername())
                .eq(Admin::getPassword,admin.getPassword()).list();
        return list.size()>0?Result.suc(list.get(0)):Result.fail();
    }
}
