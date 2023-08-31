<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%
    session.invalidate();
    String path = request.getContextPath();
    response.sendRedirect(path);
%>