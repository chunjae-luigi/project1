<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.grownjoy.db.*" %>
<%@ page import="com.grownjoy.dto.Dat" %>
<%@ include file="../encoding.jsp" %>

<%

    String id = request.getParameter("id");
    int bno = Integer.parseInt(request.getParameter("bno"));
    String content = request.getParameter("content");

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    DBC con = new MariaDBCon();
    conn = con.connect();

    try{
        String sql = "insert into dat(id, content, par) values(?, ?, ?)";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, id);
        pstmt.setString(2, content);
        pstmt.setInt(3, bno);
        rs = pstmt.executeQuery();

        if(rs.next()){
            Dat d = new Dat();
            d.setId(rs.getString("id"));
            d.setContent(rs.getString("content"));
            d.setResdate(rs.getString("resdate"));
        }

        String path = request.getContextPath();
        response.sendRedirect(path+"/board/getBoard.jsp?bno="+bno);

    } catch (SQLException e) {
        System.out.println("SQL구문 오류");
    } finally {
        con.close(rs, pstmt, conn);
    }

%>