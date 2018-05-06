<%--
  Created by IntelliJ IDEA.
  User: saarixx
  Date: 8/9/14
  Time: 9:43
--%>
<!DOCTYPE html>
<%@ page import="grails.util.Environment; org.apache.shiro.SecurityUtils" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    %{--<link href="http://cdn.bootcss.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet">--}%
    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
  %{--  <!--[if lt IE 9]>
          <script src="//cdn.bootcss.com/html5shiv/3.7.2/html5shiv.min.js"></script>
          <script src="//cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
        <![endif]-->--}%
    %{--<script src="grails-app/assets/javascripts/jquery-2.1.3.js"></script>--}%
    <asset:stylesheet rel="stylesheet" href="bootstrap.min.css" />
    <asset:javascript src="jquery-2.1.3.js"/>
    <asset:javascript src="bootstrap.js"/>
    <!-- pagination -->
    <asset:stylesheet src="jquery.pagination_2/pagination.css"/>
    <link rel="shortcut icon" href="http://unesmall.b0.upaiyun.com/1/LTE=/SVRFTS1QVUJMSVNI/MA==/20151118/vNTT-0-1447848511424.png">

    <style>
        .content-wrapper{
            width: 83%; float: left;
        }
        .main-sidebar{
            width: 15%; float: left;
        }
        .menu{
            width: 100%;
            float: left;
        }
        .menu .list-group .active{
            background-color: #eee;
        }
        .list-group-item .list-group{
            margin-bottom: 0px;
        }
        .main{
            width: 85%;
            float: left;
        }

        .images{
            margin-bottom:5px;
        }
        #more_images{
            background: #DBEAF9;
            float: left;
            height: 30px;
            line-height: 30px;
            text-align: center;
            width: 60px;
        }

        .is_must{float:left;width:10%;}
        .is_must i{
            color:red;
            font-size: 22px;
            color: red;
            position: relative;
            top: 9px;
            left: -1px;
        }
    </style>
    <script>

        var URL = '__APP__/';

        /*function LoadPage(url,data){
            if(url){
                $.ajax({
                    url:url,
                    data:data,
                    async:false,
                    success:function(data) {
                        alert("看一下这个是: " + data);
                        var jsonData = $.parseJSON(data);
                        /!*optional stuff to do after success *!/
                        $('.main .container-fluid').html(jsonData);
                    }
                });

            }
        }*/

        function is_empty(ele){
            if(!ele){
                return false;
            }

            var val = $(ele).val();

            if(!val){
                return false;
            }

            return val;
        }

        function showMsg(msg){
            alert(msg);
        }

        //验证身份证
        function IDCardCheck(num) {

            return true;

            num = num.toUpperCase();
            //身份证号码为15位或者18位，15位时全为数字，18位前17位为数字，最后一位是校验位，可能为数字或字符X。
            if (!(/(^\d{15}$)|(^\d{17}([0-9]|X)$)/.test(num))) {
                alert('输入的身份证号长度不对，或者号码不符合规定！\n15位号码应全为数字，18位号码末位可以为数字或X。');
                return false;
            }
            //校验位按照ISO 7064:1983.MOD 11-2的规定生成，X可以认为是数字10。
            //下面分别分析出生日期和校验位
            var len, re;
            len = num.length;
            if (len == 15) {
                re = new RegExp(/^(\d{6})(\d{2})(\d{2})(\d{2})(\d{3})$/);
                var arrSplit = num.match(re);

                //检查生日日期是否正确
                var dtmBirth = new Date('19' + arrSplit[2] + '/' + arrSplit[3] + '/' + arrSplit[4]);
                var bGoodDay;
                bGoodDay = (dtmBirth.getYear() == Number(arrSplit[2])) && ((dtmBirth.getMonth() + 1) == Number(arrSplit[3])) && (dtmBirth.getDate() == Number(arrSplit[4]));
                if (!bGoodDay) {
                    alert('输入的身份证号里出生日期不对！');
                    return false;
                }
                else {
                    //将15位身份证转成18位
                    //校验位按照ISO 7064:1983.MOD 11-2的规定生成，X可以认为是数字10。
                    var arrInt = new Array(7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2);
                    var arrCh = new Array('1', '0', 'X', '9', '8', '7', '6', '5', '4', '3', '2');
                    var nTemp = 0, i;
                    num = num.substr(0, 6) + '19' + num.substr(6, num.length - 6);
                    for (i = 0; i < 17; i++) {
                        nTemp += num.substr(i, 1) * arrInt[i];
                    }
                    num += arrCh[nTemp % 11];
                    return true;
                }
            }
            if (len == 18) {
                re = new RegExp(/^(\d{6})(\d{4})(\d{2})(\d{2})(\d{3})([0-9]|X)$/);
                var arrSplit = num.match(re);

                //检查生日日期是否正确
                var dtmBirth = new Date(arrSplit[2] + "/" + arrSplit[3] + "/" + arrSplit[4]);
                var bGoodDay;
                bGoodDay = (dtmBirth.getFullYear() == Number(arrSplit[2])) && ((dtmBirth.getMonth() + 1) == Number(arrSplit[3])) && (dtmBirth.getDate() == Number(arrSplit[4]));
                if (!bGoodDay) {
                    alert(dtmBirth.getYear());
                    alert(arrSplit[2]);
                    alert('输入的身份证号里出生日期不对！');
                    return false;
                }
                else {
                    //检验18位身份证的校验码是否正确。
                    //校验位按照ISO 7064:1983.MOD 11-2的规定生成，X可以认为是数字10。
                    var valnum;
                    var arrInt = new Array(7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2);
                    var arrCh = new Array('1', '0', 'X', '9', '8', '7', '6', '5', '4', '3', '2');
                    var nTemp = 0, i;
                    for (i = 0; i < 17; i++) {
                        nTemp += num.substr(i, 1) * arrInt[i];
                    }
                    valnum = arrCh[nTemp % 11];
                    if (valnum != num.substr(17, 1)) {
                        alert('18位身份证的校验码不正确！'); //应该为： + valnum
                        return false;
                    }
                    return true;
                }
            }
            return false;
        }

    </script>
    <block name="title"><title>酷兜云商</title></block>
