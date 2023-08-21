<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>온라인 서점</title>
    <%@ include file="../head.jsp" %>
    <link rel="stylesheet" href="<%=headPath%>/css/sub.css">
    <style>
        /* 본문 영역 스타일 */
    </style>
</head>
<body>
<div class="container">
    <header class="hd" id="hd">
        <%@ include file="../header.jsp" %>
    </header>
    <div class="contents" id="contents">
        <div class="sub">
            <h2>도서</h2>
        </div>
        <div class="breadcrumb">
            <p><a href="/">HOME</a> &gt; <a href="./Booklit.jsp">온라인 서점</a> &gt; <span>온라인 서점 책 올리기</span></p>
        </div>
        <section class="page" id="page1">
            <div class="page_wrap">
                <h2 class="page_tit">도서 추가하기</h2>
                <form action="addBookpro.jsp" method="post">
                    <table class="table tb2">
                        <tbody>
                        <tr>
                            <th><label for="title"> 제목</label></th>
                            <td>
                                <input type="text" name="title" id="title" class="inData" required>
                            </td>
                        </tr>
                        <tr>
                            <th><label for="author">저자</label></th>
                            <td><input type="text" name="author" id="author" class="inData" required></td>
                        </tr>
                        <tr>
                            <th><label for="price">가격</label></th>
                            <td><input type="text" name="price" id="price" class="inData" required></td>
                        </tr>
                        <tr>
                            <th><label for="company">출판사</label></th>
                            <td><input type="text" name="company" id="company" class="inData" required></td>
                        </tr>
                        <tr>
                            <th><label for="date">출간일</label></th>
                            <td><input type="text" name="date" id="date" class="inData" required></td>
                        </tr>
                        </tbody>
                    </table>
                    <div class="btn_group" style="text-align:center;">
                        <input type="submit" value="추가하기" class="inBtn inBtn1">
                        <input type="reset" value="취소" class="inBtn inBtn2">
                    </div>
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