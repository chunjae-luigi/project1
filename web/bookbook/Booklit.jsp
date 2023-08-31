<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%-- 1. 필요한 라이브러리 로딩 --%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>

<%@ page import="com.grownjoy.db.*" %>
<%@ page import="com.grownjoy.dto.*" %>

<%
    Connection con = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;


    //2. DB 연결하기
    DBC conn = new MariaDBCon();
    con = conn.connect();

    //3. SQL을 실행하여 Result(공지사항목록)을 가져오기
    String sql = "select * from book order by bno desc";
    pstmt = con.prepareStatement(sql);
    rs = pstmt.executeQuery();
    //4.가져온 목록을 boardList(공지사항목록)에 하나 씩 담기

    List<Book> bookList = new ArrayList<>();

    while(rs.next()){
        Book bk = new Book();
        bk.setBno(rs.getInt("bno"));
        bk.setTitle(rs.getString("title"));
        bk.setCompany(rs.getString("company"));
        bk.setAuthor(rs.getString("author"));
        bk.setDate(rs.getString("date"));
        bk.setPrice(rs.getInt("price"));
        bookList.add(bk);
    }
    conn.close(rs, pstmt, con);
    %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>온라인 서점 목록</title>
    <%@ include file="../head.jsp" %>
    <link rel="stylesheet" href="<%=headPath%>/css/sub.css">
    <style>
        /* 본문 영역 스타일 */
        .contents { clear:both; min-height:100vh;
            background-image: url("../image/sub/bg_visual_overview.jpg");
            background-repeat: no-repeat; background-position:center -250px; }
        .contents::after { content:""; clear:both; display:block; width:100%; }

        .page { clear:both; width: 100vw; height: 100vh; position:relative; }
        .page::after { content:""; display:block; width: 100%; clear:both; }

        .page_wrap { clear:both; width: 1200px; height: auto; margin:0 auto; }
        .page_tit { font-size:48px; text-align: center; padding-top:1em; color:#fff;
            padding-bottom: 2.4rem; }

        .tb1 { width:800px; margin:50px auto; }
        .tb1 th { line-height:32px; padding-top:8px; padding-bottom:8px;
            border-top:1px solid #333; border-bottom:1px solid #333;
            background-color:deepskyblue; color:#fff; }
        .tb1 td {line-height:15px; padding-top:8px; padding-bottom:8px;
            border-bottom:1px solid #333;
            padding-left: 14px; border-top:1px solid #333; }
        .tb1 td #imglist {line-height:15px; padding-top:8px; padding-bottom:8px;
            border-bottom:1px solid #333;
            padding-left: 14px; border-top:1px solid #333; }



        .tb1 .item1 { width:10%;  }
        .tb1 .item2 { width:65%; text-align: center; }
        .tb1 .item3 { width:10%; text-align: center; }
        .tb1 .item4 { width:15%; text-align: center; }


        #imglist img { margin: auto; }


        .inbtn2 { display:block;  border-radius:100px;
            width:600px; padding-left: 10px; padding-right: 10px; text-align: center;
            line-height: 48px; background-color: #333; color:#fff; font-size: 20px; margin: 0 auto; }
        .slide_box::-webkit-scrollbar { background-color: white; }
        .slide_box { clear:both; width:1800px; height:500px;
            margin-left: 50px;  overflow: hidden;
            scrollbar-width:none; }


        .card_lst { width: <%= (bookList.size() + 5) * 321 %>px; height: 450px; }
        .card_lst > li { width: 321px; height: 450px; float:left; margin-right: 50px;
            box-shadow:5px 5px 30px #888; border-radius:6px; overflow: hidden; }
        .card_lst > li:first-child { margin-left: 30px; }

        .card_lst li .thumb_box { width: 321px; height: 400px;
            background-repeat: no-repeat; background-position: center center;
            background-size: cover; }
        .card_lst li a { display:block; width: 321px; height: 50px; }



        .cate_lst li { border-top:1px solid #333; margin-left: 14px; margin-right: 14px;
            padding-top: 32px; height: 90px;  }
        .cate_tit li a { display:block; }

        .sl-btn-box .btn { display:block; width: 48px; height: 48px; font-size:32px;
            color:#fff; background-color:#333; text-align: center; line-height: 48px;
            font-weight: 700; cursor:pointer; position:absolute; left:100px; }
        .btn_group .btn.next { display:inline; width: 100px; height: 48px; font-size:32px;
            color:#fff; background-color:#333;  line-height: 48px;
            font-weight: 700; cursor:pointer;  left:100px;}
        .btn_group .btn.prev { display:inline; width: 100px; height: 48px; font-size:32px;
            color:#fff; background-color:#333;  line-height: 48px;
            font-weight: 700; cursor:pointer;  left:100px;}
        .thumb_tit { height: 100px; box-sizing:border-box; font-size: 18px; color:black; padding:14px; padding-bottom: 0; text-overflow: ellipsis;
            overflow:hidden; display:-webkit-box; -webkit-box-orient: vertical; -webkit-line-clamp:2;
            margin-bottom: 60px; }
    </style>
    <style>
        .btn_group { display: inline-block; clear:both; width:1200px; margin:20px auto;  text-align: center; }
        .btn_group .btn {border-radius:20px;background-color:var(--main-color) !important;border:none !important}
        .btn_group.btn.prev{float: left;}
        .btn_group.btn.next{float: right;}
        .btn_group p {text-align: center;   line-height:3.6; }
        .btn_group .btn_group1 {display: block;}

        .btn:hover, .btn:active {
            box-shadow: 2px 2px 5px #333;
        }

        .inBtn {margin-bottom:20px;}
 
    </style>

    <link rel="stylesheet" href="<%=headPath%>/css/jquery.dataTables.css">
    <script src="<%=headPath%>/js/jquery.dataTables.js"></script>
</head>
<body>
<div class="container">
    <header class="hd" id="hd">
        <%@ include file="../header.jsp" %>
    </header>
    <div class="contents" id="contents">
        <div class="sub">
            <h2>조이서비스</h2>
        </div>
        <div class="breadcrumb">
            <p><a href="/">HOME</a> &gt; <a href="">조이서비스</a> &gt; <span>도서</span></p>
        </div>
        <section class="page" id="page1">
            <div class="page_wrap">
                <h2 class="page_tit">온라인 서점 목록</h2>
                <br><br><br><br>
                <div class="btn_group">

                         <% if(sid!=null && sid.equals("admin")) { %>
                        <a href="addBook.jsp" class="inBtn inBtn1">추가하기</a>
                         <% } else{ %>
                        <a href="<%=headPath%>/qna/qnaList.jsp" class="inBtn inBtn1">배송/주문 관련 문의하기</a>
                        <% } %>
                    <br>
                    <button type="button" class="btn prev">&lt;</button>
                    <button type="button" class="btn next">&gt;</button>
                </div>
            </div>
            <div class="slide_box">

                <ul class="card_lst">
                    <% for(Book bk : bookList) { %>
                    <li>
                        <a href="<%=headPath%>/bookbook/getBook.jsp?bno=<%=bk.getBno()%>">
                            <div class="thumb_box" style="background-image: url('<%=headerPath%>/image/book/iiim<%=bk.getBno()%>.jpg');"></div>
                            <p class="thumb_tit"><%=bk.getTitle()%></p>
                        </a>
                    </li>
                    <%  } %>
                </ul>
            </div>
        </section>

        <script>
            $(function(){
                $(".btn.next").click(function(){
                    var ln = parseInt($(".card_lst").css("margin-left"));
                    var maxLeft = -((<%= bookList.size()+3 %>) * 321 - $(".slide_box").width());
                    if (ln > maxLeft) {
                        var mv = ln - 370;
                        if (mv < maxLeft) {
                            mv = maxLeft;
                        }
                        $(".card_lst").not(":animated").animate({"margin-left":mv+"px"});
                    }
                });
                $(".btn.prev").click(function(){
                    var ln = parseInt($(".card_lst").css("margin-left"));
                    if(ln<0){
                        var mv = ln + 370;
                        $(".card_lst").not(":animated").animate({"margin-left":mv+"px"});
                    }
                });
            });
        </script>
    </div>
    <footer class="ft" id="ft">
        <%@ include file="../footer.jsp" %>
    </footer>
</div>
</body>
</html>