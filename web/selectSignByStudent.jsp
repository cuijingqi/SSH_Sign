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
    <title>全部学生</title>
    <link rel="shortcut icon" href="#" />
    <script type="text/javascript" src="js/jquery-3.4.1.js"></script>
    <script type="text/javascript" src="js/bootstrap.min.js"></script>
    <link  href="css/bootstrap.min.css" rel="stylesheet"/>
    <style>
        @-moz-document url-prefix() {
            fieldset { display: table-cell; }
        }
    </style>
</head>
<body>
<!-- Modal -->
<input id="z" type="hidden"/>
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">警告</h4>
            </div>
            <div class="modal-body">
                此操作不可逆,请确认删除!
            </div>
            <div class="modal-footer">
                <button type="button" id="close" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" id="modal" class="btn btn-primary" data-dismiss="modal">确定</button>
            </div>
        </div>
    </div>
</div>
<div class="container-fluid" id="world">
    <div class="row">
        <div class="col-md-1 col-sm-1"></div>
        <div class="col-md-6 col-sm-6 col-xs-8"><div class="page-header"><h1><small>该生全部考勤</small></h1></div></div>
        <div class="col-md-5 col-sm-5 col-xs-4"></div>
    </div>
    <div class="table-responsive row " style="width: 100%">
        <table class="table table-condensed table-hover">
            <thead>
            <tr>
                <td align="center"><h4>#</h4></td>
                <td align="center"><h4>签到IP</h4></td>
                <td align="center"><h4>签到时间</h4></td>
                <td align="center"><h4>操作</h4></td>
            </tr>
            </thead>
            <tbody id="bodyt">

            </tbody>
            <tfoot id="tfoot">
            </tfoot>
        </table>
    </div>
</div>
<script>
    function g(url,stuId){
        $.get(url,{stuId:stuId},function (data) {
            $("#bodyt").html("");
            $.each( data, function(i, n){
                $("#bodyt").append("<tr>\n" +
                    "                <td align=\'center\' id=\"count"+i+1+"\" class=\"active\">...</td>\n" +
                    "                <td align=\'center\' id=\"IP"+i+1+"\" class=\"success\">...</td>\n" +
                    "                <td align=\'center\' id=\"time"+i+1+"\" class=\"success\">...</td>\n" +
                    "                <td id=\"power"+i+1+"\" class=\"active\" align=\"center\">\n" +
                    "                    <!-- Split button -->\n" +
                    "\n" +
                    "                </td>\n" +
                    "            </tr>");
                $("#count"+i+1).html(i+1);
                $("#IP"+i+1).html(n.ip);
                $("#time"+i+1).html(n.time);
                $("#power"+i+1).html("<div class=\"btn-group\">\n" +
                    "                        <button type=\"button\" data-toggle=\"modal\" data-target=\"#myModal\" onclick='deleter(\""+n.signId+"\")' class=\"btn btn-danger\" >\n" +
                    "                            删除 <span class=\"caret\"></span>\n" +
                    "                        </button>\n" +
                    "                    </div>");
            });
        },"json");
    }
    var bool;
    $("#modal").click(function () {
        setTimeout(function() {
            $.get("Sign/DeleteSign",{signId:bool},function (data) {
                if (data=="win"){
                    ifarme("selectSignByStudent.jsp");
                } else if(data=="once"){
                    alert("该考勤不存在!");
                    ifarme("selectStudent.jsp");
                } else {
                    alert("请联系管理员!");
                    ifarme("selectStudent.jsp");
                }
            },"text");
        }, 100);
    });
    function deleter(signId) {
        bool=signId;
    }
    $(function () {
       g("Student/SelectSign",${pageContext.request.getParameter("stuId")});
    });
</script>
</body>
</html>
