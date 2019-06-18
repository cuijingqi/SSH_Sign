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
                <td align="center"><h4>学号</h4></td>
                <td align="center"><h4>姓名</h4></td>
                <td align="center"><h4>性别</h4></td>
                <td align="center"><h4>班级</h4></td>
                <td align="center"><h4>电话</h4></td>
                <td align="center"><h4>签到总数</h4></td>
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
            g("Student/SelectStudent",1,8);
            $("#tfoot").show();
            return;
        }
        g("Student/SelectStudent",1,88888888,baidu);
        $("#tfoot").hide();
    });
    function g(url,index,max,baidu){
        var i=$("li[id^=p]").length;
        if (index>i) index=i;
        if (index<1)index=1;
        $.get(url,{index:index,max:max,baidu:baidu},function (data) {
            $("#bodyt").html("");
            $.each( data, function(i, n){
                // $.get("Student/SignCount",{stuId:n.stuId},function (dat) {
                //     signCount=dat;
                // });
                $("#bodyt").append("<tr>\n" +
                    "                <td align=\'center\' id=\"count"+i+1+"\" class=\"active\">...</td>\n" +
                    "                <td align=\'center\' id=\"stuId"+i+1+"\" class=\"success\">...</td>\n" +
                    "                <td align=\'center\' id=\"stuName"+i+1+"\" class=\"warning\">...</td>\n" +
                    "                <td align=\'center\' id=\"sex"+i+1+"\" class=\"danger\">...</td>\n" +
                    "                <td align=\'center\' id=\"classId"+i+1+"\" class=\"info\">...</td>\n" +
                    "                <td align=\'center\' id=\"tel"+i+1+"\" class=\"warning\">...</td>\n" +
                    "                <td align=\'center\' id=\"signCount"+i+1+"\" class=\"success\">...</td>\n" +
                    "                <td id=\"power"+i+1+"\" class=\"active\" align=\"center\">\n" +
                    "                    <!-- Split button -->\n" +
                    "\n" +
                    "                </td>\n" +
                    "            </tr>");
                $("#count"+i+1).html(i+1);
                $("#stuId"+i+1).html(n.stuId);
                $("#stuName"+i+1).html(n.stuName);
                $("#sex"+i+1).html(n.sex);
                $("#classId"+i+1).html(n.classId);
                $("#tel"+i+1).html(n.tel);
                $("#signCount"+i+1).html(n.signs.length);
                $("#power"+i+1).html("<div class=\"btn-group\">\n" +
                    "                        <button type=\"button\" onclick='u(\""+n.stuId+"\")' class=\"btn btn-success\" >\n" +
                    "                            查看签到记录 <span class=\"caret\"></span>\n" +
                    "                        </button>\n" +
                    "                    </div>");
            });
            $("li[id^=p]").removeClass("active")
            $("#p"+index).addClass("active");
            $("#pages").val(index);
            if (baidu!=null){
            }else {
            }
        },"json");
    }
    function u(stuId){
        $.ajax({
            type: "POST",
            url: "selectSignByStudent.jsp",
            data: {stuId: stuId},
            success: function (data) {
                    $("#ifarme").html(data);
            }
        });
    };
    $("#top").click(function () {
        var p= $("#pages").val();
        var z=parseInt(p)-1;
        if (z<1)z=1;
        g("Student/SelectStudent",z,8);
    });
    $("#after").click(function () {
        $.get("Student/IndexPages",{ max: "8"},
            function(data){
                var p= $("#pages").val();
                var i=data;
                var z=parseInt(p)+1;
                if(z>i)z=i;
                g("Student/SelectStudent",z,8);
            });
    });
    $("#start").click(function () {
        g("Student/SelectStudent",1,8);
    });
    $("#end").click(function () {

        $.get("Student/IndexPages",{ max: "8"},
            function(data){
                var i=data;
                g("Student/SelectStudent",i,8);
            });
    })
    function open(){
        g("Student/SelectStudent",1,8);
        $.get("Student/IndexPages",{ max: "8"},
            function(data){
                var i=data;
                for (var z=1;z<=i;z++){
                    $("#after").before("<li id=\'p"+z+"\'><a href=\"javascript:void(0);\" onclick=g(\'Student/SelectStudent\',\'"+z+"\',\'8\');>"+z+"</a></li>");
                }
            });
    };
    $(function () {
       open();
    });
</script>
</body>
</html>
