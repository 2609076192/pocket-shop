<%--
  Created by IntelliJ IDEA.
  User: chenjiaxing
  Date: 2019/5/15
  Time: 16:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sys" tagdir="/WEB-INF/tags/sys" %>
<html>
<head>
    <title>口袋商城后台管理| 主页</title>
    <jsp:include page="../includs/header.jsp"/>
</head>
<body class="hold-transition skin-blue sidebar-mini">
<div class="wrapper">
    <!--首部开始-->
    <jsp:include page="../includs/nav.jsp"/>
    <!--首部结束-->

    <!--左侧菜单开始-->
    <jsp:include page="../includs/menu.jsp"/>
    <!--左侧菜单结束-->

    <!--中间内容开始-->
    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
            <h1>
                用户管理
                <small>user manage</small>
            </h1>
            <ol class="breadcrumb">
                <li><a href="#"><i class="fa fa-dashboard"></i> 首页</a></li>
                <li class="active">用户管理</li>
            </ol>
            <br/>
            <!-- /.row -->
            <div class="row">
                <div class="col-xs-12">
                    <div class="alert alert-${baseResult.status == 200?"success":"danger"} alert-dismissible" ${baseResult.message == null ? "style='display:none;'" : ""}>
                        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                        ${baseResult.message}
                    </div>
                </div>
                <div class="col-xs-12">
                    <div class="box">
                        <div class="box-header">
                            <h3 class="box-title">用户列表</h3>

                            <div class="row" style="padding-left: 15px;padding-top: 13px;">
                                <a href="/user/form" type="button" class="btn btn-default btn-sm"><i
                                        class="fa fa-plus"></i> 新增</a>&nbsp;&nbsp;&nbsp;
                                <button href="#" type="button" class="btn btn-default btn-sm deleteAll"
                                        onclick="App.deleteMulti('/user/delete')"><i class="fa fa-trash"></i>
                                    批量删除
                                </button>&nbsp;&nbsp;&nbsp;
                                <a href="#" type="button" class="btn btn-default btn-sm"><i
                                        class="fa fa-cloud-upload"></i> 导入</a>&nbsp;&nbsp;&nbsp;
                                <a href="#" type="button" class="btn btn-default btn-sm"><i
                                        class="fa fa-cloud-download"></i> 导出</a>&nbsp;&nbsp;&nbsp;
                                <button class="btn btn-primary btn-sm"
                                        onclick="$('.search-panle').css('display')=='none'?$('.search-panle').show():$('.search-panle').hide()">
                                    <i
                                            class="fa fa-search"></i> 搜索
                                </button>
                            </div>

                            <div class="row search-panle" style="padding-left: 5px;display: none">
                                <form:form cssClass="form-horizontal" action="/user/search" method="post"
                                           modelAttribute="tbUser">
                                    <div class="row">
                                        <div class="col-xs-3">
                                            <div class="form-group">
                                                <label for="email" class="col-sm-3 control-label">邮箱</label>
                                                <div class="col-sm-8">
                                                    <form:input path="email" cssClass="form-control " placeholder="邮箱"/>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-xs-3">
                                            <div class="form-group">
                                                <label for="username" class="col-sm-3 control-label">姓名</label>
                                                <div class="col-sm-8">
                                                    <form:input path="username" cssClass="form-control"
                                                                placeholder="姓名"/>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-xs-3">
                                            <div class="form-group">
                                                <label for="phone" class="col-sm-3 control-label">手机</label>
                                                <div class="col-sm-8">
                                                    <form:input path="phone" cssClass="form-control" placeholder="手机"/>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-xs-3">
                                            <button type="submit" class="btn btn-info">搜索</button>
                                        </div>
                                    </div>
                                </form:form>
                            </div>

                        </div>
                        <!-- /.box-header -->
                        <div class="box-body table-responsive no-padding">
                            <table class="table table-hover" id="dataTable">
                                <thead>
                                <tr>
                                    <th><input type="checkbox" class="minimal icheck_master"/></th>
                                    <th>ID</th>
                                    <th>用户名</th>
                                    <th>手机</th>
                                    <th>邮箱</th>
                                    <th>更新时间</th>
                                    <th>操作</th>
                                </tr>
                                </thead>
                                <tbody>

                                </tbody>
                            </table>
                        </div>
                        <!-- /.box-body -->
                    </div>
                    <!-- /.box -->
                </div>
            </div>
        </section>


    </div>

    <!--中间内容结束-->

    <!-- 版权信息开始 -->
    <jsp:include page="../includs/copyright.jsp"/>
    <!-- 版权信息结束 -->
    <jsp:include page="../includs/footer.jsp"/>
</div>
<!--自定义模态框-->
<sys:model></sys:model>
<script>
    $(function () {
        var columns = [
            {
                "data": function (row, type, val, meta) {
                    return '<input type="checkbox" id="'+row.id+'" class="minimal"/>';
                }
            },
            {"data": "id"},
            {"data": "username"},
            {"data": "phone"},
            {"data": "email"},
            {"data": "updated"},
            {
                "data": function (row, type, val, meta) {
                    return '<a href="#" type="button" class="btn btn-default btn-sm"><i class="fa fa-trash"></i> 查看</a>' +
                        '<a href="#" type="button" class="btn btn-primary btn-sm"><i class="fa fa-search"></i> 编辑</a>' +
                        '<a href="#" type="button" class="btn btn-danger btn-sm"><i class="fa fa-edit"></i> 删除</a>';
                }
            }
        ];

        App.initDataTables("/user/page", columns);

    })


</script>
</body>
</html>
