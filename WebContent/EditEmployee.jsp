<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*, java.sql.*, javax.naming.*, javax.sql.*"%>

<%
response.setHeader("Pragma","no-cache");
response.setHeader("Cache-Control","no-cache");
response.addHeader("Cache-Control","no-store");
response.setDateHeader("Expires", 0);
request.setCharacterEncoding("UTF-8");
String id = (String)session.getAttribute("id");
String namae = (String)session.getAttribute("name");//ユーザ名
Context context = new InitialContext();//データベース接続
DataSource ds = (DataSource)context.lookup("java:comp/env/jdbc/kensyu");
Connection db = ds.getConnection();
PreparedStatement ps = db.prepareStatement("SELECT * FROM tb_employee_info WHERE employee_id=?");
ps.setString(1, request.getParameter("employee_id"));
ResultSet rs = ps.executeQuery();
if(rs.next()){
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link href="css/list.css" rel="stylesheet" media="all">
	<title>社員変更</title>
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
		<h2 style="text-align:center;margin-left:10%;">社員変更</h2>
	</header>
	<form method="post" action="Update" style="text-align:center;font-size:20px;">
		<div>
			<label>社員番号<span style="color:red; margin-right:10px;">＊</span>
				<input type="text" name="employee_id" value="<%=rs.getString("employee_id")%>" style="background-color:gray;width:200px;height:20px;border:1px solid #00CC00;" readonly/>
			</label>
		</div>
		<div>
			<label>社員名<span style="color:red; margin-right:10px;">＊</span>
				<input type="text" name="employee_name" value="<%=rs.getString("employee_name")%>" style="width:200px;height:20px;border:1px solid #00CC00;" required/>
			</label>
		</div>
		<div>
			<label>所属<span style="color:red; margin-right:10px;">＊</span>
				<input type="text" name="department" value="<%=rs.getString("department")%>"  style="width:200px;height:20px;border:1px solid #00CC00;" required/>
			</label>
		</div>
		<div>
			<label>役職
				<input type="text" name="post" value="<%=rs.getString("post")%>" style="width:200px;height:20px;border:1px solid #00CC00;"/>
			</label>
		</div>
		<div>
			<label>入社日
				<input type="date" name="entry_date" value="<%=rs.getString("entry_date")%>" style="width:200px;height:20px;border:1px solid #00CC00;"/>
			</label>
		</div>
		<div>
			<label>パスワード<span style="color:red; margin-right:10px;">＊</span>
				<input type="text" name="password" value="<%=rs.getString("password")%>"  style="width:200px;height:20px;border:1px solid #00CC00;" required/>
			</label>
		</div>
		<div>
			<label>管理権限
				<select name="admin_level"  style="width:200px;height:30px;border:1px solid #00CC00;">
				<option value="<%=rs.getInt("admin_level")%>"<%if(rs.getInt("admin_level") == 0){%>selected<% }%>>閲覧のみ</option>
				<option value="<%=rs.getInt("admin_level")%>"<%if(rs.getInt("admin_level") == 2){%>selected<% }%>>編集登録可</option>
				</select>
			</label>
		</div>
		<div>
				<input type="submit" name="update" value="更新" class="square_btn"/>
				<%if(!(id.equals(rs.getString("employee_id")))){ %>
					<input type="submit" name="delete" value="削除" class="square_btn"
						onclick="return confirm('本当に削除しても良いですか？')" />
				<%} %>
		</div>
	</form>
	<div style="text-align:center;">
		<a href="List"><button class="square_btn">キャンセル</button></a>
	</div>
</body>
</html>

<% }else { out.println("該当データなし");} %>