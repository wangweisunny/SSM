package com.wangwei.crud.service;

import com.wangwei.crud.bean.Employee;
import com.wangwei.crud.dao.EmployeeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**使用这个service层的业务组件调用dao里面的进行查询
 * @author WangWei
 * @create 2021-09-26 19:20
 */
@Service
public class EmployeeService {
    /*当然我们要注入dao层面的内容*/
    @Autowired
    EmployeeMapper employeeMapper;

    public List<Employee> getAll() {
        return employeeMapper.selectByExampleWhitDept(null);
    }

}
