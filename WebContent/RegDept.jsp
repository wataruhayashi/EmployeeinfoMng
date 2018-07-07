<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="util.Common"%>
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
//登録履歴表示
String busyo = request.getParameter("department");
if(busyo == null || !Common.NameMatch("busyo")){ busyo = ""; }

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

	<title>部署登録</title>
</head>
<body>
	<header class="bg-info p-4 mb-5 clearfix text-light">
		<div class="float-left">
			<h5><a href="Menu.jsp" class="nav-link text-light">社員情報管理システム</a></h5>
		</div>

		<div class="float-right">
			<form method="post" action="Logout">
				<label class="navbar-brand"><i class="far fa-user mr-1"></i><%=yuza%></label>
				<i class="fas fa-sign-out-alt"></i><input type="submit" value="ログアウト" class="btn btn-info">
			</form>
		</div>
	</header>


	<main class="w-50 mr-auto ml-auto sukima">
		<div class="mt-5 mb-5">
			<h4 class="bdr">部署登録</h4>
		</div>
		<div>
			<form method="post" action="AddDept">
				<!-------------------------エラー表示---------------------->

				<% String err = (String)request.getAttribute("err"); %>
				<% if(err != null) { %>
					<label class="alert alert-danger form-control text-center" role="alert">
						<%= err %>
						<button type="button" class="close" data-dismiss="alert" aria-label="Close">
							<span aria-hidden="true">&times;</span>
	  					</button>
					</label>
				<% } %>

				<div class="form-group row">
					<label class="col-2 col-form-label text-center">部署名</label>
					<div class="col-8">
						<input type="text" name="department" value="<%= busyo %>"class="form-control">
					</div>
				</div>

				<div class="form-group row">
					<div class="col-4"></div>
					<div class="col-3">
						<input type="submit" value="登録" class="btn btn-primary btn-block" onclick="return confirm('登録を行いますが、よろしいですか？')" />
					</div>

					<div class="col-3">
						<a href="Menu.jsp"><input type="button" class="btn btn-light btn-block" value="キャンセル"></a>
					</div>
				</div>
			</form>
		</div>

	</main>
</body>
</html>