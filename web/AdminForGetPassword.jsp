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
    <title>管理员登陆</title>
    <link rel="shortcut icon" href="#" />
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.4.1.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
    <link  href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet"/>
</head>
<body>
<div class="container-fluid" id="world">

    <div class="row">
        <div class="col-md-1 col-sm-1"></div>
        <div class="col-md-6 col-sm-6 col-xs-8"><div class="page-header"><h1>管理面板 <small>管理员登录</small></h1></div></div>
        <div class="col-md-5 col-sm-5 col-xs-4"></div>
    </div>
    <br/>
    <div class="row">
        <div class="col-md-1 col-sm-1"></div>
        <div class="col-md-6 col-sm-6 col-xs-8">
            <ul class="nav nav-tabs">
                <li role="presentation"><a href="Admin.jsp">登录</a></li>
                <li role="presentation" class="active"><a href="AdminForGetPassword.jsp">忘记密码</a></li>
            </ul>
        </div>

        <div class="col-md-5 col-sm-5 col-xs-4"></div>
    </div>
    <br/>
    <form id="submit" action="Admin/Login" method="post" class="form-horizontal">
        <div id="one" class="form-group">
            <label for="userName" class="control-label col-sm-2 col-xs-2 col-xs-offset-1 col-md-1 ">用户名</label>
            <div class="col-sm-2 col-md-3 col-xs-5">
                <input type="text" required="required" class="form-control" id="userName" name="userName" minlength="5" maxlength="15" placeholder="UserName">
            </div>
            <div class="col-md-0 col-sm-0 col-xs-4"></div>
            <div class="clearfix visible-xs-block"></div>
            <div class="col-md-0 col-sm-0 col-xs-3"></div>
            <div class="col-md-4 col-sm-4 col-xs-7">
                <blockquote id="usernametip">

                </blockquote>
            </div>
            <div class="col-md-4 col-sm-4 col-xs-2"></div>
        </div>

        <br/>
        <div class="form-group">
            <div class="col-sm-offset-2 col-xs-offset-1 col-sm-10">
                <button id="btns"  type="submit" class="btn btn-default">确定</button>
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
    function usernamevalidity() {
        var val = $("#userName").val();
        var reg = /^[a-zA-Z]$/
        var reg1=/^[a-zA-Z0-9_]{4,14}$/;
        if (val.length < 5 || val.length > 15) {
            $("#usernametip").html("<footer>  &times; <cite title=\"Source Title\">  用户名在5-15个字符之间</cite></footer>");
            $("#one").removeClass("has-success");
            $("#one").addClass("has-error");
            return false;
        } else if (!reg.test(val.charAt(0))) {
            $("#usernametip").html("<footer>  &times; <cite title=\"Source Title\">  用户名由字母开头</cite></footer>");
            $("#one").removeClass("has-success");
            $("#one").addClass("has-error");
            return false;
        } else if (!reg1.test(val)) {
            $("#usernametip").html("<footer>  &times; <cite title=\"Source Title\">  用户名由字母,数字和'_'组合</cite></footer>");
            $("#one").removeClass("has-success");
            $("#one").addClass("has-error");
            return false;
        } else{
            $("#usernametip").html("<footer>  &radic; <cite title=\"Source Title\">  Nice!</cite></footer>");
            $("#one").removeClass("has-error");
            $("#one").addClass("has-success");
            return true;
        }
    }

    $("#userName").mouseleave(function () {
        usernamevalidity();
    });

    $("#btns").mouseenter(function () {
        usernamevalidity();
    });
    $("#submit").submit(function () {
        if($("#userName").val().length!=0){
            if (usernamevalidity()){
                    return true;
            }
        }
        return false;
    });
    $(function () {

    });
</script>
<%
    String msg = request.getAttribute("msg")+"";
    switch (msg){
    case "fail":
%><script>$("#myAlert").html("<div class=\"alert alert-danger\">\n" +
    "                <a href=\"#\" class=\"close\" data-dismiss=\"alert\">&times;</a>\n" +
    "                <strong>失败</strong> 账号或者密码错误!\n" +
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
