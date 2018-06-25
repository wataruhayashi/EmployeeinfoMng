package beans;
import java.io.Serializable;
import java.sql.Date;

public class Tb_employee_info implements Serializable{
    	//各プライベートインスタンス変数
    	private String employee_id;
    	private String employee_name;
    	private String department;
    	private String post;
    	private Date entry_date;
    	private String password;
    	private int admin_level;

    	//各ゲッターとセッター
	public void setEmployee_id(String employee_id) { this.employee_id = employee_id; }
	public String getEmployee_id() { return this.employee_id; }


	public void setEmployee_name(String employee_name) { this.employee_name = employee_name; }
	public String getEmployee_name() { return this.employee_name; }


	public void setDepartment(String department) { this.department = department; }
	public String getDepartment() { return this.department; }


	public void setPost(String post) { this.post = post; }
	public String getPost() { return this.post; }


	public void setEntry_date(Date entry_date) { this.entry_date = entry_date; }
	public Date getEntry_date() { return this.entry_date; }


	public void setPassword(String password) { this.password = password; }
	public String getPassword() { return this.password; }


	public void setAdmin_level(int admin_level) { this.admin_level = admin_level; }
	public int getAdmin_level() { return this.admin_level; }

}


