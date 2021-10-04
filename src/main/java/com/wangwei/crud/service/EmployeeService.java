package com.wangwei.crud.service;

import com.wangwei.crud.bean.Employee;
import com.wangwei.crud.bean.EmployeeExample;
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


    /*保存员工*/
    public void save(Employee employee) {
        employeeMapper.insertSelective(employee);
    }

    /**
     *
     * @param name 传入的姓名
     * @return true:可用 false:不可以
     */

    public Boolean check(String name) {
        EmployeeExample employee = new EmployeeExample();
        EmployeeExample.Criteria criteria = employee.createCriteria();
        criteria.andEmpNameEqualTo(name);
//        Employee employee = new Employee(null, name, null, null, null);
        long l = employeeMapper.countByExample(employee);//当出现很多个这个相同元素的时候,就说明有一样的内容存在
        return l == 0;
    }

    /*根据id进行查询*/
    public Employee getEmp(Integer id) {
        return employeeMapper.selectByPrimaryKey(id);
    }

    /*保存修改的数据*/
    public void updateEmp(Employee employee) {
        employeeMapper.updateByPrimaryKeySelective(employee);
    }

    /*这个是进行批量删除操作*/
    public void deleteAll(List<Integer> ids) {
        EmployeeExample employee = new EmployeeExample();
        EmployeeExample.Criteria criteria = employee.createCriteria();
        criteria.andEmpIdIn(ids);
        employeeMapper.deleteByExample(employee);
    }

    /*这个是进行单一删除操作*/
    public void deleteOne(Integer id) {
        employeeMapper.deleteByPrimaryKey(id);
    }
}
