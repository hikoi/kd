
%{--<style type="text/css">
</style>--}%
<div class="container-fluid">
    <block name="menu">
        <div class="menu">
            <ul class="list-group" >
                <li class="list-group-item list-group-item-success">功能菜单</li>
                <li class="list-group-item">
                    %{--<if condition = "$Think.session.agent_id eq 0">--}%
                        <!-- 授权书管理 -->
                        <div class="list-group-item list-group-item-warning">授权书管理</div>
                        <div class="list-group">
                            <span ${controllerName == 'authBook' ? "class=active" : ''}>
                                <g:link controller="authBook" action="authBookCreateHtml"  class="list-group-item">
                                    添加授权书</g:link></span>

                            <span ${controllerName == 'authBook' ? "class=active" : ''}>
                                    <g:link controller="authBook" action="index"  class="list-group-item">
                                    授权书列表</g:link></span>
                            %{--<a onclick='LoadPage("__APP__/AuthBook/add.html")' class="list-group-item">添加授权书</a>
                            <a onclick='LoadPage("__APP__/AuthBook/index.html")' class="list-group-item">授权书列表</a>--}%
                        </div>
                   %{-- </if>--}%
                    <!-- 代理管理 -->
                    <div class="list-group-item list-group-item-warning">代理管理</div>
                    <div class="list-group">
                        %{--<if condition = "$Think.session.agent_id eq 0">
                            <a onclick='LoadPage("__APP__/AgentManage/addAgentView.html")' class="list-group-item">添加代理</a>
                        </if>
                        <a onclick='LoadPage("__APP__/AgentManage/index.html")' class="list-group-item">代理商列表</a>
                        <a onclick="LoadPage('__APP__/AgentManage/index.html',{status:'0,-1,-2,-3'})" class="list-group-item">待审核代理商</a>
                        <a onclick='LoadPage("__APP__/AgentManage/growthAgentView.html")' class="list-group-item">新增代理</a>
                        <if condition = "$Think.session.agent_id eq 0">
                            <a onclick='LoadPage("__APP__/AgentManage/editAuthTimeView.html")' class="list-group-item">批量更改授权时间</a>
                        </if>--}%
                        <g:link controller="agent" action="agentCreateOrUpdateUI" class="list-group-item">添加代理</g:link>
                        <g:link controller="agent" action="index" class="list-group-item">代理商列表</g:link>
                        <g:link controller="agent" action="index" params="[audit:'audit']" class="list-group-item">待审核代理商</g:link>
                        <g:link controller="agent" action="index" class="list-group-item" style="color: #a0a0a0">新增代理</g:link>
                        <g:link controller="agent" action="index" class="list-group-item" style="color: #a0a0a0">批量更改授权时间</g:link>
                    </div>
                    <if condition = "$Think.session.agent_id eq 0">
                        <!-- 防伪 -->
                        <div class="list-group-item list-group-item-warning">防伪管理</div>
                        <div class="list-group">
                            <g:link controller="labelCode" action="index" class="list-group-item">标签列表</g:link>
                            <g:link controller="labelCode" action="index" class="list-group-item" style="color: #a0a0a0">生成标签</g:link>
                            <g:link controller="labelCode" action="index" class="list-group-item" style="color: #a0a0a0">导出标签</g:link>
                        </div>
                        <!-- 商品 -->
                        <div class="list-group-item list-group-item-warning">商品管理</div>
                        <div class="list-group">
                            <g:link controller="goods" action="index" class="list-group-item">商品列表</g:link>
                            <g:link controller="goods" action="goodsCreateOrUpdateUI" class="list-group-item">添加商品</g:link>
                        </div>
                    </if>
                    <!-- 出库 -->
                    <div class="list-group-item list-group-item-warning">出库管理</div>
                    <div class="list-group">
                        <!--  <a onclick='LoadPage("__APP__/Index/editPass.html")' class="list-group-item">系统出库</a> -->
                        <g:link controller="orderInfo" action="index" class="list-group-item">出库记录</g:link>
                        <!-- <a onclick='LoadPage("__APP__/Index/editPass.html")' class="list-group-item">小标出库记录</a> -->
                    </div>
                    <if condition = "$Think.session.agent_id eq 0">
                        <!-- 素材库管理 -->
                        <div class="list-group-item list-group-item-warning">素材库管理</div>
                        <div class="list-group">
                            <g:link controller="fodderCategory" action="index" class="list-group-item">素材分类</g:link>
                            <g:link controller="fodderPicture" action="index" class="list-group-item">素材列表</g:link>
                        </div>
                        <!-- 管理员设置 -->
                        <div class="list-group-item list-group-item-warning">管理员设置</div>
                        <div class="list-group">
                            <g:link controller="goods" action="index" class="list-group-item" style="color: #a0a0a0">系统设置</g:link>
                        </div>
                    </if>
                </li>

            </ul>
        </div>
    </block>


</div>
<script>
    $(".list-group-item").click(function () {
        var a_class = $(this).attr("class");
        $(this).attr("class",a_class + " disabled")
    });
</script>

<block name="footer"></block>
