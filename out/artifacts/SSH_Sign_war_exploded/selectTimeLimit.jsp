<%@ page import="java.text.SimpleDateFormat" %><%--
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
    <title>全部考勤时段</title>
    <link rel="shortcut icon" href="#" />
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.4.1.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap-datetimepicker.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap-datetimepicker.zh-CN.js"></script>
    <link  href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="${pageContext.request.contextPath}/css/bootstrap-datetimepicker.min.css" rel="stylesheet">
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
                此考勤下的所有签到会一并删除,此操作不可逆,请确认删除!
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
                    <input id="baidu"  type="text" class="form-control" placeholder="时间检索!">
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
                <td align="center"><h4>起始时间</h4></td>
                <td align="center"><h4>终止时间</h4></td>
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
        var reg=/^(\d{1,4})(-|\/)(\d{1,2})\2(\d{1,2}) (\d{1,2}):(\d{1,2})$/;
        var baidu = $("#baidu").val();
        if (baidu==""||!reg.test(baidu)){
            g("TimeLimit/SelectTimeLimit",1,8);
            $("#tfoot").show();
            return;
        }
        g("TimeLimit/SelectTimeLimit",1,88888888,baidu);
        $("#tfoot").hide();
    });
    //参数n为休眠时间，单位为毫秒:
    function sleep(n) {
        var start = new Date().getTime();
        //  console.log('休眠前：' + start);
        while (true) {
            if (new Date().getTime() - start > n) {
                break;
            }
        }
        // console.log('休眠后：' + new Date().getTime());
    }
    function g(url,index,max,baidu){
        var i=$("li[id^=p]").length;
        if (index>i) index=i;
        if (index<1)index=1;
        $.get(url,{index:index,max:max,baidu:baidu},function (data) {
            $("#bodyt").html("");
            $.each( data, function(i, n){
                $.get("TimeLimit/SelectSign",{TLId:n.tlid},function (sign) {
                    $("#bodyt").append("<tr>\n" +
                        "                <td align=\'center\' id=\"count"+i+1+"\" class=\"active\">...</td>\n" +
                        "                <td align=\'center\' id=\"startTime"+i+1+"\" class=\"success\">...</td>\n" +
                        "                <td align=\'center\' id=\"endTime"+i+1+"\" class=\"warning\">...</td>\n" +
                        "                <td align=\'center\' id=\"signStudentCount"+i+1+"\" class=\"danger\">...</td>\n" +
                        "                <td id=\"power"+i+1+"\" class=\"active\" align=\"center\">\n" +
                        "                    <!-- Split button -->\n" +
                        "\n" +
                        "                </td>\n" +
                        "            </tr>");
                    // var parse = JSON.parse(i);
                    // var parse = eval(i);
                    $("#count"+i+1).html(i+1);
                    $("#startTime"+i+1).html(n.startTime);
                    $("#endTime"+i+1).html(n.endTime);
                    $("#signStudentCount"+i+1).html(sign.length);
                    $("#power"+i+1).html("<div class=\"btn-group\">\n" +
                        "                        <button type=\"button\" onclick='s(\""+n.tlid+"\")' class=\"btn btn-success\" >\n" +
                        "                            查看签到学生 <span class=\"caret\"></span>\n" +
                        "                        </button>\n" +
                        "                        <button type=\"button\" onclick='u(\""+n.tlid+"\")' class=\"btn btn-warning\" >\n" +
                        "                            修改 <span class=\"caret\"></span>\n" +
                        "                        </button>\n" +
                        "                        <button type=\"button\" data-toggle=\"modal\" data-target=\"#myModal\" onclick='deleter(\""+n.tlid+"\")' class=\"btn btn-danger\" >\n" +
                        "                            删除 <span class=\"caret\"></span>\n" +
                        "                        </button>\n" +
                        "                    </div>");
                },"json");
                sleep(20);
            });
            $("li[id^=p]").removeClass("active")
            $("#p"+index).addClass("active");
            $("#pages").val(index);
            if (baidu!=null){
            }else {
            }
        },"json");
    }
    var bool;
    $("#modal").click(function () {
        setTimeout(function() {
            $.get("TimeLimit/DeleteTimeLimit",{TLId:bool},function (data) {
                if (data=="win"){
                    ifarme("selectTimeLimit.jsp");
                } else if(data=="once"){
                    alert("该考勤不存在!");
                    ifarme("selectTimeLimit.jsp");
                } else {
                    alert("请联系管理员!");
                    ifarme("selectTimeLimit.jsp");
                }
            },"text");
        }, 100);
    });
    function deleter(TLId) {
        bool=TLId;
    }
    function u(TLId){
        $.ajax({
            type: "POST",
            url: "TimeLimit/Find",
            data: {TLId:TLId},
            success: function (dat) {
                $.get("updataTimeLimit.jsp",function (data) {
                    data=data+"<scr"+"ipt>\n" +
                        "        $(\"#TLId\").val(\'"+dat.tlid.toString().substring(0,16)+"\');\n" +
                        "        $(\"#startTime\").val(\'"+dat.startTime.substring(0,16)+"\');\n" +
                        "        $(\"#endTime\").val(\'"+dat.endTime.substring(0,16)+"\');\n" +
                        "</scr"+"ipt>"
                    $("#ifarme").html(data);
                });
            }
        });
    };
    function s(TLId){
        $.ajax({
            type: "POST",
            url: "selectStudentByTimeLimit.jsp",
            data: {TLId:TLId},
            success: function (data) {
                $("#ifarme").html(data);
            }
        });
    }
    $("#top").click(function () {
        var p= $("#pages").val();
        var z=parseInt(p)-1;
        if (z<1)z=1;
        g("TimeLimit/SelectTimeLimit",z,8);
    });
    $("#after").click(function () {
        $.get("TimeLimit/IndexPages",{ max: "8"},
            function(data){
                var p= $("#pages").val();
                var i=data;
                var z=parseInt(p)+1;
                if(z>i)z=i;
                g("TimeLimit/SelectTimeLimit",z,8);
            });
    });
    $("#start").click(function () {
        g("TimeLimit/SelectTimeLimit",1,8);
    });
    $("#end").click(function () {

        $.get("TimeLimit/IndexPages",{ max: "8"},
            function(data){
                var i=data;
                g("TimeLimit/SelectTimeLimit",i,8);
            });
    })
    function open(){
        g("TimeLimit/SelectTimeLimit",1,8);
        $.get("TimeLimit/IndexPages",{ max: "8"},
            function(data){
                var i=data;
                for (var z=1;z<=i;z++){
                    $("#after").before("<li id=\'p"+z+"\'><a href=\"javascript:void(0);\" onclick=g(\'TimeLimit/SelectTimeLimit\',\'"+z+"\',\'8\');>"+z+"</a></li>");
                }
            });
    };
    $("#baidu").datetimepicker({
        format: 'yyyy-mm-dd hh:ii',
        language: 'zh-CN',
        autoclose:true,
        initialDate: new Date(),//初始化当前日期
    });
    $(function () {
       open();
    });
</script>
</body>
</html>
