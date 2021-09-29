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
    <script type="text/javascript" src="${path }/static/js/jquery-1.12.4.min.js"></script>
    <link href="${path }/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="${path }/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>

</head>
<body>

<%--模态框--%>
<!-- Modal -->
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">添加员工</h4>
            </div>
            <div class="modal-body">
                <%--下面是表单部分
                private String empName;
                private String gender;
                private String email;
                private Integer dId;--%>
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">员工姓名:</label>
                        <div class="col-sm-10">
                            <input type="text" name="empName" class="form-control" id="inputName" placeholder="Name">
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label">员工性别:</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_add_put" value="m"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_add_put" value="w"> 女
                            </label>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label">员工邮箱:</label>
                        <div class="col-sm-10">
                            <input type="email" name="email" class="form-control" id="inputEmail" placeholder="Email">
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label">所在部门:</label>
                        <div class="col-sm-10">
                            <select class="form-control" name="dId">
                            </select>
                        </div>
                    </div>

                </form>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary">保存</button>
            </div>
        </div>
    </div>
</div>


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
            <button class="btn btn-primary" id="emp_add_modal_btn">新增</button>
            <button class="btn btn-danger">删除</button>
        </div>
    </div>
    <%--显示数据的地方--%>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="EmpsTable">
                <thead>
                <tr>
                    <th>编号</th>
                    <th>姓名</th>
                    <th>性别</th>
                    <th>邮箱</th>
                    <th>所在部门</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>

                </tbody>

            </table>
        </div>
    </div>
    <%--显示分页信息--%>
    <div class="row">
        <div class="col-md-6" id="page_msg_left">
        </div>
        <div class="col-md-6" id="page_msg_right">
        </div>
    </div>
</div>

<script type="text/javascript">
    /*这个时候我们就是在要到这个数据之后发送ajax请求进行数据的输出*/
    $(function () {
        to_page(1);
    });

    function to_page(pn) {
        /*然后我们发送一个ajax请求*/
        //千万要注意，ajax请求没有括号！！！！
        $.ajax({
            url: "${path}/emps",
            data: "pn=" + pn,
            type: "GET",
            success: function (result) {
                /*通过测试我们知道这个时候已经成功获取到我们的想要的数据
                * 这个时候我们对获取到的信息进行解析
                * 解析显示我们的分页信息，我们采用这个创建方法并调用的方式*/
                build_employee_table(result);
                build_info_nav(result);
                build_page_nav(result);
            }
        });
    }


    /*展示分页数据方法*/
    function build_employee_table(result) {
        /*要先清空里面的数据*/
        $("#EmpsTable tbody").empty();
        var emps = result.extend.page.list;
        /*获取到了我们就能进行遍历了*/
        $.each(emps, function (index, item) {
            /*然后我们在这个里面田间我们的表格结构
            * 1.先获取所有的信息，然后我们在创建需要表格到该有的位置里面
            * empId":1,"empName":"王威",
            * "gender":"m","
            * email":"wangweisunny@foxmail.com","
            * dId":1,"
            * department":{"deptId":1,"deptName":"人事部"}}
            *
            * <button class="btn btn-danger btn-sm">
              <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
              删除*/
            var empIdTd = $("<td></td>").append(item.empId);
            var empNameTd = $("<td></td>").append(item.empName);
            var empEmailTd = $("<td></td>").append(item.email);
            var empGenderTd = $("<td></td>").append(item.gender === "m" ? "男" : "女");
            var empDepartmentTd = $("<td></td>").append(item.department.deptName);
            var buttonTd1 = $("<button></button>").addClass("btn btn-warning btn-sm").append("<span></span>")
                .addClass("glyphicon glyphicon-pencil").append("编辑");
            var buttonTd2 = $("<button></button>").addClass("btn btn-danger btn-sm").append("<span></span>")
                .addClass("glyphicon glyphicon-trash").append("删除");
            /*然后把创建好的东西放置到标签table里面 你也可以把这个玩意添加到这个td里面*/
            var buttonTd = $("<td></td>").append(buttonTd1).append(" ").append(buttonTd2);
            $("<tr></tr>").append(empIdTd).append(empNameTd).append(empGenderTd)
                .append(empEmailTd).append(empDepartmentTd)
                .append(buttonTd).appendTo("#EmpsTable tbody");
            /*最后把构造好的东西全部添加到上面的表格中*/
        });
    }

    /*展示分页信息*/
    function build_info_nav(result) {
        $("#page_msg_left").empty();
        var num = result.extend.page.pageNum;
        var pages = result.extend.page.pages;
        var total = result.extend.page.total;
        $("#page_msg_left").append("当前是第" + num + "页，总共" + pages + "页，总共有" + total + "条记录")
    }

    /*展示分页条，并添加动作*/
    function build_page_nav(result) {
        $("#page_msg_right").empty();
        var ul = $("<ul></ul>").addClass("pagination");
        /*先展示我们的固定的地方*/
        var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href", "#"));
        /*翻页点击事件*/

        var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));

        if (!result.extend.page.hasPreviousPage) {
            firstPageLi.addClass("disabled");
            prePageLi.addClass("disabled");
        } else {
            prePageLi.click(function () {
                to_page(result.extend.page.pageNum - 1);
            });
            firstPageLi.click(function () {
                to_page(1);
            });
        }

        var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));

        var lastPageLi = $("<li></li>").append($("<a></a>").append("尾页").attr("href", "#"));


        if (!result.extend.page.hasNextPage) {
            nextPageLi.addClass("disabled");
            lastPageLi.addClass("disabled");
        } else {
            nextPageLi.click(function () {
                to_page(result.extend.page.pageNum + 1);
            });
            lastPageLi.click(function () {
                to_page(result.extend.page.pages);
            });
        }

        ul.append(firstPageLi).append(prePageLi);
        /*下面K开始遍历页码信息*/
        $.each(result.extend.page.navigatepageNums, function (index, item) {
            var numsLi = $("<li></li>").append($("<a></a>").append(item));
            if (result.extend.page.pageNum === item) {
                numsLi.addClass("active")
            }

            numsLi.click(function () {
                to_page(item);
            });

            ul.append(numsLi);
        });

        ul.append(nextPageLi).append(lastPageLi);

        var navEle = $("<nav></nav>").append(ul);

        // navEle.appendTo("#page_msg_right");
        /*把构建万层的内容添加到里面*/
        $("#page_msg_right").append(navEle);
    }

    /*给添加按钮绑定单击事件*/
    $("#emp_add_modal_btn").click(function () {
        getDepartmentName();
        $("#empAddModal").modal({
            backdrop: "static"
        });
    });

    /*下面我们用一个方法 这个函数先查出部门的名称
    * 注意：url这个前面的路径千万不能省略*/
    function getDepartmentName() {
        $.ajax({
            url: "${path}/depts",
            type: "GET",
            success:function (result) {
                /*{"code":100,"msg":"请求成功！！","extend":{"depts":[{"deptId":1,"deptName":"人事部"},
                {"deptId":2,"deptName":"保卫科"}]}}console.log(result)*/
                /*下面遍历一下名字先*/
                $("#empAddModal select").empty();
                $.each(result.extend.depts,function () {
                    var deptOption = $("<option></option>").append(this.deptName).attr("value",this.deptId);
                    $(deptOption).appendTo("#empAddModal select");
                });
            }
        })
    }
</script>
</body>
</html>
