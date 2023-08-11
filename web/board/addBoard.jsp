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
            <form action="addBoardPro.jsp" id="update_form" method="post">
                <table class="board_tb">
                    <thead>
                    <tbody>
                    <tr>
                        <th>글제목</th>
                        <td><input class="indata" type="text" name="title" id="title" placeholder="글 제목을 입력"></td>
                    </tr>
                    </tbody>
                </table>
                <textarea name="new_content" id="new_content" autofocus style="padding: 15px; width:100%; height: 60vh;" placeholder="글 내용 입력"></textarea>
                <%if(sid!=null && sid.equals("admin")){%>
                <input type="submit" value="작성완료" class="inbtn">
                <%}%>
            </form>
        </section>
    </div>
    <footer class="ft" id="ft">
        <%@ include file="../footer.jsp" %>
    </footer>
</div>
</body>
</html>