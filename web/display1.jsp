<%@page import="com.LikeDao"%>
<%@page import="com.SubDao "%>
<%@page import="com.ConnectionProvider"%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>

<html>
    <head>
        <meta charset="UTF-8">
        <title>Display Videos</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        
        <link rel="stylesheet" href="css/style.css">
        <script src="js/script.js"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" integrity="sha512-9usAa10IRO0HhonpyAIVpjrylPvoDwiPUiKdWk5t3PyolY1cOd4DSE0Ga+ri4AuTroPR5aQvXU9xC6qOPnzFeg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        
    </head>

    <body>
        
        
   
        <%@page import="java.sql.DriverManager"%>
        <%@page import="java.sql.ResultSet"%>
        <%@page import="java.sql.Statement"%>
        <%@page import="java.sql.Connection"%>
        <%@page import="javax.servlet.http.HttpSession" %>
        <%@page  errorPage="error_page.jsp" %>
        <%
            // Check if the user is logged in
            //HttpSession session1 = request.getSession();
            String currentUser = (String) session.getAttribute("email");
            Integer idObj = (Integer) session.getAttribute("userId");
            int id = idObj != null ? idObj.intValue() : 0;

            if (currentUser == null) {
                response.sendRedirect("login.jsp");
                return;
            }
        %>
        
        <nav class="flex-div">
            <div class="nav-left flex-div">
                <img src="images/menu.png" alt="" class="menu_icon">
                <img src="images/youtube.png" alt="" class="logo">

            </div>
            <div class="nav-middle flex-div">
                <div class="search_box flex-div">
                    <input type="text" id= "search_input" placeholder="Search">
                    <img src="images/search.png" alt="">
                </div>
                <img src="images/voice-search.png" class="mic_icon" alt="">
            </div>
            <div class="nav-right flex-div">
                <a href="display.jsp"><img src="images/upload.png" alt=""></a>
                <img src="images/more.png" alt="">
                <img src="images/notification.png" alt="">
                
                <%
                try {
                    //connection = DriverManager.getConnection(connectionUrl+dbName, userId, password);

                    Class.forName("com.mysql.jdbc.Driver");
                    Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/youtube", "root", "");
                    Statement statement = connection.createStatement();

                    String sql = "SELECT * FROM users where email='" + currentUser + "' ";

                    ResultSet resultSet = statement.executeQuery(sql);
                    while (resultSet.next()) {
                %>
                
                    <img src="images/neel.jpeg" alt="" class="user-icon" style="border-radius:45px;" > <%= resultSet.getString("name")%> 
           
                <%
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } %>
                <a href="logout.jsp">Logout</a>
                
                
            </div>
        </nav>
        
        <!-- --------------------------sidebar--------------------- -->
        <div class="sidebar" >
            <div class="shortcut-links">
                <a href=""><img src="images/home.png" alt=""><p>Home</p></a>
                <a href=""><img src="images/explore.png" alt=""><p>Shorts</p></a>
                <a href=""><img src="images/subscriprion.png" alt=""><p>Subcriptions</p></a>
                <a href=""><img src="images/show-more.png" alt=""><p>Show-more</p></a>
                <hr>
            </div>
            <div class="subcribed-list">
                <h3>SUBSCRIBED</h3>
                <% 
                // Database connection details
                String url1 = "jdbc:mysql://localhost:3306/youtube";
                String username1 = "root";
                String password1 = "";

                Connection conn1 = null;
                PreparedStatement stmt1 = null;
                ResultSet rs1 = null;
                PreparedStatement stmt2 = null;
                ResultSet rs2 = null;

                try {
                  Class.forName("com.mysql.jdbc.Driver");
                  conn1 = DriverManager.getConnection(url1, username1, password1);

                  stmt1 = conn1.prepareStatement("SELECT * FROM subscriber WHERE uid = ?");
                  stmt1.setInt(1, idObj); // Replace "uid" with the actual user ID
                  rs1 = stmt1.executeQuery();

                  while (rs1.next()) {
                    int channel_id = rs1.getInt("channel_id");

                    stmt2 = conn1.prepareStatement("SELECT name FROM users WHERE id = ?");
                    stmt2.setInt(1, channel_id);
                    rs2 = stmt2.executeQuery();

                    while (rs2.next()) {
                      String name = rs2.getString("name");
                      %>
                      <a href=""><img src="images/aa.png" alt=""><p><%= name %></p></a>
                      <%
                    }
                  }
                } catch (Exception e) {
                  e.printStackTrace();
                } finally {
                  // Close the database resources (connection, statements, result sets)
                  try {
                    if (rs2 != null) {
                      rs2.close();
                    }
                    if (stmt2 != null) {
                      stmt2.close();
                    }
                    if (rs1 != null) {
                      rs1.close();
                    }
                    if (stmt1 != null) {
                      stmt1.close();
                    }
                    if (conn1 != null) {
                      conn1.close();
                    }
                  } catch (SQLException ex) {
                    ex.printStackTrace();
                  }
                }
                %>
              </div>



            
        </div>
        
        <!-- --------------------main---------------- -->
        <div class="content">
            <div class="banner">
                <img src="images/banner2.jpg" alt="">
            </div>
            <div class="video-container">
        <%
                // database connection details
            String url = "jdbc:mysql://localhost:3306/youtube";
            String username = "root";
            String password = "";
            boolean userLikedVideo;

            Connection conn = null;
            PreparedStatement stmt = null;
            ResultSet rs = null;

            try {
                Class.forName("com.mysql.jdbc.Driver");
                conn = DriverManager.getConnection(url, username, password);

                // Prepare the SQL statement to retrieve videos
                String sql = "SELECT id, title, description, video_url, thumbnail_url, owner,ownerid FROM videos";
                stmt = conn.prepareStatement(sql);
                rs = stmt.executeQuery();

                while (rs.next()) {
                    int videoId = rs.getInt("id");
                    String title = rs.getString("title");
                    String description = rs.getString("description");
                    String videoUrl = rs.getString("video_url");
                    String thumbnailUrl = rs.getString("thumbnail_url");
                    String owner = rs.getString("owner");
                    int ownerId = rs.getInt("ownerid");
            %>
        
            <%
                LikeDao ld = new LikeDao(ConnectionProvider.getConnection());
                SubDao s = new SubDao(ConnectionProvider.getConnection());
            %>
        
        
     
        <!-- ------------------------ video------------------------ -->
            <!--<div class="list_content">-->
                <div class="vid_list">                           
                    <div class="flex-div">
                        <!img src="images/Jack.png" style="margin-left:auto;"alt="">
                        <div class="vid-info">
                            <!--<p><video width="320" height="240" controls poster="<!%= thumbnailUrl%>"><source src="<!%= videoUrl%>" type="video/mp4"></video></p>-->
<!--                            <p><video width="320" height="240" controls poster="<!%= thumbnailUrl%>">-->
                            <p>
<!--                                 when click in between send this videoes details to display2.jsp  -->
                                     <a href="display2.jsp?videoId=<%= videoId %>&title=<%= title %>&description=<%= description %>&owner=<%= owner %>">
                                        <video width="320" height="240" controls poster="<%= thumbnailUrl %>">
                                            <!-- video source -->
                                        </video>
                                    </a>
                            </p>
                            
                            <a href=""><b style="font-size:18px; color:black;font-weight: bold;">Title : <%= title %></a> </b>
                            <p>Discription : <%= description%>     </p>                 
                             
                           
                            <p style="display: flex; font:size:18px; color:black;font-weight: bold;"><%= owner%> : 
                                
                                <span style="margin-left:15px;">
                                    <% if (!s.isSubscribed(idObj, ownerId)) { %>
                                      <a href=" " onclick="doSub(<%= idObj %>, <%= ownerId %>)" class="btn btn-outline-light btn-sm">
                                        <button style="border-radius:15px;color:white; background-color: red; font-size: 20px; /* Increase the font size */
  font-weight: bold; ">Subscribe</button>
                                          
                                        <span id="sub-count1-<%= idObj %>"><%= s.countSubscribers(ownerId) %></span>
                                      </a> 
                                    <% } else { %>
                                      <a href=" " onclick="dounSub(<%= idObj %>, <%= ownerId %>)" class="btn btn-outline-light btn-sm">
                                           <button style="border-radius:15px;color:white; background-color: red; font-size: 20px; /* Increase the font size */
  font-weight: bold; ">Subscribe</button>
                                        <span id="sub-count2-<%= idObj %>"><%= s.countSubscribers(ownerId) %></span>
                                      </a> 
                                    <% } %>
                                  </span>
                                
                                
                                
                                <span style="margin-left:15px;">
                                <%if (ld.isLikedByUser(videoId, idObj) == false) {%>
                                    <a href=" " onclick="doLike(<%= videoId%>,<%= idObj%>)" class="btn btn-outline-light btn-sm"> <i class="fa fa-thumbs-o-up"></i>
<!--                                    <span class="like-counter"><%--=ld.countLikeOnPost(videoId)--%></span> -->
                                    <span id="like-count1-<%= videoId%>"><%= ld.countLikeOnPost(videoId)%></span>
                                     </a> 
                                <%} else { %>
                                    <a href=" " onclick="dounLike(<%= videoId%>,<%= idObj%>)" class="btn btn-outline-light btn-sm"> <i class="fa fa-thumbs-o-up"></i>
    <!--                                <span class="like-counter"><%--=ld.countLikeOnPost(videoId)--%></span> -->
                                         <span id="like-count2-<%= videoId%>"><%= ld.countLikeOnPost(videoId)%></span>
                                         <% } %>
                                    </a> 
                                </span>
                            </p>
                        </div>
                    </div>
                </div>  <%} %>                   
            </div>
                                    
            <%
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    try {
                        rs.close();
                    } catch (Exception e) {
                        /* ignored */ }
                    try {
                        stmt.close();
                    } catch (Exception e) {
                        /* ignored */ }
                    try {
                        conn.close();
                    } catch (Exception e) {
                        /* ignored */ }
                }
            %>                    
        </div>    
       
        <style>.video-container {
  display: flex;
  flex-wrap: wrap;
  gap: 20px; /* Adjust the gap between videos as needed */
}

.vid_list {
  width: 320px; /* Adjust the width of each video item as needed */
  flex: 0 0 auto;
}

.flex-div {
  display: flex;
  align-items: center;
}

.flex-div img {
  margin-right: 10px;
}

.vid-info {
  display: flex;
  flex-direction: column;
}

.vid-info p, .vid-info a {
  margin: 5px 0;
}
</style>
        
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
        <script src="js/myjs.js" type="text/javascript"></script>


    </body>
</html>
