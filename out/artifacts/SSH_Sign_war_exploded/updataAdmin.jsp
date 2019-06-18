<%--
  Created by IntelliJ IDEA.
  User: 崔靖奇
  Date: 2019/6/6
  Time: 12:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page errorPage="/WEB-INF/error.jsp" %>

<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>修改个人信息</title>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.4.1.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
    <link  href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet"/>
    <script>
        function usernamevalidity() {
            var val = $("#userName").val();
            var reg = /^[a-zA-Z]$/
            var reg1=/^[a-zA-Z0-9_]{5,15}$/;
            if (val.length < 5 || val.length > 15) {
                $("#usernametip").html("<footer>  &times; <cite title=\"Source Title\">  用户名在5-15个字符之间</cite></footer>");
                $("#oneusername").removeClass("has-success");
                $("#oneusername").addClass("has-error");
                return false;
            } else if (!reg.test(val.charAt(0))) {
                $("#usernametip").html("<footer>  &times; <cite title=\"Source Title\">  用户名由字母开头</cite></footer>");
                $("#oneusername").removeClass("has-success");
                $("#oneusername").addClass("has-error");
                return false;
            } else if (!reg1.test(val)) {
                $("#usernametip").html("<footer>  &times; <cite title=\"Source Title\">  用户名由字母,数字和'_'组合</cite></footer>");
                $("#oneusername").removeClass("has-success");
                $("#oneusername").addClass("has-error");
                return false;
            } else{
                $("#usernametip").html("<footer>  &radic; <cite title=\"Source Title\">  Nice!</cite></footer>");
                $("#oneusername").removeClass("has-error");
                $("#oneusername").addClass("has-success");
                return true;
            }
        }
        function passwordvalidity(){
            var val = $("#password").val();
            var reg1=/^[a-zA-Z0-9_]{8,25}$/;
            if (val.length<8||val.length>25){
                $("#passwordtip").html("<footer>  &times; <cite title=\"Source Title\">  密码在8-25个字符之间</cite></footer>");
                $("#onepassword").removeClass("has-success");
                $("#onepassword").addClass("has-error");
                return false;
            }else if (!reg1.test(val)) {
                $("#passwordtip").html("<footer>  &times; <cite title=\"Source Title\">  密码由字母,数字和'_'组合</cite></footer>");
                $("#onepassword").removeClass("has-success");
                $("#onepassword").addClass("has-error");
                return false;
            } else{
                $("#passwordtip").html("<footer>  &radic; <cite title=\"Source Title\">  Nice!</cite></footer>");
                $("#onepassword").removeClass("has-error");
                $("#onepassword").addClass("has-success");
                return true;
            }
        }
        function emailvalidity(){
            var val = $("#email").val();
            var reg1=/^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,8})$/;
            if (!reg1.test(val)) {
                $("#emailtip").html("<footer>  &times; <cite title=\"Source Title\">  邮箱填写不正确!</cite></footer>");
                $("#oneemail").removeClass("has-success");
                $("#oneemail").addClass("has-error");
                return false;
            } else{
                $("#emailtip").html("<footer>  &radic; <cite title=\"Source Title\">  Nice!</cite></footer>");
                $("#oneemail").removeClass("has-error");
                $("#oneemail").addClass("has-success");
                return true;
            }
        }
        function telvalidity(){
            var val = $("#tel").val();
            var reg1=/^1[3456789]\d{9}$/;
            if (!reg1.test(val)) {
                $("#teltip").html("<footer>  &times; <cite title=\"Source Title\">  电话号码填写不正确!</cite></footer>");
                $("#onetel").removeClass("has-success");
                $("#onetel").addClass("has-error");
                return false;
            } else{
                $("#teltip").html("<footer>  &radic; <cite title=\"Source Title\">  Nice!</cite></footer>");
                $("#onetel").removeClass("has-error");
                $("#onetel").addClass("has-success");
                return true;
            }
        }
        $(function () {
            $("#aId").val("${pageContext.session.getAttribute("admin").AId}");
            $("#name").val("${pageContext.session.getAttribute("admin").name}");
            $("#userName").val("${pageContext.session.getAttribute("admin").userName}");
            $("#password").val("${pageContext.session.getAttribute("admin").password}");
            $("#email").val("${pageContext.session.getAttribute("admin").email}");
            $("#tel").val("${pageContext.session.getAttribute("admin").tel}");
        });
        function validity() {
            if ($("#aId").val().trim()!="") {
                $("#oneid").removeClass("has-error");
                $("#oneid").addClass("has-success");
                if ($("#name").val().trim()!=""&&$("#name").val().trim().length<8) {
                    $("#onename").removeClass("has-error");
                    $("#onename").addClass("has-success");
                    if (usernamevalidity()) {
                        if (passwordvalidity()){
                            if (emailvalidity()){
                                if (telvalidity()){
                                    return true;
                                }
                            }
                        }
                    }
                } else{
                    $("#onename").removeClass("has-success");
                    $("#onename").addClass("has-error");
                    return false;
                }
            } else{
                $("#oneid").removeClass("has-success");
                $("#oneid").addClass("has-error");
                return false;
            }
            return false;
        }
        function sub() {
            if (validity()){
                var aId = $("#aId").val();
                var name = $("#name").val();
                var userName = $("#userName").val();
                var password = $("#password").val();
                var email = $("#email").val();
                var tel = $("#tel").val();
                $.ajax({
                    type: "POST",
                    url: "Admin/UpdataAdmin",
                    data: {AId:aId,
                        name:name,
                        userName:userName,
                        password:password,
                        email:email,
                        tel:tel},
                    success: function (data) {
                        if (data=="win"){
                            $("#myAlert").html("<div class=\"alert alert-success\">\n" +
                                "                <a href=\"#\" class=\"close\" data-dismiss=\"alert\">&times;</a>\n" +
                                "                <strong>成功</strong> 修改成功!<a href='${pageContext.request.contextPath}/Admin.jsp'>重新登录</a>后生效!\n" +
                                "            </div>");
                            $(location).attr('href', '${pageContext.request.contextPath}/Admin.jsp');
                        }else if (data=="onceing"){
                            $("#myAlert").html("<div class=\"alert alert-warning\">\n" +
                                "                <a href=\"#\" class=\"close\" data-dismiss=\"alert\">&times;</a>\n" +
                                "                <strong>失败</strong> 用户名已存在!\n" +
                                "            </div>")
                        } else if (data=="once"){
                            $("#myAlert").html("<div class=\"alert alert-warning\">\n" +
                                "                <a href=\"#\" class=\"close\" data-dismiss=\"alert\">&times;</a>\n" +
                                "                <strong>失败</strong> 管理员不存在!\n" +
                                "            </div>")
                        } else {
                            $("#myAlert").html("<div class=\"alert alert-danger\">\n" +
                                "                <a href=\"#\" class=\"close\" data-dismiss=\"alert\">&times;</a>\n" +
                                "                <strong>错误</strong> 请联系上级管理员或开发者email:546836710@qq.com!\n" +
                                "            </div>")
                        }
                    }
                });
            }
        };
    </script>
