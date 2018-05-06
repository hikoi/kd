<%--
  Created by IntelliJ IDEA.
  User: unes
  Date: 2018/4/23
  Time: 13:11
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta name="layout" content="homepage">
    <meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>
    %{--<asset:javascript src="jquery-2.1.3.js"/>--}%
</head>

<body>
    <ul class="list-group" >
        <li class="list-group-item list-group-item-success"><h4 style="margin:0;">标签列表</h4></li>
    </ul>
    <form id="myForm" class="form-inline" method="post" action="/labelCode/index" enctype="multipart/form-data">
        <div class="form-group">
            <label>
                <select class="form-control" name="codeType">
                    <option value="maxCode" <g:if test="${'maxCode' == params.codeType}">selected</g:if>>大标号码</option>
                    <option value="middleCode" <g:if test="${'middleCode' == params.codeType}">selected</g:if>>中标标号码</option>
                    <option value="minCode" <g:if test="${'minCode' == params.codeType}">selected</g:if>>小标号码</option>
                    <option value="securityCode" <g:if test="${'securityCode' == params.codeType}">selected</g:if>>防伪标号码</option>
                </select>
            </label>
            <input type="text" class="form-control" id="codeValue" value="${params.codeValue}" name="codeValue">
        </div>
        <div class="form-group">
            <label>状态</label>
            <select class="form-control" name="status">
                <option value="">请选择</option>
                <option value="1" <g:if test="${'1' == params.status}">selected</g:if>>已导出</option>
                <option value="0" <g:if test="${'0' == params.status}">selected</g:if>>未导出</option>
            </select>
        </div>
        <div class="form-group">
            <label>拖的数量</label>
            <input type="text" class="form-control" value="${params.minNumber}" size="2" id="minNumber" name="minNumber" onkeyup="value=value.replace(/[^\d]/g,'')" placeholder="输数字">
        </div>
        <!-- <div class="form-group">
        <label for="exampleInputEmail2">开始时间</label>
        <input type="text" class="form-control" id="start_time" name="start_time">
      </div>
      <div class="form-group">
        <label for="exampleInputEmail2">结束时间</label>
        <input type="text" class="form-control" id="end_time" name="end_time">
      </div> -->
        <button type="submit" class="btn btn-default">搜索</button>
        <span id="reset" class="btn btn-default">重置</span>
    </form>
    <div class="panel panel-default" style="margin-top: 20px;">
        <table class="table">
            <thead>
            <tr>
                <th>序号</th>
                <th>大标号码</th>
                <th>中标标号码</th>
                <th>小标号码</th>
                <th>防伪标号码</th>
                <th>状态</th>
                <th>拖数</th>
                <th>添加时间</th>
            </tr>
            </thead>
            <tbody>
                <g:each status="i" in="${pagedResultList}" var="vo">
                    <tr>
                        <th scope="row">${vo?.id}</th>
                        <td>${vo?.maxCode}</td>
                        <td>${vo?.middleCode}</td>
                        <td>${vo?.minCode}</td>
                        <td>${vo?.securityCode}</td>
                        <td>
                            <g:if test="${vo?.status}">
                                已导出
                            </g:if>
                            <g:else>
                                未导出
                            </g:else>
                        </td>
                        <td>${vo?.minNumber}</td>
                        <td class="addTime" id="${i}">${vo?.addTime}</td>
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
            </li>
        </ul>
    </nav>
    <script>
        $(function(){
            //重置条件搜索栏
            $("#reset").click(function () {
                window.location.href="/labelCode/index?codeValue&status&minNumber";
            });

            //分页
           /* $('.pagination li').click(function(){
                var code_type = '<{$post.code_type}>';
                var code_value = '<{$post.code_value}>';
                var status = '<{$post.status}>';
                var minNumber = '<{$post.minNumber}>';
                var start_time = '<{$post.start_time}>';
                var end_time = '<{$post.end_time}>';
                var page = $(this).children('a').attr('page');
                var class_name = $(this).attr('class');

                if(class_name != 'active'){
                    LoadPage('__APP__/MakeCode/index.html',{'p': page,'code_type':code_type,'code_value':code_value,'status':status,'minNumber':minNumber,'start_time':start_time,'end_time':end_time});
                }

            });*/



            //搜索
            /*$('#myForm').submit(function() {

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