</head>
<body>
    <shiro:authenticated/>

    <!-- Jquery -->
    %{--<asset:javascript src="jquery-2.1.3.js"/>--}%
    <!-- Left side column. contains the logo and sidebar -->
    %{--<g:render template="/layouts/nav"/>--}%
    <g:render template="/layouts/header"/>


    <aside class="main-sidebar">
        <!-- sidebar: style can be found in sidebar.less -->
        <section class="sidebar">
            <g:render template="/layouts/nav"/>
        </section>
    </aside>

    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper">
        <g:layoutBody/>
    </div><!-- /.content-wrapper -->




    <script type="text/javascript">
        //域名
        var teamname = ['百优团队','新SHOW团队','巨人联盟','梵领团队','天成国际','美嫩BABY团队','one团队','凡水团队','优品团队','优美国际','利宁团队','飞跃联盟','梵领团队'],
            site = ['byg','xsg','jrg','flg','tcg','mng','oneg','fsg','ypg','ymg','lng','fyg','zfg'],
            websiteName = location.host;
        websiteName = websiteName.split('.');
        websiteName = websiteName[0];
        for(var i=0;i<site.length;i++){
            if(websiteName == site[i]){
                document.title = teamname[i];
            }
        }
    </script>

    %{-- 首页三个代理商数据--}%
    <script type="text/javascript">
        $(document).ready(function() {
            //去掉addTime秒后面的".0"(加了class属性为addTime的时间)
            $(".addTime").each(function(key,value){
                value.innerHTML = value.innerHTML.substring(0,19);
            });

            //分页中的页码当前页的样式
            $(".currentStep").css("background-color","#337AB7");
            $(".currentStep").css("color","#fff");


            var url = window.location.href;
            //获取url端口后面的路径
            var endDir = url.substring(url.indexOf("/",8)+1);
            if(!endDir) {
                $.ajax({
                    url: "/agent/pageIndex",      //响应到那个处理 对应到controller的函数
                    //data: "id=" + this.value,
                    //cache: false,
                    //dataType: json,
                    success: function (data) {
                        var dataJson = $.parseJSON(data);
                        $("#validCount").append(" <span>" + dataJson.validCount + "</span>");
                        $("#stayCount").append(" <span>" + dataJson.stayCount + "</span>");
                        $("#allCount").append(" <span>" + dataJson.allCount + "</span>");
                    }
                });
            }
        });
    </script>
</body>

</html>