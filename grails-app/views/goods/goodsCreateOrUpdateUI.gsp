<%--
  Created by IntelliJ IDEA.
  User: unes
  Date: 2018/4/23
  Time: 17:17
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta name="layout" content="homepage">
    <meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>
</head>

<body>
    <style type="text/css" media="screen">

    element.style {
      width: 1024px;
      z-index: 999;
    }
    #picList{
        margin-top:65px;
    }
    .form-group .pic_list{
        display:inline;
    }
    .form-group .pic_list:first-child{
        margin-left:19%;
    }
    .form-group .pic_list .pic_del{

        display: inline-block;
        position: relative;
        top: -63px;
        left: 69px;
        background: #DBEAF9;
        width: 48px;
        height: 30px;
        line-height: 30px;
        text-align: center;
    }
    </style>
    <ul class="list-group" >
        <li class="list-group-item list-group-item-success"><h4 style="margin:0;">添加商品</h4></li>
    </ul>
    <form id="myForm" class="form-horizontal" method="post" action="/goods/saveOrUpdate" enctype="multipart/form-data">
        <input type="hidden" name="id" value="${goods?.id}"  id="id" >
        <div class="form-group">
            <label class="col-sm-2 control-label">授权书</label>
            <div class="col-sm-8">
                %{--<volist name="auth_list" id="vo">
                    <label class="radio-inline">
                        <input type="radio" name="auth_id"  value="<{$vo.id}>" <g:if test="$info.auth_id eq $vo.id or $vo.id eq 1">checked</g:if> > <{$vo.name}>
                    </label>
                </volist>--}%
                <g:each status="i" in="${authBooks}" var="ab">
                    <label class="radio-inline">
                        <input type="radio" name="auth_id"  value="${ab?.id}" <g:if test="${goods?.authId == (i+1)}">checked</g:if> > ${ab?.name}
                    </label>
                </g:each>
            </div>
        </div>
        <div class="form-group">
            <label for="code" class="col-sm-2 control-label">商品编码</label>
            <div class="col-sm-2">
                <input type="text" name="code" value="${goods?.code}" class="form-control" id="code" placeholder="输入商品编码">
            </div>
            <div class="is_must">必填(<i>*</i>)</div>
        </div>
        <div class="form-group">
            <label for="title" class="col-sm-2 control-label">商品名称</label>
            <div class="col-sm-4">
                <input type="text" name="title" value="${goods?.title}" class="form-control" id="title" placeholder="输入商品名称">
            </div>
            <div class="is_must">必填(<i>*</i>)</div>
        </div>
        <div class="form-group">
            <label for="mark_price" class="col-sm-2 control-label">市场价格(全国统一价)</label>
            <div class="col-sm-1">
                <input type="text" name="markPrice" value="${goods?.markPrice}" class="form-control" id="mark_price" placeholder="市场价格">
            </div>
            <div class="is_must">必填(<i>*</i>)</div>
        </div>
        <div class="form-group">
            <label for="price" class="col-sm-2 control-label">价格</label>
            <div class="col-sm-1">
                <input type="text" name="price" value="${goods?.price}" class="form-control" id="price" placeholder="商品价格">
            </div>
        </div>
        <div class="form-group">
            <label for="stock_price" class="col-sm-2 control-label">进货价格</label>
            <div class="col-sm-1">
                <input type="text" name="stockPrice" value="${goods?.stockPrice}" class="form-control" id="stock_price" placeholder="进货价格">
            </div>
        </div>
        <div class="form-group">
            <label for="specs" class="col-sm-2 control-label">商品规格</label>
            <div class="col-sm-2">
                <input type="text" name="specs" value="${goods?.specs}" class="form-control" id="specs" placeholder="输入商品规格">
            </div>
        </div>
        <div class="form-group">
            <label for="stock" class="col-sm-2 control-label">商品库存</label>
            <div class="col-sm-1">
                <input type="text" name="stock" value="${goods?.stock}" class="form-control" id="stock" placeholder="商品库存">
            </div>
        </div>
        <div class="form-group" id="picList">
            %{--<volist name="info['pic_list']" id="vo" key="pk">
                <div class="pic_list">
                    <div class="pic_del" img_path="<{$info['y_pic_list'][$pk-1]}>">删除</div>
                    <img src="<{$vo}>"  class="img-rounded" style="height: 70px;">
                </div>
            </volist>--}%
            <g:each in="${picList}" var="pic">
                <div class="pic_list">
                    <div class="pic_del" img_path="<{$info['y_pic_list'][$pk-1]}>">删除</div>
                    <img src="${webRequest.getBaseUrl() + "/Uploads/" + pic}"  class="img-rounded" style="height: 70px;">
                </div>
            </g:each>
        </div>
        <div class="form-group">
            <label for="more_images" class="col-sm-2 control-label">商品图片</label>
            <div class="col-sm-2 goods_images">
                <input type="file" name="images" class="form-control images"  >
            </div>
            <div id="more_images">更多+</div>
        </div>
        <div class="form-group">
            <label for="container" class="col-sm-2 control-label">商品详情</label>
            <div class="col-sm-10">

                %{--富文本编辑器开始--}%
                %{--<script type="text/javascript">

                    var upyun_url='<{$upyun_info.UPYUN_URL}>',
                        upyun_bucketname='<{$upyun_info.UPYUN_BUCKETNAME}>',
                        upyun_operator_name='<{$upyun_info.UPYUN_OPERATOR_NAME}>',
                        upyun_operator_pwd='<{$upyun_info.UPYUN_OPERATOR_PWD}>';
                </script>
                <asset:javascript src="ueditor.all.js"/>
                <asset:javascript src="ueditor.config.js"/>
                <asset:link rel="stylesheet" href="themes/default/css/ueditor.css"/>
                <!--建议手动加在语言，避免在ie下有时因为加载语言失败导致编辑器加载失败-->
                <!--这里加载的语言文件会覆盖你在配置项目里添加的语言类型，比如你在配置项目里配置的是英文，这里加载的中文，那最后就是中文-->
               --}%%{-- <script type="text/javascript" charset="utf-8" src="__PUBLIC__/plug/ueditor/lang/zh-cn/zh-cn.js"></script>--}%%{--
                <asset:javascript src="lang/zh-cn/zh-cn.js"/>
                <style type="text/css">
                div{
                    width:100%;
                }
                </style>

                <div>

                    <script id="editor" type="text/plain" style="width:1024px;height:500px;"></script>
                        </div>

                    <script type="text/javascript" >

                        //实例化编辑器
                        //建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
                        var ue = UE.getEditor('editor');

                    </script>--}%
                    %{--富文本编辑器结束--}%
                <input type="hidden" id="uHidden"/>
                <!-- 加载编辑器的容器 -->
                <script id="container" name="descs" type="text/plain">
                    %{-- 这里写你的初始化内容 --}%
                </script>
                <!-- 配置文件 -->
                %{--<script type="text/javascript" src="ueditor.config.js"></script>--}%
                <asset:javascript src="ueditor.config.js"/>
                <!-- 编辑器源码文件 -->
                %{--<script type="text/javascript" src="ueditor.all.js"></script>--}%
                <asset:javascript src="ueditor.all.js"/>
                <!-- 实例化编辑器 -->
                <script type="text/javascript">
                    var ue = UE.getEditor('container');
                </script>

            </div>
        </div>
        <div class="form-group">
            <div class="col-sm-10">
                <button type="submit" class="btn btn-primary btn-lg btn-block" style="width: 12%;margin: 0 auto;">提交</button>
            </div>
        </div>
    </form>

    <script>
        $(function(){

            $('#myForm').submit(function() {
                var code = is_empty('#code');
                var title = is_empty('#title');
                var mark_price = is_empty('#mark_price');

                if(code === false){
                    showMsg('商品编码不能为空!');
                    return false;
                }
                if(title === false){
                    showMsg('商品名称不能为空!');
                    return false;
                }
                if(mark_price === false){
                    showMsg('市场价格不能为空!');
                    return false;
                }

                var pic_len = $('.images').length;
                var ye_pic_len = $('#picList .pic_list').length;
                var k = 0;
                for(var i=0;i<pic_len;i++){
                    var pic_val = $('.images').eq(i).val();
                    if(pic_val){
                        k++;
                    }

                }
                if(k == 0 && ye_pic_len == 0){
                    showMsg('商品图片不能为空!');
                    return false;
                }

                $('#myForm').submit();

                /*$(this).ajaxSubmit(function(data){
                    showMsg(data.msg);
                    console.log(data);
                });*/

                //防止页面刷新
                return false;
            });

            //添加更多图片
            $('#more_images').click(function(event) {
                /* Act on the event */
                $('.goods_images').append($('.images').eq(0).clone());
            });

            //删除商品图片
            $('.pic_del').click(function(event) {
                /* Act on the event */
                var _this = $(this);
                var goods_id = $('#id').val();
                var img_path = $(this).attr('img_path');

                $.post('__APP__/Goods/delPic.html', {goods_id: goods_id,pic_url:img_path}, function(data) {
                    /*optional stuff to do after success */
                    if(data.status == 1){
                        _this.parent().remove();
                    }
                    showMsg(data.msg);
                    console.log(data);
                });
            });

        });

        //对编辑器的操作最好在编辑器ready之后再做
        ue.ready(function() {
            //设置编辑器的内容
            var value = '<div style="width:100%;height:100%;">'+"${goods?.descs}"+'</div>';
            //$("#uHidden").val(value);
            alert(value);
            //$("#content").html($("#uHidden").val());
            //UE.getEditor('container').setContent(value);
            //ue.setContent('%{--${goods?.descs}--}%');
            var va = UE.getEditor('content').getContent();
            $("#uHidden").val(va);
            //ue.setContent("<b>gadsfg</b>");
            UE.getEditor('content').execCommand('insertHtml', "<b>gadsfg</b>");
        });
    </script>
</body>
</html>