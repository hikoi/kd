<%--
  Created by IntelliJ IDEA.
  User: unes
  Date: 2018/4/23
  Time: 16:30
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta name="layout" content="homepage">
    <meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>
    %{--<asset:javascript src="jquery-2.1.3.js"/>--}%
</head>

<body>
    <ul class="list-group" >
        <li class="list-group-item list-group-item-success"><h4 style="margin:0;">商品列表</h4></li>
    </ul>
    <form id="myForm" class="form-inline" method="post" action="/goods/index" enctype="multipart/form-data">
        <div class="form-group">
            <label for="code">商品编码</label>
            <input type="text" class="form-control" id="code" name="code" value="${params.code}">
        </div>
        <div class="form-group">
            <label for="title">商品标题</label>
            <input type="text" class="form-control" id="title" name="title" value="${params.title}">
        </div>
        <button type="submit" class="btn btn-default">搜索</button>
        <span id="reset" class="btn btn-default">重置</span>
    </form>
    <div class="panel panel-default" style="margin-top: 20px;">
        <table class="table">
            <thead>
            <tr>
                <th>商品ID</th>
                <th>商品编码</th>
                <th>商品名称</th>
                <th>商品价格</th>
                <th>商品图片</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody>
            <g:each in="${pagedResultList}" var="vo">
                <tr>
                    <th scope="row">${vo?.id}</th>
                    <th scope="row">${vo?.code}</th>
                    <td>${vo?.title}</td>
                    <td>${vo?.markPrice}</td>
                    <td>
                        <g:if test="${vo?.pic}">
                            <img src="${webRequest.getBaseUrl() + "/Uploads/" + vo?.pic}"  class="img-rounded" style="height: 70px;">
                        </g:if>
                    </td>
                    <td>
                        <button type="button" goodsId ="${vo?.id}" class="btn btn-info edit_goods">修改</button>
                    </td>
                </tr>
            </g:each>
            </tbody>
        </table>
    </div>
    <nav>
        <ul class="pagination">
            <li>
                %{-- 分页 --}%
                <g:if test="${total > 0}">
                    <g:paginate next="下一页" prev="上一页" params="${params}"
                                maxsteps="10" action="index" total="${total}"/>
                </g:if>
                <a>商品总数:${total}</a>
            </li>
        </ul>
    </nav>
    <script>
        $(function(){
            //重置条件搜索栏
            $("#reset").click(function () {
                window.location.href="/goods/index?code&title";
            });
    
            //分页
            /*$('.pagination li').click(function(){
                var page = $(this).children('a').attr('page');
                var class_name = $(this).attr('class');
    
                if(class_name != 'active'){
                    LoadPage('__APP__/Goods/index.html',{'p': page});
                }
    
            });*/
    
            //修改
            $('.edit_goods').click(function(event) {
                /* Act on the event */
                var goodsId = $(this).attr('goodsId');
                window.location.href = '/goods/goodsCreateOrUpdateUI?goodsId=' + goodsId;
    
            });
    
            //搜索
            /*$('#myForm').submit(function() {
    
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