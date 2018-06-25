package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

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

import beans.Tb_employee_info;
@WebServlet("/List")
public class List extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public List() {
        super();
    }

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    	//ブラウザ戻るボタン押した時の処理
	    	HttpSession session = request.getSession(false);
	    	if(session.getAttribute("id") == null) {
	    	getServletContext().getRequestDispatcher("/Login.jsp").forward(request, response);
	    	}

	    	//ビーンズの配列を作成
	    	ArrayList<Tb_employee_info> list = new ArrayList<>();

	    	Connection db = null;
		PreparedStatement ps =null;
		ResultSet rs = null;
		try {
		    	//データベース接続
			Context context = new InitialContext();
			DataSource ds = (DataSource)context.lookup("java:comp/env/jdbc/kensyu");
			db = ds.getConnection();
			ps = db.prepareStatement("SELECT * FROM tb_employee_info ORDER BY employee_id");
			rs = ps.executeQuery();
			//データベースから全データを抽出
			while(rs.next()) {
				Tb_employee_info info = new Tb_employee_info();
				info.setEmployee_id(rs.getString("employee_id"));
				info.setEmployee_name(rs.getString("employee_name"));
				info.setDepartment(rs.getString("department"));
				info.setPost(rs.getString("post"));
				info.setEntry_date(rs.getDate("entry_Date"));
				info.setPassword(rs.getString("password"));
				info.setAdmin_level(rs.getInt("admin_level"));
				list.add(info);
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
		request.setAttribute("list", list);
		getServletContext().getRequestDispatcher("/EmployeeinfoList.jsp").forward(request, response);
	}

}
