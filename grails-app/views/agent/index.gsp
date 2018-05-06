<%--
  Created by IntelliJ IDEA.
  User: spider
  Date: 26/9/14
  Time: 15:16
  代理商列表和待审核代理商列表共用页面
--%>
<%@ page import="com.alibaba.fastjson.serializer.SerializerFeature; com.alibaba.fastjson.JSON" contentType="text/html;charset=UTF-8" expressionCodec="none" %>
<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta name="layout" content="homepage">
</head>

<body>


<ul class="list-group" >
    <li class="list-group-item list-group-item-success">
        <h4 style="margin:0;">
            <g:if test="${params?.audit}">
                待审核代理商列表<g:if test="${parentAgent}">（${parentAgent?.name}的下级）</g:if>
            </g:if>
            <g:else>
                代理商列表<g:if test="${parentAgent}">（${parentAgent?.name}的下级）</g:if>
            </g:else>
        </h4>
    </li>
</ul>
<form id="myForm" class="form-inline" method="post" action="/agent/index<g:if test='${params?.audit}'>?audit=audit</g:if>" enctype="multipart/form-data">
    %{--<input type="hidden" name="status" value="<{$search.stat}>">--}%
    <input type="hidden" name="aid" value="${parentAgent?.agentid}">
    <div class="form-group">
        <label>代理星级</label>
        <select class="form-control" name="star" id="star">
            <option value="0">--请选择--</option>
            <g:each status="i" in="${agentStars}" var="agentStar">
                <option id="${i+1}" value="${agentStar?.id}">${agentStar?.name}</option>
            </g:each>
        </select>
    </div>
    <div class="form-group">
        <input type="hidden" id="searchF" value="${searchF}">
        <label>
            <select class="form-control" name="searchField" id="search_field">
                <option id="weixin" value="weixin">微信号</option>
                <option id="tel" value="tel">手机号</option>
                <option id="name" value="name">姓名</option>
                <option id="agentNo" value="agentNo">授权编号</option>
            </select>
        </label>
        <input type="text" class="form-control" id="search_value" name="searchValue" value="${searchValue}">
    </div>
    <!-- <div class="form-group">
	    <label for="exampleInputEmail2">商品标题</label>
	    <input type="text" class="form-control" id="title" name="title">
  	</div> -->
    <button type="submit" class="btn btn-default">搜索</button>
    <span id="reset" class="btn btn-default">重置</span>
</form>
<div class="panel panel-default" style="margin-top: 20px;">
    <table class="table">
        <thead>
        <tr>
            <th>姓名</th>
            <th>手机</th>
            <th>微信号</th>
            <th>级别</th>
            <th>状态</th>
            <th>推荐人</th>
            <th>到期时间</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
            <g:each status="i" in="${agentList}" var="vo">
                <tr id="${vo?.id}" class="info">
                    <td>${vo?.name}</td>
                    <td>${vo?.tel}</td>
                    <td>${vo?.weixin}</td>
                    <td>${vo?.starStr}</td>
                    <td>${vo?.statStr}</td>
                    <td>${vo?.parentName}</td>
                    <td>${vo?.endtimeStr}</td>
                    <td>
                        %{--<if condition="$search['stat'] neq -2">--}%
                            <button type="button" aid="${vo?.id}" class="btn btn-info next_agent" style="width: 150px;">下级(${vo?.nextAgentNum})</button>
                            <!-- <button type="button" aid="<{$vo.agentid}>" class="btn btn-info download">下载证书</button> -->
                            <button type="button" aid="${vo?.id}" class="btn btn-info show_auth">查看证书</button>
                            %{--<else />
                            <button type="button" aid="<{$vo.agentid}>" class="btn btn-warning adopt_agent">通过</button>
                        </if>--}%
                        <button type="button" aid="${vo?.id}" class="btn btn-warning edit_agent">修改</button>
                        <button type="button" aid="${vo?.id}" class="btn btn-danger del_agent">删除</button>
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
            <a>代理总人数:${total}</a>
        </li>
    </ul>
</nav>
<script>
    $(function(){

        //重置条件搜索栏
        $("#reset").click(function () {
            if(${searchStar}){
                $("#"+${searchStar}).removeAttr("selected");
            }
            $("#" + $("#searchF").val()).removeAttr("selected");
            $("#search_value").val("");
            window.location.href="/agent/index?aid=${parentAgent?.agentid}";
        });
        //搜索下拉框回显
        if(${searchStar}){
            $("#"+${searchStar}).attr("selected","selected");
        }
        if($("#search_value").val()){
            $("#"+$("#searchF").val()).attr("selected","selected");
        }

        /*//分页
        $('.pagination li').click(function(){
            var page = $(this).children('a').attr('page');
            var class_name = $(this).attr('class');
            var pid = '<{$search.parent_id}>';
            var search_field = '<{$search.search_field}>';
            var search_value = '<{$search.search_value}>';
            var star = '<{$search.star}>';
            var stat = '<{$search.stat}>';

            if(class_name != 'active'){
                LoadPage('__APP__/AgentManage/index.html',{'p': page,'pid':pid,'search_field':search_field,'search_value':search_value,'star':star,'status':stat});
            }

        });*/

        //下级代理
        $('.next_agent').click(function(){
            var aid = $(this).attr('aid');
            if(aid == ''){
                alert('请选择代理');
                return false;
            }
            window.location.href = '/agent/index?aid=' + aid;
        });

        //下载证书
        $('.download').click(function(){
            var aid = $(this).attr('aid');
            if(aid == ''){
                alert('请选择代理');
                return false;
            }
            var url = '__APP__/AgentManage/downAuthBook.html?aid='+aid;
            window.open(url);

            return false;
        });

        //查看证书
        $('.show_auth').click(function(){
            var aid = $(this).attr('aid');
            if(aid == ''){
                alert('请选择代理');
                return false;
            }
            alert(aid);
            window.location.href = '/agent/showAuthBook?aid=' + aid;
        });


        //修改
        $('.edit_agent').click(function(event) {
            /* Act on the event */
            var aid = $(this).attr('aid');
            if(aid == ''){
                alert('请选择代理');
                return false;
            }
            window.location.href = '/agent/agentCreateOrUpdateUI?aid=' + aid;

        });

        //通过
        $('.adopt_agent').click(function(event) {
            /* Act on the event */
            var aid = $(this).attr('aid');
            if(aid == ''){
                alert('请选择代理');
                return false;
            }

            if (confirm("是否确定通过"))  {
                $.post('__APP__/AgentManage/adoptAgent.html', {aid: aid}, function(data) {
                    alert(data.msg);
                    if(data.status == 1){
                        LoadPage("__APP__/AgentManage/index.html",{status:-2});
                    }
                });
            }

            return false;
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
                $.post('/Agent/deleteAgent', {aid: aid}, function(data) {
                    alert(data);
                    window.location.href="/agent/index";
                });
            }

            return false;

        });

        //搜索
       /* $('#myForm').submit(function() {

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
