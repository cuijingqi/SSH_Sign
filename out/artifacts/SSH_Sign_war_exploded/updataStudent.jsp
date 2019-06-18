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
    <title>修改学生</title>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.4.1.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
    <link  href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet"/>
    <script>
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
        function validity() {
            if ($("#stuId").val().trim()!="") {
                $("#oneid").removeClass("has-error");
                $("#oneid").addClass("has-success");
                if ($("#stuName").val().trim()!=""&&$("#stuName").val().trim().length<8) {
                    $("#onename").removeClass("has-error");
                    $("#onename").addClass("has-success");
                    if ($("#classId").val().trim()!="") {
                        $("#oneclass").removeClass("has-error");
                        $("#oneclass").addClass("has-success");
                        if (telvalidity()){
                            return true;
                        }
                        return  false;
                    } else{
                        $("#oneclass").removeClass("has-success");
                        $("#oneclass").addClass("has-error");
                        return false;
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
                if ($("#stuName").val().trim()!=""&&$("#stuId").val().trim()!=""&&$("#classId").val().trim()!=""&&$("#tel").val().trim()!=""){
                    var stuId = $("#stuId").val();
                    var stuName = $("#stuName").val();
                    var sex=$("input[type='radio']:checked").val();
                    var classId = $("#classId").val();
                    var tel = $("#tel").val();
                    $.ajax({
                        type: "POST",
                        url: "Student/UpdataStudent",
                        data: {stuId: stuId,
                            stuName:stuName,
                            sex:sex,
                            classId:classId,
                            tel:tel},
                        success: function (data) {
                            if (data=="win"){
                                $("#myAlert").html("<div class=\"alert alert-success\">\n" +
                                    "                <a href=\"#\" class=\"close\" data-dismiss=\"alert\">&times;</a>\n" +
                                    "                <strong>成功</strong> 修改成功!\n" +
                                    "            </div>");
                            }else if (data=="once"){
                                $("#myAlert").html("<div class=\"alert alert-warning\">\n" +
                                    "                <a href=\"#\" class=\"close\" data-dismiss=\"alert\">&times;</a>\n" +
                                    "                <strong>失败</strong> 学生不存在!\n" +
                                    "            </div>")
                            } else {
                                $("#myAlert").html("<div class=\"alert alert-danger\">\n" +
                                    "                <a href=\"#\" class=\"close\" data-dismiss=\"alert\">&times;</a>\n" +
                                    "                <strong>错误</strong> 请联系管理员!\n" +
                                    "            </div>")
                            }
                        }
                    });
                }
            }
        };
    </script>
</head>
<body>
<div class="container-fluid" id="world">
    <div class="row">
        <div class="col-md-1 col-sm-1"></div>
        <div class="col-md-6 col-sm-6 col-xs-8"><div class="page-header"><h1><small>修改学生</small></h1></div></div>
        <div class="col-md-5 col-sm-5 col-xs-4"></div>
    </div>
    <form id="submit" class="form-horizontal">
        <div class="form-group" id="oneid">
            <label for="stuId" class="control-label col-sm-2 col-xs-2 col-xs-offset-1 col-md-1 ">学号</label>
            <div class="col-sm-4 col-md-5 col-xs-5">
                <input type="text" required="required" readonly class="form-control" id="stuId" name="stuId" placeholder="学号">
            </div>
            <div class="col-md-6 col-sm-6 col-xs-4"><input type="hidden" id="secret" name="secret" value="0" /></div>
        </div>
        <div class="form-group" id="onename">
            <label for="stuName" class="control-label col-sm-2 col-xs-2 col-xs-offset-1 col-md-1 ">姓名</label>
            <div class="col-sm-4 col-md-5 col-xs-5">
                <input type="text" required="required"  class="form-control" id="stuName" name="stuName" placeholder="姓名">
            </div>
            <div class="col-md-6 col-sm-6 col-xs-4"></div>
        </div>
        <div class="form-group" id="onesex">
            <label for="man" class="control-label col-sm-2 col-xs-2 col-xs-offset-1 col-md-1 ">性别</label>
            <div class="col-sm-4 col-md-5 col-xs-5">
                <div class="row">
                    <div class="radio col-sm-6 col-md-6 col-xs-6">
                    <label>
                        <input type="radio" name="sex" id="man" value="男" checked>男
                    </label>
                    </div>
                    <div class="radio col-sm-6 col-md-6 col-xs-6">
                    <label>
                        <input type="radio" name="sex" id="woman" value="女">女
                    </label>
                    </div>
                </div>
            </div>
            <div class="col-md-6 col-sm-6 col-xs-4"></div>
        </div>
        <div class="form-group" id="oneclass">
            <label for="classId" class="control-label col-sm-2 col-xs-2 col-xs-offset-1 col-md-1 ">班级</label>
            <div class="col-sm-4 col-md-5 col-xs-5">
                <input type="text" required="required" class="form-control" id="classId" name="classId" placeholder="班级">
            </div>
            <div class="col-md-6 col-sm-6 col-xs-4"></div>
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
