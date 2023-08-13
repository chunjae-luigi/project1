<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.chunjae.db.*" %>
<%@ page import="com.chunjae.dto.*" %>
<%@ page import="java.text.SimpleDateFormat" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>공지사항</title>
    <%@ include file="../head.jsp" %>
</head>
<%
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    DBC con = new MariaDBCon();
    conn = con.connect();

    String sql = "select * from board order by bno desc";
    pstmt = conn.prepareStatement(sql);
    rs = pstmt.executeQuery();

    List<Board> boards = new ArrayList<>();

    SimpleDateFormat ndf = new SimpleDateFormat("yyyy년 MM월 dd일");
    while(rs.next()){
      boards.add(new Board(rs.getInt("bno"), rs.getString("title"), rs.getString("contents"), rs.getString("author"), ndf.format(rs.getDate("regdate")), rs.getInt("cnt")));
    }
    con.close(rs, pstmt, conn);
%>
<body>
<div class="wrap">
    <header class="hd" id="hd">
        <%@ include file="../header.jsp" %>
    </header>
    <div class="contents" id="contents">
        <div class="breadcrumb">
            <p><a href="../">HOME</a> &gt; <span>공지사항 목록</span></p>
        </div>
        <section class="page" id="page1">
            <div class="table_container">
                <table class="board_tb" id="myTable">
                    <thead>
                    <tr>
                        <th class="item1">글번호</th>
                        <th class="item2">글제목</th>
                        <th class="item3">작성자</th>
                        <th class="item4">작성일</th>
                    </tr>
                    </thead>
                    <tbody>
                    <% for(Board bd: boards){
                        bd.print();
                    %>
                    <tr>
                        <td class="item1"><%=bd.getBno() %></td>
                        <td class="item2"><a href="/board/getBoard.jsp?bno=<%=bd.getBno()%>"><%=bd.getTitle() %></a></td>
                        <td class="item3"><%=bd.getAuthor() %></td>
                        <td class="item4"><%=bd.getRegdate() %> </td>
                    </tr>
                    <%}%>
                    </tbody>
                </table>
                <script>
                    $(document).ready( function () {
                        $('#myTable').DataTable();
                    });
                </script>
            <div class="board_tb">
                <%if(sid!=null && sid.equals("admin")){%>
                    <a href="addBoard.jsp" class="inbtn">글쓰기</a>
                <%}%>
            </div>
            </div>
        </section>
    </div>
    <footer class="ft" id="ft">
        <%@ include file="../footer.jsp" %>
    </footer>
</div>
</body>
</html>