<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Signup YouTube Page</title>
    </head>
    <body>
                   
         
        <form action="signup_servlet">
            <table>
                <tr>
                    <td>Full Name: </td>
                    <td><input type="text" name="fname"></td>
                </tr>     
                <tr>
                    <td>Password</td>
                    <td><input type="password" name="pass"></td>
                </tr>  
                <tr>
                    <td>Confirm Password</td>
                    <td><input type="password" name="cpass"></td>
                </tr>  
                <tr>
                    <td>Email:</td>
                    <td><input type="email" name="email"></td>
                </tr>
                <tr>
                    <td><input type="submit"  value="signup"/></td>  
                </tr>
            </table>    
        </form>    
    </body>
</html>
