<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*"%> 

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
<% 	
String gallery_id=request.getParameter("inputid");
String gallery_name=request.getParameter("inputname");

%>
   
    <div id="header" style="background-color:#FFA500;">
<h1 style="margin-bottom:0;"><%out.println(gallery_name);%></h1></div>

  </head>
  <body>

<%
String funcID = request.getParameter("funcID");
String image_id = request.getParameter("image_id");
String title = request.getParameter("title");
String link = request.getParameter("link");
String artist_id = request.getParameter("artist_id");
String detail_id = request.getParameter("detail_id");
String year = request.getParameter("year");
String type = request.getParameter("type");
String width = request.getParameter("width");
String height = request.getParameter("height");
String location = request.getParameter("location");
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
<br>
<%
try {
	String url="jdbc:mysql://127.0.0.1:3306/gallery";
	String id="gallery";
	String pwd="eecs221";
	Connection con= DriverManager.getConnection(url,id,pwd); 

	Statement stmt;
	ResultSet rs1;

stmt = con.createStatement(); // Statements allow to issue SQL queries to the database
String sql="SELECT * FROM image where gallery_id = '"+gallery_id+"'";
rs1=stmt.executeQuery(sql); // Result set get the result of the SQL query
out.println("<table border=\"1\" cellpadding=\"10\">");
out.println("<tr>");
out.println("<th>Image ID</th>");
out.println("<th>Image</th>");			
out.println("<th>Title</th>");	
out.println("</tr>");
while (rs1.next()) {
	out.println("<tr>");
	out.println("<td>"+rs1.getString("image_id")+"</td>");
%>
	<td><img src="<%out.println(rs1.getString("link"));%>" widht="200"  height="200" alt="image"></td> 
	<td><a href="detail.jsp?indetailid=<%out.println(rs1.getString("detail_id"));%>&inimageid=<%out.println(rs1.getString("image_id"));%>&intitle=<%out.println(rs1.getString("title"));%>"><%out.println(rs1.getString("title"));%></a></td>      
<%		

}
rs1.close();
stmt.close();
out.println("</table>");
}
catch(Exception e)
{
	out.println(e.toString());
}
%>
<br>
<b>Add an Image:</b>
<form method="post">
    		<input name="funcID" type="hidden" value="2">
    	<br>
    	Image ID:<input name="image_id" type="text">
    	Image URL: <input name="link" type="text">
    	Title: <input name="title" type="text">
    	Artist ID: <input name="artist_id" type="text">
    	Artist Gallery: <input name="gallery_id" type="text"></br><br>
    	Detail ID: <input name="detail_id"  type="text">
 	    Year: <input name="year" type="text">
 	    Type: <input name="type" type="text">
 	    Width: <input name="width" type="text">
 	    Height: <input name="height" type="text"><br>
 	    Location: <input name="location" type="text">
  	    Description: <input name="description" type="text">	   
    	<br><input type="submit" value="Add"/></br>
    	Please reload the page after adding. 
</form>

<b>Delete an Image  </b>
<form method="post">
			<input name="funcID" type="hidden" value="3">
			Please enter the image ID: <input name="image_id" type="text">
    		<input type="submit" value="Delete"/><br>
    		Please reload the page after deleting. 
    		
</form>

<% if(funcID!=null) {				
	try {
		String url="jdbc:mysql://127.0.0.1:3306/gallery";
		String id="gallery";
		String pwd="eecs221";
		Connection con= DriverManager.getConnection(url,id,pwd); 
	
		int func=Integer.valueOf(funcID);
		PreparedStatement pstmt;
		PreparedStatement pstmt1;
		PreparedStatement pstmt2;
		PreparedStatement pstmt3;
		ResultSet rs;
		switch(func) {

		case 2:

			pstmt1 = con.prepareStatement("insert into image values (?,?,?,?,?,?)",Statement.RETURN_GENERATED_KEYS);
			pstmt1.clearParameters();
			pstmt1.setString(1, image_id);
			pstmt1.setString(2, title);
			pstmt1.setString(3, link);
			pstmt1.setString(4, gallery_id);
			pstmt1.setString(5, artist_id);
			pstmt1.setString(6, detail_id);
			pstmt1.executeUpdate();

			pstmt2 = con.prepareStatement("insert into detail values (?,?,?,?,?,?,?,?)");
			pstmt2.clearParameters();
			pstmt2.setString(1, detail_id);			
			pstmt2.setString(2, image_id);
			pstmt2.setString(3, year);
			pstmt2.setString(4, type);
			pstmt2.setString(5, width);
			pstmt2.setString(6, height);
			pstmt2.setString(7, location);
			pstmt2.setString(8, description);
			pstmt2.executeUpdate();

			out.println("Successfully added.");
			pstmt2.close();
			break;

			
		case 3:
			// PreparedStatements can use variables and are more efficient
			pstmt = con.prepareStatement("delete from image  where image_id = '"+image_id+"'");

			pstmt.clearParameters();
	
			out.println("Successfully delete");
			
			pstmt.executeUpdate();
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
