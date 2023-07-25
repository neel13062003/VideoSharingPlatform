<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Upload Video & Display Video</title>
    </head>
    <body>
        
        <%@page import="java.sql.DriverManager"%>
        <%@page import="java.sql.ResultSet"%>
        <%@page import="java.sql.Statement"%>
        <%@page import="java.sql.Connection"%>
        <%@page import="javax.servlet.http.HttpSession" %>
        
        <a href="display1.jsp" style="">Click To See Videoes</a>
        <hr>
        <a href="logout.jsp">Logout</a>
        <hr>
        
        <%
        String s1 = (String) session.getAttribute("email");
        Integer idObj = (Integer) session.getAttribute("userId");
        int id = idObj != null ? idObj.intValue() : 0;

        
        %>
        <p><%=   s1    %></p>
        <p><%=  id %></p>
        <table>
            <tr bgcolor="#A52A2A">
                <td><b>Email</b></td>
                <td><b>Full Name</b></td>
            </tr>
        <%
            try{ 
                //connection = DriverManager.getConnection(connectionUrl+dbName, userId, password);
               
                Class.forName("com.mysql.jdbc.Driver");
                Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/youtube","root","");
                Statement statement=connection.createStatement();
                 
                String sql ="SELECT * FROM users where email='"+s1+"' ";

                ResultSet resultSet = statement.executeQuery(sql);
                while(resultSet.next()){
            %>
            <tr bgcolor="#DEB887">
                <td><%= resultSet.getString("email") %> </td>
                <td><%= resultSet.getString("name") %> </td>
            </tr>
            <% 
                }   

            }catch(Exception e) {
                e.printStackTrace();
            } %>
        </table>
        
        
        
        
        <h2>Upload Video</h2>
        <form action="UploadServlet" method="post" enctype="multipart/form-data">
            <label for="title">Title:</label>
            <input type="text" name="title" id="title" required><br><br>
            <label for="description">Description:</label>
            <textarea name="description" id="description" required></textarea><br><br>
            <label for="video">Video file:</label>
            <input type="file" name="video" id="video" required><br><br>
            <label for="thumbnail">Thumbnail image:</label>
            <input type="file" name="thumbnail" id="thumbnail" required><br><br>
            <label for="tag">Tag: </label><input type="text" name="tag" id="tag" required><br><br>
            <input type="submit" value="Upload">
        </form>

        <hr>
       
    </body>
</html>
