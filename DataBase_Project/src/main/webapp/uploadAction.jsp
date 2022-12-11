<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="file.FileDAO" %> 
<%@ page import="java.io.File" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="bbs.Bbs" %> 
<%@ page import="bbs.BbsDAO" %>     
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
		String directory = application.getRealPath("/upload/");
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
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('업로드 성공!')");
			script.println("history.back()");
			script.println("</script>");
			
		}
	%>
</body>
</html>