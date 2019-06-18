<%--
  Created by IntelliJ IDEA.
  User: 崔靖奇
  Date: 2019/6/16
  Time: 21:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page isErrorPage="true" %>
<!--
彩蛋
开发者Email:546836710@qq.com
交流建议及提交BUG
感谢使用我闲暇之余而诞生的作品
祝你早午晚都安!
-->
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>error page</title>
</head>
<body>
开发者Email:546836710@QQ.COM
error page getMessage:<H3><%= exception.getMessage() %></H3>
error page getCause:<H3><%= exception.getCause() %></H3>
error page getStackTrace:<H3><%= exception.getStackTrace() %></H3>
error page getLocalizedMessage:<H3><%= exception.getLocalizedMessage() %></H3>
error page getSuppressed:<H3><%= exception.getSuppressed() %></H3>
error page getClass:<H3><%= exception.getClass() %></H3>

</body>
</html>