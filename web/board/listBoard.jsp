<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="com.grownjoy.db.*" %>
<%@ page import="com.grownjoy.vo.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    DBC con = new MariaDBCon();
    conn = con.connect();

    List<Board> boardList = new ArrayList<>();
    try {
        String sql = "SELECT * FROM boardList where boardType = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, 2);
        rs = pstmt.executeQuery();
        while (rs.next()) {
            Board bd = new Board();
            bd.setBno(rs.getInt("bno"));
            bd.setTitle(rs.getString("title"));
            bd.setResdate(rs.getString("resdate"));
            bd.setAuthor(rs.getString("author"));
            bd.setName(rs.getString("name"));
            bd.setCnt(rs.getInt("cnt"));
            boardList.add(bd);
        }
    } catch (SQLException e) {
        System.out.println("sql 구문 오류");
    } finally {
        con.close(rs, pstmt, conn);
    }

    SimpleDateFormat ymd = new SimpleDateFormat("yyyy-MM-dd");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>그로우앤조이::자유게시판</title>
    <%@ include file="../head.jsp" %>
    <link rel="stylesheet" href="<%=headPath%>/css/sub.css">
</head>
<body>
<div class="wrap">
    <header class="hd" id="hd">
        <%@ include file="../header.jsp" %>
    </header>
    <div  class="contents" id="contents">
        <div class="sub">
            <h2>커뮤니티</h2>
        </div>
        <div class="breadcrumb">
            <p><a href="/"> HOME </a> &gt; <a href="<%=headerPath%>/board/listNotice.jsp"> 커뮤니티 </a> &gt; <span> 자유게시판 </span></p>
        </div>
        <section class="page" id="page1">
            <div class="page_wrap">
                <h2 class="page_tit">자유게시판</h2>
                <table class="table tb1" id="myTable">
                    <colgroup>
                        <col style="width:8%;">
                        <col style="width:auto;">
                        <col style="width:10%;">
                        <col style="width:10%;">
                        <col style="width:5%;">
                    </colgroup>
                    <thead>
                    <tr>
                        <th class="num">번호</th>
                        <th class="title">제목</th>
                        <th class="author">작성자</th>
                        <th class="date">작성일</th>
                        <th class="cnt">조회</th>
                    </tr>
                    </thead>
                    <tbody>
                    <%
                        if(boardList.size() > 0){
                            int num = 1;
                            for(Board bd : boardList) {
                                Date date = ymd.parse(bd.getResdate());  //날짜데이터로 변경
                                String dateStr = ymd.format(date);

                                String title = "";
                                if(bd.getTitle().length() > 86) {
                                    title = bd.getTitle().substring(85) + "...";
                                } else {
                                    title = bd.getTitle();
                                }

                    %>
                    <tr>
                        <td class="num"><%=num %></td>
                        <td class="title txtLeft"><a href="<%=headerPath%>/board/getBoard.jsp?bno=<%=bd.getBno() %>"><%=title %></a></td>
                        <td class="date"><%=bd.getName() %></td>
                        <td class="date"><%=dateStr %></td>
                        <td class="num"><%=bd.getCnt() %></td>
                    </tr>
                    <%  num++; } } else { %>
                    <tr><td colspan="5">등록된 자유게시물이 없습니다.</td></tr>
                    <% } %>
                    </tbody>
                </table>
                <script>
                    $(document).ready( function () {
                        $('#myTable').DataTable({
                            order:[[0, "desc"]]
                        });
                    });
                </script>
                <% if(sid != null) { %>
                <div class="btn_group">
                    <a href="<%=headerPath%>/board/addBoard.jsp" class="inBtn inBtn1">자유게시판 등록</a>
                </div>
                <% } %>
            </div>
        </section>
    </div>
    <footer class="ft" id="ft">
        <%@ include file="../footer.jsp" %>
    </footer>
</div>
</body>
</html>
