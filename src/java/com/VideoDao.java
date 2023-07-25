package com;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class VideoDao {
    // Method to get a video by its ID
    
    Connection con;

    public VideoDao(Connection con) {
        this.con = con;
    }
    public static Video getVideoById(int videoId) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            // Get a database connection
            conn = ConnectionProvider.getConnection();

            // Prepare the SQL statement to retrieve the specific video by videoId
            String sql = "SELECT id, title, description, video_url, thumbnail_url, owner, ownerid FROM videos WHERE id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, videoId);

            // Execute the query
            rs = stmt.executeQuery();

            // If a matching video is found, create and return a Video object
            if (rs.next()) {
                int id = rs.getInt("id");
                String title = rs.getString("title");
                String description = rs.getString("description");
                String videoUrl = rs.getString("video_url");
                String thumbnailUrl = rs.getString("thumbnail_url");
                String owner = rs.getString("owner");
                int ownerId = rs.getInt("ownerid");

                return new Video(id, title, description, videoUrl, thumbnailUrl, owner, ownerId);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // Close the database resources
            closeResources(conn, stmt, rs);
        }

        return null; // Return null if video not found or error occurs
    }

    // Method to get a list of related videos based on movie tags
     // Method to get a list of related videos based on movie tags
    public static List<Video> getRecommendedVideosByTags(int videoId) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Video> recommendedVideos = new ArrayList<>();

        try {
            // Get a database connection
            conn = ConnectionProvider.getConnection();

            // Get the movie tags associated with the clicked video
            List<String> tags = getMovieTagsByVideoId(videoId);

            // If there are no tags associated with the clicked video, return an empty list
            if (tags.isEmpty()) {
                return recommendedVideos;
            }

            // Prepare the SQL statement to retrieve recommended videos based on movie tags
            String sql = "SELECT id, title, description, video_url, thumbnail_url, owner, ownerid FROM videos WHERE id != ? AND id IN (SELECT video_id FROM video_tags WHERE tag IN (?";
            for (int i = 1; i < tags.size(); i++) {
                sql += ", ?";
            }
            sql += ")) LIMIT 10";

            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, videoId);

            // Set the movie tags as parameters in the SQL statement
            for (int i = 0; i < tags.size(); i++) {
                stmt.setString(i + 2, tags.get(i));
            }

            // Execute the query
            rs = stmt.executeQuery();

            // Create Video objects for each recommended video and add them to the list
            while (rs.next()) {
                int id = rs.getInt("id");
                String title = rs.getString("title");
                String description = rs.getString("description");
                String videoUrl = rs.getString("video_url");
                String thumbnailUrl = rs.getString("thumbnail_url");
                String owner = rs.getString("owner");
                int ownerId = rs.getInt("ownerid");

                Video video = new Video(id, title, description, videoUrl, thumbnailUrl, owner, ownerId);
                recommendedVideos.add(video);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // Close the database resources
            closeResources(conn, stmt, rs);
        }

        return recommendedVideos;
    }

    // Helper method to get movie tags associated with a video
    private static List<String> getMovieTagsByVideoId(int videoId) {
    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;
    List<String> tags = new ArrayList<>();

    try {
        // Get a database connection
        conn = ConnectionProvider.getConnection();

        // Prepare the SQL statement to retrieve movie tags by videoId
        String sql = "SELECT tag FROM video_tags WHERE video_id = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setInt(1, videoId);

        // Execute the query
        rs = stmt.executeQuery();

        // Add the movie tags to the list
        while (rs.next()) {
            String tag = rs.getString("tag");
            tags.add(tag);
        }

    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        // Close the database resources
        closeResources(conn, stmt, rs);
    }

    return tags;
}

    // Helper method to close database resources
    private static void closeResources(Connection conn, PreparedStatement stmt, ResultSet rs) {
        try {
            if (rs != null) {
                rs.close();
            }
            if (stmt != null) {
                stmt.close();
            }
            if (conn != null) {
                conn.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
