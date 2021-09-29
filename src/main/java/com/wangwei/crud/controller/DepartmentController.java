package com.wangwei.crud.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.wangwei.crud.bean.Department;
import com.wangwei.crud.bean.Employee;
import com.wangwei.crud.bean.Msg;
import com.wangwei.crud.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**这个是专门查出这个部门信息的
 * @author WangWei
 * @create 2021-09-28 21:20
 */
@Controller
public class DepartmentController {
    @Autowired
    DepartmentService departmentService;

    @RequestMapping("/depts")
    @ResponseBody
    public Msg getEmps(){
        List<Department> all = departmentService.getAll();

        return Msg.success().add("depts",all);
    }
}
