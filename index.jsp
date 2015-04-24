<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*"%> 

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
    
    <title>CQQ Gallery</title>
    
	
  </head>
  <body>
<% 	
	String funcID = request.getParameter("funcID");

	String name = request.getParameter("name");
	String description = request.getParameter("description");
	String image = request.getParameter("image");

	String gallery_id = request.getParameter("gallery_id");
	
	String artist_id = request.getParameter("artist_id");
	String birth_year = request.getParameter("birth_year");
	String country = request.getParameter("country");

	String link = request.getParameter("link");
	String year = request.getParameter("year");
	String type = request.getParameter("type");
	String width = request.getParameter("width");
	String height = request.getParameter("height");
	String location = request.getParameter("location");
	
	String detail_id=request.getParameter("detail_id");
	String image_id = request.getParameter("image_id");
	String title = request.getParameter("title");
	String image_count = request.getParameter("image_count");



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

<div id="header" style="background-color:#FFA500;">
<h1 style="margin-bottom:0;">Galleries</h1></div>

<% 
try {
String url="jdbc:mysql://127.0.0.1:3306/gallery";
String id="gallery";
String pwd="eecs221";
Connection con= DriverManager.getConnection(url,id,pwd); 

Statement stmt1;
ResultSet rs1;

stmt1 = con.createStatement(); // Statements allow to issue SQL queries to the database
String sql="SELECT gallery.gallery_id,gallery.name,gallery.description,gallery.image,count(image.image_id) as image_count FROM gallery, image where image.gallery_id = gallery.gallery_id group by image.gallery_id";
rs1=stmt1.executeQuery(sql); // Result set get the result of the SQL query
out.println("<table border=\"1\" cellpadding=\"10\">");
out.println("<caption> <b>Gallery List</b> </caption>");
out.println("<tr>");
out.println("<th>Gallery ID</th>");
out.println("<th>Name</th>");
out.println("<th>Description</th>");
out.println("<th>Bumber of images</th>");
out.println("<th>Photo</th>");
out.println("</tr>");
while (rs1.next()) {
	out.println("<tr>");
	out.println("<td>"+rs1.getString("gallery_id")+"</td>");
%>
<td><a href="gallery.jsp?inputid=<%out.println(rs1.getString("gallery_id"));%>&inputname=<%out.println(rs1.getString("name"));%>"><%out.println(rs1.getString("name"));%></a></td>
<%out.println("<td>"+rs1.getString("description")+"</td>");%>
<%out.println("<td>"+rs1.getString("image_count")+"</td>");%>
<td><img src="<%out.println(rs1.getString("image"));%>" widht="200"  height="200" alt="<%out.println(rs1.getString("name"));%>"></td>
<%			}
rs1.close();
stmt1.close();
out.println("</table>");

}
catch(Exception e)
{
	out.println(e.toString());
}
%>


<b>Add a new gallery:</b>
<form method="post">
    		<input name="funcID" type="hidden" value="2">
    	Name: <input name="name" type="text">
    	Description: <input name="description" type="text">
    	Photo URL: <input name="image" type="text">
    	    		<input type="submit" value="Add"/>
<br>Please reload the page after adding.
    	
</form>

<b>Add a new artist:</b>
<form method="post">
    		<input name="funcID" type="hidden" value="10">
    	Name: <input name="name" type="text">
    	Birth Year: <input name="birth_year" type="text">
    	Country: <input name="country" type="text">
    	Description: <input name="description" type="text">
    	    		<input type="submit" value="Add"/>
<br>Please reload the page after adding.
    	
</form>

<b>Modify a gallery:</b>
<form method="post">
    		<input name="funcID" type="hidden" value="3">
    	Please enter the gallery ID: <input name="gallery_id" type="text">
    	New Name: <input name="name" type="text">
    	New Description: <input name="description" type="text">
    	    		<input type="submit" value="Submit"/>
<br>Please reload the page after submitting.    	
</form>

<b>Search for an image:</b>
<form method="post">
    		<input name="funcID" type="hidden" value="4">
    	Please enter the image type: <input name="type" type="text">
    	    		<input type="submit" value="Searh By Type"/>
    	
</form>

<form method="post">
    		<input name="funcID" type="hidden" value="5">
    	Please enter the create year: <input name="year" type="text">
    	    		<input type="submit" value="Searh By Create Year"/>
    	
</form>

<form method="post">
    		<input name="funcID" type="hidden" value="7">
    	Please enter the location: <input name="location" type="text">
    	    		<input type="submit" value="Searh By Location"/>
    	
</form>

<form method="post">
    		<input name="funcID" type="hidden" value="6">
    	Please enter the artist name: <input name="name" type="text">
    	    		<input type="submit" value="Searh By artist name"/>
    	
