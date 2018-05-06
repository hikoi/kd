<!-- header logo: style can be found in header.less -->
<%@ page import="org.apache.shiro.SecurityUtils" %>
<header class="main-header">
    %{--<a href="#" class="logo"><b>GUOGEGE</b>Admin</a>--}%
    %{--<a href="#" class="logo"><asset:image src="icon.png" />&nbsp;&nbsp;<b>米酷商城</b></a>--}%
    <style type="text/css" >

    .navbar button {
        margin-right: 20px;
        margin-top: 10px;
        color: white;
        border: 1px solid white;
        background-color: #1f1f1f;
        font-size: 14px;
        border-radius: 3px;
        padding: 0 5px;
    }

    .navbar button:hover {
        background-color: #fff;
        color: #1f1f1f;
    }


    </style>
    <link%{-- rel="shortcut icon" src="icon.png">--}%
    <!-- Header Navbar: style can be found in header.less -->
    <nav class="navbar navbar-static-top" role="navigation">
        <block name="header">
            <div class="page-header">
                <div class="admin_name" style="margin-left: 50px;display: inline-block;">管理员:${SecurityUtils.subject.principal}</div>
                <div class="logout" style="display: inline-block;margin-left: 30px;"><a href="/auth/logout">退出</a></div>
            </div>
        </block>
    </nav>


</header>