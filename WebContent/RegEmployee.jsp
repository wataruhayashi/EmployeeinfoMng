<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
response.setHeader("Pragma","no-cache");
response.setHeader("Cache-Control","no-cache");
response.addHeader("Cache-Control","no-store");
response.setDateHeader("Expires", 0);
request.setCharacterEncoding("UTF-8");
String namae = (String)session.getAttribute("name");//ユーザ名
String ext_err = (String)request.getAttribute("err");//エラー表示
if(ext_err == null){ ext_err = "";}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="css/list.css" rel="stylesheet" media="all">
<title>社員登録</title>
</head>

<body>
	<header>
	<div style="text-align:left;font-size:30px;">社員情報管理システム</div>
		<form method="post" action="Logout" >
			<label style="font-size:small;float:right;">
			<span style="margin-right:10px;"><%= namae %></span>
				<input type="submit" value="ログアウト" class="square_btn">
			</label>
		</form>
		<h2 style="text-align:center;margin-left:10%;">社員登録</h2>
	</header>

<form method="post" action="Add"style="text-align:center;">
	<span style="color:red;"><%=ext_err %></span>
	<div style="font-size:20px;">
		<label>社員番号<span style="color:red;">＊</span>
			<input type="text" name="employee_id" required/  style="width:200px;height:20px;border:1px solid #00CC00;"/>
		</label>
	</div>
	<div style="font-size:20px;">
		<label>社員名<span style="color:red;">＊</span>
			<input type="text" name="employee_name" required style="width:200px;height:20px;border:1px solid #00CC00;"/>
		</label>
	</div>
	<div style="font-size:20px;">
		<label><span>所属</span><span style="color:red;">＊</span>
			<input type="text" name="department" required style="width:200px;height:20px;border:1px solid #00CC00;"/>
		</label>
	</div>
	<div style="font-size:20px;">
		<label><span>役職</span><span style="color:red;">＊</span>
			<input type="text" name="post"  style="width:200px;height:20px;border:1px solid #00CC00;"/>
		</label>
	</div>
	<div style="font-size:20px;">
		<label><span>入社日</span>
			<input type="date" name="entry_date" style="width:200px;height:20px;border:1px solid #00CC00;"/>
		</label>
	</div>
	<div style="font-size:20px;">
		<label><span>パスワード</span><span style="color:red;">＊</span>
			<input type="text" name="password" required style="width:200px;height:20px;border:1px solid #00CC00;"/>
		</label>
	</div>
	<div style="font-size:20px;">
		<label><span>管理権限</span>
			<select name="admin_level" style="width:200px;height:30px;border:1px solid #00CC00;">
			<option value="0">閲覧のみ</option>
			<option value="1">編集可</option>
			<option value="2">編集登録可</option>
			</select>
		</label>
	</div>
	<div>
		<input type="submit" value="登録"  class="square_btn"/>
	</div>
</form>
	<div style="text-align:center;">
		<a href="List"><button class="square_btn">キャンセル</button></a>
	</div>
</body>
</html>