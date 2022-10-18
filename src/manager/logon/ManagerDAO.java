package manager.logon;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import util.JDBCUtil;

public class ManagerDAO {
	// 싱글톤 패턴(Singleton Pattern)
	private ManagerDAO() { }
	
	private static ManagerDAO instance = new ManagerDAO();
	
	public static ManagerDAO getInstance() {
		return instance;
	}
	// DB 연결과 질의를 위한 변수 선언
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	// 관리자 확인 메소드 - 아이디와 비밀번호
	public int checkManager(String managerId, String managerPwd) {
		String sql = "select * from manager where "
				+ "managerId = ? and managerPwd = ?";
		int cnt = 0;
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, managerId);
			pstmt.setString(2, managerPwd);
			rs = pstmt.executeQuery();
			if(rs.next()) cnt = 1; // 로그인 성공, 아이디와 비밀번호 모두 일치 했을 때
			else cnt = 0;          // 로그인 실패, 아이디 또는 비밀번호가 일치하지 않았을 때
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt, rs);
		}
		return cnt;
	}
	
}
