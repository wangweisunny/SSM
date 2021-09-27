package com.wangwei.crud.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.wangwei.crud.bean.Employee;
import com.wangwei.crud.bean.Msg;
import com.wangwei.crud.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * 处理员工的增删改查请求
 * @author WangWei
 * @create 2021-09-26 19:15
 */

@Controller
public class EmployeeController {
    /*我们要在这里调用service层的业务组件*/
    @Autowired
    EmployeeService employeeService;
    /*员工查询，分页查询*/

    /*使用Ajax和json对象对数据进行封装和发送*/
    @RequestMapping("/emps")
    @ResponseBody
    public Msg getEmps(@RequestParam(value = "pn",defaultValue = "1")Integer pn){
        PageHelper.startPage(pn,5);
        List<Employee> emps =  employeeService.getAll();
        PageInfo<Employee> page = new PageInfo<>(emps, 5);
        return Msg.success().add("page",page);
        /*但是我们拿到的数据怎么办呢？我们可以来一个链式的存储方式*/
    }



//    @RequestMapping("/emps")
    public String getEmps(@RequestParam(value = "pn",defaultValue = "1")Integer pn, Model model){
        /*这个时候不是分页，用插件
        * 在查询之前调用一下相应方法，然后，传入分页页码和分页大小即可
        * startPage后紧跟的查询，就算一个分页查询*/
        PageHelper.startPage(pn,5);
        List<Employee> emps =  employeeService.getAll();
        /*查询出来之后，我们使用pageInfo来包装我们的结果
        * 想要设置连续传入几页，再list传入的时候，直接在后面
        * 传入个数字就行了。*/
        PageInfo page = new PageInfo(emps,5);
        /*因为这个page里面就由我们想要的信息，所以
        * 我们直接把这个page交给页面就行了*/
        model.addAttribute("page",page);

        return "list";
    }
}
