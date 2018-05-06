<%--
  Created by IntelliJ IDEA.
  User: spider
  Date: 26/9/14
  Time: 15:16
--%>
<%@ page import="com.alibaba.fastjson.serializer.SerializerFeature; com.alibaba.fastjson.JSON" contentType="text/html;charset=UTF-8" expressionCodec="none" %>
<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta name="layout" content="homepage">%{--
    <meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>--}%
    <!-- bootstrap 3.0.2 -->
    %{--<asset:stylesheet src="bootstrap.css"/>--}%
    <!-- font Awesome -->
    %{--<asset:stylesheet src="font-awesome.css"/>--}%
    <!-- Theme style -->
    %{--<asset:stylesheet src="AdminLTE.css"/>--}%
    <!-- AdminLTE Skins. Choose a skin from the css/skins
         folder instead of downloading all of them to reduce the load. -->
    %{--<asset:stylesheet src="skins/skin-blue.css"/>--}%
    <!-- page -->
    %{--<asset:stylesheet src="page.css"/>--}%

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <!--<script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>-->
    <![endif]-->
</head>

<body>
<!-- Content Header (Page header) -->
<section class="content-header"></section>
<!-- 引导图 -->
<section class="content">
    <block name="main">
        <div class="main">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-xs-6 col-md-4"><button type="button" class="btn btn-success"><h3 id="validCount">有效代理总数:${validCount}</h3></button></div>
                </div>
                <div class="row">
                    <div class="col-xs-6 col-md-4"><button type="button" class="btn btn-warning"><h3 id="stayCount">待审核:${stayCount}</h3></button></div>
                </div>
                <div class="row">
                    <div class="col-xs-6 col-md-4"><button type="button" class="btn btn-info"><h3 id="allCount">总代理数:${allCount}</h3></button></div>
                </div>
            </div>




            %{--<div class="container-fluid">
                <div class="row">
                    <div class="col-xs-6 col-md-4"><button type="button" class="btn btn-success"><h3>有效代理总数:${validCount}</h3></button></div>
                </div>
                <div class="row">
                    <div class="col-xs-6 col-md-4"><button type="button" class="btn btn-warning"><h3>待审核:${stayCount}</h3></button></div>
                </div>
                <div class="row">
                    <div class="col-xs-6 col-md-4"><button type="button" class="btn btn-info"><h3>总代理数:${allCount}</h3></button></div>
                </div>
            </div>--}%



        </div>
    </block>
</section>
<!-- /.content -->

</body>

</html>