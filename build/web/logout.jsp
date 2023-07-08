<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>LogOut Pages</title>
    </head>
    <body>
        <%@ page import="javax.servlet.http.*" %>
        <%
          HttpSession session1 = request.getSession(true);
          session1.invalidate();
          //response.sendRedirect("index.html");
        %>
        You have successfully logged out. Click <a href="home.jsp">Click Here</a> to log in again.
    </body>
</html>
