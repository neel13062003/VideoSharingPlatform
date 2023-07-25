package com;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class VideoServlet extends HttpServlet {
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        // Get the videoId parameter from the URL
        String videoIdParam = request.getParameter("videoId");
        if (videoIdParam == null || videoIdParam.isEmpty()) {
            response.sendRedirect("display1.jsp");
            return;
        }

        int videoId = Integer.parseInt(videoIdParam);
         // Get the clicked video object from the database
        Video clickedVideo = VideoDao.getVideoById(videoId);

        // Get the related videos list from the database
        List<Video> relatedVideos = VideoDao.getRecommendedVideosByTags(videoId);

        // Set the attributes in the request to be accessed in display2.jsp
        request.setAttribute("clickedVideo", clickedVideo);
        request.setAttribute("relatedVideos", relatedVideos);

        // Forward the request to display2.jsp to display the clicked video and recommended videos
        request.getRequestDispatcher("display2.jsp").forward(request, response);
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("VideoServlet received the request1.");
        processRequest(request, response);
    }

   
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("VideoServlet received the request2.");
        processRequest(request, response);
    }

    
    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
