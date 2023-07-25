package com;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class SubDao {
  private Connection con;

  public SubDao(Connection con) {
    this.con = con;
  }

  public boolean insertSub(int uid, int channel_id) {
    boolean success = false;
    try {
      String query = "INSERT INTO subscriber (uid, channel_id) VALUES (?, ?)";
      PreparedStatement stmt = this.con.prepareStatement(query);
      stmt.setInt(1, uid);
      stmt.setInt(2, channel_id);
      int rows = stmt.executeUpdate();
      if (rows > 0) {
        success = true;
      }
    } catch (SQLException e) {
      e.printStackTrace();
    }
    return success;
  }

  public int countSubscribers(int channel_id) {
    int count = 0;
    try {
//      String query = "SELECT count(*) AS total FROM subscriber WHERE channel_id = ?";
      String query = "SELECT COUNT(DISTINCT uid, channel_id) AS total FROM subscriber WHERE channel_id = ?";
      PreparedStatement stmt = this.con.prepareStatement(query);
      stmt.setInt(1, channel_id);
      ResultSet rs = stmt.executeQuery();
      if (rs.next()) {
        count = rs.getInt("total");
      }
    } catch (SQLException e) {
      e.printStackTrace();
    }
    return count;
  }

  public boolean isSubscribed(int uid, int channel_id) {
    boolean subscribed = false;
    try {
      String query = "SELECT * FROM subscriber WHERE uid = ? AND channel_id = ?";
      PreparedStatement stmt = this.con.prepareStatement(query);
      stmt.setInt(1, uid);
      stmt.setInt(2, channel_id);
      ResultSet rs = stmt.executeQuery();
      if (rs.next()) {
        subscribed = true;
      }
    } catch (SQLException e) {
      e.printStackTrace();
    }
    return subscribed;
  }

  public boolean deleteSub(int uid, int channel_id) {
    boolean success = false;
    try {
      String query = "DELETE FROM subscriber WHERE uid = ? AND channel_id = ?";
      PreparedStatement stmt = this.con.prepareStatement(query);
      stmt.setInt(1, uid);
      stmt.setInt(2, channel_id);
      int rows = stmt.executeUpdate();
      if (rows > 0) {
        success = true;
      }
    } catch (SQLException e) {
      e.printStackTrace();
    }
    return success;
  }
}
