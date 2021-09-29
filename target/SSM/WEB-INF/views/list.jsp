<%--
  Created by IntelliJ IDEA.
  User: 13221
  Date: 2021/9/26
  Time: 19:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>员工列表</title>
    <%
        pageContext.setAttribute("path", request.getContextPath());
    %>
    <script type="text/javascript" src="${path }/static/js/jquery-1.12.4.min.js"></script>
    <link href="${path}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="${path}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>
<%--搭建页面系统--%>
<div class="container">
    <%--标题--%>
    <div class="row">
        <%--你选择几就算是网上占几列--%>
        <div class="col-md-12">
            <h1>SSM-CRUD</h1>
        </div>
    </div>
    <%--按钮--%>
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button class="btn btn-primary">新增</button>
            <button class="btn btn-danger">删除</button>
        </div>
    </div>
    <%--显示数据的地方--%>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover">
                <%--表格首航--%>
                <tr>
                    <th>编号</th>
                    <th>姓名</th>
                    <th>性别</th>
                    <th>邮箱</th>
                    <th>所在部门</th>
                    <th>操作</th>
                </tr>
                <%--取出我们之间搞到的数据--%>
                <c:forEach items="${page.list}" var="emp">
                    <%--表格第二行
                        private Integer empId;String empName;
                        String gender;String email;Integer dId;--%>
                    <tr>
                        <th>${emp.empId}</th>
                        <th>${emp.empName}</th>
                        <th>${emp.gender == "m"?"男":"女"}</th>
                        <th>${emp.email}</th>
                        <th>${emp.department.deptName}</th>
                        <th>
                            <button class="btn btn-danger btn-sm">
                                <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
                                删除
                            </button>
                            <button class="btn btn-warning btn-sm">
                                <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
                                修改
                            </button>
                        </th>
                    </tr>
                </c:forEach>
            </table>
        </div>
    </div>
    <%--显示分页信息--%>
    <div class="row">
        <div class="col-md-6">
            当前是第${page.pageNum}页，总共${page.pages}页，总共有${page.total}条记录
        </div>
        <div class="col-md-6">
            <nav aria-label="Page navigation">
                <ul class="pagination">
                    <%--上一页的逻辑--%>
                    <c:if test="${page.hasPreviousPage}">
                        <li>
                            <a href="${path}/emps?pn=${page.pageNum-1}" aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                            </a>
                        </li>
                    </c:if>
                    <li><a href="${path}/emps?pn=1">首页</a></li>
                    <c:forEach items="${page.navigatepageNums}" var="page_Name">
                        <%--下面的这个意思就是判断是否为当前页--%>
                        <c:if test="${page_Name == page.pageNum}">
                            <li class="active"><a href="#">${page_Name}</a></li>
                        </c:if>
                        <c:if test="${page_Name != page.pageNum}">
                            <li><a href="${path}/emps?pn=${page_Name}">${page_Name}</a></li>
                        </c:if>
                    </c:forEach>
                    <li><a href="${path}/emps?pn=${page.pages}">尾页</a></li>
                    <%--尾页逻辑--%>
                    <c:if test="${page.hasNextPage}">
                        <li>
                            <a href="${path}/emps?pn=${page.pageNum+1}" aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                            </a>
                        </li>
                    </c:if>
                </ul>
            </nav>
        </div>
    </div>
</div>
</body>
</html>
