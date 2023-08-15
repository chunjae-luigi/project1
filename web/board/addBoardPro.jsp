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

    String sid = (String)session.getAttribute("id");
    String title = request.getParameter("title");
    String new_content = request.getParameter("new_content");
    if(title==null || title.equals("")){
        System.out.println("타이틀이 그러면 안 돼지");
        out.println("<script>history.back();</script>");
    }
    else {
        System.out.println(sid + " " + title + "\n" + new_content);
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        DBC con = new MariaDBCon();
        conn = con.connect();

        String sql = "insert into board(title, contents, author) values(?, ?, ?)";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, title);
        pstmt.setString(2, new_content);
        pstmt.setString(3, sid);
        int cnt = pstmt.executeUpdate();
        System.out.println(cnt);

        if (cnt > 0) {
            System.out.println("글 작성이 완료되었습니다.");
            response.sendRedirect("boardList.jsp");
        } else {
            out.println("<script>history.back();</script>");
            System.out.println("sql 구문이 처리되지 않았습니다.");
        }
        con.close(rs, pstmt, conn);
    }
%>
