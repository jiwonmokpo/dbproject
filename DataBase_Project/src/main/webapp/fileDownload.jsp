<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="file.FileDAO" %> 
<%@ page import="java.io.File" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>   
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="content-Type" content="text/html; charset=UTF-8">
<meta name="veiwport" content = "width=device-width" initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<title>MNU Town</title>
</head>
<body>
	<% 
		String directory = "C:/dbupload";
		String files[] = new File(directory).list();
		
		for(String file : files) {
			out.write("<a href=\"" + request.getContextPath() + "/downloadAction?file=" +
				java.net.URLEncoder.encode(file, "UTF-8") + "\">" + file + "</a><br>");
			
		}
	%>

</body>
</html>