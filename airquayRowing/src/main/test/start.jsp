<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%-- <%@ page import = "org.json.simple.JSONArray" %> --%>
<%-- <%@ page import = "org.json.simple.JSONObject" %> --%>
<%-- <%@ page import = "java.text.SimpleDateFormat" %> --%>
<%
Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;
// JSONObject sObject = new JSONObject();
// JSONArray sArray = new JSONArray();
// JSONObject sMain = new JSONObject();
String msg=null;
String raceDate=null;
String driverName="com.mysql.jdbc.Driver";
String url = "jdbc:mysql://13.209.161.83:3306/airquay";
String id = "root";
String pwd ="airquay1!";
try{
Class.forName(driverName);
msg=request.getParameter("raceDate");
conn = DriverManager.getConnection(url,id,pwd);
out.print(msg);
String sql="update isOn set onOrOff=?;";
pstmt = conn.prepareStatement(sql);
pstmt.setString(1, msg);
pstmt.executeUpdate();
conn.close();
} catch(Exception e){
e.printStackTrace();
}
%>