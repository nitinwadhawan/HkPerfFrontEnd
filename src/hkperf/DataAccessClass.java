package hkperf;

/**
 * Created with IntelliJ IDEA.
 * User: Nitin Wadhawan
 * Date: 8/12/13
 * Time: 12:13 PM
 * To change this template use File | Settings | File Templates.
 */


import java.io.IOException;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;


public class DataAccessClass {


	public static int count = 0;
	String sqlForResultSet;

	public List<LoadParam> getResult(String sql, LoadParam objectName) throws IOException {
		Properties prop = new Properties();
//		prop.load(getClass().getResourceAsStream("../environmentLocator.properties"));
		System.out.println("inside getResult");
		List<LoadParam> resultList = new ArrayList<LoadParam>();
		String JDBC_DRIVER = "com.mysql.jdbc.Driver";


	/*	String DB_URL = (String) prop.get("dburl");
		String USER = (String) prop.get("dbuser");
		String PASS = (String) prop.get("dbpass");*/
		String DB_URL = "jdbc:mysql://localhost:3306/page_load_performance";
		String USER = "root";
		String PASS = "root";

		java.sql.Connection conn = null;
		java.sql.Statement stmt = null;
		java.sql.Statement countStmt = null;
		try {
			//STEP 2: Register JDBC driver
			Class.forName("com.mysql.jdbc.Driver");

			//STEP 3: Open a connection
			System.out.println("Connecting to a selected database...");
			conn = DriverManager.getConnection(DB_URL, USER, PASS);
			System.out.println("Connected database successfully...");

			//STEP 4: Execute a query
			String getcount = "select Count(*) from page_load_performance.response a ,page_load_performance.response_details b where a.request_id=b.request_id and a.website_id=1 and b.response_view_type=1;";
			System.out.println("Creating statement...");
			stmt = conn.createStatement();
			countStmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(sql);
			ResultSet rsCount = countStmt.executeQuery(getcount);


			//STEP 5: Extract data from result set
			while (rsCount.next()) {
				count = rsCount.getInt(1);
				System.out.println("count=" + count);
			}

			while (rs.next()) {
				objectName = new LoadParam();
				objectName.setLoadTime(rs.getFloat("load_time"));
				objectName.setDateTime(rs.getString("create_dt"));
				resultList.add(objectName);

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

