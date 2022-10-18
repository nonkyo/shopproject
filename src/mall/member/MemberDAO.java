package mall.member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;


import util.JDBCUtil;

// DAO(Data Access Object) - DB의 연결, 해제, 질의를 담당하는 클래스
public class MemberDAO {
	
	// singletone Pattern (싱클톤 패턴) - 클래스의 인스턴스를 하나만 생성하는 방법
	//외부에서 객체를 만들수없게하는 생성자
	private MemberDAO(){}
	
	// 그래서 이 객체를 리턴해서 사용하게 함
	private static MemberDAO memberDAO = new MemberDAO();
	
	public static MemberDAO getInstance(){	//클래스에서 바로 불러올수있도록 static 붙임 
		return memberDAO;	//외부에서 객체를 생성하지 못하고 내부에서 생성한 객체를 리턴해서 외부에서 사용
	}
	
	// DB 연결, 질의 객체 선언
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	
	//회원가입 메소드
	public int insertMember(MemberDTO member) {
		String sql = "insert into member values(?, ?, ?, ?, ?, ?, now())";
		int cnt = 0;	//성공 여부를 알려주는 변수
		
		try {
			conn = JDBCUtil.getConnection();
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member.getId());
			pstmt.setString(2, member.getPwd());
			pstmt.setString(3, member.getName());
			pstmt.setString(4, member.getEmail());
			pstmt.setString(5, member.getTel());
			pstmt.setString(6, member.getAddress());
			cnt = pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			JDBCUtil.close(conn, pstmt);
		}
		return cnt;
	}
	
	
	// 회원 아이디 중복 체크 메소드
	public int CheckID(String id) {
		String sql = "select * from member where id =?";
		int cnt =0; // 성공 여부
		
		try {
			conn = JDBCUtil.getConnection();
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) cnt = 0; //아이디가 이미 존재함, 생성 불가, 실패
			else cnt = 1;			// 아이디가 존재하지 않음, 생성 가능, 성공
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			JDBCUtil.close(conn, pstmt, rs);
		}
		return cnt;
		
	}
	
	// 로그인 메소드
	public int login(String id, String pwd) {
		String sql = "select * from member where id = ?";
		int cnt = -1; // -1: 아이디가 없음, 0: 아이디는 있고 비밀번호가 다름, 1: 아이디와 비밀번호가 모두 일치
		
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()){	//아이디가 있을 때
				String dbPwd = rs.getString("pwd");
				if(pwd.equals(dbPwd)){  //비밀번호도 일치
					cnt = 1;
				}else {					// 비밀번호 불일치
					cnt = 0;
				}
			}else {			//아이디가 없을 때
				cnt = -1;
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			JDBCUtil.close(conn, pstmt, rs);
		}
		return cnt;
	}
	
	
	// 회원 정보 보기 메소드(1명, 자신의 정보)
	public MemberDTO getMember(String id) {
		String sql = "select * from member where id = ?";
		MemberDTO member = new MemberDTO();
		
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				// 가입일을 제외한 정보를 member테이블로부터 가져와서 member객체에 저장함 
				member.setId(rs.getString("id"));	//디비에서 가져온 아이디를 멤버객체에 담겠다
				member.setPwd(rs.getString("pwd"));
				member.setName(rs.getString("name"));
				member.setEmail(rs.getString("email"));
				member.setTel(rs.getString("tel"));
				member.setAddress(rs.getString("address"));
				member.setRegDate(rs.getTimestamp("regDate"));
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			JDBCUtil.close(conn, pstmt, rs);
		}
		return member;
	}
	
	// 회원 정보 수정 메소드
	public int updateMember(MemberDTO member) {
		String sql = "update member set pwd=?, name=?, email=?, tel=?, address=? where id = ?";
		int cnt =0; //수정 성공 여부
		
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member.getPwd());
			pstmt.setString(2, member.getName());
			pstmt.setString(3, member.getEmail());
			pstmt.setString(4, member.getTel());
			pstmt.setString(5, member.getAddress());
			pstmt.setString(6, member.getId());
			cnt = pstmt.executeUpdate();
			
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			JDBCUtil.close(conn, pstmt);
		}
		return cnt;
	}
	
	// 회원 삭제 (탈퇴) 메소드 
	public int deleteMember(String id, String pwd) throws Exception{
		String sql1 = "delete from member where id=? and pwd =?";
		
		int cnt = 0;
		
		try {
			conn = JDBCUtil.getConnection();
			// 1작업 - 회원 삭제(탈퇴)
			pstmt = conn.prepareStatement(sql1);
			pstmt.setString(1, id);
			pstmt.setString(2, pwd);
			cnt = pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			JDBCUtil.close(conn, pstmt);
		}
		return cnt;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
