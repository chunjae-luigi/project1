<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%-- 1. 필요한 라이브러리 가져오기 --%>
<%@ page import="java.sql.*" %>
<%@ page import="com.grownjoy.db.*" %>
<%@ page import="com.grownjoy.dto.*" %>
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
    <title>공지사항 수정하기</title>

    <%@ include file="../head.jsp" %>
</head>
<body>
<div class="container">
    <header class="hd" id="hd">
        <%@ include file="../header.jsp" %>
    </header>
    <div class="contents" id="contents">
        <div class="breadcrumb">
            <p><a href="/">HOME</a> &gt; <a href="">온라인 서점</a> &gt; <span>온라인 서점 목록</span></p>
        </div>
        <section class="page" id="page1">
            <div class="page_wrap">
                <h2 class="page_tit">온라인 서점 목록 수정</h2>
                <hr>
                <form action="<%=headerPath%>/bookbook/updateBookpro.jsp" method="post">
                    <table class="tb1">
                        <tbody>
                        <tr>
                            <th><label for="bno"></label>글 번호</th>
                            <td>
                                <input type="text" name="bno" id="bno" class="indata" value="<%=bk.getBno()%>" readonly>
                               
                            </td>
                        </tr>
                        <tr>
                            <th><label for="title"> 제목</label></th>
                            <td>
                                <input type="text" name="title" id="title" class="indata" required>
                            </td>
                        </tr>
                        <tr>
                            <th><label for="author">저자</label></th>
                            <td><input type="text" name="author" id="author" class="indata" required></td>
                        </tr>
                        <tr>
                            <th><label for="price">가격</label></th>
                            <td><input type="text" name="price" id="price" class="indata" required></td>
                        </tr>
                        <tr>
                            <th><label for="company">출판사</label></th>
                            <td><input type="text" name="company" id="company" class="indata" required></td>
                        </tr>
                        <tr>
                            <th><label for="date">출간일</label></th>
                            <td><input type="text" name="date" id="date" class="indata" required></td>
                        </tr>
                         <tr>
                            <td colspan="2">
                                <%-- 6. 수정하기(submit)을 누르면, 수정처리로 넘기기 --%>
                                <a href="<%=headerPath%>/bookbook/Booklit.jsp" class="inbtn">글 목록</a>
                                <% if(sid.equals("admin") || sid.equals(bk.getAuthor())) { %>
                                <input type="submit" value="글수정" class="inbtn">
                                <a href="<%=headerPath%>/bookbook/delBook.jsp?bno=<%=bk.getBno() %>" class="inbtn">글 삭제</a>
                                <% } %>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </form>
            </div>
        </section>
    </div>
    <footer class="ft" id="ft">
        <%@ include file="../footer.jsp" %>
    </footer>
</div>
</body>
</html>