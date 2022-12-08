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
		int maxSize = 1024 * 1024 * 100; //100MB limit
		String encoding = "UTF-8";
		
		MultipartRequest multipartRequest
		= new MultipartRequest(request, directory, maxSize, encoding,
				new DefaultFileRenamePolicy());
		
		String fileName = multipartRequest.getOriginalFileName("file");
		String fileRealName = multipartRequest.getFilesystemName("file");
		
		if( 
			!fileName.endsWith(".docx") &&
			!fileName.endsWith(".pptx") &&
			!fileName.endsWith(".hwp") && 
			!fileName.endsWith(".xls") &&
		   	!fileName.endsWith(".pdf") && 
		   	!fileName.endsWith(".jpg") &&
		   	!fileName.endsWith(".png"))
		{
			File file = new File(directory + fileRealName);
			file.delete();
			out.write("업로드할 수 없는 확장자입니다.");
		} else {
			new FileDAO().upload(fileName, fileRealName);
			out.write("파일명 : " + fileName + "<br>");
			out.write("실제 파일명 : " + fileRealName + "<br>");
		}
	%>
</body>
</html>