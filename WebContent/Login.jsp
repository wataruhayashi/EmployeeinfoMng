<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String ext_err = (String)request.getAttribute("err");
if(ext_err == null){ext_err = "";}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link href="css/list.css" rel="stylesheet" type="text/css">
	<title>ログイン画面</title>
</head>

<body>
	<form method="post" action="Login">
		<h2 style="text-align:center;margin:50px;">ログイン</h2>
		<div style="text-align:center;color:red;"><%= ext_err %></div>
		<div align="center">
			<span style="font-size:20px;">社員番号</span><br /><input type="text" name="logId" style="margin-bottom:30px;width:30%;height:20px;border:1px solid #00CC00;" /><br />
			<span style="font-size:20px;">パスワード</span><br /><input type="password" name="logPass" style="margin-bottom:30px;width:30%;height:20px;border:1px solid #00CC00;"/><br />
			<input type="submit" value="ログイン" class="square_btn" />
		</div>

	</form>
</body>
</html>