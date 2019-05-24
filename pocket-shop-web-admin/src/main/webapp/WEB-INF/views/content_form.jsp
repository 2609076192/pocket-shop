<%--
  Created by IntelliJ IDEA.
  User: chenjiaxing
  Date: 2019/5/15
  Time: 16:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sys" tagdir="/WEB-INF/tags/sys" %>
<html>
<head>
    <title>口袋商城后台管理| 内容表单页</title>
    <jsp:include page="../includs/header.jsp"/>
    <link href="/static/assets/plugins/jquery-ztree/css/zTreeStyle/zTreeStyle.min.css" rel="stylesheet"/>
    <link rel="stylesheet" href="/static/assets/plugins/dropzone/min/dropzone.min.css" />
    <link rel="stylesheet" href="/static/assets/plugins/dropzone/min/basic.min.css" />
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
                内容管理
                <small>content manage</small>
            </h1>
            <ol class="breadcrumb">
                <li><a href="#"><i class="fa fa-dashboard"></i> 首页</a></li>
                <li class="active">内容管理</li>
            </ol>
            <br/>

            <div class="row">
                <div class="col-md-12">
                    <div class="alert alert-danger alert-dismissible" ${baseResult.message == null ? "style='display:none;'" : ""}>
                        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                        ${baseResult.message}
                    </div>
                </div>
                <div class="col-md-12">
                    <div class="box box-info">
                        <div class="box-header with-border">
                            <h3 class="box-title">${tbUser.id==null?"新增":编辑}内容</h3>
                        </div>
                        <!-- /.box-header -->
                        <!-- form start -->
                        <form:form cssClass="form-horizontal" action="/content/save" method="post"
                                   modelAttribute="tbContent" id="inputForm">
                            <form:hidden path="id" cssClass="form-control required email"/>
                            <div class="box-body">
                                <div class="form-group">
                                    <label for="categoryId" class="col-sm-2 control-label">分类</label>

                                    <div class="col-sm-10">
                                        <form:hidden path="categoryId" />
                                        <input id="categoryName" class="form-control required" readonly="true"
                                                    data-toggle="modal" data-target="#modal-default"/>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label for="title" class="col-sm-2 control-label" >标题</label>

                                    <div class="col-sm-10">
                                        <form:input path="title" cssClass="form-control required" placeholder="标题"/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="subTitle" class="col-sm-2 control-label" >子标题</label>

                                    <div class="col-sm-10">
                                        <form:input path="subTitle" cssClass="form-control required" placeholder="子标题"/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="titleDesc" class="col-sm-2 control-label" >标题描述</label>

                                    <div class="col-sm-10">
                                        <form:input path="titleDesc" cssClass="form-control required" placeholder="标题描述"/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="url" class="col-sm-2 control-label" >链接</label>

                                    <div class="col-sm-10">
                                        <form:input path="url" cssClass="form-control required" placeholder="链接"/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="url" class="col-sm-2 control-label">图片1</label>

                                    <div class="col-sm-10">
                                        <form:hidden path="pic" cssClass="form-control required" readonly="true"/>
                                        <div id="dropz" class="dropzone"></div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="url" class="col-sm-2 control-label">图片2</label>

                                    <div class="col-sm-10">
                                        <form:input path="pic2" cssClass="form-control required"/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="content" class="col-sm-2 control-label">内容</label>

                                    <div class="col-sm-10">
                                        <form:textarea path="content" cssClass="form-control required"/>
                                    </div>
                                </div>
                            </div>
                            <!-- /.box-body -->
                            <div class="box-footer">
                                <button type="button" class="btn btn-default" onclick="history.go(-1);">返回</button>
                                <button type="submit" class="btn btn-info pull-right">提交</button>
                            </div>
                            <!-- /.box-footer -->
                        </form:form>
                    </div>
                </div>
            </div>
        </section>
    </div>
    <!--中间内容结束-->

    <!-- 版权信息开始 -->
    <jsp:include page="../includs/copyright.jsp"/>
    <!-- 版权信息结束 -->
    <jsp:include page="../includs/footer.jsp"/>
    <!--自定义模态框-->
    <sys:model title="请选择"
               message='<ul id="myTree" class="ztree" style="width:260px; overflow:auto;"></ul>'></sys:model>
</div>
<script src="/static/assets/plugins/jquery-ztree/js/jquery.ztree.core-3.5.min.js"></script>
<script src="/static/assets/plugins/dropzone/min/dropzone.min.js"></script>
<script>
    $(function () {
        App.initZTree("/content/category/treeData",["id"],function (nodes) {
            var category_id = nodes[0].id;

            $("#categoryId").val(category_id);
            $("#categoryName").val(nodes[0].name);
            $("#modal-default").modal("hide");
        });
    })
    var myDropzone = new Dropzone("#dropz", {
        url: "/upload",
        dictDefaultMessage: '拖动文件至此或者点击上传', // 设置默认的提示语句
        paramName: "dropzFile", // 传到后台的参数名称
        init: function () {
            this.on("success", function (file, data) {
                // 上传成功触发的事件
                $("#pic").val(data.fileName);
            });
        }
    });
</script>
</body>
</html>
