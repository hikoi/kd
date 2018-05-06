<%--
  出库记录
  User: unes
  Date: 2018/4/24
  Time: 14:16
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta name="layout" content="homepage">
</head>

<body>
    <ul class="list-group" >
        <li class="list-group-item list-group-item-success"><h4 style="margin:0;">出库记录</h4></li>
    </ul>
    <form id="myForm" class="form-inline" method="post" action="/orderInfo/index" enctype="multipart/form-data">
        <div class="form-group">
            <label for="star">发货人代理星级</label>
            <select class="form-control" name="star" id="star">
                <option value="">--请选择--</option>
                %{--<if condition = "$Think.session.agent_id eq 0">--}%
                    <option value="0" <g:if test="${star == 0}">selected</g:if>>工厂</option>
                %{--</if>--}%
                <g:each in="${agentStars}" var="lvo">
                    <option value="${lvo?.id}" <g:if test="${star == lvo?.id}">selected</g:if>>${lvo?.name}</option>
                </g:each>
            </select>
        </div>

        <div class="form-group">
            <label for="search_field">
                <select class="form-control" name="searchField" id="search_field">
                    <option value="code" <g:if test="${searchField == 'code'}">selected</g:if>>条形码</option>
                    <option value="orderSn" <g:if test="${searchField == 'orderSn'}">selected</g:if>>发货单号</option>
                    <option value="consignee" <g:if test="${searchField == 'consignee'}">selected</g:if>>收货人</option>
                    <option value="adminName" <g:if test="${searchField == 'adminName'}">selected</g:if>>发货人</option>
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
                <th>发货单号</th>
                <th>收货人</th>
                <th>发货人</th>
                <th>发货时间</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody>
            <g:each in="${pagedResultList}" var="vo">
                <tr>
                    <th scope="row">${vo?.orderSn}</th>
                    <td>${vo?.consignee}</td>
                    <td>${vo?.adminName}</td>
                    <td class="addTime">${vo?.addTime}</td>
                    <td>
                        <button type="button" aid="${vo?.orderSn}" class="btn btn-info show_detail">查看详情</button>
                        <button type="button" aid="${vo?.orderSn}" class="btn btn-danger del_agent">删除</button>
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
                    <a>发货总数:${total}</a>
                </g:if>
                <g:else>
                    没有发货单
                </g:else>
            </li>
        </ul>
    </nav>
    <script>
        $(function(){
            //重置条件搜索栏
            $("#reset").click(function () {
                window.location.href="/orderInfo/index?star&searchValue";
            });

            //分页
            %{--}$('.pagination li').click(function(){
                var page = $(this).children('a').attr('page');
                var class_name = $(this).attr('class');
                var search_field = '${search.search_field}';
                var search_value = '${search.search_value}';
                var star = '${search.star}';
                var web_type = '${search.web_type}';

                if(class_name != 'active'){
                    LoadPage('__APP__/DeliverGoods/index.html',{'p': page,'search_field':search_field,'search_value':search_value,'star':star,web_type:web_type});
                }

            });--}%

            //删除
            $('.del_agent').click(function(event) {
                /* Act on the event */
                var aid = $(this).attr('aid'),
                    web_type = $(this).attr('web_type');

                if(aid == ''){
                    alert('请选择订单');
                    return false;
                }

                if(web_type == ''){
                    alert('请选择站点');
                    return false;
                }


                if (confirm("是否确定删除"))  {
                    $.post('__APP__/DeliverGoods/delOrder.html', {order_sn: aid,web_type:web_type}, function(data) {
                        alert(data.msg);
                        if(data.status == 1){
                            LoadPage("__APP__/DeliverGoods/index.html");
                        }
                    });
                }

                return false;

            });

            //查看详情
            $('.show_detail').click(function(){
                var aid = $(this).attr('aid'),
                    web_type = $(this).attr('web_type');

                if(aid == ''){
                    alert('请选择订单');
                    return false;
                }

                if(web_type == ''){
                    alert('请选择站点');
                    return false;
                }

                window.location.href = "/orderGoods/index?aid=" + aid;
                /*LoadPage('__APP__/DeliverGoods/showDetail.html',{'aid':aid,web_type:web_type});*/

            });

            /*//搜索
            $('#myForm').submit(function() {

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