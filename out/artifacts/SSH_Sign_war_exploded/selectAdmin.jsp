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
    <title>全部子管理员</title>
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
        <div class="col-md-7 col-sm-7 col-xs-8">
            <div class="col-lg-12">
                <div class="input-group">
                    <input id="baidu"  type="text" class="form-control" placeholder="姓名关键字模糊检索!">
                    <span class="input-group-btn">
                        <button id="google" class="btn btn-default" type="button">Go!</button>
                    </span>
                </div><!-- /input-group -->
            </div><!-- /.col-lg-6 -->
        </div>
        <div class="col-md-5 col-sm-5 col-xs-4">
            <input id="pages" type="hidden"/>
        </div>
    </div>
    <div class="table-responsive row " style="width: 100%">
        <table class="table table-condensed table-hover">
            <thead>
            <tr>
                <td align="center"><h4>#</h4></td>
                <td align="center"><h4>编号</h4></td>
                <td align="center"><h4>姓名</h4></td>
                <td align="center"><h4>用户名</h4></td>
                <td align="center"><h4>密码</h4></td>
                <td align="center"><h4>邮箱</h4></td>
                <td align="center"><h4>电话</h4></td>
                <td align="center"><h4>创建时间</h4></td>
                <td align="center"><h4>操作</h4></td>
            </tr>
            </thead>
            <tbody id="bodyt">

            </tbody>
            <tfoot id="tfoot">
            <tr>
                <td colspan="7">
                    <nav aria-label="Page navigation">
                        <ul class="pagination">
                            <li id="start" class="previous"><a href="#"><span aria-hidden="true">&larr;</span> 首页</a></li>
                            <li>
                                <a id="top" href="#" aria-label="Previous">
                                    <span aria-hidden="true">&laquo;</span>
                                </a>
                            </li>

                            <li id="after">
                                <a id="down" href="#" aria-label="Next">
                                    <span aria-hidden="true">&raquo;</span>
                                </a>
                            </li>
                            <li id="end" class="next"><a href="#">末尾 <span aria-hidden="true">&rarr;</span></a></li>
                        </ul>
                    </nav>
                </td>
            </tr>
            </tfoot>
        </table>
    </div>
</div>
<script>
    $("#google").click(function () {
        var baidu = $("#baidu").val();
        if (baidu==""||baidu.length>6){
            g("Admin/SelectAdmin",1,8,${pageContext.session.getAttribute("admin").AId});
            $("#tfoot").show();
            return;
        }
        g("Admin/SelectAdmin",1,88888888,${pageContext.session.getAttribute("admin").AId},baidu);
        $("#tfoot").hide();
    });
    function g(url,index,max,competence,baidu){
        var i=$("li[id^=p]").length;
        if (index>i) index=i;
        if (index<1)index=1;
        $.get(url,{index:index,max:max,competence:competence,baidu:baidu},function (data) {
            $("#bodyt").html("");
            $.each( data, function(i, n){
                $("#bodyt").append("<tr>\n" +
                    "                <td align=\'center\' id=\"count"+i+1+"\" class=\"active\">...</td>\n" +
                    "                <td align=\'center\' id=\"AId"+i+1+"\" class=\"success\">...</td>\n" +
                    "                <td align=\'center\' id=\"name"+i+1+"\" class=\"warning\">...</td>\n" +
                    "                <td align=\'center\' id=\"userName"+i+1+"\" class=\"info\">...</td>\n" +
                    "                <td align=\'center\' id=\"password"+i+1+"\" class=\"danger\">...</td>\n" +
                    "                <td align=\'center\' id=\"email"+i+1+"\" class=\"info\">...</td>\n" +
                    "                <td align=\'center\' id=\"tel"+i+1+"\" class=\"warning\">...</td>\n" +
                    "                <td align=\'center\' id=\"createDate"+i+1+"\" class=\"success\">...</td>\n" +
                    "                <td id=\"power"+i+1+"\" class=\"active\" align=\"center\">\n" +
                    "                    <!-- Split button -->\n" +
                    "\n" +
                    "                </td>\n" +
                    "            </tr>");
                $("#count"+i+1).html(i+1);
                $("#AId"+i+1).html(n.aid);
                $("#name"+i+1).html(n.name);
                $("#userName"+i+1).html(n.userName);
                $("#password"+i+1).html(n.password);
                $("#email"+i+1).html(n.email);
                $("#tel"+i+1).html(n.tel);
                $("#createDate"+i+1).html(n.createDate);
                $("#power"+i+1).html("<div class=\"btn-group\">\n" +
                    "                        <button type=\"button\" data-toggle=\"modal\" data-target=\"#myModal\" onclick='deleter(\""+n.aid+"\")' class=\"btn btn-danger\" >\n" +
                    "                            删除 <span class=\"caret\"></span>\n" +
                    "                        </button>\n" +
                    "                    </div>");
            });
            $("li[id^=p]").removeClass("active")
            $("#p"+index).addClass("active");
            $("#pages").val(index);
            if (competence!=null){
            }else {
            }
        },"json");
    }
    var bool;
    $("#modal").click(function () {
        setTimeout(function() {
            $.get("Admin/DeleteAdmin",{AId:bool},function (data) {
                if (data=="win"){
                    ifarme("selectAdmin.jsp");
                } else if(data=="once"){
                    alert("该管理员不存在!");
                    ifarme("selectAdmin.jsp");
                } else {
                    alert("请联系开发者Email:546836710@qq.com!");
                    ifarme("selectAdmin.jsp");
                }
            },"text");
        }, 100);
    });
    function deleter(AId) {
        bool=AId;
    }
    $("#top").click(function () {
        var p= $("#pages").val();
        var z=parseInt(p)-1;
        if (z<1)z=1;
        g("Admin/SelectAdmin",z,8,${pageContext.session.getAttribute("admin").AId});
    });
    $("#after").click(function () {
        $.get("Admin/IndexPages",{ max: "8",competence:${pageContext.session.getAttribute("admin").AId}},
            function(data){
                var p= $("#pages").val();
                var i=data;
                var z=parseInt(p)+1;
                if(z>i)z=i;
                g("Admin/SelectAdmin",z,8,${pageContext.session.getAttribute("admin").AId});
            });
    });
    $("#start").click(function () {
        g("Admin/SelectStudent",1,8,${pageContext.session.getAttribute("admin").AId});
    });
    $("#end").click(function () {

        $.get("Admin/IndexPages",{ max: "8",competence:${pageContext.session.getAttribute("admin").AId}},
            function(data){
                var i=data;
                g("Admin/SelectAdmin",i,8,${pageContext.session.getAttribute("admin").AId});
            });
    })
    function open(){
        g("Admin/SelectAdmin",1,8,${pageContext.session.getAttribute("admin").AId});
        $.get("Admin/IndexPages",{ max: "8",competence:${pageContext.session.getAttribute("admin").AId}},
            function(data){
                var i=data;
                for (var z=1;z<=i;z++){
                    $("#after").before("<li id=\'p"+z+"\'><a href=\"javascript:void(0);\" onclick=g(\'Admin/SelectAdmin\',\'"+z+"\',\'8\',${pageContext.session.getAttribute("admin").AId});>"+z+"</a></li>");
                }
            });
    };
    $(function () {
       open();
    });
</script>
</body>
</html>
