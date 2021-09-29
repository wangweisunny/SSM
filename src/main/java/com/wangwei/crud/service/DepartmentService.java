package com.wangwei.crud.service;

import com.wangwei.crud.bean.Department;
import com.wangwei.crud.dao.DepartmentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author WangWei
 * @create 2021-09-28 21:21
 */
@Service
public class DepartmentService {
    @Autowired
    private DepartmentMapper departmentMapper;

    public List<Department> getAll(){
       return departmentMapper.selectByExample(null);
    }

}
