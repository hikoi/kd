<%--
  Created by IntelliJ IDEA.
  User: unes
  Date: 2018/4/24
  Time: 19:29
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta name="layout" content="homepage">
</head>

<body>
    <ul class="list-group" >
        <li class="list-group-item list-group-item-success"><h4 style="margin:0;">素材分类列表</h4></li>
    </ul>
    <button type="button"  class="btn btn-warning cate_view" aid pid="${params.pid}">添加</button>
    <div class="panel panel-default" style="margin-top: 20px;">
        <table class="table">
            <thead>
            <tr>
                <th>分类ID</th>
                <th>分类名称</th>
                <th>分类图片</th>
                <th>上级分类</th>
                <th>分类等级</th>
                <g:if test="${pid}"><th>分类类型</th></g:if>
                <th>是否显示</th>
                <th>添加时间</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody>
            <g:each in="${pagedResultList}" var="vo">
                <tr>
                    <th scope="row">${vo?.id}</th>
                    <td>${vo?.title}</td>
                    <td><img src="${'http://kudouys.b0.upaiyun.com/' + vo?.headImg}" alt="" width="50"></td>
                    <td>${vo?.parentTitle}</td>
                    <td>第${vo?.cateLv}级</td>
                    <g:if test="${pid}">
                        <td>
                            <g:if test="${vo?.cateType == 1}">图片</g:if>
                            <g:elseif test="${vo?.cateType == 2}">文章</g:elseif>
                            <g:elseif test="${vo?.cateType == 0}"><b style="color:red;">请选择类型</b></g:elseif>
                            <g:elseif test="${vo?.cateType == 3}">朋友圈</g:elseif>
                            <g:elseif test="${vo?.cateType == 4}">视频</g:elseif>
                        </td>
                    </g:if>
                    <td><g:if test="${vo?.isShow == 1}">显示</g:if><g:else>不显示</g:else></td>
                    <td class="addTime">${vo?.addTime}</td>
                    <td>

                        <button type="button" aid="${vo?.id}" pid="${params.pid}" class="btn btn-warning cate_view">修改</button>
                        <g:if test="${pid}">
                            <button type="button" cid="${vo?.id}" cateType="${vo?.cateType}" class="btn btn-info show_fodder">查看素材</button>
                            <button type="button" cid="${vo?.id}" class="btn btn-warning add_fodder">添加素材</button>
                        </g:if>
                        <g:else>
                            <button type="button" pid="${vo?.id}" class="btn btn-info show_next">查看下级(${vo?.junior})</button>
                            <button type="button" pid="${vo?.id}" aid class="btn btn-warning cate_view">添加下级</button>
                        </g:else>
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
                                max="15" maxsteps="10" action="index" total="${total}"/>
                </g:if>
                <a>分类总数:${total}</a>
            </li>
        </ul>
    </nav>
    <script>
        $(function(){

            //查看下级
            $('.show_next').click(function(event) {
                /* Act on the event */
                var pid = $(this).attr('pid');
                window.location.href = "/fodderCategory/index?pid=" + pid;

            });

            //添加素材
            $('.add_fodder').click(function(event) {
                /* Act on the event */
                var cid = $(this).attr('cid');

                LoadPage('__APP__/FodderManage/addArticleView.html',{cate_lv2:cid});

            });

            //查看素材
            $('.show_fodder').click(function(event) {
                /* Act on the event */
                var cid = $(this).attr('cid');
                var cateType = $(this).attr('cateType');
                if(cateType == 0 || cateType == 1){//分类类型是图片或者请选择类型
                    window.location.href = "/fodderPicture/index?cid=" + cid + "&cateType=" + cateType;
                }else {
                    window.location.href = "/fodderArticle/index?cid=" + cid + "&cateType=" + cateType;
                }

            });

            //添加或者修改素材分类
            $('.cate_view').click(function(event) {
                /* Act on the event */
                var id = $(this).attr('aid'),
                    pid = $(this).attr('pid');
                window.location.href = "/fodderCategory/createOrUpdateUI?id=" + id + "&pid=" + pid;
            });

            //删除
            $('.del_agent').click(function(event) {
                /* Act on the event */
                var aid = $(this).attr('aid');

                if(aid == ''){
                    alert('请选择代理');
                    return false;
                }

                if (confirm("是否确定删除"))  {
                    $.post('__APP__/FodderManage/delAgent.html', {aid: aid}, function(data) {
                        alert(data.msg);
                        if(data.status == 1){
                            LoadPage("__APP__/FodderManage/index.html");
                        }
                    });
                }

                return false;

            });

            //搜索
            $('#myForm').submit(function() {

                $(this).ajaxSubmit(function(data){
                    $('.main .container-fluid').html(data);
                });

                //防止页面刷新
                return false;
            });

        });

    </script>
</body>
</html>