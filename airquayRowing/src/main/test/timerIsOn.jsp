<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
    <script src="https://code.jquery.com/jquery-1.9.1.min.js"></script>
    <script type="text/javascript">

        $(document).ready(function(){
            setInterval(
                function t(){
                    <%
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection conn = null;
                    PreparedStatement pstmt = null;
                    ResultSet rs = null;

                    try{
                        String jdbcDriver = "jdbc:mysql://localhost:3306/airquay";
                        String dbUser = "root";
                        String dbPwd = "airquay1!";

                        conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPwd);
                        pstmt = conn.prepareStatement("select * from isOn");
                        rs = pstmt.executeQuery();
                        while(rs.next()){
                            if(rs.getString("onOrOff").equals("1"))
                                %>
                            console.log(<%=rs.getString("onOrOff")%>+"00000000000000");
                            id.innerHTML=<%=rs.getString("onOrOff")%>;
                            
                            <%

                        }
                    }catch(SQLException se){
                        se.printStackTrace();
                    }finally{
                        if(rs != null) rs.close();
                        if(pstmt != null) pstmt.close();
                        if(conn != null) conn.close();
                    }
                    %>
                },1)
        })

    </script>
    <div id="id"></div>
</body>
</html>
