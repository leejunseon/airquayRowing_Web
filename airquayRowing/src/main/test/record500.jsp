<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String race_num = null;
        String bowNum = null;
        String record = null;

        try{
        String url = "jdbc:mysql://localhost:3306/airquay";
        Class.forName("com.mysql.jdbc.Driver");
        record= request.getParameter("RECORD");
        bowNum= request.getParameter("BOWNUM");
        race_num= request.getParameter("race_num");
        conn = DriverManager.getConnection(url, "root", "airquay1!");
        String sql = "insert into record500 values(?,?,?);";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, race_num);
        pstmt.setString(2, bowNum);
        pstmt.setString(3, record);
        pstmt.executeUpdate();
        out.print("complete");
} catch(Exception e){
        e.printStackTrace();
}

%>