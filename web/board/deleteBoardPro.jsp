<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.chunjae.db.*" %>
<%@ page import="com.chunjae.dto.*" %>
<%@ page import="java.text.SimpleDateFormat" %>


<%
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");
    response.setContentType("text/html; charset=utf-8");

    int bno = Integer.parseInt(request.getParameter("bno"));
    System.out.println(bno);

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    DBC con = new MariaDBCon();
    conn = con.connect();

    String sql = "delete from board where bno=?";
    pstmt = conn.prepareStatement(sql);
    pstmt.setInt(1, bno);
    int cnt = pstmt.executeUpdate();
    System.out.println(cnt);

    if(cnt>0){
        System.out.println("글 삭제가 완료되었습니다.");
        response.sendRedirect("boardList.jsp");
    } else{
        System.out.println("sql 구문이 처리되지 않았습니다.");
    }

    con.close(rs, pstmt, conn);
%>