<%--
  Created by IntelliJ IDEA.
  User: unes
  Date: 2018/4/26
  Time: 16:50
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta name="layout" content="homepage">
</head>

<body>
    <style type="text/css" media="screen">
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
        <li class="list-group-item list-group-item-success"><h4 style="margin:0;">添加分类</h4></li>
    </ul>
    <form id="myForm" class="form-horizontal" method="post" action="/fodderCategory/createOrUpdate" enctype="multipart/form-data">
        <input type="hidden" name="id" value="${params.id}"  id="id" >
        <input type="hidden" name="pid" value="<g:if test="${params.pid}">${params.pid}</g:if><g:else>0</g:else>"  id="pid" >
        <div class="form-group">
            <label for="title" class="col-sm-2 control-label">分类名称</label>
            <div class="col-sm-3">
                <input type="text" name="title" value="${fodderCategory?.title}" class="form-control" id="title" placeholder="输入分类名称">
            </div>
            <div class="is_must">必填(<i>*</i>)</div>
        </div>
        <div class="form-group">
            <label for="is_show1" class="col-sm-2 control-label">是否显示</label>
            <div class="col-sm-4">
                <label class="radio-inline">
                    <input type="radio" name="is_show" id="is_show1" value="1" <g:if test="${fodderCategory?.isShow == 1 || !fodderCategory}">checked="checked"</g:if>> 显示
                </label>
                <label class="radio-inline">
                    <input type="radio" name="is_show" id="is_show2" value="0" <g:if test="${fodderCategory?.isShow == 0}">checked="checked"</g:if>>不显示
                </label>
            </div>
        </div>
        <g:if test="${!params.id && !params.pid}">
            <div class="form-group">
                <label for="firstCaty" class="col-sm-2 control-label">一级分类</label>
                <div class="col-sm-2">
                    <select class="form-control" name="pid" id="firstCaty">
                        <option value="0">添加一级分类</option>
                        <g:each in="${fodderCategorys}" var="vo">
                            <option value="${vo?.id}" %{--<g:if test="vo['id'] eq cate_lv1">selected</g:if>--}%>${vo?.title}</option>
                        </g:each>
                    </select>
                </div>
                <div class="is_must"></div>
            </div>
        </g:if>
        <g:if test="${params.pid}">
            <div class="form-group">
                <label for="cateType" class="col-sm-2 control-label">分类类型</label>
                <div class="col-sm-2">
                    <select class="form-control" id="cateType" name="cate_type">
                        %{--<volist name="cate_status_list" id="cvo">
                            <option value="<{$cvo.id}>" <if condition="$info['cate_type'] eq $cvo.id">selected</if> ><{$cvo.name}></option>
                        </volist>--}%
                        <option value="1" %{--<g:if test="${params.cateType == '1'}">selected</g:if>--}%>图片</option>
                        <option value="2" %{--<g:if test="${params.cateType == '2'}">selected</g:if>--}%>文章</option>
                        <option value="3" %{--<g:if test="${params.cateType == '3'}">selected</g:if>--}%>朋友圈</option>
                        <option value="4" %{--<g:if test="${params.cateType == '4'}">selected</g:if>--}%>视频</option>
                    </select>
                </div>
            </div>
        </g:if>
        <div class="form-group">
            <label for="sort" class="col-sm-2 control-label">排序</label>
            <div class="col-sm-1">
                <input type="text" name="sort" value="${fodderCategory?.sort}" class="form-control" id="sort" placeholder="输入数字">
            </div>
            <div class="is_must">数字越小排前面</div>
        </div>
        <div class="form-group">
            <label for="images" class="col-sm-2 control-label">分类LOGO图片</label>
            <div class="col-sm-2 goods_images">
                <input type="file" id="images" name="images" class="form-control images"  >
            </div>
            <div class="is_must">必填(<i>*</i>)</div>
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

                var id = is_empty('#id'),
                    title = is_empty('#title'),
                    mark_price = is_empty('#mark_price');

                if(title === false){
                    showMsg('分类名称不能为空!');
                    return false;
                }

                if(id === false){
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
                        showMsg('分类图片不能为空!');
                        return false;
                    }

                }

                $(this).ajaxSubmit(function(data){
                    showMsg(data.msg);
                    console.log(data);
                    if(data.status == 1){
                        LoadPage('__APP__/FodderManage/index.html',{'pid':data.result.pid});
                    }
                });

                //防止页面刷新
                return false;
            });

        });


    </script>
</body>
</html>