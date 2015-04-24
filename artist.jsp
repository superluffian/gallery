<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*"%> 

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
 <%  
  	String name = request.getParameter("inputname");
  	String artist_id = request.getParameter("inputid");
 %>   	
  				<div id="header" style="background-color:#FFA500;">
				<h1 style="margin-bottom:0;"><%out.println(name);%></h1></div>  
 

  </head>
  <body>
<% 	
	String funcID = request.getParameter("funcID");
	String birth_year = request.getParameter("birth_year");
	String country = request.getParameter("country");
	String description = request.getParameter("description");


%>
<%
	try {
		Class.forName("com.mysql.jdbc.Driver").newInstance();
	}
	catch(Exception e)
	{
		out.println("can't load mysql driver");
		out.println(e.toString());
	}
%>

  	

<b>Modify  details:</b>
<form method="post">
    		<input name="funcID" type="hidden" value=1>
    	Birth Year: <input name="birth_year" type="text">
    	Country: <input name="country" type="text">
    	Description: <input name="description" type="text">
    	<input type="submit" value="Submit"/>
    	<br>Please reload the page after submitting.
    	
</form>
<%
try {
		String url="jdbc:mysql://127.0.0.1:3306/gallery";
		String id="gallery";
		String pwd="eecs221";
		Connection con= DriverManager.getConnection(url,id,pwd); 
	
		Statement stmt;
		ResultSet rs;

				stmt = con.createStatement(); // Statements allow to issue SQL queries to the database
				String sql="SELECT * FROM artist where artist_id = '"+artist_id+"'";
				rs=stmt.executeQuery(sql); // Result set get the result of the SQL query
				out.println("<table border=\"1\">");
				out.println("<tr>");
				out.println("<th>ArtistID</th>");
				out.println("<th>Name</th>");
				out.println("<th>Birth Year</th>");
				out.println("<th>Country</th>");
				out.println("<th>Description</th>");
				out.println("</tr>");
				while (rs.next()) {
					out.println("<tr>");
					out.println("<td>"+rs.getString("artist_id")+"</td>");
					out.println("<td>"+rs.getString("name")+"</td>");
					out.println("<td>"+rs.getString("birth_year")+"</td>");
					out.println("<td>"+rs.getString("country")+"</td>");
					out.println("<td>"+rs.getString("description")+"</td>");
					out.println("</tr>");
				}
				rs.close();
				stmt.close();
				out.println("</table>");
}
catch(Exception e)
	{
			out.println(e.toString());
	} 
%>

<% if(funcID!=null) {				
	try {	
		String url="jdbc:mysql://127.0.0.1:3306/gallery";
		String id="gallery";
		String pwd="eecs221";
		Connection con= DriverManager.getConnection(url,id,pwd); 
	int func=Integer.valueOf(funcID);
	PreparedStatement pstmt;
	ResultSet rs2;		
	switch(func) {
			case 1:
				// PreparedStatements can use variables and are more efficient
				pstmt = con.prepareStatement("update artist set birth_year = ?, country = ? , description = ? where artist_id = ?");
				// Use ? to represent the variables
				pstmt.clearParameters();
				// Parameters start with 1	
				pstmt.setString(1, birth_year);
				pstmt.setString(2, country);
				pstmt.setString(3, description);
				pstmt.setString(4, artist_id);
				out.println("Successfully modified");
				
				pstmt.executeUpdate();
				rs2=pstmt.getGeneratedKeys();
				rs2.close();
				pstmt.close();
				break;
		}
		con.close();
	}
	catch(Exception e)
	{
			out.println(e.toString());
	} 	
	
} %>


  
  </body>
</html>