</form>

<b>Search for an artist:</b>
<form method="post">
    		<input name="funcID" type="hidden" value="8">
    	Please enter the country: <input name="country" type="text">
    	    		<input type="submit" value="Searh By Country"/>
    	
</form>
<form method="post">
    		<input name="funcID" type="hidden" value="9">
    	Please enter the birth year: <input name="birth_year" type="text">
    	    		<input type="submit" value="Searh By Birth year"/>
    	
</form>




<% if(funcID!=null) {				
	try {
		String url="jdbc:mysql://127.0.0.1:3306/gallery";
		String id="gallery";
		String pwd="eecs221";
		Connection con= DriverManager.getConnection(url,id,pwd); 
	
		int func=Integer.valueOf(funcID);
		Statement stmt;
		PreparedStatement pstmt;
		ResultSet rs;
		switch(func) {
			
		case 2:
			// PreparedStatements can use variables and are more efficient
			pstmt = con.prepareStatement("insert into gallery values (default,?,?,?)",Statement.RETURN_GENERATED_KEYS);
			// Use ? to represent the variables
			pstmt.clearParameters();
			// Parameters start with 1	
			pstmt.setString(1, name);
			pstmt.setString(2, description);
			pstmt.setString(3, image);
			pstmt.executeUpdate();
			rs=pstmt.getGeneratedKeys();
			while (rs.next()) {
				out.println("Successfully added. Gallery ID:"+rs.getInt(1));
			}
			rs.close();
			pstmt.close();
			break;
			
		case 3:
			// PreparedStatements can use variables and are more efficient
			pstmt = con.prepareStatement("update gallery set name = ?, description = ?  where gallery_id = ?");
			// Use ? to represent the variables
			pstmt.clearParameters();
			// Parameters start with 1	
			pstmt.setString(1, name);
			pstmt.setString(2, description);
			pstmt.setString(3, gallery_id);
			out.println("Successfully modified");
			
			pstmt.executeUpdate();
			rs=pstmt.getGeneratedKeys();
			rs.close();
			pstmt.close();
			break;

		case 4:
		stmt = con.createStatement(); // Statements allow to issue SQL queries to the database
		String sql2="SELECT * FROM image,detail,artist where detail.type = '"+type+"' and image.image_id = detail.image_id and artist.artist_id = image.artist_id ";

		rs=stmt.executeQuery(sql2); // Result set get the result of the SQL query
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
		break;
		
		
		case 5:
		stmt = con.createStatement(); // Statements allow to issue SQL queries to the database
		String sql3="SELECT * FROM image,detail,artist where detail.year = '"+year+"' and image.image_id = detail.image_id and artist.artist_id = image.artist_id ";

		rs=stmt.executeQuery(sql3); // Result set get the result of the SQL query
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
		break;
		
		case 6:
		stmt = con.createStatement(); // Statements allow to issue SQL queries to the database
		String sql4="SELECT * FROM image,detail,artist where artist.name = '"+name+"' and image.image_id = detail.image_id and artist.artist_id = image.artist_id ";

		rs=stmt.executeQuery(sql4); // Result set get the result of the SQL query
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
		break;
		
		case 7:
		stmt = con.createStatement(); // Statements allow to issue SQL queries to the database
		String sql5="SELECT * FROM image,detail,artist where detail.location = '"+location+"' and image.image_id = detail.image_id and artist.artist_id = image.artist_id ";

		rs=stmt.executeQuery(sql5); // Result set get the result of the SQL query
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
		break;
		
		case 8:
		stmt = con.createStatement(); // Statements allow to issue SQL queries to the database
		String sql6="SELECT * FROM artist where country = '"+country+"'";
		rs=stmt.executeQuery(sql6); // Result set get the result of the SQL query
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
		break;
		
		case 9:
		stmt = con.createStatement(); // Statements allow to issue SQL queries to the database
		String sql7="SELECT * FROM artist where birth_year = '"+birth_year+"'";
		rs=stmt.executeQuery(sql7); // Result set get the result of the SQL query
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
		break;
		
			
	case 10:
		// PreparedStatements can use variables and are more efficient
		pstmt = con.prepareStatement("insert into artist values (default,?,?,?,?)",Statement.RETURN_GENERATED_KEYS);
		// Use ? to represent the variables
		pstmt.clearParameters();
		// Parameters start with 1	
		pstmt.setString(1, name);
		pstmt.setString(2, birth_year);
		pstmt.setString(3, country);
		pstmt.setString(4, description);
		pstmt.executeUpdate();
		rs=pstmt.getGeneratedKeys();
		while (rs.next()) {
			out.println("Successfully added. Aritist ID:"+rs.getInt(1));
		}
		rs.close();
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
