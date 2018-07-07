<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<!-- <link rel="stylesheet" type="text/css" href="css2/log.css"> -->
	<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
	<!-- <script type="text/javascript" src="js/bootstrap.min.js"></script> -->
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js" integrity="sha384-smHYKdLADwkXOn1EmN1qk/HfnUcbVRZyYmZ4qpPea6sjB/pTJ0euyQp0Mk8ck+5T" crossorigin="anonymous"></script>

	<title>ログイン画面</title>
</head>

<body>
	<header class="bg-info p-4 mb-5">
		<div>
			<h5>社員情報管理システム</h5>
		</div>
	</header>

	<form method="post" action="Login" class="form-control bg-light w-50 m-auto">

		<% String err = (String)request.getAttribute("err"); %>
		<% if(err != null) { %>
			<div class="alert alert-danger  alert-dismissible fade show text-center" role="alert">
			<%= err %>
			<button type="button" class="close" data-dismiss="alert" aria-label="Close">
    		<span aria-hidden="true">&times;</span>
  			</button>
			</div>
		<% } %>
		<div class="form-group">
			<label>社員番号</label>
			<input type="text" name="loginId" class="form-control">
		</div>

		<div class="form-group">
			<label>パスワード</label>
			<input type="password" name="loginPass" class="form-control">
		</div>

		<div>
		   <input type="submit" value="ログイン" class="form-control bg-info">
		</div>
	</form>
</body>
</html>