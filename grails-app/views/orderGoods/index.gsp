<%--
  发货详情
  User: unes
  Date: 2018/4/24
  Time: 16:52
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta name="layout" content="homepage">
</head>

<body>
    <ul class="list-group" >
        <li class="list-group-item list-group-item-success"><h4 style="margin:0;">发货详情</h4></li>
    </ul>
    <p class="text-justify">发货单号:${orderInfo.orderSn}</p>
    <p class="text-justify">发货人:${orderInfo.adminName}</p>
    <p class="text-justify">发货人微信号:${orderInfo.adminNameWeixin}</p>
    <p class="text-justify">收货人:${orderInfo.consignee}</p>
    <p class="text-justify">收货人微信号:${orderInfo.consigneeWeixin}</p>
    <p class="text-justify" id="addTime">发货时间:${orderInfo.addTime}</p>
    <div class="panel panel-default" style="margin-top: 20px;">
        <table class="table">
            <thead>
            <tr>
                <th>商品编号</th>
                <th>商品名称</th>
                <th>条形码</th>
                <th>商品图片</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody>
                <g:each in="${orderGoodsList}" var="vo">
                    <tr>
                        <th scope="row">${vo?.goodsId}</th>
                        <td>${vo?.goodsName}</td>
                        <td>${vo?.code}</td>
                        <td><img src="${'/Uploads/' + vo?.goodsPic}"  class="img-rounded" style="width: 80px;"></td>
                        <td>
                            <button type="button" aid="${vo?.orderSn}" code="${vo?.code}" web_type="" class="btn btn-danger del_agent">删除</button>
                        </td>
                    </tr>
                </g:each>
            </tbody>
        </table>

    </div>
    <g:if test="${!orderGoodsList}">
        没有发货单
    </g:if>
    <script>
        $(function(){
            //去掉addTime秒后面的".0"
            $("#addTime").html($("#addTime").html().substring(0,24));


            //删除
            $('.del_agent').click(function(event) {
                /* Act on the event */
                var aid = $(this).attr('aid');
                var code = $(this).attr('code');


                if(aid == ''){
                    alert('请选择订单');
                    return false;
                }

                if(code == ''){
                    alert('请选择条形码');
                    return false;
                }

                if (confirm("是否确定删除"))  {
                    $.post('__APP__/DeliverGoods/delOrderGoods.html', {order_sn: aid,code:code}, function(data) {
                        alert(data.msg);
                        if(data.status == 1){
                            LoadPage("__APP__/DeliverGoods/showDetail.html",{aid:aid});
                        }
                    });
                }

                return false;

            });


        });

    </script>
</body>
</html>