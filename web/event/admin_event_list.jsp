<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.grownjoy.dto.Event" %>
<%@ page import="com.grownjoy.db.DBC" %>
<%@ page import="com.grownjoy.db.MariaDBCon" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>이벤트 관리</title>
    <%@ include file="../head.jsp" %>
    <link rel="stylesheet" href="<%=headPath%>/css/sub.css">    <link rel="stylesheet" href="<%=headPath%>/css/sub.css">
    <style>
        img {width:100%; height:auto; margin-bottom: 20px;}
        .img_tb {word-wrap: break-word}
    </style>
</head>
<%
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    DBC con = new MariaDBCon();
    conn = con.connect();

    String sql = "select * from event";
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
        <div class="sub">
            <h2>이벤트 관리</h2>
        </div>
        <div class="breadcrumb">
            <p><a href="../">HOME</a> &gt; <span>이벤트 목록</span></p>
        </div>
        <section class="page" id="page1">
            <div class="table_container">

                <form action="admin_event_delete.jsp">
                    <table class="table tb1">
                        <tbody class="img_tb">
                        <tr>
                            <%
                                for(Event event: eventList){
                                    pageContext.setAttribute("event", event);
                            %>
                            <td><a href="/event/admin_event_get.jsp?eno=<%=event.getEno()%>">
                                <ul class="img">
                                    <li>
                                        <%if(event.getImg_name()!=null){%>
                                        <img src="/event/event_img/${event.img_name}.jpg" alt="">
                                        <%} else{%>
                                        <img src="/event/event_img/0.jpg" alt="img_not_found">
                                        <%}%>
                                    </li>
                                    <li>
                                        <input type="checkbox" name="isdelete" value="<%=event.getEno()%>"> <%=event.getTitle()%>
                                    </li>
                                    <li>
                                        <%
                                            if(event.getStartdate()!=null && event.getEnddate()!=null){ %>
                                        <td><%=event.getStartdate()%>~<%=event.getEnddate()%></td>
                                        <%} else{%>
                                    </li>
                                    <li><%=event.isStatus()%></li>
                                    <%}%>
                                </ul>
                            </a>
                            </td>
                            <%}%>
                        </tr>
                        </tbody>
                    </table>
                    <script>
                        $(document).ready( function () {
                            $('#myTable').DataTable();
                        });
                    </script>
                    <table class="row_table">
                        <tbody>
                        <tr>
                            <td><a href="admin_event_add.jsp" class="inbtn">이벤트 추가</a></td>
                            <td><input type="submit" class="inbtn" value="이벤트 삭제">
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