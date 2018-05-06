<%--
  Created by IntelliJ IDEA.
  User: unes
  Date: 2018/4/16
  Time: 17:28
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta name="layout" content="homepage">
    <meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>
    <title></title>
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
        <li class="list-group-item list-group-item-success">
            <h4 style="margin:0;">
                <g:if test="${authBook?.id}">
                    修改授权书
                </g:if>
                <g:else>
                    添加授权书
                </g:else>
            </h4>
        </li>
    </ul>
    <g:form class="form-horizontal myForm" useToken="true" method="post" action="createOrUpdateAutoBook" enctype="multipart/form-data">
        <input type="hidden" name="id" value="${authBook?.id}"  id="id" >
        <div class="form-group">
            <label for="name" class="col-sm-2 control-label">授权书名称</label>
            <div class="col-sm-2">
                <input type="text" name="name" value="${authBook?.name}" class="form-control" id="name" placeholder="输入授权书名称">
            </div>
            <div class="is_must">必填(<i>*</i>)</div>
        </div>

        <div class="form-group">
            <label class="col-sm-2 control-label">授权书图片</label>
            <div class="col-sm-2 goods_images">
                <input type="file" name="images" class="form-control images"  >
            </div>
        </div>

        <div class="form-group">
            <div class="col-sm-10">
                <button type="submit" class="btn btn-primary btn-lg btn-block" style="width: 12%;margin: 0 auto;">提交</button>
            </div>
        </div>
        <g:if test="${flash.invalidToken}">
            不要按两次按钮。
        </g:if>
    </g:form>
    <g:if test="${authBook}">
        <div class="form-group" id="picList">
            <div class="pic_list">
                <img src="${webRequest.getBaseUrl() + "/" + authBook.imgPath}"  class="img-rounded" style="">
            </div>
        </div>
    </g:if>
    <script>
        $(function(){

            $('.myForm').submit(function() {
                var name = is_empty('#name'),
                    aid = is_empty('id'),
                    pic_val = is_empty('.images');

                if(name === false){
                    showMsg('授权书名称不能为空!');
                    return false;
                }

                if(aid === true && pic_val === false){
                    showMsg('授权书图片不能为空!');
                    return false;
                }

                $('form').submit();


                /*原来的提交方式*/
                /*$(this).ajaxSubmit(function(data){
                    showMsg(data.msg);
                    console.log(data);
                    if(data.status == 1){
                        LoadPage('__APP__/AuthBook/index.html');
                    }

                });*/

                //防止页面刷新
                return false;
            });

        });

    </script>
</body>
</html>