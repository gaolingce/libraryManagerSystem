<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title></title>
    <link rel="stylesheet" href="css/reset.css">
    <link rel="stylesheet" href="css/public.css">
    <script type="text/javascript" src="js/vue-router.min.js"></script>
    <script type="text/javascript" src="js/vue.min.js"></script>
    <script type="text/javascript" src="js/vue-resource.min.js"></script>
    <script type="text/javascript" src="js/json2.js"></script>
</head>
<body>
<div class="public-header-warrp">
    <div class="public-header">
        <div class="content">
            <div class="public-header-logo"><a href=""><i>LOGO</i>
                <h3>aowin</h3></a></div>
            <div class="public-header-admin fr" id="body">
                <p class="admin-name">{{username}} 您好！</p>
                <div class="public-header-fun fr">
                    <a href="#" class="public-header-man">管理</a>
                    <a href="javascript:void(0)" class="public-header-loginout" @click="outLogin">安全退出</a>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="clearfix"></div>
<!-- 内容展示 -->
<div class="public-ifame mt20">
    <div class="content">
        <!-- 内容模块头 -->

        <div class="clearfix"></div>
        <!-- 左侧导航栏 -->
        <div class="public-ifame-leftnav">
            <div class="public-title-warrp">
                <div class="public-ifame-title ">
                    <a href="">首页</a>
                </div>
            </div>
            <ul class="left-nav-list">
                <li class="public-ifame-item">
                    <a href="javascript:;">系统管理</a>
                    <div class="ifame-item-sub">
                        <ul>
                            <li><a href="usermanager/addUser.jsp" target="content">添加用户</a></li>
                            <li><a href="usermanager/userManager.jsp" target="content">用户管理</a></li>
                        </ul>
                    </div>
                </li>
                <li class="public-ifame-item">
                    <a href="javascript:;">图书管理</a>
                    <div class="ifame-item-sub">
                        <ul>
                            <li><a href="libraryManager/addBook.jsp" target="content">新增图书</a>
                            <li><a href="libraryManager/booksManager.jsp" target="content">图书管理</a></li>
                        </ul>
                    </div>
                </li>
                <li class="public-ifame-item">
                    <a href="javascript:;">图书借阅</a>
                    <div class="ifame-item-sub">
                        <ul>
                            <li><a href="borrowBooks/userInformation.jsp" target="content">个人信息</a>
                            <li><a href="borrowBooks/borrowing.jsp" target="content">已借列表</a>
                            <li><a href="borrowBooks/bookList.jsp" target="content">图书列表</a></li>
                        </ul>
                    </div>
                </li>


            </ul>
        </div>
        <!-- 右侧内容展示部分 -->
        <div class="public-ifame-content">
            <iframe name="content" src="mainPage/main.jsp" frameborder="0" id="mainframe" scrolling="yes" marginheight="0" marginwidth="0" width="100%" style="height: 700px;"></iframe>
        </div>
    </div>
</div>
<script src="js/jquery.min.js"></script>
<script>

    new Vue({
        el:"#body",
        data:{
           username:'',
        },
        mounted:function () {
            this.username = sessionStorage.getItem("username");
        },
        methods:{
            outLogin:function () {
                // this.$router.push("login.jsp");
                location.href="login.jsp";
                sessionStorage.removeItem("username");
            }
        }
    });


    $().ready(function(){
        var item = $(".public-ifame-item");

        for(var i=0; i < item.length; i++){
            $(item[i]).on('click',function(){
                $(".ifame-item-sub").hide();
                if($(this.lastElementChild).css('display') == 'block'){
                    $(this.lastElementChild).hide()
                    $(".ifame-item-sub li").removeClass("active");
                }else{
                    $(this.lastElementChild).show();
                    $(".ifame-item-sub li").on('click',function(){
                        $(".ifame-item-sub li").removeClass("active");
                        $(this).addClass("active");
                    });
                }
            });
        }
    });
</script>
</body>
</html>