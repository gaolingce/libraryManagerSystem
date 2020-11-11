<%--
  Created by IntelliJ IDEA.
  User: lenovo
  Date: 2020/11/7
  Time: 14:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>后台欢迎页</title>
    <link rel="stylesheet" href="../css/reset.css"/>
    <link rel="stylesheet" href="../css/content.css"/>
    <%--    <script type="text/javascript" src="../js/laydate/laydate.js"></script>--%>
    <script type="text/javascript" src="../js/vue.min.js"></script>
    <script type="text/javascript" src="../js/vue-resource.min.js"></script>
    <script type="text/javascript" src="../js/json2.js"></script>
</head>
<body marginwidth="0" marginheight="0">
<div class="container" id="mainBody">
    <div v-show="display">
        <div class="public-nav">您当前的位置：<a href="">图书借阅</a>><a href="">图书列表</a></div>
        <div class="public-content">
            <div class="public-content-header">
                <h3>图书列表</h3>
            </div>
            <br>
            <div id="refer" class="public-content-cont">
                图书编号：<input type="text" v-model="bookReferCondition.bookcode"/>
                图书名称： <input type="text" v-model="bookReferCondition.bookname" />
                <input type="button" class="page-btn" value="查询" @click="refer">
            </div>
            <div class="public-content-cont">
                <table class="public-cont-table">
                    <tr>
                        <th style="width:10%">图书id</th>
                        <th style="width:10%">图书编号</th>
                        <th style="width:20%">图书名称</th>
                        <th style="width:10%">图书作者</th>
                        <th style="width:10%">图书价格</th>
                        <th style="width:20%">出版社</th>
                        <th style="width:10%">图书状态</th>
                        <th style="width:10%">操作</th>
                    </tr>
                    <tr v-for="book in bookList">
                        <td>{{book.bookid}}</td>
                        <td>{{book.bookcode}}</td>
                        <td>{{book.bookname}}</td>
                        <td>{{book.author}}</td>
                        <td>{{book.price}}</td>
                        <td>{{book.publisher}}</td>
                        <td>{{book.status==1?"在馆":"借出"}}</td>
                        <td>
                            <div class="table-fun">
                                <a href="javascript:void(0)" @click="borrow(book.bookcode)">借阅</a>
                            </div>
                        </td>
                    </tr>

                </table>
                <div class="page">

                    共<span>{{page.totalRecords}}</span>本图书
                    <a href="javascript:void(0)" @click="toFirstPage">首页</a>
                    <a href="javascript:void(0)" @click="toPrePage">上一页</a>
                    <a href="javascript:void(0)" @click="toNextPage">下一页</a>
                    第<span style="color:red;font-weight:600">{{bookReferCondition.currentPage}}</span>页
                    共<span style="color:red;font-weight:600">{{page.totalPage}}</span>页
                    <a href="javascript:void(0)" @click="toLastPage">末页</a>
                    <input type="text" class="page-input" v-model="page.jumpage" >
                    <input type="submit" class="page-btn" value="跳转" @click="jump">

                </div>
            </div>
        </div>
    </div>


</div>



</body>

