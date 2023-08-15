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
    int bno = Integer.parseInt(request.getParameter("bno"));

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    DBC con = new MariaDBCon();
    conn = con.connect();

    String sql = "select * from board where bno=?";
    pstmt = conn.prepareStatement(sql);
    pstmt.setInt(1, bno);
    rs = pstmt.executeQuery();
    Board now = new Board();
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일 hh시 mm분 ss초");

    if(rs.next()){
      now.setBno(rs.getInt("bno"));
      now.setTitle(rs.getString("title"));
      now.setContents(rs.getString("contents"));
      now.setAuthor(rs.getString("author"));
      now.setRegdate(sdf.format(rs.getDate("regdate")));
      now.setCnt(rs.getInt("cnt"));
    }

    con.close(rs, pstmt, conn);
%>

<body>
<div class="wrap">
    <header class="hd" id="hd">
        <%@ include file="../header.jsp" %>
    </header>
    <%
        if(sid==null){
          response.sendRedirect("/board/boardList.jsp");
        }
    %>
    <div class="contents" id="contents">
        <div class="breadcrumb">
            <p><a href="../">HOME</a> &gt; <span>공지사항</span></p>
        </div>
        <section class="page" id="page1">
            <div class="table_container">
                <table class="board_tb">
                    <thead>
                    <tr>
                        <th class="item1">글번호</th>
                        <th class="item2">글제목</th>
                        <th class="item3">작성자</th>
                        <th class="item4">작성일</th>
                        <th class="item5">조회수</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td class="item1"><%=now.getBno()%></td>
                        <td class="item2"><%=now.getTitle()%></td>
                        <td class="item3"><%=now.getAuthor()%></td>
                        <td class="item4"><%=now.getRegdate()%></td>
                        <td class="item5"><%=now.getCnt()%></td>
                    </tr>
                    </tbody>
                </table>
                <div class="paragraph">
                    <%=now.getContents()%>
                </div>
            </div>
            <%if(sid!=null && sid.equals("admin")){%>
            <table class="row_table">
                <tbody>
                <tr>
                    <td><a href="/board/boardList.jsp>" class="inbtn">글목록</a></td>
                    <td><a href="/board/updateBoard.jsp?bno=<%=now.getBno()%>" class="inbtn">글수정</a></td>
                    <td><div class="inbtn" onclick="isDelete()">글삭제</div></td>
                </tr>
                </tbody>
            </table>
            <%}%>
        </section>
        <script>
            function isDelete(){
                let isdelete = confirm("정말 삭제하시겠습니까?");
                if(isdelete){
                    location.href = "/board/deleteBoardPro.jsp?bno=<%=now.getBno()%>";
                }
            }
        </script>
    </div>
    <footer class="ft" id="ft">
        <%@ include file="../footer.jsp" %>
    </footer>
</div>
</body>
</html>