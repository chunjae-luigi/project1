<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="com.grownjoy.db.*" %>
<%@ page import="com.grownjoy.dto.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="com.grownjoy.util.*" %>
<%@ page import="java.security.NoSuchAlgorithmException" %>
<%

    String id = request.getParameter("id");
    String pw = request.getParameter("pw");
    try {
        pw = AES256.sha256(pw);
    } catch (NoSuchAlgorithmException e) {
        throw new RuntimeException(e);
    }

    Connection conn = null;
    PreparedStatement pstmt = null;

    DBC con = new MariaDBCon();
    conn = con.connect();

    Member mem = new Member();
    try {
        String sql = "update member set pw=? where id=?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, pw);
        pstmt.setString(2, id);
        int cnt = pstmt.executeUpdate();
        if(cnt > 0) {
            response.sendRedirect("/admin/memberList.jsp");
        } else {
            out.println("<script>alert('변경에 실패하였습니다.');history.go(-1);</script>");
        }
    } catch (SQLException e) {
        System.out.println("sql 구문 오류");
    } finally {
        con.close(pstmt, conn);
    }
%>