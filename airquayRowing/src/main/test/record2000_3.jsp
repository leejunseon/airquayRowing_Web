<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>   
	<script src="https://code.jquery.com/jquery-1.9.1.min.js"></script>
	<script type="text/javascript">
		<%
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String hutPosition = null;
		String raceNum = null;
		String bowNum = null;
		String hour = null;
		String minute=null;
		String second=null;
		String milisecond=null;

		try{
			String url = "jdbc:mysql://localhost:3306/airquay";
			Class.forName("com.mysql.jdbc.Driver");
			hutPosition= request.getParameter("HUT");
			hour= request.getParameter("HOUR");
			minute= request.getParameter("MINUTE");
			second= request.getParameter("SECOND");
			milisecond= request.getParameter("MILISECOND");
			bowNum= request.getParameter("BOWNUM");
			raceNum= request.getParameter("RACENUM");
			conn = DriverManager.getConnection(url, "root", "airquay1!");
			out.print(second);
			if(hutPosition.equals("500m"))
			{
				String sql = "insert into 500m values(?,?,?,?,?,?);";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, raceNum);
				pstmt.setString(2, bowNum);
				pstmt.setString(3, hour);
				pstmt.setString(4, minute);
				pstmt.setString(5, second);
				pstmt.setString(6, milisecond);
			}
			else if(hutPosition.equals("1000m"))
			{
				String sql = "insert into 1000m values(?,?,?,?,?,?);";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, raceNum);
				pstmt.setString(2, bowNum);
				pstmt.setString(3, hour);
				pstmt.setString(4, minute);
				pstmt.setString(5, second);
				pstmt.setString(6, milisecond);
			}
			else if(hutPosition.equals("1500m"))
			{
				String sql = "insert into 1500m values(?,?,?,?,?,?);";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, raceNum);
				pstmt.setString(2, bowNum);
				pstmt.setString(3, hour);
				pstmt.setString(4, minute);
				pstmt.setString(5, second);
				pstmt.setString(6, milisecond);
			}
			else
			{
				String sql = "insert into 2000m values(?,?,?,?,?,?);";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, raceNum);
				pstmt.setString(2, bowNum);
				pstmt.setString(3, hour);
				pstmt.setString(4, minute);
				pstmt.setString(5, second);
				pstmt.setString(6, milisecond);
			}
			pstmt.executeUpdate();
			conn.close();
		} catch(Exception e){
			e.printStackTrace();
		}
		%>
		$(document).ready(function(){
			function t(){
			<%
            Class.forName("com.mysql.jdbc.Driver");
            try{
                String jdbcDriver = "jdbc:mysql://localhost:3306/airquay";
                String dbUser = "root";
                String dbPwd = "airquay1!";

                conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPwd);
                pstmt = conn.prepareStatement("select * from 2000m where raceNum=? and bowNum=3;");
                pstmt.setString(1, "5");
                rs = pstmt.executeQuery();
                while(rs.next()){
                    %>
				id.innerHTML=500+":"+<%=rs.getString("bowNum")%>+":"+<%=rs.getString("arriveHour")%>+":"+<%=rs.getString("arriveMinute")%>+":"+<%=rs.getString("arriveSecond")%>+":"+<%=rs.getString("arriveMiliSecond")%>;
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
			}
		})
	</script>
	<div id="id"></div>
</body>
</html>
