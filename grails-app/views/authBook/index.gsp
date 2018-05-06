<%--
  Created by IntelliJ IDEA.
  User: unes
  Date: 2018/4/17
  Time: 12:07
--%>

<%@ page import="com.alibaba.fastjson.serializer.SerializerFeature; com.alibaba.fastjson.JSON" contentType="text/html;charset=UTF-8" expressionCodec="none" %>
<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta name="layout" content="homepage">
    <meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>
</head>

<body>
    <ul class="list-group" >
        <li class="list-group-item list-group-item-success"><h4 style="margin:0;">授权书列表</h4></li>
    </ul>
    <form id="myForm" class="form-inline" method="post" action="/authBook/index" enctype="multipart/form-data">

        <div class="form-group">
            <label for="name">授权书名字</label>
            <input type="text" class="form-control" id="name" name="name" value="${params.name}">
        </div>
        <button type="submit" class="btn btn-default">搜索</button>
    </form>
    <div class="panel panel-default" style="margin-top: 20px;">
        <table class="table">
            <thead>
            <tr>
                <th>授权书编码</th>
                <th>授权书名称</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody>
                <g:each status="i" in="${authBookList}" var="authBook">
                    <tr id="${authBook?.id}" class="info">
                        <td>${authBook?.id}</td>
                        <td>${authBook?.name}</td>
                        <td>
                            <button type="button" aid="${authBook?.id}" class="btn btn-info edit_goods">修改</button>
                        </td>
                    </tr>
                </g:each>
            </tbody>
        </table>
    </div>
    <nav>
        <ul class="pagination">
            %{--<g:if test="${params.offset/10}"--}%
            <li>
                %{-- 分页 --}%
                <g:if test="${total > 0}">
                    <g:paginate next="下一页" prev="上一页" params="${params}"
                                maxsteps="10" action="index" total="${total}"/>
                </g:if>
                <a>授权书总数:${total}</a>
            </li>
        </ul>
    </nav>
    <script>
        $(function(){

           /* //分页
            $('.pagination li').click(function(){
                var page = $(this).children('a').attr('page');
                var class_name = $(this).attr('class');

                if(class_name != 'active'){
                    LoadPage('__APP__/Goods/index.html',{'p': page});
                }

            });*/

            //修改
            $('.edit_goods').click(function(event) {
                /* Act on the event */
                var aid = $(this).attr('aid');
                //LoadPage('__APP__/AuthBook/add.html',{'aid': aid});
                window.location.href = "/authBook/authBookCreateHtml?aid=" + aid

            });

            //搜索
            /*$('#myForm').submit(function() {
                alert(111);
                $(this).ajaxSubmit(function(data){
                    $('.main .container-fluid').html(data);
                });

                //防止页面刷新
                return false;
            });*/

        });

    </script>
</body>
</html>