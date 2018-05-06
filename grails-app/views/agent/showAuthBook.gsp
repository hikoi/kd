<%--
  Created by IntelliJ IDEA.
  User: unes
  Date: 2018/4/27
  Time: 16:16
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta name="layout" content="homepage">
</head>

<body>
    <div class="row">
        <g:each in="authImgList" var="vo">
            <img src="${vo}" style="margin-bottom: 20px;margin-left: 20px;">
        </g:each>
    </div>
</body>
</html>