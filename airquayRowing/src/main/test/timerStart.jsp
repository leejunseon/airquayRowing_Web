<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String msg = null;
        String driverName="com.mysql.jdbc.Driver";
        String url = "jdbc:mysql://localhost:3306/airquay";
        String id = "root";
        String pwd ="airquay1!";
        try{
                Class.forName(driverName);
        }catch(ClassNotFoundException e){
        out.println("Where is your mysql jdbc driver?");
        e.printStackTrace();
        return;
        }
        conn = DriverManager.getConnection(url,id,pwd);
        String sql="update isOn set onOrOff=1;";
        pstmt = conn.prepareStatement(sql);
        pstmt.executeUpdate();
        conn.close();
%>
<html>
        <head>
        <meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
        <title>Insert title here</title>
        </head>
        <body>
        <script src="https://code.jquery.com/jquery-1.9.1.min.js"></script>
        <script type="text/javascript">
                $(document).ready(function(){
                setInterval(
                        function t(){
                                id.innerHTML=1;
                        } , 1)
                })
        </script>
        <div id="id"></div>
</body>
</html>
