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
    <title>添加考勤时段</title>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.4.1.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap-datetimepicker.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap-datetimepicker.zh-CN.js"></script>
    <link  href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="${pageContext.request.contextPath}/css/bootstrap-datetimepicker.min.css" rel="stylesheet">
    <script>
        function validity() {
            var reg=/^(\d{1,4})(-|\/)(\d{1,2})\2(\d{1,2}) (\d{1,2}):(\d{1,2})$/;
            if ($("#startTime").val()!=""&&reg.test($("#startTime").val())){
                $("#onestarttime").removeClass("has-error");
                $("#onestarttime").addClass("has-success");
                if ($("#endTime").val()!=""&&reg.test($("#endTime").val())){
                    $("#oneendtime").removeClass("has-error");
                    $("#oneendtime").addClass("has-success");
                    if ($("#blank").val()!=""&&!isNaN($("#blank").val())){
                        $("#oneblank").removeClass("has-error");
                        $("#oneblank").addClass("has-success");
                        if ($("#count").val()!=""&&!isNaN($("#count").val())){
                            $("#onecount").removeClass("has-error");
                            $("#onecount").addClass("has-success");
                            return true;
                        } else {
                            $("#onecount").removeClass("has-success");
                            $("#onecount").addClass("has-error");
                            return false;
                        }
                    } else {
                        $("#blank").removeClass("has-success");
                        $("#blank").addClass("has-error");
                        return false;
                    }
                } else {
                    $("#oneendtime").removeClass("has-success");
                    $("#oneendtime").addClass("has-error");
                    return false;
                }
            } else {
                $("#onestarttime").removeClass("has-success");
                $("#onestarttime").addClass("has-error");
                return false;
            }
            return false;
        }
        function sub() {
            if (validity()){
                var blank = $("#blank").val();
                var count = $("#count").val();
                var startTime = $("#startTime").val();
                var endTime = $("#endTime").val();
                $.ajax({
                    type: "POST",
                    url: "TimeLimit/InsertTimeLimit",
                    data: {
                        startTime:startTime,
                        endTime:endTime,
                        blank:blank,
                        count:count
                    },
                    success: function (data) {
                        $("#myAlert").html("<div class=\"alert alert-success\">\n" +
                            "                <a href=\"#\" class=\"close\" data-dismiss=\"alert\">&times;</a>\n" +
                            "                <strong>添加结果:</strong> "+data+"\n" +
                            "            </div>");
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
        <div class="col-md-6 col-sm-6 col-xs-8"><div class="page-header"><h1><small>添加考勤时段</small></h1></div></div>
        <div class="col-md-5 col-sm-5 col-xs-4"></div>
    </div>
    <form id="submit" class="form-horizontal">
        <div class="form-group" id="onestarttime">
            <label for="startTime" class="control-label col-sm-2 col-xs-2 col-xs-offset-1 col-md-1 ">起始时间</label>
            <div class="col-sm-4 col-md-5 col-xs-5">
                <input type="text" required="required"  class="form-control" id="startTime" name="startTime" placeholder="起始时段">
            </div>
            <div class="col-md-6 col-sm-6 col-xs-4"></div>
        </div>
        <div class="form-group" id="oneendtime">
            <label for="endTime" class="control-label col-sm-2 col-xs-2 col-xs-offset-1 col-md-1 ">终止时间</label>
            <div class="col-sm-4 col-md-5 col-xs-5">
                <input type="text" required="required"  class="form-control" id="endTime" name="endTime" placeholder="终止时段">
            </div>
            <div class="col-md-6 col-sm-6 col-xs-4"></div>
        </div>
        <div class="form-group" id="oneblank">
            <label for="blank" class="control-label col-sm-2 col-xs-2 col-xs-offset-1 col-md-1 ">间隔</label>
            <div class="col-sm-4 col-md-5 col-xs-5">
                <input type="text" required="required"  class="form-control" id="blank" name="blank" placeholder="和次数联合使用,多次添加时之间的间隔,例如7,即次数间隔为每周.">
            </div>
            <div class="col-md-6 col-sm-6 col-xs-4"></div>
        </div>
        <div class="form-group" id="onecount">
            <label for="count" class="control-label col-sm-2 col-xs-2 col-xs-offset-1 col-md-1 ">次数</label>
            <div class="col-sm-4 col-md-5 col-xs-5">
                <input type="text" required="required"  class="form-control" id="count" name="count" placeholder="批量添加,填写间隔联合使用">
            </div>
            <div class="col-md-6 col-sm-6 col-xs-4"></div>
        </div>
        <br/>
        <div class="form-group">
            <div class="col-sm-offset-2 col-xs-offset-1 col-sm-10">
                <button id="btns"  type="button" class="btn btn-default" onclick="sub()">添加</button>
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
<script>
    $("#startTime").datetimepicker({
        format: 'yyyy-mm-dd hh:ii',
        language: 'zh-CN',
        autoclose:true,
        initialDate: new Date(),//初始化当前日期
    }).on("click",function(){
        $("#startTime").datetimepicker("setEndDate",$("#endTime").val());
    });
    $("#endTime").datetimepicker({
        format: 'yyyy-mm-dd hh:ii',
        language: 'zh-CN',
        autoclose:true,
        initialDate: new Date(),//初始化当前日期
    }).on("click",function(){
        $("#endTime").datetimepicker("setStartDate",$("#startTime").val());
    });
</script>
</body>
</html>
