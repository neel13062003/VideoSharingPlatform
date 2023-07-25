<%@page import="java.util.ArrayList"%>
<%@page import="com.VideoDao"%>
<%@page import="java.util.List"%>
<%@page import="com.Video"%>
<%@page import="com.LikeDao"%>
<%@page import="com.SubDao "%>
<%@page import="com.ConnectionProvider"%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!-- dedicated_video_page.jsp -->
<!DOCTYPE html>
<html>
<head>
    <!-- Your CSS and other meta tags -->
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
            String currentUser = (String) session.getAttribute("email");
            Integer idObj = (Integer) session.getAttribute("userId");
            int id = idObj != null ? idObj.intValue() : 0;

            if (currentUser == null) {
                response.sendRedirect("login.jsp");
                return;
            }
        %>

<!-- --------------------main---------------- -->
<div class="content">
    <div class="video-container">
        <%
            int videoId = Integer.parseInt(request.getParameter("videoId"));
            // Get the tags associated with the current video
            List<String> tags = new ArrayList<String>();
            try {
                Class.forName("com.mysql.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/youtube", "root", "");
                String sql = "SELECT tag FROM video_tags WHERE video_id = ?";
                PreparedStatement stmt = conn.prepareStatement(sql);
                stmt.setInt(1, videoId);
                ResultSet rs = stmt.executeQuery();
                while (rs.next()) {
                    String tag = rs.getString("tag");
                    tags.add(tag);
                }
                rs.close();
                stmt.close();
                conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }

            // Fetch related videos based on tags
            List<Video> relatedVideos = new ArrayList<Video>();
            for (String tag : tags) {
                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/youtube", "root", "");
                    String sql = "SELECT * FROM videos WHERE id IN (SELECT video_id FROM video_tags WHERE tag = ?)";
                    PreparedStatement stmt = conn.prepareStatement(sql);
                    stmt.setString(1, tag);
                    ResultSet rs = stmt.executeQuery();
                    while (rs.next()) {
                        int relatedVideoId = rs.getInt("id");
                        String title = rs.getString("title");
                        String description = rs.getString("description");
                        String videoUrl = rs.getString("video_url");
                        String thumbnailUrl = rs.getString("thumbnail_url");
                        String owner = rs.getString("owner");
                        int ownerId = rs.getInt("ownerid");
                        Video video = new Video(relatedVideoId, title, description, videoUrl, thumbnailUrl, owner, ownerId);
                        relatedVideos.add(video);
                    }
                    rs.close();
                    stmt.close();
                    conn.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }

            LikeDao ld = new LikeDao(ConnectionProvider.getConnection());
            SubDao s = new SubDao(ConnectionProvider.getConnection());
            int count=0;
            for (Video relatedVideo : relatedVideos) {
//                count++;
        %>

        <!-- ------------------------ video------------------------ -->
        
        <div class="vid_list" style="display: flex;
        flex-wrap: wrap;
        gap: 20px;">
            <div class="flex-div">

                <div class="vid-info">
                    
                     <% if (relatedVideo.getVideoId() == videoId) { %>
                         <!-- ------------------------ Clicked video ------------------------ -->
                        <div class="clicked-video" style="flex-basis: 100%;
        text-align: center;"> 
                            <video width="500" height="300" style="text-align:center; margin:10px; padding:10px; width: 800px;" controls poster="<%= relatedVideo.getThumbnailUrl()%>">
                                <source src="<%= relatedVideo.getVideoUrl()%>" type="video/mp4">
                            </video>
                            <br><h1>Recommended Videoes</h1>
                        </div>
                    <% } else { %>
                        <!-- ------------------------ Recommended videos ------------------------ -->
                        <div class="recommended-video" style="flex-basis: 33.33%;
        text-align: center;">
                            <video width="320" height="240" controls poster="<%= relatedVideo.getThumbnailUrl()%>">
                                <source src="<%= relatedVideo.getVideoUrl()%>" type="video/mp4">
                            </video>
                        </div>
                    <% } %>
                    
                    <a href=""><b style="font-size:18px; color:black;font-weight: bold;">Title : <%= relatedVideo.getTitle()%></a> </b>
                    <p>Discription : <%= relatedVideo.getDescription()%>     </p>

                    <p style="display: flex; font:size:18px; color:black;font-weight: bold;"><%= relatedVideo.getOwner()%> :

                        <span style="margin-left:15px;">
                            <% if (!s.isSubscribed(idObj, relatedVideo.getOwnerId())) { %>
                                <a href=" " onclick="doSub(<%= idObj %>, <%= relatedVideo.getOwnerId() %>)" class="btn btn-outline-light btn-sm">
                                    <button style="border-radius:15px;color:white; background-color: red; font-size: 20px; /* Increase the font size */
    font-weight: bold; ">Subscribe</button>

                                    <span id="sub-count1-<%= idObj %>"><%= s.countSubscribers(relatedVideo.getOwnerId()) %></span>
                                </a>
                            <% } else { %>
                                <a href=" " onclick="dounSub(<%= idObj %>, <%= relatedVideo.getOwnerId() %>)" class="btn btn-outline-light btn-sm">
                                    <button style="border-radius:15px;color:white; background-color: red; font-size: 20px; /* Increase the font size */
    font-weight: bold; ">Subscribe</button>
                                    <span id="sub-count2-<%= idObj %>"><%= s.countSubscribers(relatedVideo.getOwnerId()) %></span>
                                </a>
                            <% } %>
                        </span>

                        <span style="margin-left:15px;">
                            <% if (ld.isLikedByUser(relatedVideo.getVideoId(), idObj) == false) { %>
                                <a href=" " onclick="doLike(<%= relatedVideo.getVideoId()%>,<%= idObj%>)" class="btn btn-outline-light btn-sm"> <i class="fa fa-thumbs-o-up"></i>
                                    <!--                                    <span class="like-counter"><%--=ld.countLikeOnPost(videoId)--%></span> -->
                                    <span id="like-count1-<%= relatedVideo.getVideoId()%>"><%= ld.countLikeOnPost(relatedVideo.getVideoId())%></span>
                                </a>
                            <% } else { %>
                                <a href=" " onclick="dounLike(<%= relatedVideo.getVideoId()%>,<%= idObj%>)" class="btn btn-outline-light btn-sm"> <i class="fa fa-thumbs-o-up"></i>
                                    <!--                                <span class="like-counter"><%--=ld.countLikeOnPost(videoId)--%></span> -->
                                    <span id="like-count2-<%= relatedVideo.getVideoId()%>"><%= ld.countLikeOnPost(relatedVideo.getVideoId())%></span>
                            <% } %>
                        </span>
                    </p>
                </div>
            </div>
        </div>
        <% } %>                   
        </div>
    </div>

    
<!-- Add recommended video list CSS -->
<style>
    .recommended-videos {
        margin-top: 20px;
    }

    .recommended-video-list {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
        gap: 20px;
    }

    .recommended-video {
        border: 1px solid #ccc;
        padding: 10px;
    }

    .recommended-video img {
        width: 100%;
    }

    .recommended-video h3 {
        margin-top: 10px;
        font-size: 18px;
    }

    .recommended-video p {
        margin-top: 5px;
    }
</style>                   
        </div>
</body>
</html>

