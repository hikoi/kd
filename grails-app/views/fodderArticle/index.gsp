<%--
  素材列表页面(文章)
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
    <ul class="list-group" >
        <li class="list-group-item list-group-item-success"><h4 style="margin:0;">素材列表</h4></li>
    </ul>
    <div class="form-group">
        <button type="button"  class="btn btn-warning cate_view" pid="0" >添加</button>
    </div>

    <form id="myForm" class="form-inline" method="post" action="/fodderArticle/index" enctype="multipart/form-data">
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
        <table class="table">
            <thead>
            <tr>
                <th>文章ID</th>
                <th>文章标题</th>
                <th>分类名称</th>
                <g:if test="${params.cateType != '3'}">
                    <th>文章标题图</th>
                    <th>点赞数</th>
                </g:if>
                <th>阅读数</th>
                <th>是否显示</th>
                <g:if test="${params.cateType != '3'}">
                    <th>排序序号</th>
                </g:if>
                <th>添加时间</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody>
            <g:each in="${pagedResultList}" var="vo">
                <tr>
                    <th scope="row">${vo?.id}</th>
                    <td>${vo?.title}</td>
                    <td>${vo?.cateName}</td>
                    <g:if test="${params.cateType != '3'}">
                        <td><img src="${'http://kudouys.b0.upaiyun.com/'+vo?.headImg+'!100'}" alt="" width="50"></td>
                        <td>${vo?.likes}</td>
                    </g:if>
                    <td>${vo?.reads}</td>
                    <td>
                        <g:if test="${vo?.isShow == 1}">
                            显示
                        </g:if>
                        <g:else>
                            隐藏
                        </g:else>
                    </td>
                    <g:if test="${params.cateType != '3'}">
                        <td>${vo?.sort}</td>
                    </g:if>
                    <td><g:formatDate format="yyyy-MM-dd HH:mm:ss" date="${vo?.addTime*1000}"/></td>
                    <td>
                        <button type="button" aid="${vo?.id}>" class="btn btn-warning cate_view">修改</button>
                        <button type="button" aid="${vo?.id}>" isShow="${vo?.isShow}>" class="btn btn-warning cate_show">
                            <g:if test="${vo?.isShow == 1}">
                                隐藏
                            </g:if>
                            <g:else>
                                显示
                            </g:else>
                        </button>
                        <!-- <button type="button" aid="${vo?.id}>" class="btn btn-danger del_agent">删除</button> -->
                    </td>
                </tr>
            </g:each>
            </tbody>
        </table>
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
        $(function(){
            //重置条件搜索栏
            $("#reset").click(function () {
                window.location.href="/fodderPicture/index?cateLv1&cateLv2&cateType&isShow";
            });

            //查看下级
            $('.show_next').click(function(event) {
                /* Act on the event */
                var pid = $(this).attr('pid');

                LoadPage('__APP__/FodderManage/index.html',{pid:pid});

            });

            //添加或者修改素材分类
            $('.cate_view').click(function(event) {
                var id = $(this).attr('aid');
                LoadPage('__APP__/FodderManage/addArticleView.html',{id:id});

            });

            //显示或者隐藏
            $('.cate_show').click(function(event) {
                var _this = $(this),
                    is_show = _this.attr('is_show'),
                    id = _this.attr('aid');

                $.post('__APP__/FodderManage/showArticle.html', {is_show:is_show,id:id}, function(data) {
                    alert(data.msg);
                    if(data.status == 1){
                        _this.html(data.result.show_name);
                        _this.attr('is_show',data.result.is_show);
                    }
                });

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

                /*$(this).ajaxSubmit(function(data){
                    $('.main .container-fluid').html(data);
                });*/
                //被选中的素材类型
                var cateType = $("#cate_type :selected").attr("value");
                if( cateType == 1 || cateType == 0){
                    $('#myForm').attr("action","/fodderPicture/index");
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