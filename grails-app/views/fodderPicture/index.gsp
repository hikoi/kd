<%--
  素材列表页面(图片).
  User: unes
  Date: 2018/4/25
  Time: 15:11
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta name="layout" content="homepage">
</head>

<body>
    <ul class="list-group">
        <li class="list-group-item list-group-item-success">
            <h4 style="margin:0;">素材列表</h4></li>
    </ul>
    <div class="form-group">
        <button type="button" class="btn btn-warning cate_view" pid="0">添加</button>
    </div>
    <form id="myForm" class="form-inline" method="post" action="/fodderPicture/index" enctype="multipart/form-data">
        <div class="form-group">
            <label for="cateLv1">一级分类</label>
            <select class="form-control" name="cateLv1" id="cateLv1">
                <option value="">--请选择--</option>
                <g:each in="${cateLv1s}" var="vo">
                    <option value="${vo?.id}" <g:if test="${params.cateLv1 == vo?.id.toString()}">selected</g:if>>${vo?.title}</option>
                </g:each>
            </select>
        </div>
        <div class="form-group">
            <label for="cate_lv2">二级分类</label>
            <select class="form-control" name="cateLv2" id="cate_lv2">
                <option value="" cate_type="0" >--请选择--</option>
            </select>
        </div>
        <div class="form-group">
            <label for="cate_type">素材类型</label>
            <select class="form-control" name="cateType" id="cate_type">
                <option value="0">--请选择--</option>
                %{--<volist name="cate_status_list" id="svo">
                    <option value="<{$svo.id}>" <if condition="$search['cate_type'] eq $svo['id']">selected</if> ><{$svo.name}></option>
                </volist>--}%
                <option value="1" <g:if test="${params.cateType == '1'}">selected</g:if>>图片</option>
                <option value="2" <g:if test="${params.cateType == '2'}">selected</g:if>>文章</option>
                <option value="3" <g:if test="${params.cateType == '3'}">selected</g:if>>朋友圈</option>
                <option value="4" <g:if test="${params.cateType == '4'}">selected</g:if>>视频</option>
            </select>
        </div>
        <div class="form-group">
            <label for="isShow">是否显示</label>
            <select class="form-control" name="isShow" id="isShow">
                <option value="">--请选择--</option>
                <option value="1" <g:if test="${params.isShow == '1'}">selected</g:if>>显示</option>
                <option value="0" <g:if test="${params.isShow == '0'}">selected</g:if>>不显示</option>
            </select>
        </div>
        <button type="submit" class="btn btn-default">搜索</button>
        <span id="reset" class="btn btn-default">重置</span>
    </form>
    <div class="panel panel-default" style="margin-top: 20px;">
        <input type="hidden" name="cate_id" value="<{$search['cate_lv2']}>"  id="cate_id" >
        <div class="row">
            <g:each in="${pagedResultList}" var="vo">
                <div class="col-md-2">
                    <div class="form-group">
                        <center style="margin-top: 10px;">
                            <div class="checkbox">
                                <label>
                                    <input type="checkbox" class="sel_sing" aid="${vo?.id}" > 选择
                                </label>
                            </div>
                        </center>
                        <center style="margin-top: 10px;">
                            <img src="${'http://kudouys.b0.upaiyun.com/' + vo?.original +'!100'}" class="img-rounded">
                        </center>
                        <center style="margin-top: 10px;">
                            <button type="button" class="btn btn-warning cate_show" aid="${vo?.id}" isShow="${vo?.isShow}">
                                <g:if test="${vo?.isShow}">
                                    隐藏
                                </g:if>
                                <g:else>
                                    显示
                                </g:else>
                            </button>
                            <button type="button" class="btn btn-warning del_pic" aid="${vo?.id}">删除</button>
                        </center>
                    </div>
                </div>
            </g:each>
        </div>
    </div>
    <div class="row">
        <div class="col-md-1">
            <div class="checkbox">
                <label>
                    <input type="checkbox" id="all_select">全选
                </label>
            </div>
        </div>
        <div class="col-md-3">
            <button type="button" class="btn btn-info edit_pic">修改</button>
        </div>
    </div>
    <nav>
        <ul class="pagination">
            <li>
                 %{--分页--}%
                <g:if test="${total > 0}">
                    <g:paginate next="下一页" prev="上一页" params="${params}"
                                max="12" maxsteps="12" action="index" total="${total}"/>
                </g:if>
                <a>素材总数:${total}</a>
            </li>
        </ul>
    </nav>
    <script>
        $(function() {
            //重置条件搜索栏
            $("#reset").click(function () {
                window.location.href="/fodderPicture/index?cateLv1&cateLv2&cateType&isShow";
            });

            //全选
            $('#all_select').click(function(event) {
                $('.sel_sing').attr('checked', 'checked');
            });

            //修改图片
            $('.edit_pic').click(function(event) {
                var cid = $('#cate_id').val(),
                    ids = [],
                    pids='',
                    len = $('.sel_sing:checked').length;

                if(len > 0){
                    for(var i=0;i<len;i++){
                        ids.push($('.sel_sing:checked').eq(i).attr('aid'));
                    }

                    if(ids.length > 0){
                        pids = ids.join(',');
                    }
                }else{
                    alert('请选择图片');
                    return false;
                }
                console.log(ids,pids);
                LoadPage('__APP__/FodderManage/editPicView.html',{pids:pids,cid:cid});
            });

            //显示或者隐藏
            $('.cate_show').click(function(event) {
                var _this = $(this),
                    isShow = _this.attr('isShow'),
                    id = _this.attr('aid');

                $.post('__APP__/FodderManage/showArticle.html', {
                    isShow: isShow,
                    id: id
                }, function(data) {
                    alert(data.msg);
                    if (data.status == 1) {
                        _this.html(data.result.show_name);
                        _this.attr('isShow', data.result.isShow);
                    }
                });

            });

            //添加或者修改素材分类
            $('.cate_view').click(function(event) {
                LoadPage('__APP__/FodderManage/addArticleView.html');
            });

            //删除
            $('.del_pic').click(function(event) {
                var _this = $(this);
                var aid = $(this).attr('aid');

                if (aid == '') {
                    alert('请选择图片');
                    return false;
                }

                if (confirm("是否确定删除")) {
                    $.post('__APP__/FodderManage/delPic.html', {
                        id: aid
                    }, function(data) {
                        alert(data.msg);
                        if (data.status == 1) {
                            _this.parents('.col-md-2').remove();
                            // LoadPage("__APP__/FodderManage/articleList.html");
                        }
                    });
                }

                return false;

            });

            //搜索
            $('#myForm').submit(function() {

                /*$(this).ajaxSubmit(function(data) {
                    $('.main .container-fluid').html(data);
                });*/
                //被选中的素材类型
                var cateType = $("#cate_type :selected").attr("value");
                if( cateType == 2 || cateType == 3 || cateType == 4){
                    $('#myForm').attr("action","/fodderArticle/index");
                }
                $(this).submit();
                //防止页面刷新
                return false;
            });

            //选择一级分类
            get_cate();
            $('#cateLv1').change(function() {
                var pid = $(this).find('option:selected').val();
                get_cate(pid);
            });

            //选择二级分类
            $('#cate_lv2').change(function() {
                var cateLv1 = $('#cateLv1').find('option:selected').val(),
                    cate_lv2 = $(this).find('option:selected').val(),
                    cate_type = $(this).find('option:selected').attr('cate_type');

            });

            function get_cate(pid) {

                if (pid == '' || pid == undefined) {
                    var pid = $('#cateLv1').find('option:selected').val();
                }

                $.post('/fodderPicture/selCate', {
                    pid: pid
                }, function(data) {
                    var html = '',
                        cateLv2 = '${params.cateLv2}';
                    if (data.status == 1) {

                        for (k in data.result) {
                            if (data.result[k].id == cateLv2) {
                                html += '<option value="' + data.result[k].id + '" selected cate_type="' + data.result[k].cate_type + '">' + data.result[k].title + '</option>';
                            } else {
                                html += '<option value="' + data.result[k].id + '" cate_type="' + data.result[k].cate_type + '">' + data.result[k].title + '</option>';
                            }

                        }

                    }else{
                        html = '<option value="">--请选择--</option>';
                    }

                    $('#cate_lv2').html(html);
                });
            }

        });
    </script>
</body>
</html>