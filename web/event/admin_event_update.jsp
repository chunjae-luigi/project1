<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="grownjoy.dto.Event" %>
<%@ page import="grownjoy.db.DBC" %>
<%@ page import="grownjoy.db.MariaDBCon" %>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>이벤트 관리</title>
    <%@ include file="../head.jsp" %>
    <link rel="stylesheet" href="<%=headPath%>/css/sub.css">
    <style>
        img {width:100%; height:auto; margin-bottom: 20px;}
    </style>
</head>
<%
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    DBC con = new MariaDBCon();
    conn = con.connect();


    int eno = Integer.parseInt(request.getParameter("eno"));
    String sql = "select * from event where eno=?";
    pstmt = conn.prepareStatement(sql);
    pstmt.setInt(1, eno);
    rs = pstmt.executeQuery();

    Event event = new Event();
    SimpleDateFormat ndf = new SimpleDateFormat("yyyy년 MM월 dd일");

    if(rs.next()){
        if(rs.getDate("startdate")!=null && rs.getDate("enddate")!=null){
            event = new Event(rs.getInt("eno"), rs.getBoolean("status"), ndf.format(rs.getDate("regdate")), ndf.format(rs.getDate("startdate")), ndf.format(rs.getDate("enddate")), rs.getString("title"), rs.getString("content"), rs.getString("img_name"), rs.getString("img_path"), rs.getInt("cnt"));
        } else{
            event = new Event(rs.getInt("eno"), rs.getBoolean("status"), ndf.format(rs.getDate("regdate")), null, null, rs.getString("title"), rs.getString("content"), rs.getString("img_name"), rs.getString("img_path"), rs.getInt("cnt"));
        }
        request.setAttribute("event", event);
    }
    con.close(rs, pstmt, conn);

%>
<body>
<div class="wrap">
    <header class="hd" id="hd">
        <%@ include file="../header.jsp" %>
    </header>
    <div class="contents" id="contents">
        <div class="sub">
            <h2>이벤트 수정</h2>
        </div>
        <div class="breadcrumb">
            <p><a href="../">HOME</a> &gt; <span>공지사항 목록</span></p>
        </div>
        <section class="page" id="page1">
            <div class="table_container">
                <form action="admin_event_update_pro.jsp" method="post">
                    <input type="hidden" name="eno" value="<%=event.getEno()%>">
                    <table class="table tb2">
                        <tbody>
                        <tr>
                            <th>글 제목</th>
                            <td><input type="text" name="title" id="title" value="<%=event.getTitle()%>"></td>
                        </tr>
                        <tr>
                            <th>작성일</th>
                            <td><%=event.getRegdate()%></td>
                        </tr>
                        <tr>
                            <th>조회수</th>
                            <td><%=event.getCnt()%></td>
                        </tr>
                        <tr>
                            <th>진행 여부</th>
                            <td>
                                <%if(event.isStatus()){ %>
                                <label for="ongoing">진행 중</label><input type="radio" name="status" id="ongoing" value="true" checked>
                                <label for="stopped">지난 이벤트</label><input type="radio" name="status" id="stopped" value="false">
                                <%} else{%>
                                <label for="ongoing">진행 중</label><input type="radio" name="status" id="ongoing" value="true" checked>
                                <label for="stopped">지난 이벤트</label><input type="radio" name="status" id="stopped" value="false">
                                <%}%>
                            </td>
                        </tr>
                        <tr>
                            <td><label for="startdate">시작일</label><input type="date" name="startdate" id="startdate"></td>
                            <td><label for="enddate">끝나는 일</label><input type="date" name="enddate" id="enddate"></td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <%if(event.getImg_name()!=null){%>
                                <img src="/event/event_img/${event.img_name}.jpg" alt="">
                                <%}%>
                                <input type="file" accept=".jpg" name="file">
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <textarea name="content" id="" cols="30" rows="10"><%=event.getContent()%></textarea>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                    <script>
                        $(document).ready( function () {
                            $('#myTable').DataTable();
                        });
                    </script>
                    <input class="inbtn" type="submit" value="글 수정 완료">
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