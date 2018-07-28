<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@ page import = "java.sql.*" %>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%-- <%@ page import = "org.json.simple.JSONArray" %> --%>
<%-- <%@ page import = "org.json.simple.JSONObject" %> --%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
  <script src="https://code.jquery.com/jquery-1.9.1.min.js"></script>
    <script type="text/javascript">
    $(document).ready(function(){
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
          String[] record500=new String[24];
          int index=0;
          conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPwd);
          pstmt = conn.prepareStatement("select * from 500m where raceNum=?;");
          pstmt.setString(1, "5");
          rs = pstmt.executeQuery();
          while(rs.next()){
            record500[index++]=rs.getString("bowNum");
            record500[index++]=rs.getString("arriveHour")+":"+rs.getString("arriveMinute")+":"+rs.getString("arriveSecond")+"."+rs.getString("arriveMiliSecond");
          }
          index=0;
//           JSONObject sObject = new JSONObject();
//           JSONArray sArray = new JSONArray();
//           JSONObject sMain = new JSONObject();
//           sMain.put("500m_1_bow",record500[index++]);
//           sMain.put("500m_1_record",record500[index++]);
//           sMain.put("500m_2_bow",record500[index++]);
//           sMain.put("500m_2_record",record500[index++]);
//           sMain.put("500m_3_bow",record500[index++]);
//           sMain.put("500m_3_record",record500[index++]);
//           sMain.put("500m_4_bow",record500[index++]);
//           sMain.put("500m_4_record",record500[index++]);
//           sMain.put("500m_5_bow",record500[index++]);
//           sMain.put("500m_5_record",record500[index++]);
//           sMain.put("500m_6_bow",record500[index++]);
//           sMain.put("500m_6_record",record500[index]);
//           sArray.add(sMain);
//           out.print(sArray);
        }catch(SQLException se){
          se.printStackTrace();
        }finally{
          if(rs != null) rs.close();
          if(pstmt != null) pstmt.close();
          if(conn != null) conn.close();
        }
        %>
      }
    })
  </script>
</body>
</html>
