package com.wangwei.Page;

import com.github.pagehelper.PageInfo;
import com.wangwei.crud.bean.Employee;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import java.util.List;

/**
 * @author WangWei
 * @create 2021-09-26 19:44
 */

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration /*没有这个注解，我们就无法对WebApplicationContext 进行自动装配*/
/*因为到mvc的地方了，我们得把这个mvc的页引入*/
@ContextConfiguration(locations = {"classpath:applicationContext.xml","file:src/main/webapp/WEB-INF/dispatcherServlet-servlet.xml"})
public class PageTest {
    @Autowired
    WebApplicationContext context;
    /*创建一个虚拟的mvc请求，直接获取处理结果*/
    MockMvc mockMvc;

    @Before
    public void initMockMvc(){
        mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
    }

    @Test
    public void testPage() throws Exception {
        /*这个时候我们就需要再这个里面进行一下请求模拟了
        * 然后拿到返回值*/
        MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pn", "5")).andReturn();
        //请求完整之后,我们的请求域里面就会有我们创建过的对象
        MockHttpServletRequest request = result.getRequest();
        PageInfo page = (PageInfo) request.getAttribute("page");
        int pageNum = page.getPageNum();
        long total = page.getTotal();
        int[] Nums = page.getNavigatepageNums();
        for (int i :
                Nums) {
            System.out.print(i+" ");
        }
        System.out.println("当前页数和总数据为："+pageNum+", "+total);
        /*拿到里面的数据*/
        List<Employee> list = page.getList();
        for (Employee e :
                list) {
            System.out.println(e);
        }
    }
}
