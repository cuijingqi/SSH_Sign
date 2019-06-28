<%--
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
    <title>学生签到</title>
    <link rel="shortcut icon" href="#" />
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.4.1.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
    <link  href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet"/>
</head>
<body>
<div class="container-fluid" id="world">

    <div class="row">
        <div class="col-md-1 col-sm-1"></div>
        <div class="col-md-6 col-sm-6 col-xs-8"><div class="page-header"><h1>学生 <small>学生签到</small></h1></div></div>
        <div class="col-md-5 col-sm-5 col-xs-4"></div>
    </div>
    <br/>
    <div class="row">
        <div class="col-md-1 col-sm-1"></div>
        <div class="col-md-6 col-sm-6 col-xs-8">
            <ul class="nav nav-tabs">
                <li role="presentation" class="active"><a href="Sign.jsp">签到</a></li>
                <li role="presentation"><a href="javascript:void(0)">作业提交</a></li>
            </ul>
        </div>

        <div class="col-md-5 col-sm-5 col-xs-4"></div>
    </div>
    <br/>
    <form id="submit" action="sign" method="post" class="form-horizontal">
        <div class="form-group">
            <label for="stuId" class="control-label col-sm-2 col-xs-2 col-xs-offset-1 col-md-1 ">学号</label>
            <div class="col-sm-4 col-md-5 col-xs-5">
                <input type="text" required="required" class="form-control" id="stuId" name="stuId" placeholder="学号">
            </div>
            <div class="col-md-6 col-sm-6 col-xs-4"></div>
        </div>
        <div class="form-group">
            <label for="stuName" class="control-label col-sm-2 col-xs-2 col-xs-offset-1 col-md-1 ">姓名</label>
            <div class="col-sm-4 col-md-5 col-xs-5">
                <input type="text" required="required" readonly class="form-control" id="stuName" name="stuName" placeholder="姓名">
            </div>
            <div class="col-md-6 col-sm-6 col-xs-4"></div>
        </div>
        <div class="form-group">
            <label for="classId" class="control-label col-sm-2 col-xs-2 col-xs-offset-1 col-md-1 ">班级</label>
            <div class="col-sm-4 col-md-5 col-xs-5">
                <input type="text" required="required" readonly class="form-control" id="classId" name="classId" placeholder="班级">
            </div>
            <div class="col-md-6 col-sm-6 col-xs-4"></div>
        </div>
        <div class="form-group">
            <label for="tel" class="control-label col-sm-2 col-xs-2 col-xs-offset-1 col-md-1 ">电话</label>
            <div class="col-sm-4 col-md-5 col-xs-5">
                <input type="text" required="required" readonly class="form-control" id="tel" name="tel" placeholder="电话">
            </div>
            <div class="col-md-6 col-sm-6 col-xs-4"></div>
        </div>
        <br/>
        <div class="form-group">
            <div class="col-sm-offset-2 col-xs-offset-1 col-sm-10">
                <button id="btns"  type="submit" class="btn btn-default">签到</button>
            </div>
        </div>
    </form>
    <div class="form-group">
        <div class="col-md-2 col-sm-2 col-xs-1"></div>
        <div id="myAlert" class="col-sm-8 col-xs-10 col-md-5">

        </div>
        <div class="col-md-5 col-sm-2 col-xs-1"></div>
    </div>
</div>
<script>
    function find(){
        if ($("#stuName").val()!=null) {
            var stuId = $("#stuId").val();
            $.ajax({
                type: "POST",
                url: "Student/Find",
                data: {stuId: stuId},
                success: function (data) {
                    $("#stuName").val(data.stuName);
                    $("#classId").val(data.classId);
                    $("#tel").val(data.tel);
                }
            });
        }
    }
    $("#stuId").mouseleave(function () {
        if($("#stuId").val().length!=0)
            if ($("#stuName").val().length==0)
                find();
    });
    $("#btns").mouseenter(function () {
        if($("#stuId").val().length!=0)
            if ($("#stuName").val().length==0)
                find();
    });
    $("#submit").submit(function () {

        if($("#stuName").val().length!=0&&$("#stuId").val().length!=0){
            return true;
        }else {
            return false;
        }
    });
    $(function () {
    });
</script>
<%
    String msg = request.getAttribute("msg")+"";
    switch (msg){
        case "win":
%><script>$("#myAlert").html("<div class=\"alert alert-success\">\n" +
    "                <a href=\"#\" class=\"close\" data-dismiss=\"alert\">&times;</a>\n" +
    "                <strong>成功</strong> 签到成功!\n" +
    "            </div>")</script><%
        break;
    case "fail":
%><script>$("#myAlert").html("<div class=\"alert alert-danger\">\n" +
    "                <a href=\"#\" class=\"close\" data-dismiss=\"alert\">&times;</a>\n" +
    "                <strong>错误</strong> 请联系管理员!\n" +
    "            </div>")</script><%
        break;
    case "timeout":
%><script>$("#myAlert").html("<div class=\"alert alert-warning\">\n" +
    "                <a href=\"#\" class=\"close\" data-dismiss=\"alert\">&times;</a>\n" +
    "                <strong>失败</strong> 不在考勤时段内!\n" +
    "            </div>")</script><%
        break;
    case "once":
%><script>$("#myAlert").html("<div class=\"alert alert-warning\">\n" +
    "                <a href=\"#\" class=\"close\" data-dismiss=\"alert\">&times;</a>\n" +
    "                <strong>失败</strong> 该设备已签到!\n" +
    "            </div>")</script><%
            break;
    case "wining":
%><script>$("#myAlert").html("<div class=\"alert alert-success\">\n" +
    "                <a href=\"#\" class=\"close\" data-dismiss=\"alert\">&times;</a>\n" +
    "                <strong>成功</strong> 请勿重复签到!\n" +
    "            </div>")</script><%
            break;
    }

%>
<script src="https://cdn.jsdelivr.net/npm/darkmode-js@1.3.4/lib/darkmode-js.min.js"></script>
<script>
    new Darkmode().showWidget();
</script>
</body>
</html>
