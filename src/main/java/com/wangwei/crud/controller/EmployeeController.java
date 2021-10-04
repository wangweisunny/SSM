package com.wangwei.crud.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.wangwei.crud.bean.Employee;
import com.wangwei.crud.bean.Msg;
import com.wangwei.crud.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

    /*查询数据库,检查方法*/
    @RequestMapping("/check")
    @ResponseBody
    public Msg check(@RequestParam("name") String name){
        //先判断用户名是否是合法的表达式;
        String regx = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})";
        if(!name.matches(regx)){
            return Msg.fail().add("va_msg", "用户名必须是6-16位数字和字母的组合或者2-5位中文");
        }
        Boolean check = employeeService.check(name);
        System.out.println(name);
        if(check){
            return Msg.success();
        }else {
            return Msg.fail().add("va_msg", "用户名不可用!!");
        }
    }
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


    /**
     * 员工保存
     * 1、支持JSR303校验
     * 2、导入Hibernate-Validator
     */
    @RequestMapping(value = "/emp",method = RequestMethod.POST)
    @ResponseBody
    /*注意,我们传入的东西是直接进行封装的
    * Valid:这个注解是帮助你检查校验是否成功的，BindingResult：这个能帮助你获取
    * 校验失败的信息*/
    public Msg addEmp(@Valid Employee employee, BindingResult result){
        if(result.hasErrors()){
            //校验失败，应该返回失败，在模态框中显示校验失败的错误信息
            Map<String, Object> map = new HashMap<>();
            List<FieldError> errors = result.getFieldErrors();
            for (FieldError fieldError : errors) {
                /*获取出现校验失败的字段信息*/
                System.out.println("错误的字段名："+fieldError.getField());
                /*这个是出现校验失败之后，错误的信息情况*/
                System.out.println("错误信息："+fieldError.getDefaultMessage());
                map.put(fieldError.getField(), fieldError.getDefaultMessage());
            }
            return Msg.fail().add("errorFields", map);
        }else{
            employeeService.save(employee);
            return Msg.success();
        }
    }


    /*写一个方法处理这个请求，获取单个员工对象的请求*/
    @ResponseBody
    @RequestMapping(value = "/emp/{id}",method = RequestMethod.GET)
    /*通过这个 PathVariable这个注解进行路径上的参数获取*/
    public Msg getEmp(@PathVariable("id") Integer id){
        Employee employee = employeeService.getEmp(id);
        return Msg.success().add("emp",employee);
    }

    /*写一个方法，这个方法是进行保存的修改的操作
    * empId，只有这样的时候，才能把这个路径上的id封装进去。
    *
     * 如果直接发送ajax=PUT形式的请求
     * 封装的数据
     * 因为put请求无法进行数据的封装，然后我们就会获得null值
     * Employee
     * [empId=1014, empName=null, gender=null, email=null, dId=null]
     *
     * 问题：
     * 请求体中有数据；
     * 但是Employee对象封装不上；
     * 然后因为都是null值，然后这个就会被我们的方法拼串，拼成下面的错误sql语句
     * update tbl_emp  where emp_id = 1014;
     *
     * 原因：
     * Tomcat：
     * 		1、将请求体中的数据，封装一个map。
     * 		2、request.getParameter("empName")就会从这个map中取值。
     * 		3、SpringMVC封装POJO对象的时候。
     * 				会把POJO中每个属性的值，request.getParamter("email");
     * AJAX发送PUT请求引发的血案：
     * 		PUT请求，请求体中的数据，request.getParameter("empName")拿不到
     * 		Tomcat一看是PUT不会封装请求体中的数据为map，只有POST形式的请求才封装请求体为map
     * org.apache.catalina.connector.Request--parseParameters() (3111);
     *
     * protected String parseBodyMethods = "POST";
     * if( !getConnector().isParseBodyMethod(getMethod()) ) {
     success = true;
     return;
     }
     *
     *
     * 解决方案；
     * 我们要能支持直接发送PUT之类的请求还要封装请求体中的数据
     * 1、配置上HttpPutFormContentFilter；
     * 2、他的作用；将请求体中的数据解析包装成一个map。
     * 3、request被重新包装，request.getParameter()被重写，就会从自己封装的map中取数据*/
    @ResponseBody
    @RequestMapping(value = "/emp/{empId}",method = RequestMethod.PUT)
    public Msg updateEmp(Employee employee, HttpServletRequest request){
        System.out.println("请求体中的值："+request.getParameter("gender"));
        System.out.println("将要更新的员工数据："+employee);
        employeeService.updateEmp(employee);
        return Msg.success();
    }

    /*接下来书写我们的删除操作*/
//    @ResponseBody
//    @RequestMapping(value = "/emp/{id}",method = RequestMethod.DELETE)
//    public Msg delete(@PathVariable("id") String id){
//        int i = Integer.parseInt(id);
//        employeeService.deleteOne(i);
//        return Msg.success();
//    }

    /**
     * 通过传进来的字符串的不同进行不同的
     * 删除风格
     * 单个批量二合一
     * 批量删除：1-2-3
     * 单个删除：1
     */
    @ResponseBody
    @RequestMapping(value="/emp/{ids}",method=RequestMethod.DELETE)
    public Msg deleteEmp(@PathVariable("ids")String ids){
        //批量删除
        if(ids.contains("-")){
            /*将我们的所有id值封装到一个list集合之中*/
            List<Integer> del_ids = new ArrayList<>();
            String[] str_ids = ids.split("-");
            //组装id的集合
            for (String string : str_ids) {
                del_ids.add(Integer.parseInt(string));
            }
            employeeService.deleteAll(del_ids);
        }else{
            Integer id = Integer.parseInt(ids);
            employeeService.deleteOne(id);
        }
        return Msg.success();
    }


////    @RequestMapping("/emps")
//    public String getEmps(@RequestParam(value = "pn",defaultValue = "1")Integer pn, Model model){
//        /*这个时候不是分页，用插件
//        * 在查询之前调用一下相应方法，然后，传入分页页码和分页大小即可
//        * startPage后紧跟的查询，就算一个分页查询*/
//        PageHelper.startPage(pn,5);
//        List<Employee> emps =  employeeService.getAll();
//        /*查询出来之后，我们使用pageInfo来包装我们的结果
//        * 想要设置连续传入几页，再list传入的时候，直接在后面
//        * 传入个数字就行了。*/
//        PageInfo page = new PageInfo(emps,5);
//        /*因为这个page里面就由我们想要的信息，所以
//        * 我们直接把这个page交给页面就行了*/
//        model.addAttribute("page",page);
//
//        return "list";
//    }
}
