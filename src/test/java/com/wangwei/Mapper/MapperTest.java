package com.wangwei.Mapper;

import com.wangwei.crud.bean.Department;
import com.wangwei.crud.bean.Employee;
import com.wangwei.crud.dao.DepartmentMapper;
import com.wangwei.crud.dao.EmployeeMapper;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.UUID;

/**
 * 这个是个测试类，推荐使用spring的单元测试方法
 * 步骤：
 *     1.导入spring test的包，maven里面去搜
 *     2.@ContextConfiguration注解标记到类上，并且要指定你得spring配置文件位置
 *     3.@RunWith(SpringJUnit4ClassRunner.class)：这个是执行单元测试的时候，我们
 *     要做的执行单元测试模块内容。
 *     4.剩下的，我们直接autowire即可，因为直接就联合了spring了
 * @author WangWei
 * @create 2021-09-26 17:43
 */

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:applicationContext.xml")
public class MapperTest {

    @Autowired
    DepartmentMapper departmentMapper;

    @Autowired
    EmployeeMapper employeeMapper;

    @Autowired
    SqlSession sqlSession;
    @Test/*测试部门的信息*/
    public void testCRUD(){
        /*1、创建ioc容器*/
//        ClassPathXmlApplicationContext ioc = new ClassPathXmlApplicationContext("applicationContext.xml");
//        /*2、从容器中拿出我们的mapper类*/
//        DepartmentMapper departmentMapper = ioc.getBean(DepartmentMapper.class);
        /*上面的步骤也可以用，但是这个方法貌似更高大上一点，不是吗*/

        /*下面我们尝试一下添加操作*/
//        departmentMapper.insertSelective(new Department(null,"人事部"));
//        departmentMapper.insertSelective(new Department(null,"保卫科"));

        /*测试一下查和讯*/
        Department department = departmentMapper.selectByPrimaryKey(2);
        System.out.println(department);  //没问题
    }

    @Test /*这个方法我们用来测试employee的插入和删除*/
    public void testEmployee(){
        /*Integer empId, String empName, String gender, String email, Integer dId*/
//        employeeMapper.insertSelective(new Employee(null,"王威","m","wangweisunny@foxmail.com",1));
    /*下面我们相当于是复习一下批量插入的一个操作*/
        EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
        for (int i = 0; i <= 100; i++) {
            String name = UUID.randomUUID().toString().substring(0, 5) + i;
            mapper.insertSelective(new Employee(null, name, "m", name + "@qq.com", 2));
        }
        System.out.print("批量插入成功：");
    }
}
