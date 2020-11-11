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
        <div class="public-nav">您当前的位置：<a href="">图书管理</a>><a href="">图书管理</a></div>
        <div class="public-content">
            <div class="public-content-header">
                <h3>图书管理</h3>
            </div>
            <br>
            <div id="refer" class="public-content-cont">
                图书编号：<input type="text" v-model="bookReferCondition.bookcode"/>
                图书名称： <input type="text" v-model="bookReferCondition.bookname" />
                状态：
                <select class="form-input-txt"  v-model="bookReferCondition.status">
                    <option value="1" >在馆</option>
                    <option value="-1" >借出</option>
                </select>
                <input type="button" class="page-btn" value="查询" @click="refer">
            </div>
            <div class="public-content-cont">
                <table class="public-cont-table">
                    <tr>
                        <th style="width:10%">图书id</th>
                        <th style="width:10%">图书编号</th>
                        <th style="width:15%">图书名称</th>
                        <th style="width:10%">图书作者</th>
                        <th style="width:15%">图书价格</th>
                        <th style="width:10%">出版社</th>
                        <th style="width:10%">图书状态</th>
                        <th style="width:20%">操作</th>
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
                                <a href="javascript:void(0)" @click="ud(book.bookcode)">修改</a>
                                <a href="javascript:void(0)" @click="del(book.bookcode)">删除</a>
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


    <!--修改图书信息-->
    <div class="container" v-show="hidden">
        <div class="public-content" id="addUser">
            <div class="public-content-header">
                <h3>新增图书</h3>
            </div>
            <div class="public-content-cont" >
                <div class="form-group">
                    <label for="bookcode">图书编号</label>
                    <input class="form-input-txt" type="text" id="bookcode"   v-model.trim="udBook.bookcode" />
                </div>
                <div class="form-group">
                    <label for="username">图书名称</label>
                    <input class="form-input-txt" type="text" id="username"   v-model.trim="udBook.bookname" />
                </div>
                <div class="form-group">
                    <label for="password">图书作者</label>
                    <input class="form-input-txt" type="password" id="password" v-model.trim="udBook.author"/>
                </div>
                <div class="form-group">
                    <label for="idcard">图书价格</label>
                    <input class="form-input-txt" type="text" id="idcard" v-model.trim="udBook.price"/>
                </div>
                <div class="form-group">
                    <label for="phone">出版社</label>
                    <input class="form-input-txt" type="text" id="phone" v-model.trim="udBook.publisher"/>
                </div>
                <div class="form-group">
                    <label for="status">图书状态</label>
                    <select class="form-input-txt" id="status" v-model="udBook.status">
                        <option value="1" >在馆</option>
                        <option value="-1" >借出</option>
                    </select>
                </div>
            </div>

            <div class="clearfix"></div>
            <div class="form-group" style="margin-left:150px;">
                <input type="button" class="sub-btn"  @click="saveChange" value="提  交"/>
                <input type="button" class="sub-btn" @click="reset"  value="重  置"/>
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
                status:'',
                currentPage: 1
            }

        },
        mounted:function () {
            this.display = true;
            this.hidden = false;
            <!--页面加载，就调用referUsers（） currentPage=1 -->
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
            del:function (bookcode) {
                this.$http.get("/libraryManagerSystem/book/delBook",{params:{bookcode:bookcode}}).then(function (response) {
                    this.bookList = response.body.list;
                    this.bookReferCondition.currentPage = response.body.pageNum;
                    this.page.totalPage = response.body.pages;
                    this.page.totalRecords = response.body.total;
                })
            },
            <!--同步修改信息-->
            ud:function (bookcode) {
                this.display = false;
                this.hidden = true;
                this.$http.get("/libraryManagerSystem/book/checkBookCode",{params:{bookcode:bookcode}}).then(
                    function (response) {
                        this.udBook.bookname = response.body.bookname;
                        this.udBook.author = response.body.author;
                        this.udBook.price = response.body.price;
                        this.udBook.publisher = response.body.publisher;
                        this.udBook.bookcode = response.body.bookcode;
                        this.udBook.status = response.body.status;
                    }
                )
            },
            <!--修改完成后保存-->
            saveChange:function () {
                if (this.isDisable === true){
                    return;
                }
                this.$http.post("/libraryManagerSystem/book/updateBook",this.udBook).then(function (response) {
                    alert("修改成功！");
                    this.reset();
                    this.bookList = response.body.list;
                    this.bookReferCondition.currentPage = response.body.pageNum;
                    this.page.totalPage = response.body.pages;
                    this.page.totalRecords = response.body.total;

                    this.display = true;
                    this.hidden = false;
                })
            },
            reset:function () {
                this.udBook.bookname = '';
                this.udBook.author = '';
                this.udBook.price = '';
                this.udBook.publisher = '';
                this.udBook.bookcode = '';
                this.udBook.status = '';
            },
            refer:function () {
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