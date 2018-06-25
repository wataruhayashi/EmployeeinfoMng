package controller;

import java.io.IOException;
import java.sql.Connection;
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
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;


@WebServlet("/Login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public Login() {
        super();
    }
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    	Connection db = null;
		PreparedStatement ps =null;
		ResultSet rs = null;
		String id = request.getParameter("logId");
		String pass = request.getParameter("logPass");
		try {
		    	//データベース接続
			Context context = new InitialContext();
			DataSource ds = (DataSource)context.lookup("java:comp/env/jdbc/kensyu");
			db = ds.getConnection();
			//入力された項目がデータベースにあるか検索
			String sql = "SELECT * FROM tb_employee_info WHERE employee_id='"+id+"' AND password='"+pass+"';";
			ps = db.prepareStatement(sql);
			rs = ps.executeQuery();
			HttpSession session = request.getSession();
			if(session != null) {session.invalidate();}

			//未入力項目エラー表示
			if((id == "") || (pass == "")) {
			    request.setAttribute("err", "未入力項目があります。");
			    getServletContext().getRequestDispatcher("/Login.jsp").forward(request, response);
			}
			//データベースにあった場合
			if(rs.next()) {
			    HttpSession newSession = request.getSession(true);
			    if(rs.getInt("admin_level") == 0) {newSession.setAttribute("hyoji", 0);}
			    newSession.setAttribute("id",rs.getString("employee_id"));
			    newSession.setAttribute("name", rs.getString("employee_name"));
			    response.sendRedirect("List");
			    //なかった場合
			}else {
			    request.setAttribute("err", "社員番号かパスワードに誤りがあります。");
			    getServletContext().getRequestDispatcher("/Login.jsp").forward(request, response);
			}

		} catch (NamingException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) { rs.close(); }
				if(ps != null) { ps.close(); }
				if(db != null) { db.close(); }
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

}
