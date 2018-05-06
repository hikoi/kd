<%--
  Created by IntelliJ IDEA.
  User: unes
  Date: 2018/4/18
  Time: 14:41
  添加代理商和修改代理商共用页面
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta name="layout" content="homepage">
    <title></title>
</head>

<body>
    <style type="text/css" media="screen">
        #star{
            font-size: 7px;
            padding-left: 4px;
        }
        /*设置下拉框的样式*/
        .col-sm-1{
            width: 13%;
        }
        .col-sm-3{
            width: 30%;
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
    <asset:link rel="stylesheet" href="datetimepicker.css"/>
    <asset:javascript src="bootstrap-datetimepicker.js"/>
    <ul class="list-group" >
        <li class="list-group-item list-group-item-success">
            <h4 style="margin:0;">
                <g:if test="${agent}">
                    修改代理商
                </g:if>
                <g:else>
                    添加代理商
                </g:else>
            </h4>
        </li>
    </ul>
    <form id="myForm" class="form-horizontal" method="post" action="/agent/createOrUpdateAgent<g:if test="${agent}">?opt=update</g:if>" enctype="multipart/form-data">
        <input type="hidden" name="agentid" value="${agent?.agentid}"  id="id" >
        <div class="form-group">
            <label for="name" class="col-sm-2 control-label">选择授权书</label>
            <div class="col-sm-9">
                <g:each status="i" in="${authBooks}" var="authBook">
                    <label class="checkbox-inline">
                        %{--<g:checkBo name="authBooks" checked="false" value="${projectInstance.id}" />--}%
                        <input type="checkbox" id="${'authBook'+(i+1)}" name="authAgentRelation" class="sel_auth_book auth_book_${authBook?.authLv}" value="${authBook?.id}"> ${authBook?.name}
                    </label>
                </g:each>
            </div>
        </div>
        <g:if test="${agent}">
            <div class="form-group">
                <label for="p_weixin" class="col-sm-2 control-label">上级代理微信号</label>
                <div class="col-sm-3">
                    <input type="text" name="p_weixin" value="" class="form-control" id="p_weixin" placeholder="输入上级微信号, 填写1的时候默认上级为工厂">
                </div>
                <div class="is_must">必填(<i>*</i>) </div>
            </div>
        </g:if>
        <div class="form-group">
            <label for="name" class="col-sm-2 control-label">代理姓名</label>
            <div class="col-sm-2">
                <input type="text" name="name" value="${agent?.name}" class="form-control" id="name" placeholder="输入姓名">
            </div>
            <div class="is_must">必填(<i>*</i>)</div>
        </div>
        %{--<fieldset disabled>--}%
            <div class="form-group">
                <label for="agentNo" class="col-sm-2 control-label">授权编号</label>
                <div class="col-sm-2">
                    <input type="text" name="agentNo"  readonly value="<g:if test="${agent}">${agent.agentNo}</g:if><g:else>${agentNo}</g:else>" class="form-control" id="agentNo" placeholder="">
                </div>
            </div>
        %{----}%</fieldset>
        <div class="form-group">
            <label for="tel" class="col-sm-2 control-label">代理手机</label>
            <div class="col-sm-2">
                <input type="text" name="tel" value="${agent?.tel}" class="form-control" id="tel" placeholder="">
            </div>
            <div class="is_must">必填(<i>*</i>)</div>
        </div>
        <div class="form-group">
            <label for="cardno" class="col-sm-2 control-label">身份证号</label>
            <div class="col-sm-2">
                <input type="text" name="cardno" value="${agent?.cardno}" class="form-control" id="cardno" placeholder="">
            </div>
            <div class="is_must">必填(<i>*</i>)</div>
        </div>
        <div class="form-group">
            <label for="weixin" class="col-sm-2 control-label">代理微信</label>
            <div class="col-sm-2">
                <input type="text" name="weixin" value="${agent?.weixin}" class="form-control" id="weixin" placeholder="输入微信号">
            </div>
            <div class="is_must">必填(<i>*</i>)</div>
        </div>
        <g:if test="${!agent}">
            <div class="form-group">
                <label for="password" class="col-sm-2 control-label">登录密码</label>
                <div class="col-sm-2">
                    <input type="text" name="password" value="" class="form-control" id="password" placeholder="输入登录密码">
                </div>
                <div class="is_must">必填(<i>*</i>)</div>
            </div>
        </g:if>
        %{--<fieldset disabled>--}%
            <div class="form-group">
                <label for="star" class="col-sm-2 control-label">代理星级</label>
                <div class="col-sm-2">
                    <select class="form-control" disabled readonly name="star" id="star">
                        <g:each in="${agentStars}" var="agentStar">
                            <option value="${agentStar.id}">${agentStar.name}</option>
                        </g:each>
                    </select>
                </div>
            </div>
        %{--</fieldset>--}%
        <div class="form-group">
            <label for="startime" class="col-sm-2 control-label">开始时间</label>
            <div class="col-sm-2">
                <input size="16" type="text" id="startime" name="startime" readonly class="form_datetime form-control">
                <!-- <input type="text" name="startime" value="" class="form-control tcal frm-controlM tcalInput" id="pw2" placeholder=""> -->
            </div>
        </div>
        <div class="form-group">
            <label for="endtime" class="col-sm-2 control-label">结束时间</label>
            <div class="col-sm-2">
                <input size="16" type="text" id="endtime" name="endtime" readonly class="form-control form_datetime">
                <!-- <input type="text" name="endtime" value="" class="form-control tcal frm-controlM tcalInput" id="pw2" placeholder=""> -->
            </div>
        </div>
        <div class="form-group">
            <label  for="province" class="col-sm-2 control-label">所在省份:</label>
            <div class="col-sm-1">
                <select class="form-control" name="province" id="province">
                    <option value="${agent?.province}">${agent?.province}</option>
                </select>
            </div>
        </div>
        <div class="form-group">
            <label  for="city" class="col-sm-2 control-label">所在城市:</label>
            <div class="col-sm-1">
                <select class="form-control" name="city" id="city">
                    <option value="${agent?.city}">${agent?.city}</option>
                </select>
            </div>
        </div>
        <div class="form-group">
            <label  for="county" class="col-sm-2 control-label">所在县、区:</label>
            <div class="col-sm-1">
                <select class="form-control" name="county" id="county">
                    <option value="${agent?.county}">${agent?.county}</option>
                </select>
            </div>
        </div>
        <div class="form-group">
            <label  for="address" class="col-sm-2 control-label">详细地址:</label>
            <div class="col-sm-4">
                <input type="text" class="form-control" name="address" id="address" value="${agent?.address}">
            </div>
        </div>
        <div class="form-group">
            <label for="specs" class="col-sm-2 control-label">代理QQ</label>
            <div class="col-sm-2">
                <input type="text" name="qq" value="${agent?.qq}" class="form-control" id="specs" placeholder="输入QQ号">
            </div>
        </div>
        <div class="form-group">
            <label for="stat" class="col-sm-2 control-label">代理状态</label>
            <div class="col-sm-1">
                <select class="form-control" name="stat" id="stat">
                    <option value="">---请选择---</option>
                    <option value="1">已审核</option>
                    <option value="0" selected="">待总部审核</option>
                    <option value="-1">黑名单</option>
                    <option value="-2">待上级审核</option>
                    <option value="-3">驳回修改</option>
                </select>
            </div>
        </div>
        <g:if test="${agent}">
            <div class="form-group">
                <label for="password" class="col-sm-2 control-label">修改密码</label>
                <div class="col-sm-2">
                    <input type="password" name="password" value="" class="form-control" id="password" placeholder="输入密码">
                </div>
            </div>
            <div class="form-group">
                <label for="password2" class="col-sm-2 control-label">确认密码</label>
                <div class="col-sm-2">
                    <input type="password" name="password2" value="" class="form-control" id="password2" placeholder="输入密码">
                </div>
            </div>
        </g:if>
        <div class="form-group">
            <div class="col-sm-10">
                <button type="submit" class="btn btn-primary btn-lg btn-block" style="width: 12%;margin: 0 auto;">提交</button>
            </div>
        </div>
    </form>
    <asset:javascript src="area.js"/>
    <script type="text/javascript">
        var s=["province","city","county"];//三个select的name
        var province = '${agent?.province}';
        var city = '${agent?.city}';
        var county = '${agent?.county}';
        province = province ? province : "省份";
        city = city ? city : "地级市";
        county = county ? county : "市、县级市";
        var opt0 = [province,city,county];//初始值
        _init_area();

        //验证微信是否存在
        $("#weixin").blur(function () {
            var weixin = $("#weixin").val();
            $.post("/agent/verificationWeixin",{weixin:weixin},function (data) {
                if(data){
                    //alert(data);
                    $("#weixin").focus();
                }
            });
        });

        $(function(){

            //选择授权书回显
            <g:each status="i" in="${agent?.authAgentRelation}" var="vo">
                $("${'#authBook'+vo?.authId}").attr("checked","checked");
            </g:each>
            //时间格式化
            Date.prototype.format = function (fmt) { //author: meizz
                var o = {
                    "M+": this.getMonth() + 1, //月份
                    "d+": this.getDate(), //日
                    "H+": this.getHours(), //小时
                    "m+": this.getMinutes(), //分
                    "s+": this.getSeconds(), //秒
                    "q+": Math.floor((this.getMonth() + 3) / 3), //季度
                    "S": this.getMilliseconds() //毫秒
                };
                if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
                for (var k in o)
                    if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
                return fmt;
            }
            var nowTime  = new Date();
            var startime = nowTime.format("yyyy-MM-dd HH:mm");
            nowTime.setFullYear(nowTime.getFullYear()+1);
            nowTime.setDate(nowTime.getDate()-1);
            var endtime = nowTime.format("yyyy-MM-dd HH:mm");
            //设置开始和结束时间
            $("#startime").val(startime);
            $("#endtime").val(endtime);
            //

            $('#myForm').submit(function() {
                var name = is_empty('#name');
                var tel = is_empty('#tel');
                var cardno = is_empty('#cardno');
                var weixin = is_empty('#weixin');
                var password = is_empty('#password');
                var phone = $('#tel').val();
                var card = $('#cardno').val();

                if(name === false){
                    showMsg('姓名不能为空!');
                    return false;
                }
                if(tel === false){
                    showMsg('手机号码不能为空!');
                    return false;
                }
                var partten = /^1[3,4,5,7,8]\d{9}$/;
                if(!partten.test(phone)){
                    showMsg('手机号码格式不正确!');
                    return false;
                }

                if(cardno === false){
                    showMsg('身份证号不能为空!');
                    return false;
                }
                if(IDCardCheck(card) === false){

                    return  false;
                }

                if(weixin === false){
                    showMsg('微信号不能为空!');
                    return false;
                }

                if(password === false){
                    showMsg('密码不能为空!');
                    return false;
                }


                $(this).ajaxSubmit(function(data){
                    showMsg(data.msg);
                    console.log(data);
                    if(data.status == 1){
                        LoadPage("__APP__/AgentManage/index.html")
                    }
                });

                //防止页面刷新
                return false;
            });

            //控制选择授权书
            $('.sel_auth_book').click(function(event) {
                var auth_lv = parseInt($(this).filter(":checked").attr('auth_lv'));

                if(auth_lv == 1){
                    $(".auth_book_2").each(function(){
                        $(this).prop("checked",!!$(".auth_book_1").prop("checked"));
                    });

                }


                console.log(auth_lv);

            });

            //时间选择器
            $(".form_datetime").datetimepicker({
                format: "yyyy-mm-dd hh:ii",
                autoclose: true,
            });


        });

    </script>
</body>
</html>
