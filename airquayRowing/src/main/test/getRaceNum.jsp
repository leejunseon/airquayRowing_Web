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
String raceNum = null;
String raceDate=null;
java.util.Date today = new java.util.Date();
// SimpleDateFormat fm1 = new SimpleDateFormat("yyyy-MM-dd");

String CurrentDate = request.getParameter("raceDate");

try{
String url = "jdbc:mysql://localhost:3306/airquay";
Class.forName("com.mysql.jdbc.Driver");
conn = DriverManager.getConnection(url, "root", "airquay1!");
String sql = "select raceDate from raceInfo where raceNum=1;";
pstmt = conn.prepareStatement(sql);
rs = pstmt.executeQuery();
rs.last();
raceDate=rs.getString("raceDate");
} catch(Exception e){
e.printStackTrace();
}
if(CurrentDate.equals(raceDate)){
// sObject.put("key", "ok");
// sArray.add(0, sObject);
// sMain.put("dataSend", sArray);
// out.print(sMain);
}
else{
// sObject.put("key", "no");
// sArray.add(0, sObject);
// sMain.put("dataSend", sArray);
// out.print(sMain);
}

%>
