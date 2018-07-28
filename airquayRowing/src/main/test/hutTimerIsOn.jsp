<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%-- <%@ page import = "org.json.simple.JSONArray" %> --%>
<%-- <%@ page import = "org.json.simple.JSONObject" %> --%>
<%@ page import = "java.text.SimpleDateFormat" %>
<%
Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;
// JSONObject sObject = new JSONObject();
// JSONArray sArray = new JSONArray();
// JSONObject sMain = new JSONObject();
String raceDate=null;
String driverName="com.mysql.jdbc.Driver";
String url = "jdbc:mysql://localhost:3306/airquay";
String id = "root";
String pwd ="airquay1!";
try{
Class.forName(driverName);
conn = DriverManager.getConnection(url,id,pwd);
String sql="select * from isOn;";
pstmt=conn.prepareStatement(sql);
rs = pstmt.executeQuery();
rs.last();
raceDate=rs.getString("onOrOff");
conn.close();
} catch(Exception e){
e.printStackTrace();
}
if("1".equals(raceDate)){
// sObject.put("key", "on");
// sArray.add(0, sObject);
// sMain.put("dataSend", sArray);
// out.print(sMain);
}
else{
// sObject.put("key", "off");
// sArray.add(0, sObject);
// sMain.put("dataSend", sArray);
// out.print(sMain);
}
%>