package hkperf;

/**
 * Created with IntelliJ IDEA.
 * User: Nitin Wadhwan
 * Date: 8/12/13
 * Time: 12:13 PM
 * To change this template use File | Settings | File Templates.
 */


import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


public class DataAccessClass {


	public static int count = 0;
	String sqlForResultSet;

	public static void main(String args[]) {


	}


	public static List<LoadParam> getResult(String sql, LoadParam objectName) {
		System.out.println("inside getResult");
		List<LoadParam> resultList = new ArrayList<LoadParam>();
		String JDBC_DRIVER = "com.mysql.jdbc.Driver";
		String DB_URL = "jdbc:mysql://localhost:3306/page_load_performance";

		//  Database credentials
		String USER = "root";
		String PASS = "root";


		java.sql.Connection conn = null;
		java.sql.Statement stmt = null;
		try {
			//STEP 2: Register JDBC driver
			Class.forName("com.mysql.jdbc.Driver");

			//STEP 3: Open a connection
			System.out.println("Connecting to a selected database...");
			conn = DriverManager.getConnection(DB_URL, USER, PASS);
			System.out.println("Connected database successfully...");

			//STEP 4: Execute a query
			System.out.println("Creating statement...");
			stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(sql);


			//STEP 5: Extract data from result set
			while (rs.next()) {
				objectName = new LoadParam();
				objectName.setLoadTime(rs.getFloat("load_time"));
				objectName.setDateTime(rs.getString("create_dt"));
				resultList.add(objectName);
				count++;
			}
			rs.close();
		} catch (SQLException se) {
			//Handle errors for JDBC
			se.printStackTrace();
		} catch (Exception e) {
			//Handle errors for Class.forName
			e.printStackTrace();
		} finally {
			//finally block used to close resources
			try {
				if (stmt != null)
					conn.close();
			} catch (SQLException se) {
			}// do nothing
			try {
				if (conn != null)
					conn.close();
			} catch (SQLException se) {
				se.printStackTrace();
			}//end finally try
		}//end try
		System.out.println("Goodbye!");
		return resultList;

	}
}

