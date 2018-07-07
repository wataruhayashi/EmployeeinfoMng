<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*, javax.naming.*,javax.sql.*,util.Common"%>
<%
//キャッシュ削除
response.setHeader("Pragma", "no-cache");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Cache-Control", "no-store");
response.setDateHeader("Expires", 0);
if(session.getAttribute("id") == null) {
	request.setAttribute("err", Common.BackErr);
	//Login.jspにリクエストとレスポンスをフォワード
	getServletContext().getRequestDispatcher("/Login.jsp").forward(request,response);
}
//ユーザ名
String yuza = (String)session.getAttribute("name");
//エラー表示
String err =(String)request.getAttribute("err");
if(err == null){err = "";}
String NulId =(String)request.getAttribute("NulId");
if(NulId == null){NulId = "";}
String NulName =(String)request.getAttribute("NulName");
if(NulName == null){NulName = "";}
String NulDep =(String)request.getAttribute("NulDep");
if(NulDep == null){NulDep = "";}
String NulPass =(String)request.getAttribute("NulPass");
if(NulPass == null){NulPass = "";}
String IdmissMatch =(String)request.getAttribute("IdmissMatch");
if(IdmissMatch == null){IdmissMatch = "";}
String NamemissMatch =(String)request.getAttribute("NamemissMatch");
if(NamemissMatch == null){NamemissMatch = "";}
//登録履歴表示
String employee_id = request.getParameter("employee_id");
if(employee_id == null || !Common.IdMatch(employee_id)){employee_id = "";}
String employee_name = request.getParameter("employee_name");
if(employee_name == null || !Common.NameMatch(employee_name)){employee_name = "";}
String department = request.getParameter("department");
if(department == null){department = "";}
String post = request.getParameter("post");
if(post == null){post = "";}
String entry_date = request.getParameter("entry_date");
if(entry_date == null){entry_date = "";}
String password = request.getParameter("password");
if(password == null){password = "";}
String oz = request.getParameter("admin_level");
if(oz == null){ oz = "0"; }
Integer admin_level = Integer.parseInt(oz);
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<!-- <link rel="stylesheet" type="text/css" href="css2/add.css" /> -->
	<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
	<link href="https://use.fontawesome.com/releases/v5.0.6/css/all.css" rel="stylesheet">
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js" integrity="sha384-smHYKdLADwkXOn1EmN1qk/HfnUcbVRZyYmZ4qpPea6sjB/pTJ0euyQp0Mk8ck+5T" crossorigin="anonymous"></script>
	<title>社員登録</title>
</head>

<body>
	<form method="post" action="Logout">
		<h1><a href="Menu.jsp">社員情報管理システム</a></h1>
		<div>
			ログインユーザー氏名：<span><%= yuza %></span>
			<input type="submit" value="ログアウト">
		</div>
		<h2>社員登録</h2>
	</form>

	<form method="post" action="Add">
		<div><%= err %></div>
		<div><%= IdmissMatch %></div>
		<div><%= NamemissMatch %></div>
		<div><%= NulId %></div>
		<div><%= NulName %></div>
		<div><%= NulDep %></div>
		<div><%= NulPass %></div>

		<%
		//tb_departmentテーブルに接続
		request.setCharacterEncoding("UTF-8");
		Context context = new InitialContext();
		DataSource ds = (DataSource)context.lookup("java:comp/env/jdbc/kensyu");
		Connection db = ds.getConnection();
		PreparedStatement ps = db.prepareStatement("SELECT department FROM tb_department");
		ResultSet rs = ps.executeQuery();
		%>

		<div>
			<label>社員番号<span>＊</span>
				<input type="text" name="employee_id" value="<%= employee_id %>"maxlength=5/>
			</label>
		</div>

		<div>
			<label>社員氏名<span>＊</span>
				<input type="text" name="employee_name" value="<%= employee_name %>" maxlength=20/>
			</label>
		</div>

		<div>
			<label>所属<span>＊</span>
				<select name="department">
				<% while(rs.next()) { //全データを表示 %>
				<option value="<%= rs.getString("department") %>">
				<%= rs.getString("department") %>
				</option>
				<% }
					rs.close();
					ps.close();
					db.close();
				%>
			</select>
			</label>
		</div>

		<div>
			<label>役職
				<input type="text" name="post" value="<%= post %>"/>
			</label>
		</div>

		<div>
			<label>入社日
				<input type="date" name="entry_date" value="<%= entry_date %>"/>
			</label>
		</div>

		<div>
			<label>パスワード<span>＊</span>
				<input type="password" name="password" value="<%= password %>"/>
			</label>
		</div>


		<div>
			<label>管理権限
				<select name="admin_level">
				<option value="<%= Common.AUTH_GENE %>" <% if(admin_level == Common.AUTH_GENE){ %> selected <% } %>>閲覧のみ</option>
				<option value="<%= Common.AUTH_MANE %>" <% if(admin_level == Common.AUTH_MANE){ %> selected <% } %>>登録編集可</option>
				</select>
			</label>
		</div>

		<div>
			<input type="submit" value="登 録"/>
		</div>

	</form>

	<div>
		<a href="List"><button>キャンセル</button></a>
	</div>

</body>
