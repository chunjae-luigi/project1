<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%-- 1. 필요한 라이브러리 가져오기 --%>
<%@ page import="java.sql.*" %>
<%@ page import="com.grownjoy.db.*" %>
<%@ page import="com.grownjoy.dto.Book" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%
    Connection con = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    int bno = Integer.parseInt(request.getParameter("bno"));

    // 2. DB 연결하기
    DBC conn = new MariaDBCon();
    con = conn.connect();

    //3. SQL을 실행하여 Result(공지사항 한 레코드)을 가져오기
    String sql = "select * from book where bno=?";
    pstmt = con.prepareStatement(sql);
    pstmt.setInt(1, bno);
    rs = pstmt.executeQuery();

    //4. 가져온 한 레코드를 하나의 Board 객체에 담기
    Book bk  = new Book();


    if(rs.next()){
        bk.setBno(rs.getInt("bno"));
        bk.setTitle(rs.getString("title"));
        bk.setCompany(rs.getString("company"));
        bk.setAuthor(rs.getString("author"));
        bk.setDate(rs.getString("date"));
        bk.setPrice(rs.getInt("price"));
    }
    conn.close(rs, pstmt, con);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>도서 상세보기</title>
    <%@ include file="../head.jsp" %>
</head>
<body>
<div class="container">
    <header class="hd" id="hd">
        <%@ include file="../header.jsp" %>
    </header>
    <div class="contents" id="contents">
        <div class="breadcrumb">
            <p><a href="/">HOME</a> &gt; <a href="<%=headerPath%>/bookbook/bookList.jsp">온라인서점</a> &gt; <span>도서 상세보기</span></p>
        </div>
        <section class="page" id="page1">
            <div class="page_wrap">
                <h2 class="page_tit">도서 상세보기</h2>
                <hr>
<%--                <div class="book_image">--%>

<%--                    <script>--%>
<%--                        $(document).ready(function() {--%>
<%--                                $(".imglist").html("<li><img src='/images/im" + <%=bk.getBno()%> + ".jpg'></li>");--%>
<%--                        });--%>
<%--                    </script>--%>


<%--                    <ul class="imglist"></ul>--%>
<%--                </div>--%>
                <table class="tb1">
                    <tbody>
                    <tr>
                        <td id="imglist" class="tb1">
                            <script>
                                $(document).ready(function() {
                                    $("#imglist").html("<img src='/images/im" + <%=bk.getBno()%> + ".jpg'>");
                                });
                            </script>

                        </td>
                        <td>
                            <table class="tb1">
                                <tbody>
                                <tr>
                                    <th>글 제목</th>
                                    <td><%=bk.getTitle() %></td>
                                </tr>
                                <tr>
                                    <th>출판사</th>
                                    <td><%=bk.getCompany() %></td>
                                </tr>
                                <tr>
                                    <th>저자</th>
                                    <td><%=bk.getAuthor() %></td>
                                </tr>
                                <tr>
                                    <th>출간일</th>
                                    <td><%=bk.getDate() %></td>
                                </tr>
                                <tr>
                                    <th>가격</th>
                                    <td>  <%="\t"%><%=bk.getPrice() %></td>
                                </tr>
                                <tr>
                                    <th>구매처</th>
                                <td><a href="https://search.kyobobook.co.kr/search?keyword=<%=bk.getTitle()%>"  class="inbtn2" target="_blank" >구매링크</a></td>
                                </tr>
                                </tbody>
                            </table>
                        </td>
                    </tr>
                    </tbody>
                </table>
                <div>
                    <td><a href="https://search.kyobobook.co.kr/search?keyword=<%=bk.getTitle()%>"  class="inbtn1" target="_blank" >구매링크</a></td>
                </div>
<%--                    <tr>--%>
<%--                        <th>글 제목</th>--%>
<%--                        <td><%=bk.getTitle() %></td>--%>
<%--                    </tr>--%>
<%--                    <tr>--%>
<%--                        <th>출판사</th>--%>
<%--                        <td><%=bk.getCompany() %></td>--%>
<%--                    </tr>--%>
<%--                    <tr>--%>
<%--                        <th>저자</th>--%>
<%--                        <td><%=bk.getAuthor() %></td>--%>
<%--                    </tr>--%>
<%--                    <tr>--%>
<%--                        <th>출간일</th>--%>
<%--                        <td><%=bk.getDate() %></td>--%>
<%--                    </tr>--%>
<%--                    <tr>--%>
<%--                        <th>가격</th>--%>
<%--                        <td><%=bk.getPrice() %></td>--%>
<%--                    </tr>--%>
<%--                    <tr>--%>

                <section>
                        <td colspan="2">
                            <a href="<%=headerPath%>/bookbook/Booklit.jsp" class="inbtn">글 목록</a>
                            <% if(sid.equals("admin")) { %>
                            <a href="<%=headerPath%>/bookbook/updateBook.jsp?bno=<%=bk.getBno() %>" class="inbtn">글 수정</a>
                            <a href="<%=headerPath%>/bookbook/delBook.jsp?bno=<%=bk.getBno() %>" class="inbtn">글 삭제</a>
                            <% } %>

                        </td>
                </section>


            </div>
        </section>
    </div>
    <footer class="ft" id="ft">
        <%@ include file="../footer.jsp" %>
    </footer>
</div>
</body>
</html>