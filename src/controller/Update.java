package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;
@WebServlet("/Update")
public class Update extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    request.setCharacterEncoding("UTF-8");
	    Connection db = null;
	    PreparedStatement ps = null;
	    try {
		//データベースに接続
		Context context = new InitialContext();
		DataSource ds = (DataSource)context.lookup("java:comp/env/jdbc/kensyu");
		db = ds.getConnection();
		//削除ボタンクリック時
		if (request.getParameter("delete") != null) {
		      ps = db.prepareStatement("DELETE FROM tb_employee_info WHERE employee_id=?");
		      ps.setString(1, request.getParameter("employee_id"));
		//更新ボタンクリック時
		} else {
		      ps = db.prepareStatement("UPDATE tb_employee_info SET employee_name=?, department=?, post=?, entry_date=?, password=?,admin_level=? WHERE employee_id=?");
		      ps.setString(1, request.getParameter("employee_name"));
		      ps.setString(2, request.getParameter("department"));
		      ps.setString(3, request.getParameter("post"));
		      String entry_date = request.getParameter("entry_date");
			if((entry_date != null) && (entry_date != "")) {
			    Date date = Date.valueOf(entry_date);
			    ps.setDate(4, date);
			}else {
			    ps.setDate(4, null);
			}
		      ps.setString(5, request.getParameter("password"));
		      ps.setInt(6, Integer.parseInt(request.getParameter("admin_level")));
		      ps.setString(7, request.getParameter("employee_id"));
		}
		ps.executeUpdate();
	    } catch (NamingException e) {
		e.printStackTrace();
	    }catch (SQLException e1) {
		e1.printStackTrace();
	    }finally {
		try {
		    if(ps != null) {ps.close();}
		    if(db != null) {db.close();}
		}catch(SQLException e) {
		    e.printStackTrace();
		}
	    }
	    response.sendRedirect("List");
	}
}
