<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.grownjoy.dto.Event" %>
<%@ page import="com.grownjoy.db.DBC" %>
<%@ page import="com.grownjoy.db.MariaDBCon" %>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>그로우앤조이::관리자페이지-이벤트관리</title>
    <%@ include file="../head.jsp" %>
    <link rel="stylesheet" href="<%=headPath%>/css/admin.css">
    <style>
        img {width:10%; height:auto; margin-bottom: 20px;}
        .img_tb {word-wrap: break-word}

        .card {display:inline-block;width:24%;margin-left:1%;}
        .card:nth-child(4n + 1) {margin-left:0;}
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
<div class="admin_wrap">
    <header class="admin_hd" id="adminHd">
        <%@ include file="/admin/adminHeader.jsp" %>
    </header>
    <div class="admin_contents" id="adminContents">
        <h2>이벤트 관리</h2>
        <section class="page"><div class="page_wrap"><form action="admin_event_delete.jsp">
            <ul class="card_con">
            <%
                for(Event event: eventList){
                    pageContext.setAttribute("event", event);
            %>
            <li class="card">
                <a href="/admin/admin_event_get.jsp?eno=<%=event.getEno()%>">
                    <%if(event.getImg_name()!=null){%>
                    <img class="card-img-top" src="/admin/event_img/${event.img_name}.jpg" alt="eventing">
                    <%} else{%>
                    <img class="card-img-top" src="/admin/event_img/0.jpg" alt="img_not_found">
                    <%}%>
                    <div class="card-body">
                        <h5 class="card-title"><input type="checkbox" name="isdelete" value="<%=event.getEno()%>"> <%=event.getTitle()%></h5>
                        <p class="card-text">
                            <% if(event.getStartdate()!=null && event.getEnddate()!=null){ %>
                            <%=event.getStartdate()%> <br>~<%=event.getEnddate()%>
                            <%}%>
                        </p>
                    </div>
                </a>
            </li>
            <%}%>
            </ul>
        </form></div></section>
        <div class="btn_group">
            <a href="admin_event_add.jsp" class="inBtn inBtn1">이벤트 추가</a>
            <input type="submit" class="inBtn inBtn2" value="이벤트 삭제">
        </div>
    </div>
</div>
</body>
</html>