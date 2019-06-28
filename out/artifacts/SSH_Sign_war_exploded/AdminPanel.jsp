<%@ page import="java.util.Date" %><%--
  Created by IntelliJ IDEA.
  User: 崔靖奇
  Date: 2019/6/6
  Time: 12:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page errorPage="/WEB-INF/error.jsp" %>
<!--
彩蛋
开发者Email:546836710@qq.com
交流建议及提交BUG
感谢使用我闲暇之余而诞生的作品
祝你早午晚都安!
-->
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>管理面板</title>
    <link rel="shortcut icon" href="#" />
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.4.1.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
    <link  href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet"/>
</head>
<body>
<div class="container-fluid" id="world">

    <div class="row">
        <div class="col-md-1 col-sm-1"></div>
        <div class="col-md-6 col-sm-6 col-xs-8" >
            <div class="page-header">
                <h1>管理面板 <small id="login" class="label label-success">${pageContext.session.getAttribute("admin").name}</small></h1>
            </div>
        </div>
        <div class="col-md-5 col-sm-5 col-xs-4"></div>
    </div>
    <div class="row">
        <div class="col-md-1 col-sm-1"></div>
        <div class="col-md-6 col-sm-6 col-xs-8">
            <ul class="nav nav-tabs">
                <li role="presentation" id="btn11" ><a id="btn1">全部展开</a></li>
                <li role="presentation" id="btn22" class="active" ><a id="btn2">全部折叠</a></li>
            </ul>
        </div>

        <div class="col-md-5 col-sm-5 col-xs-4"></div>
    </div>
    <br/>
    <div class="clearfix visible-xs-block"></div>
    <div  class="col-md-3 col-sm-2 col-xs-2" align="center">
        <div class="panel-group" id="accordion">
            <div class="panel panel-default">
                <div class="panel-heading" align="center">
                    <h4 class="panel-title"><a data-toggle="collapse" data-parent="#accordion" href="#panel1">学生管理</a></h4>
                </div>
                <div id="panel1" class="panel-collapse collapse">
                    <a href="javascript:void(0)"><div id="addStudent" class="panel-body" align="center">添加学生</div></a>
                    <a href="javascript:void(0)"><div id="selectStudent" class="panel-body" align="center">删 改 查</div></a>
                </div>
            </div>
            <div class="panel panel-default">
                <div class="panel-heading" align="center">
                    <h4 class="panel-title"><a data-toggle="collapse" data-parent="#accordion" href="#panel2">考勤管理</a></h4>
                </div>
                <div id="panel2" class="panel-collapse collapse">
                    <a href="javascript:void(0)"><div id="addTimeLimit" class="panel-body" align="center">添加考勤时段</div></a>
                    <a href="javascript:void(0)"><div id="selectTimeLimit" class="panel-body" align="center">查看考勤时段</div></a>
                    <a href="javascript:void(0)"><div id="selectSign" class="panel-body" align="center">查看考勤统计</div></a>
                </div>
            </div>
            <div class="panel panel-default">
                <div class="panel-heading" align="center">
                    <h4 class="panel-title"><a data-toggle="collapse" data-parent="#accordion" href="#panel3">作业管理</a></h4>
                </div>
                <div id="panel3" class="panel-collapse collapse">
                    <a href="javascript:void(0)"><div class="panel-body" align="center">查看作业</div></a>
                    <a href="javascript:void(0)"><div class="panel-body" align="center">作业路径</div></a>
                </div>
            </div>
            <div class="panel panel-default">
                <div class="panel-heading" align="center">
                    <h4 class="panel-title"><a data-toggle="collapse" data-parent="#accordion" href="#panel4">个人中心</a></h4>
                </div>
                <div id="panel4" class="panel-collapse collapse">
                    <a href="javascript:void(0)"><div id="addAdmin" class="panel-body" align="center">添加子管理员</div></a>
                    <a href="javascript:void(0)"><div id="selectAdmin" class="panel-body" align="center">查看子管理员</div></a>
                    <a href="javascript:void(0)"><div id="updataAdmin" class="panel-body" align="center">修改个人信息</div></a>
                </div>
            </div>
        </div>
    </div>
    <div class="col-md-9 col-sm-10 col-xs-10">
        <div id="ifarme"></div>
    </div>
</div>
<script>
    $("#login").dblclick(function () {
        $.get("Admin/Quit",function () {
            $(location).attr('href', '${pageContext.request.contextPath}/Admin.jsp');
        });
    });
    $(function(){
        $('#btn1').click(function(){
            $("#btn22").removeClass("active");
            $("#btn11").addClass("active");
            $('.collapse').collapse('show');
        });
        $('#btn2').click(function(){
            $("#btn11").removeClass("active");
            $("#btn22").addClass("active");
            $('.collapse').collapse('hide');
        });
    });
    function ifarme(url){
        $.get(url,function (data) {
            $("#ifarme").html(data);
        });
    }
    $("#addStudent").click(function () {
        ifarme("addStudent.jsp");
    });
    $("#selectStudent").click(function () {
        ifarme("selectStudent.jsp");
    });
    $("#addAdmin").click(function () {
        ifarme("addAdmin.jsp");
    });
    $("#updataAdmin").click(function () {
        ifarme("updataAdmin.jsp");
    });
    $("#selectAdmin").click(function () {
        ifarme("selectAdmin.jsp");
    });
    $("#addTimeLimit").click(function () {
        ifarme("addTimeLimit.jsp");
    });
    $("#selectSign").click(function () {
        ifarme("selectSignAsStudent.jsp");
    });
    $("#selectTimeLimit").click(function () {
        ifarme("selectTimeLimit.jsp");
    });
</script>
<%--//这是个假彩蛋--%>
<%--<%--%>
<%--    if(Integer.parseInt(request.getSession().getAttribute("Tip")+"")==0){--%>
<%--        request.getSession().setAttribute("Tip", Integer.parseInt(request.getSession().getAttribute("Tip")+"")+1);--%>
<%--        %>--%>
<%--        <script>--%>
<%--            $("#world").append("<div id=\"modal\">"+--%>
<%--                "<!-- Small modal -->\n" +--%>
<%--                "<button value=\"HTML\" id=\"tt\" type=\"button\" class=\"btn btn-primary\" data-toggle=\"modal\" data-target=\".bs-example-modal-sm\"><%new Date();%></button>\n" +--%>
<%--                "\n" +--%>
<%--                "<div class=\"modal fade bs-example-modal-sm\" tabindex=\"-1\" role=\"dialog\" aria-labelledby=\"mySmallModalLabel\">\n" +--%>
<%--                "  <div class=\"modal-dialog modal-sm\" role=\"document\">\n" +--%>
<%--                "    <div class=\"modal-content\">\n" +--%>
<%--                "      <h5>你好!${pageContext.session.getAttribute("admin").name}</h5>\n<h4>通知:</h4>\n<h5>     暂无.</h5>" +--%>
<%--                "    </div>\n" +--%>
<%--                "  </div>\n" +--%>
<%--                "</div>\n</div>");--%>
<%--            $("#tt").click();--%>
<%--            // $("#modal").remove();--%>
<%--        </script>--%>
<%--        <%--%>
<%--    }--%>
<%--%>--%>
<script src="https://cdn.jsdelivr.net/npm/darkmode-js@1.3.4/lib/darkmode-js.min.js"></script>
<script>
    new Darkmode().showWidget();
</script>
</body>
</html>
