package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
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
@WebServlet("/Add")
public class Add extends HttpServlet {
	private static final long serialVersionUID = 1L;


	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    request.setCharacterEncoding("UTF-8");

		Connection db = null;
		PreparedStatement ps =null;
		PreparedStatement ps2 = null;
		ResultSet rs = null;
		try {
		    	//データベース接続
			Context context = new InitialContext();
			DataSource ds = (DataSource)context.lookup("java:comp/env/jdbc/kensyu");
			db = ds.getConnection();
			String sql = "SELECT employee_id FROM tb_employee_info WHERE employee_id='" + request.getParameter("employee_id") + "';";
			System.out.println(sql);
			ps2 = db.prepareStatement(sql);
			rs = ps2.executeQuery();
			boolean flg = rs.next();
			//社員番号重複エラー表示
			if(flg) {
			    	request.setAttribute("err", "この社員番号は登録済みです。");
			    	getServletContext().getRequestDispatcher("/RegEmployee.jsp").forward(request, response);
			}else {
        			//データベースにインサート
        			ps = db.prepareStatement("INSERT INTO tb_employee_info(employee_id, employee_name, department, post, entry_date, password, admin_level) VALUES(? ,? ,? ,? ,? ,? ,?)");
        			ps.setString(1, request.getParameter("employee_id"));
        			ps.setString(2, request.getParameter("employee_name"));
        			ps.setString(3, request.getParameter("department"));
        			ps.setString(4, request.getParameter("post"));
        			String entry_date = request.getParameter("entry_date");
        			if((entry_date != null) && (entry_date != "")) {
        			    Date date = Date.valueOf(entry_date);
        			    ps.setDate(5, date);
        			}else {
        			    ps.setDate(5, null);
        			}
        			ps.setString(6, request.getParameter("password"));
        			ps.setInt(7, Integer.parseInt(request.getParameter("admin_level")));
        			ps.executeUpdate();
			}
		} catch (NamingException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(ps!=null) { ps.close(); }
				if(db!=null) { db.close(); }
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		response.sendRedirect("List");
	}

}
