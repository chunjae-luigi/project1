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
    <title>지난 이벤트 게시판</title>
    <%@ include file="../head.jsp" %>
</head>
<%
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    DBC con = new MariaDBCon();
    conn = con.connect();

    String sql = "select * from event where status=false";
    pstmt = conn.prepareStatement(sql);
    rs = pstmt.executeQuery();

    List<Event> eventList = new ArrayList<>();

    SimpleDateFormat ndf = new SimpleDateFormat("yyyy년 MM월 dd일");

    while(rs.next()){
        if(rs.getDate("startdate")!=null && rs.getDate("enddate")!=null){
            eventList.add(new Event(rs.getInt("eno"), rs.getBoolean("status"), ndf.format(rs.getDate("regdate")), ndf.format(rs.getDate("startdate")), ndf.format(rs.getDate("enddate")), rs.getString("title"), rs.getString("content"), rs.getString("img_name"), rs.getString("img_path"), rs.getInt("cnt")));
        } else{
            eventList.add(new Event(rs.getInt("eno"), rs.getBoolean("status"), ndf.format(rs.getDate("regdate")), null, null, rs.getString("title"), rs.getString("content"), rs.getString("img_name"), rs.getString("img_path"), rs.getInt("cnt")));
        }
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
                <table class="board_tb">
                    <thead>
                    <tr>
                        <th>글 번호</th>
                        <th>글 제목</th>
                        <th>진행 기한</th>
                        <th>등록일</th>
                        <th>조회수</th>
                    </tr>
                    </thead>
                    <tbody>
                    <%
                        int index = 0;
                        for(Event event: eventList){
                            index++;
                            event.print();
                    %>
                    <tr>
                        <td><%=index %></td>
                        <td><a href="/event/evented_get.jsp?eno=<%=event.getEno()%>"><%=event.getTitle()%></a></td>
                        <%
                            if(event.getStartdate()!=null && event.getEnddate()!=null){ %>
                        <td><%=event.getStartdate()%>~<%=event.getEnddate()%></td>
                        <%} else{%>
                        <td>&nbsp;</td>
                        <%}%>
                        <td><%=event.getRegdate()%></td>
                        <td><%=event.getCnt()%></td>
                    </tr>
                    <%}%>
                    </tbody>
                </table>
                <script>
                    $(document).ready( function () {
                        $('#myTable').DataTable();
                    });
                </script>
            </div>
        </section>
    </div>
    <footer class="ft" id="ft">
        <%@ include file="../footer.jsp" %>
    </footer>
</div>
</body>
</html>