<%@ page contentType="text/html; charset=UTF-8" %>
<%
response.setHeader("Pragma","no-cache");
response.setHeader("Cache-Control","no-cache");
response.addHeader("Cache-Control","no-store");
response.setDateHeader("Expires", 0);
request.setCharacterEncoding("UTF-8");
String namae = (String)session.getAttribute("name");//ユーザー名
Integer hyoji= (Integer)session.getAttribute("hyoji");//編集権限
//検索クエリ
String id = (String)request.getParameter("employee_id");//入力された社員番号
String name = (String)request.getParameter("employee_name");//入力された社員名
String dep = (String)request.getParameter("department");//入力された所属
if(id == null){id = "";}
if(name == null){name = "";}
if(dep == null){dep = "";}
%>
<jsp:useBean id="list" class="java.util.ArrayList" scope="request" />

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8" />
	<link href="css/list.css" rel="stylesheet" type="text/css">
	<title>社員一覧</title>
</head>

<body>
	<header>
	<div style="text-align:left;font-size:30px;">社員情報管理システム</div>
		<form method="post" action="Logout" >
			<label style="font-size:small;float:right;margin:10px;">
			<span style="margin-right:10px;"><%= namae %></span>
				<input type="submit" value="ログアウト" class="square_btn">
			</label>
		</form>
		<h2 style="text-align:center;margin-left:10%;">社員一覧</h2>
	</header>

	<form method="post" action="Query">
		<div style="border:1px solid #00CC00;padding:5px;margin:0 25%;">
			<label>
				<span style="font-size:20px;">社員番号</span><input type="text" name="employee_id" value="<%= id %>" style="margin: 5px 30px;width:200px;height:20px;border:1px solid #00CC00;">
				<span style="font-size:20px;">社員名</span><input type="text" name="employee_name" size="30" value="<%= name %>" style="margin: 5px 30px;width:200px;height:20px;border:1px solid #00CC00;"><br/>
				 <span style="font-size:20px;margin-right:10px;">所属</span><input type="text" name="department" value="<%= dep %>" style="margin: 5px 60px;width:400px;height:20px;border:1px solid #00CC00;">
				<input type="submit" value="検索" class="square_btn">
			</label>
		</div>
	</form>
	<div style="padding-left:180px;margin:20px;">
		<%if(hyoji == null){ %>
			<form method="post" action="RegEmployee.jsp">
				<input type="submit" value="新規登録" class="square_btn" style="margin:10px;">
			</form>
		<%} %>

		<table style="width:1024px;background-color:#E0FFFF;border: 2px solid white;text-align:center;">
			<tr style="background-color:#008BBB;height:50px;font-size:20px;">
				<th>社員番号</th><th>社員名</th><th>所属</th><th>役職</th><th>入社日</th>
				<% if(hyoji == null){ %>
					<th></th>
				<%} %>
			</tr>
			<% for(Object item : list) {
			beans.Tb_employee_info info = (beans.Tb_employee_info)item;
			%>
			<tr style="height:50px;font-size:20px;">
				<td><%=info.getEmployee_id() %></td>
				<td><%=info.getEmployee_name() %></td>
				<td><%=info.getDepartment() %></td>
				<td><%=info.getPost() %></td>
					<%String nullDate = "-";
					  if(info.getEntry_date() == null){ %>
						<td><%=nullDate %></td>
					<%}else{ %>
						<td><%=info.getEntry_date() %></td>
					<% } %>
					<%if(hyoji == null){ %>
						<td><a href="EditEmployee.jsp?employee_id=<%=info.getEmployee_id()%>"><button class="square_btn">編集</button></a></td>
					<%} %>
			</tr>
			<% } %>
		</table>
	</div>
</body>
</html>
