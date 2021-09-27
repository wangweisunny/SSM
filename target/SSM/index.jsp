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
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>员工列表</title>
    <%
        pageContext.setAttribute("path", request.getContextPath());
    %>
    <script type="text/javascript"
            src="${path }/static/js/jquery-1.12.4.min.js"></script>
    <link
            href="${path }/static/bootstrap-3.3.7-dist/css/bootstrap.min.css"
            rel="stylesheet">
    <script
            src="${path }/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>

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
                <tr>
                    <th>编号</th>
                    <th>姓名</th>
                    <th>性别</th>
                    <th>邮箱</th>
                    <th>所在部门</th>
                    <th>操作</th>
                </tr>

            </table>
        </div>
    </div>
    <%--显示分页信息--%>
    <div class="row">
        <div class="col-md-6">
            当前是第页，总共页，总共有条记录
        </div>
        <div class="col-md-6">

        </div>
    </div>
</div>

<script type="text/javascript">
    /*这个时候我们就是在要到这个数据之后发送ajax请求进行数据的输出*/
    $(function () {
       /*然后我们发送一个ajax请求*/
        $.ajax({
            url:"${path}/emps",
            data:"pn=1",
            type:"GET",
            success:function (result) {
                console.log(result)
            }
        });
    });
</script>
</body>
</html>
