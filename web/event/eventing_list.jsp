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
    <title>이벤트 게시판</title>
    <%@ include file="../head.jsp" %>
    <link rel="stylesheet" href="<%=headPath%>/css/sub.css">

    <style>
        img {width:100%; height:auto; margin-bottom: 20px;}
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

    String sql = "select * from event where status=true";
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
            <h2>진행 중인 이벤트</h2>
        </div>
        <div class="breadcrumb">
            <p><a href="../">HOME</a> &gt; <span>이벤트 목록</span></p>
        </div>
        <section class="page"><div class="page_wrap">
            <ul class="card_con">
            <%
                for(Event event: eventList){
                    pageContext.setAttribute("event", event);
            %>
                <li class="card">
                    <a href="<%=headPath%>/event/eventing_get.jsp?eno=<%=event.getEno()%>">
                    <%if(event.getImg_name()!=null){%>
                    <img class="card-img-top" src="<%=headPath%>/event/event_img/${event.img_name}.jpg" alt="eventing">
                    <%} else{%>
                    <img class="card-img-top" src="<%=headPath%>/event/event_img/0.jpg" alt="img_not_found">
                    <%}%>
                    <div class="card-body">
                        <h5 class="card-title"><%=event.getTitle()%></h5>
                        <p class="card-text">
                            <% if(event.getStartdate()!=null && event.getEnddate()!=null){ %>
                            <%=event.getStartdate()%> <br>~<%=event.getEnddate()%>
                            <%} else{%> 진행중
                            <%}%>
                        </p>
                    </div>
                    </a>
                </li>

            <%}%>
            </ul>
        </div></section>
    </div>
    <footer class="ft" id="ft">
        <%@ include file="../footer.jsp" %>
    </footer>
</div>
</body>
</html>