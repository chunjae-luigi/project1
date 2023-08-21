<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="com.grownjoy.db.*" %>
<%@ page import="com.grownjoy.dto.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%

    String id = request.getParameter("id");

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    DBC con = new MariaDBCon();
    conn = con.connect();

    Member mem = new Member();
    try {
        String sql = "SELECT * FROM member WHERE id = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, id);
        rs = pstmt.executeQuery();
        if (rs.next()) {
            mem.setName(rs.getString("name"));
            mem.setId(rs.getString("id"));
            mem.setTel(rs.getString("tel"));
            mem.setRegdate(rs.getString("regdate"));
        }
    } catch (SQLException e) {
        System.out.println("sql 구문 오류");
    } finally {
        con.close(rs, pstmt, conn);
    }

    SimpleDateFormat ymd = new SimpleDateFormat("yyyy-MM-dd");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>그로우앤조이::관리자페이지-회원관리</title>
    <%@ include file="../head.jsp" %>
    <link rel="stylesheet" href="<%=headPath%>/css/admin.css">
    <style>
        .tb2 th {width:50%;}
    </style>
</head>
<body>
<div class="admin_wrap">
    <header class="admin_hd" id="adminHd">
        <%@ include file="/admin/adminHeader.jsp" %>
    </header>
    <div class="admin_contents" id="adminContents">
        <h2><%= mem.getName() %>님의 비밀번호 변경</h2>
        <div class="container">
            <form action="memberUpdatePwPro.jsp" method="post">
                <input type="hidden" name="id" id="id" value="<%=mem.getId() %>">
                <table class="table tb2">
                    <tbody>
                        <tr>
                            <th><label for="pw">변경할 비밀번호 4자리를 입력해주세요.</label></th>
                            <td><input type="text" name="pw" id="pw" class="inData"></td>
                        </tr>
                    </tbody>
                </table>
                <div class="btn_group">
                    <input type="submit" class="inBtn inBtn2" value="변경하기">
                </div>
            </form>
        </div>
    </div>
</div>
</body>
</html>
