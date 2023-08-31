<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.grownjoy.db.*" %>

<%
    request.setCharacterEncoding("UTF-8");
    response.setContentType("text/html; charset=UTF-8");
    response.setCharacterEncoding("UTF-8");
    String title = request.getParameter("title");
    String author = request.getParameter("author");
    String company = request.getParameter("company");
    String date = request.getParameter("date");
    int price = Integer.parseInt(request.getParameter("price"));


    Connection conn = null;
    PreparedStatement pstmt = null;
    DBC con = new MariaDBCon();
    conn = con.connect();


    String sql = "insert into book(title, author, company,date,price) values (?, ?, ?,?,?)";
    pstmt = conn.prepareStatement(sql);
    pstmt.setString(1, title);
    pstmt.setString(2, author);
    pstmt.setString(3, company);
    pstmt.setString(4,date);
    pstmt.setInt(5,price);


    int cnt = pstmt.executeUpdate();

    String path = request.getContextPath();

    if(cnt>0){
        response.sendRedirect(path+"/bookbook/Booklit.jsp");
    } else {
        response.sendRedirect(path"/bookbook/addBook.jsp");
    }
    con.close(pstmt, conn);
%>
