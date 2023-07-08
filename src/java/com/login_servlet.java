package com;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;
import javax.servlet.http.HttpSession;

public class login_servlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            String email = request.getParameter("email");
            String password = request.getParameter("password");

            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet login_servlet</title>");
            out.println("</head>");
            out.println("<body>");
            //out.println("<h1>Servlet login_servlet at " + request.getContextPath() + "</h1>");

            if (!password.equals("") && !email.equals("")) {
                StudentDB s = new StudentDB();
                if (s.validateLogin(email, password)) {
                    //out.println("<h1>Success</h1>");
                    try {
                        /*search sr = new search();
                        ResultSet rs = sr.searchstudent(uname);
                        //out.println("<h1>Success</h1>");
                        out.println("<h1>NAME : " + rs.getString("USERNAME") + "</h1>");
                        out.println("<h1>ROLL NUMBER : " + rs.getInt("SEM") + "</h1>");    
                        out.println("<h1>FULL NAME : " + rs.getString("FULLNAME") + "</h1>");
                        out.println("<h1>SEM : " + rs.getInt("SEM") + "</h1>");
                        out.println("<h1>ROLL NO : " + rs.getInt("ROLLNO") + "</h1>");
                        out.println("<h1>CONTACT : " + rs.getInt("CONTACT") + "</h1>");
                        out.println("<h1>EMAIL : " + rs.getInt("Email") + "</h1>");*/

 /*Request Dispactch -  Both work as same
                        RequestDispatcher rd = request.getRequestDispatcher("Second Servlet"); 
                        rd.forward(request,response);
                         */
                        String str = request.getParameter("email");
                        String pass = request.getParameter("password");

                        // Validate the user's email and password, and retrieve the user's ID from the database
                        int userId = validateUser(str, password);

                        //HttpSession session = request.getSession();
                        //session.setAttribute("email", str);

                        // If the user's email and password are valid, store the email and ID in the session
                        if (userId > 0) {
                            HttpSession session = request.getSession();
                            session.setAttribute("email", email);
                            session.setAttribute("userId", userId);

                            // Redirect the user to the home page
                            response.sendRedirect("display1.jsp");
                        } else {
                            // If the user's email and password are not valid, show an error message
                            request.setAttribute("errorMessage", "Invalid email or password");
                            request.getRequestDispatcher("home.jsp").forward(request, response);
                        }

                        //out.println("Success");
                        //response.sendRedirect("display.jsp");  //other method - (request dispactcher) method.  - Call one servletto other servlet.
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                } else {
                    out.println("<h1>Login Failed</h1>");
                }
            } else {
                out.println("<h1>Pls Enter Data</h1>");
            }

            out.println("</body>");
            out.println("</html>");
        }
    }
    
     private int validateUser(String email, String password) {
        // TODO: Validate the user's email and password, and retrieve the user's ID from the database
        // Here's an example of how you can retrieve the user's ID from the database using JDBC:
        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/youtube","root","")) {
            String sql = "SELECT id FROM users WHERE email=? AND password=?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, email);
                stmt.setString(2, password);
                try (ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) {
                        return rs.getInt("id");
                    } else {
                        return 0;
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return 0;
        }
    }
    

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}


//https://youtu.be/CzlZGHAGHbk => Amazing 
