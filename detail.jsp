<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*"%> 

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
<% 	
String detail_id=request.getParameter("indetailid");
String image_id = request.getParameter("inimageid");
String title=request.getParameter("intitle");

%>
   
    <div id="header" style="background-color:#FFA500;">
<h1 style="margin-bottom:0;"><%out.println(title);%></h1></div>

  </head>
  <body>

<%
String name = request.getParameter("name");

String funcID = request.getParameter("funcID");
String link = request.getParameter("link");
String artist_id = request.getParameter("artist_id");
String year = request.getParameter("year");
String type = request.getParameter("type");
String width = request.getParameter("width");
String height = request.getParameter("height");
String location = request.getParameter("location");
String description = request.getParameter("description");
 

%>





<% 				
	try {
		String url="jdbc:mysql://127.0.0.1:3306/gallery";
		String id="gallery";
		String pwd="eecs221";
		Connection con= DriverManager.getConnection(url,id,pwd); 
	
		Statement stmt;
		PreparedStatement pstmt;
		ResultSet rs;

		stmt = con.createStatement(); // Statements allow to issue SQL queries to the database
		String sql="SELECT * FROM image,detail,artist where image.image_id = '"+image_id+"' and detail.image_id = '"+image_id+"' and artist.artist_id = image.artist_id ";
		rs=stmt.executeQuery(sql); // Result set get the result of the SQL query
		out.println("<table border=\"1\" cellpadding=\"10\">");
		out.println("<tr>");
		out.println("<th>Image ID</th>");
		out.println("<th>Image</th>");	
		out.println("<th>Artist Name</th>");	
		out.println("<th>Year</th>");	
		out.println("<th>Type</th>");	
		out.println("<th>Width</th>");	
		out.println("<th>Height</th>");	
		out.println("<th>Location</th>");	
		out.println("<th>Description</th>");	
		out.println("</tr>");

		while (rs.next()) {
			out.println("<tr>");
			out.println("<td>"+rs.getString("image_id")+"</td>");
%>
			<td><img src="<%out.println(rs.getString("link"));%>" widht="200"  height="200" alt="image"></td> 
			<td><a href="artist.jsp?inputid=<%out.println(rs.getString("artist_id"));%>&inputname=<%out.println(rs.getString("name"));%>"><%out.println(rs.getString("name"));%></a></td>      
			
<%
		out.println("<td>"+rs.getString("year")+"</td>");
		out.println("<td>"+rs.getString("type")+"</td>");
		out.println("<td>"+rs.getString("width")+"</td>");
		out.println("<td>"+rs.getString("height")+"</td>");
		out.println("<td>"+rs.getString("location")+"</td>");
		out.println("<td>"+rs.getString("description")+"</td>");

}
		rs.close();
		stmt.close();
		out.println("</table>");


		con.close();
	}
	catch(Exception e)
	{
			out.println(e.toString());
	} 	
	
%>






  
  </body>
</html>
