<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%
Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;
String msg1;
String msg2;
String msg3;
String msg4;
String driverName="com.mysql.jdbc.Driver";
String url = "jdbc:mysql://13.209.161.83:3306/airquay";
String id = "root";
String pwd ="airquay1!";
try{
Class.forName(driverName);
msg1=request.getParameter("HOUR");
msg2=request.getParameter("MINUTE");
msg3=request.getParameter("SECOND");
msg4=request.getParameter("MILISECOND");
conn = DriverManager.getConnection(url,id,pwd);
String sql="update isOn set pastHour=?, pastMinute=?, pastSecond=?, pastMiliSecond=?;";
pstmt = conn.prepareStatement(sql);
pstmt.setString(1, msg1);
pstmt.setString(2, msg2);
pstmt.setString(3, msg3);
pstmt.setString(4, msg4);
pstmt.executeUpdate();
conn.close();
} catch(Exception e){
e.printStackTrace();
}
%>