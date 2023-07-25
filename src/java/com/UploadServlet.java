package com;

import java.io.FileOutputStream;
import java.*;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.UUID;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import javax.servlet.http.HttpSession;


@WebServlet("/uploads")
@MultipartConfig
public class UploadServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private static final String SAVE_DIR = "uploads";
    private static final String DB_URL = "jdbc:mysql://localhost:3306/youtube";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // Gets the user's full name from the session object
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");
        String name = null;
        int ownerid=0;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM users WHERE email=?");
            pstmt.setString(1, email);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                name = rs.getString("name");
                ownerid = rs.getInt("id");   
            }
            pstmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred while retrieving the user's full name.");
            return;
        }

        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String owner = name;
        String tag = request.getParameter("tag"); // Get the tags from the form


        // Gets the video file and saves it to the uploads directory
        Part videoPart = request.getPart("video");
        String fileName = getUniqueFileName(Paths.get(videoPart.getSubmittedFileName()).getFileName().toString());
        //String savePath = request.getServletContext().getRealPath("/") + SAVE_DIR + "/";
        String savePath = "C://Java/YouTube/web/uploads/";
        Path path = Paths.get(savePath);
        if (!Files.exists(path)) {
            Files.createDirectories(path);
        }
        InputStream videoContent = videoPart.getInputStream();
        Files.copy(videoContent, path.resolve(fileName));

        // Gets the thumbnail file and saves it to the uploads directory
        Part thumbnailPart = request.getPart("thumbnail");
        String thumbnailName = getUniqueFileName(Paths.get(thumbnailPart.getSubmittedFileName()).getFileName().toString());
        InputStream thumbnailContent = thumbnailPart.getInputStream();
        Files.copy(thumbnailContent, path.resolve(thumbnailName));

        // Saves the video details to the database
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            PreparedStatement pstmt = conn.prepareStatement("INSERT INTO videos (title, description, video_url, thumbnail_url, owner,ownerid) VALUES (?, ?, ?, ?, ?,?)");
            pstmt.setString(1, title);
            pstmt.setString(2, description);
            pstmt.setString(3, SAVE_DIR + "/" + fileName);
            pstmt.setString(4, SAVE_DIR + "/" + thumbnailName);
            pstmt.setString(5, owner);
            pstmt.setInt(6, ownerid);

            pstmt.executeUpdate();
            pstmt.close();
            
            // Get the last inserted video's ID
            int videoId = 0;
            PreparedStatement getLastIdStmt = conn.prepareStatement("SELECT LAST_INSERT_ID() as last_id");
            ResultSet rs = getLastIdStmt.executeQuery();
            if (rs.next()) {
                videoId = rs.getInt("last_id");
            }
            getLastIdStmt.close();

            // Split the tags if multiple tags are provided (assuming they are separated by commas)
            String[] tagsArray = tag.split(",");

            // Insert tags into the video_tags table
            for (String tagValue : tagsArray) {
                PreparedStatement insertTagsStmt = conn.prepareStatement("INSERT INTO video_tags (video_id, tag) VALUES (?, ?)");
                insertTagsStmt.setInt(1, videoId);
                insertTagsStmt.setString(2, tagValue.trim());
                insertTagsStmt.executeUpdate();
                insertTagsStmt.close();
            }
            
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred while saving the video details to the database.");
            return;
        }

        // Redirects to the display page
        response.sendRedirect("display.jsp");

    }

    private String getUniqueFileName(String name, String extension) {
        String uuid = UUID.randomUUID().toString();
        return name + "_" + uuid + "." + extension;
    }

    private String getUniqueFileName(String name) {
        int dotIndex = name.lastIndexOf(".");
        String extension = name.substring(dotIndex + 1);
        String fileNameWithoutExtension = name.substring(0, dotIndex);
        return getUniqueFileName(fileNameWithoutExtension, extension);
    }

}



