<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>이벤트 게시판</title>
    <%@ include file="../head.jsp" %>
    <style>
        img {width:100%; height:auto; margin-bottom: 20px;}
    </style>
</head>
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
                <form action="admin_event_add_pro.jsp" method="post">
                    <table class="table tb2">
                        <tbody>
                        <tr>
                            <th>글 제목</th>
                            <td><input type="text" name="title" id="title"></td>
                        </tr>

                        <tr>
                            <th>진행 여부</th>
                            <td>
                                <label for="ongoing">진행 중</label><input type="radio" name="status" id="ongoing" value="true" checked>
                                <label for="stopped">지난 이벤트</label><input type="radio" name="status" id="stopped" value="false">
                            </td>
                        </tr>
                        <tr>
                            <td><label for="startdate">시작일</label><input type="date" name="startdate" id="startdate"></td>
                            <td><label for="enddate">끝나는 일</label><input type="date" name="enddate" id="enddate"></td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <input type="file" accept=".jpg" name="file">
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <textarea name="content" id="" cols="30" rows="10"></textarea>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                    <script>
                        $(document).ready( function () {
                            $('#myTable').DataTable();
                        });
                    </script>
                    <input class="inbtn" type="submit" value="글 추가 완료">
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