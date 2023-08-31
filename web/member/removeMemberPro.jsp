<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.grownjoy.db.*" %>
<%@ page import="com.grownjoy.dto.*" %>
<%@ page import="com.grownjoy.db.DBC" %>
<%@ page import="com.grownjoy.db.MariaDBCon" %>
<%@ page import="com.grownjoy.util.AES256" %>
<%
    String id = request.getParameter("id");
    boolean adminYn = session.getAttribute("id").equals("admin");

    Connection conn = null;
    PreparedStatement pstmt = null;

    DBC con = new MariaDBCon();
    conn = con.connect();
    if(conn != null){
        System.out.println("DB 연결 성공");
    }

    try {
        String sql = "delete from member where id=?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, id);
        int cnt = pstmt.executeUpdate();
        String path= = request.getContextPath();
        if(cnt > 0){
            if(adminYn) {
                response.sendRedirect(path+"/admin/memberList.jsp");
            } else {
                response.sendRedirect(path+"/member/logout.jsp");
            }
        } else {
            out.println("<script>alert('탈퇴 처리를 진행하지 못했습니다.');history.go(-1);</script>");
        }
    } catch(SQLException e) {
        System.out.println("SQL 구문이 처리되지 못했습니다.");
    } finally {
        con.close(pstmt, conn);
    }
%>