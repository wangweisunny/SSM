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
<%--添加模态框--%>
<!-- 员工修改的模态框 -->
<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">员工修改</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="empName_update_static"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_update_input" placeholder="email@qq.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_update_input" value="m" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_update_input" value="w"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <!-- 部门提交部门id即可 -->
                            <select class="form-control" name="dId">
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
            </div>
        </div>
    </div>
</div>


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
                            <span class="help-block"></span>
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
                            <input type="email" name="email" class="form-control" id="inputEmail" placeholder="Email@qq.com">
                            <span class="help-block"></span>
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
                <button type="button" class="btn btn-primary" id="emp_save">保存</button>
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
            <button class="btn btn-danger" id="emp_delete_modal_btn">删除选中</button>
        </div>
    </div>
    <%--显示数据的地方--%>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="EmpsTable">
                <thead>
                <tr>
                    <th>
                        <input type="checkbox" id="check_all"/>
                    </th>
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
        /*加上下面的这个，我们就能解决这个前往新页面，出现对勾还是显示的问题了*/
        $("#check_all").prop("checked",false);
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
            /*下面这个是写出一个多选框，然后能进行选定*/
            var checkBoxTd = $("<td><input type='checkbox' class='check_item'/></td>");
            var empIdTd = $("<td></td>").append(item.empId);
            var empNameTd = $("<td></td>").append(item.empName);
            var empEmailTd = $("<td></td>").append(item.email);
            var empGenderTd = $("<td></td>").append(item.gender === "m" ? "男" : "女");
            var empDepartmentTd = $("<td></td>").append(item.department.deptName);
            var buttonTd1 = $("<button></button>").addClass("btn btn-warning btn-sm edit_btn").append("<span></span>")
                .addClass("glyphicon glyphicon-pencil").append("编辑");
            /*每一次for循环遍历的时候，都给这个后面添加的按钮添加一个属性，这个属性是改条信息的id号码*/
                buttonTd1.attr("edit_id",item.empId);
            var buttonTd2 = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn").append("<span></span>")
                .addClass("glyphicon glyphicon-trash").append("删除");
            /*同样这个也是，给他田间一个属性，这个属性添加的id值*/
                buttonTd2.attr("delete_id",item.empId);
                buttonTd2.attr("delete_name",item.empName);
            /*然后把创建好的东西放置到标签table里面 你也可以把这个玩意添加到这个td里面*/
            var buttonTd = $("<td></td>").append(buttonTd1).append(" ").append(buttonTd2);
            $("<tr></tr>").append(checkBoxTd).append(empIdTd).append(empNameTd).append(empGenderTd)
                .append(empEmailTd).append(empDepartmentTd)
                .append(buttonTd).appendTo("#EmpsTable tbody");
            /*最后把构造好的东西全部添加到上面的表格中*/
        });
    }

    /*创建一个大的值,用来返回最后一页.*/
    let PageNumber,newPage;

    /*展示分页信息*/
    function build_info_nav(result) {
        $("#page_msg_left").empty();
        var num = result.extend.page.pageNum;
        var pages = result.extend.page.pages;
        var total = result.extend.page.total;
        $("#page_msg_left").append("当前是第" + num + "页，总共" + pages + "页，总共有" + total + "条记录")
        PageNumber = pages;
        newPage=num;
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

    //清空表单样式及内容
    function reset_form(ele){
        $(ele)[0].reset();
        //清空表单样式
        $(ele).find("*").removeClass("has-error has-success");
        $(ele).find(".help-block").text("");
    }

    /*给添加按钮绑定单击事件*/
    $("#emp_add_modal_btn").click(function () {
        /*每一次给他表单刷新即可*/
        reset_form("#empAddModal form");
        getDepartmentName("#empAddModal select");
        $("#empAddModal").modal({
            /*这个里面是用来设置默认属性的*/
            backdrop: "static"
        });
    });

    /*下面我们用一个方法 这个函数先查出部门的名称
    * 注意：url这个前面的路径千万不能省略*/
    function getDepartmentName(element) {
        $.ajax({
            url: "${path}/depts",
            type: "GET",
            success:function (result) {
                /*{"code":100,"msg":"请求成功！！","extend":{"depts":[{"deptId":1,"deptName":"人事部"},
                {"deptId":2,"deptName":"保卫科"}]}}console.log(result)*/
                /*下面遍历一下名字先*/
                $(element).empty();  /*注意要清空*/
                $.each(result.extend.depts,function () {
                    var deptOption = $("<option></option>").append(this.deptName).attr("value",this.deptId);
                    $(deptOption).appendTo(element);
                });
            }
        })
    }

    /*信息校验*/
    function checkMsg(){
        /*一般校验用户名和邮箱,邮箱可以使用正则表达式*/
        <%--inputName inputEmail--%>
        var name = $("#inputName").val();
        var email = $("#inputEmail").val();
        //1、拿到要校验的数据，使用正则表达式
        var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
        if(!regName.test(name)){
            //alert("用户名可以是2-5位中文或者6-16位英文和数字的组合");
            show_validate_msg("#inputName", "error", "用户名可以是2-5位中文或者6-16位英文和数字的组合");
            return false;
        }else{
            show_validate_msg("#inputName", "success", "");
        }

        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if(!regEmail.test(email)){
            //alert("邮箱格式不正确");
            //应该清空这个元素之前的样式
            show_validate_msg("#inputEmail", "error", "邮箱格式不正确");
            //  $("#inputEmail").parent().addClass("has-error");
            // $("#inputEmail").next("span").text("邮箱格式不正确");
            return false;
        }else{
            show_validate_msg("#inputEmail", "success", "");
        }
        return true;
    }
    //显示校验结果的提示信息,抽取成一个方法
    function show_validate_msg(ele,status,msg){
        //首先清除当前元素的校验状态
        $(ele).parent().removeClass("has-success has-error");
        $(ele).next("span").text("");
        if("success"===status){
            $(ele).parent().addClass("has-success");
            $(ele).next("span").text(msg);
        }else if("error" === status){
            $(ele).parent().addClass("has-error");
            $(ele).next("span").text(msg);
        }
    }

    /*建议使用焦点事件,失去焦点就发送ajax请求进行校验*/
    $("#inputName").blur(function () {
        /*然后我们在这里查询数据库看看有没有重复的东西.*/
        var name = this.value;
        $.ajax({
            url:"${path}/check",
            data:"name="+name,
            type:"POST",
            success:function (result) {
                if (result.code === 100){
                    show_validate_msg("#inputName", "success", "用户名可用!!");
                    $("#emp_save").attr("ok","success");
                }else {
                    show_validate_msg("#inputName", "error", result.extend.va_msg);
                    $("#emp_save").attr("ok","error");
                }
            }
        })
    });

    /*给保存绑定单击事件*/
    $("#emp_save").click(function () {
        /*要获取我们表单中的数据，然后提交个我们的服务器进行保存*/
        // alert($("#empAddModal form").serialize());  这个能直接获得我们的提交的内容,通过字符串的方式进行的发送
        /*我们尽量在保存之前进行表单数据校验*/
        /*在保存前在加上一层限制*/
        if ($(this).attr("ok") === "error"){
            return false;
        }
        if (checkMsg()){
            save_emp();
        }
    });

    function save_emp() {
        $.ajax({
            url:"${path}/emp",
            type:"POST",
            data:$("#empAddModal form").serialize(),
            /*其实做完上面的步骤,我们就算是已经完成了添加操作
            * 1.关闭模态框
            * 2.来到最后一页刷新数据*/
            success:function (result) {
                // alert(result.msg);
                //alert(result.msg);
                if(result.code === 100){
                    //员工保存成功；
                    //1、关闭模态框
                    $("#empAddModal").modal("hide");
                    //2、来到最后一页，显示刚才保存的数据
                    //发送ajax请求显示最后一页数据即可
                    /*我们通过传入一个比这个总页数更大的数据来,进入最后一页*/
                    to_page(PageNumber+10);
                }else{
                    //显示失败信息
                    //console.log(result);
                    //有哪个字段的错误信息就显示哪个字段的；
                    if(undefined !== result.extend.errorFields.email){
                        //显示邮箱错误信息
                        show_validate_msg("#inputEmail", "error", result.extend.errorFields.email);
                    }
                    if(undefined !== result.extend.errorFields.empName){
                        //显示员工名字的错误信息
                        show_validate_msg("#inputName", "error", result.extend.errorFields.empName);
                    }
                }

            }
        });
    }

    //1、我们是按钮创建之前就绑定了click，所以绑定不上。
    //1）、可以在创建按钮的时候绑定。    2）、绑定点击.live()
    //jquery新版没有live，使用on进行替代
    /*注意on方法这个东西呢，很好用，所有要记住，也很常有*/
    $(document).on("click",".edit_btn",function(){
        //alert("edit");
        //1、查出部门信息，并显示部门列表
        getDepartmentName("#empUpdateModal select");
        //2、查出员工信息，显示员工信息
        getEmp($(this).attr("edit_id"));

        //3、把员工的id传递给模态框的更新按钮
        $("#emp_update_btn").attr("edit_id",$(this).attr("edit_id"));
        /*下面的这个是打开模态框的函数方法*/
        $("#empUpdateModal").modal({
            backdrop:"static"
        });
    });

    function getEmp(id){
        $.ajax({
            url:"${path}/emp/"+id,
            type:"GET",
            success:function(result){
                //console.log(result);
                var empData = result.extend.emp;
                $("#empName_update_static").text(empData.empName);
                $("#email_update_input").val(empData.email);
                $("#empUpdateModal input[name=gender]").val([empData.gender]);
                $("#empUpdateModal select").val([empData.dId]);
            }
        });
    }

    /*下面就是在按下更新键之后要做的事*/
    //点击更新，更新员工信息
    $("#emp_update_btn").click(function(){
        //验证邮箱是否合法
        //1、校验邮箱信息
        var email = $("#email_update_input").val();
        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if(!regEmail.test(email)){
            show_validate_msg("#email_update_input", "error", "邮箱格式不正确");
            return false;
        }else{
            show_validate_msg("#email_update_input", "success", "");
        }

        //2、发送ajax请求保存更新的员工数据
        updateEmp($(this).attr("edit_id"));
    });

    /*抽取方法，用于更新数据的保存操作
    * 其实本身在数据进行封装的时候，我们也可以直接发送post请求
    * 然后再序列化的地方进行，一下方法的更改就行了
    * 这样做的化，就不需要在web文件中加上那个过滤器了。*/
    function updateEmp(id) {
        $.ajax({
            url:"${path}/emp/"+id,
            //type:"POST",
            type:"PUT",
            //data:$("#empUpdateModal form").serialize()+"&_method=PUT",
            data:$("#empUpdateModal form").serialize(),
            success:function(){
                //alert(result.msg);
                //1、关闭对话框
                $("#empUpdateModal").modal("hide");
                //回到当前页面 当前页在上面进行定义
                to_page(newPage);
            }
        });
    }

    /*下面书写删除逻辑
* 同理，我们的删除按钮也是现加的，我们也得进行绑定*/
    $(document).on("click",".delete_btn",function(){
        /*在这里发送ajax请求进行删除*/
        // alert($(this).attr("delete_name"));
        deleteOne($(this).attr("delete_id"),$(this).attr("delete_name"))
    });

    function deleteOne(id,name) {
        /*可以先弹出删除页面*/
        // var empName = $(this).parents("tr").find("td:eq(2)").text()+"";
        // alert(empName);
        // alert(name);
        // var empId = id;
        if(confirm("确认删除【"+name+"】吗？")){
            /*如果确认之后，就发送ajax请求继续*/
            $.ajax({
                url:"${path}/emp/"+id,
                type:"DELETE",
                success:function () {
                    // alert("删除成功！")
                    // alert(result.msg);
                    //回到本页
                    to_page(newPage);
                }
            });
        }
    }
    /*完成上面的添加删除多选框之后，我们完善一下全选全部不选的单击事件*/
    //完成全选/全不选功能
    $("#check_all").click(function(){
        //因为checked这个属性值是默认属性值，
        // 所以当我们获取内容的时候，attr只能获取checked是undefined;
        //我们这些dom原生的属性；使用prop进行获取默认属性的值；
        // 关于我们自定义的属性值，我们应该用attr。
        //prop也可以修改和读取dom原生属性的值
        /*总结起来就是,自己加的，用attr，默认的用prop
        * 将所有的按钮都与其同步*/
        $(".check_item").prop("checked",$(this).prop("checked"));
    });

    //全选矿的判定，给我们的每一个单选框都天上这个点击事件，每一次都会进行一次判定
    $(document).on("click",".check_item",function(){
        //判断当前选择中的元素是否5个
        /*$(".check_item:checked")：这个属性是匹配选中个数的
        * 有几个选中，这个数字就是几
        * 但是有个问题呀，就是当你前往下一页的时候，你会发现这个还是悬赏的，我们在前往下一页的前面。
        * 榜上这个清空属性机制*/
        var flag = $(".check_item:checked").length===$(".check_item").length;
        $("#check_all").prop("checked",flag);
    });

    //点击全部删除，就批量删除
    $("#emp_delete_modal_btn").click(function(){
        //
        var empNames = "";
        var del_idstr = "";
        $.each($(".check_item:checked"),function(){
            //组装所有的姓名。
            empNames += $(this).parents("tr").find("td:eq(2)").text()+",";
            //组装员工id字符串
            del_idstr += $(this).parents("tr").find("td:eq(1)").text()+"-";
        });
        //去除empNames多余的,
        empNames = empNames.substring(0, empNames.length-1);
        //去除删除的id多余的-
        del_idstr = del_idstr.substring(0, del_idstr.length-1);

        if (empNames === "" || del_idstr === ""){
            alert("你未选中任何东西");
            // confirm("");
        }else{
            if(confirm("确认删除【"+empNames+"】吗？")){
                //发送ajax请求删除
                $.ajax({
                    url:"${path}/emp/"+del_idstr,
                    type:"DELETE",
                    success:function(result){
                        alert(result.msg);
                        //回到当前页面
                        to_page(newPage);
                    }
                });
            }
        }
    });
</script>
</body>
</html>

<%--最后。我么只需要将这个项目打包，放到服务器里面就行了。--%>