<script type="text/javascript">
    new Vue({
        el: "#mainBody",
        data: {
            display:'',
            hidden: '',
            bookList: [],
            book: {
                bookcode:'',
                bookname:'',
                author:'',
                price:'',
                publisher:'',
                status:''
            },
            page:{
                totalRecords: '',
                totalPage: '',
                upPage: '',
                lastPage: '',
                jumpage:''
            },
            udBook:{
                bookcode:'',
                bookname:'',
                author:'',
                price:'',
                publisher:'',
                status:''
            },
            bookReferCondition:{
                bookcode:'',
                bookname:'',
                author:'',
                price:'',
                publisher:'',
                status:1,
                currentPage: 1
            }

        },
        mounted:function () {
            this.display = true;
            this.hidden = false;
            <!--页面加载，显示图书相关信息 currentPage=1 -->
            this.$http.post("/libraryManagerSystem/book/referBooks",this.bookReferCondition).then(
                function (response) {
                    this.bookList = response.body.list;
                    this.bookReferCondition.currentPage = response.body.pageNum;
                    this.page.totalPage = response.body.pages;

                    this.page.totalRecords = response.body.total;
                }
            );
        },
        methods:{
            borrow:function(bookcode){
                const username = sessionStorage.getItem("username");
                this.$http.get("/libraryManagerSystem/borrow/borrowBook",{params:{username:username,bookcode:bookcode}}).then(
                    function (response) {
                        if (response.bodyText==="") {
                            alert("您有逾期图书，或欠款未交，暂时不能借书！");
                        }
                        this.bookList = response.body.list;
                        this.bookReferCondition.currentPage = response.body.pageNum;
                        this.page.totalPage = response.body.pages;
                        this.page.totalRecords = response.body.total;
                    }
                )
            },
            refer:function () {
                this.bookReferCondition.status = 1;
                this.bookReferCondition.currentPage = 1;
                this.$http.post("/libraryManagerSystem/book/referBooks",this.bookReferCondition).then(
                    function (response) {
                        this.bookList = response.body.list;
                        this.bookReferCondition.currentPage = response.body.pageNum;
                        this.page.totalPage = response.body.pages;
                        this.page.totalRecords = response.body.total;
                    }
                );
            },
            //下面几个是分页相关
            jump:function () {
                this.bookReferCondition.currentPage = this.page.jumpage;
                this.$http.post("/libraryManagerSystem/book/referBooks",this.bookReferCondition).then(
                    function (response) {
                        this.bookList = response.body.list;
                        this.bookReferCondition.currentPage = response.body.pageNum;
                        this.page.totalPage = response.body.pages;
                        this.page.totalRecords = response.body.total;
                    }
                );
            },
            toFirstPage:function () {
                this.bookReferCondition.currentPage = 1;
                this.$http.post("/libraryManagerSystem/book/referBooks",this.bookReferCondition).then(
                    function (response) {
                        this.bookList = response.body.list;
                        this.bookReferCondition.currentPage = response.body.pageNum;
                        this.page.totalPage = response.body.pages;
                        this.page.totalRecords = response.body.total;
                    }
                );
            },
            toPrePage:function () {
                if (this.bookReferCondition.currentPage-2<0){
                    alert("当前为第一页");
                    return;
                }
                --this.bookReferCondition.currentPage;
                this.$http.post("/libraryManagerSystem/book/referBooks",this.bookReferCondition).then(
                    function (response) {
                        this.bookList = response.body.list;
                        this.bookReferCondition.currentPage = response.body.pageNum;
                        this.page.totalPage = response.body.pages;
                        this.page.totalRecords = response.body.total;
                    }
                );
            },
            toNextPage:function () {
                if (this.bookReferCondition.currentPage+1>this.page.totalPage){
                    alert("当前为最后一页");
                    return;
                }

                ++this.bookReferCondition.currentPage;
                this.$http.post("/libraryManagerSystem/book/referBooks",this.bookReferCondition).then(
                    function (response) {
                        this.bookList = response.body.list;
                        this.bookReferCondition.currentPage = response.body.pageNum;
                        this.page.totalPage = response.body.pages;
                        this.page.totalRecords = response.body.total;
                    }
                );
            },
            toLastPage:function () {
                this.bookReferCondition.currentPage = this.page.totalPage;
                this.$http.post("/libraryManagerSystem/book/referBooks",this.bookReferCondition).then(
                    function (response) {
                        this.bookList = response.body.list;
                        this.bookReferCondition.currentPage = response.body.pageNum;
                        this.page.totalPage = response.body.pages;
                        this.page.totalRecords = response.body.total;
                    }
                );
            }
        }


    });
</script>

</html>