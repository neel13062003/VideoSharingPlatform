<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
    <head>
        <title>YouTube Login</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">      
    </head>
    <body>
        <div>
            <form action="login_servlet" method="POST">
                <table>
                    <tr>
                        <td>Email:</td>
                        <td><input type="email"  name="email" ></td>  
                    </tr>
                    <tr>
                        <td>Password:</td>
                        <td><input type="password"  name="password"></td>  
                    </tr>
                    <tr>
                        <td><input type="submit"  value="login"></td>  
                    </tr>
                </table>
            </form> 
            
            <a href="signup.jsp"><button>Sign up</button></a><br><br>
        </div>
    </body>
</html>