</head>
<body>
<div class="container-fluid" id="world">
    <div class="row">
        <div class="col-md-1 col-sm-1"></div>
        <div class="col-md-6 col-sm-6 col-xs-8"><div class="page-header"><h1><small>修改个人信息</small></h1></div></div>
        <div class="col-md-5 col-sm-5 col-xs-4"></div>
    </div>
    <form id="submit" class="form-horizontal">
        <div class="form-group" id="oneid">
            <label for="aId" class="control-label col-sm-2 col-xs-2 col-xs-offset-1 col-md-1 ">编号</label>
            <div class="col-sm-4 col-md-5 col-xs-5">
                <input type="text" required="required" readonly class="form-control" id="aId" name="aId" placeholder="编号">
            </div>
            <div class="col-md-6 col-sm-6 col-xs-4"><input type="hidden" id="secret" name="secret" value="0" /></div>
        </div>
        <div class="form-group" id="onename">
            <label for="name" class="control-label col-sm-2 col-xs-2 col-xs-offset-1 col-md-1 ">姓名</label>
            <div class="col-sm-4 col-md-5 col-xs-5">
                <input type="text" required="required"  class="form-control" id="name" name="name" placeholder="姓名">
            </div>
            <div class="col-md-6 col-sm-6 col-xs-4"></div>
        </div>

        <div class="form-group" id="oneusername">
            <label for="userName" class="control-label col-sm-2 col-xs-2 col-xs-offset-1 col-md-1 ">用户名</label>
            <div class="col-sm-4 col-md-5 col-xs-5">
                <input type="text" required="required"  class="form-control" id="userName" name="userName" placeholder="用户名">
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

        <div class="form-group" id="onepassword">
            <label for="password" class="control-label col-sm-2 col-xs-2 col-xs-offset-1 col-md-1 ">密码</label>
            <div class="col-sm-4 col-md-5 col-xs-5">
                <input type="text" required="required"  class="form-control" id="password" name="password" placeholder="Password">
            </div>
            <div class="col-md-0 col-sm-0 col-xs-4"></div>
            <div class="clearfix visible-xs-block"></div>
            <div class="col-md-0 col-sm-0 col-xs-3"></div>
            <div class="col-md-4 col-sm-4 col-xs-7">
                <blockquote id="passwordtip">

                </blockquote>
            </div>
            <div class="col-md-4 col-sm-4 col-xs-2"></div>
        </div>

        <div class="form-group" id="oneemail">
            <label for="email" class="control-label col-sm-2 col-xs-2 col-xs-offset-1 col-md-1 ">Email</label>
            <div class="col-sm-4 col-md-5 col-xs-5">
                <input type="text" required="required" class="form-control" id="email" name="email" placeholder="Email">
            </div>
            <div class="col-md-0 col-sm-0 col-xs-4"></div>
            <div class="clearfix visible-xs-block"></div>
            <div class="col-md-0 col-sm-0 col-xs-3"></div>
            <div class="col-md-4 col-sm-4 col-xs-7">
                <blockquote id="emailtip">

                </blockquote>
            </div>
            <div class="col-md-4 col-sm-4 col-xs-2"></div>
        </div>
        <div id="onetel" class="form-group">
            <label for="tel" class="control-label col-sm-2 col-xs-2 col-xs-offset-1 col-md-1 ">电话</label>
            <div class="col-sm-4 col-md-5 col-xs-5">
                <input type="text"  class="form-control" id="tel" name="tel" placeholder="电话">
            </div>
            <div class="col-md-0 col-sm-0 col-xs-4"></div>
            <div class="clearfix visible-xs-block"></div>
            <div class="col-md-0 col-sm-0 col-xs-3"></div>
            <div class="col-md-4 col-sm-4 col-xs-7">
                <blockquote id="teltip">

                </blockquote>
            </div>
            <div class="col-md-4 col-sm-4 col-xs-2"></div>
        </div>
        <br/>
        <div class="form-group">
            <div class="col-sm-offset-2 col-xs-offset-1 col-sm-10">
                <button id="btns"  type="button" class="btn btn-default" onclick="sub()">修改</button>
            </div>
        </div>
        <div class="form-group">
            <div class="col-md-2 col-sm-2 col-xs-1"></div>
            <div id="myAlert" class="col-sm-8 col-xs-10 col-md-5">

            </div>
            <div class="col-md-5 col-sm-2 col-xs-1"></div>
        </div>
    </form>
</div>
</body>
</html>
