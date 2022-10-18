package mall.bank;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import util.JDBCUtil;

public class BankDAO {
	private BankDAO() {}
	
	private static BankDAO bankDAO = new BankDAO();
	
	public static BankDAO getInstance() {
		return bankDAO;
	}
	
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	// 카드 추가
	public void insertBank(BankDTO dto) {
		String sql = "insert into bank(card_no, card_com, member_id, member_name) values(?,?,?,?)";
		
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getCard_no());
			pstmt.setString(2, dto.getCard_com());
			pstmt.setString(3, dto.getMember_id());
			pstmt.setString(4, dto.getMember_name());
			pstmt.executeUpdate();
		}catch(Exception e) {
			System.out.println("=> insertBank() 메소드 에러");
			e.printStackTrace();
		}finally {
			JDBCUtil.close(conn, pstmt);
		}
	}
	
	// 카드 수정
	
	// 카드 삭제(전체) -> 회원 탈퇴시에 트랜잭션 처리

	
	// 카드 삭제 (1개)
	public void deleteBank(String member_id, String card_no){
		String sql = "delete from bank where member_id=? and card_no=?";
		
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member_id);
			pstmt.setString(2, card_no);
			pstmt.executeUpdate();
		}catch(Exception e) {
			System.out.println("=> deleteBank() 메소드 에러");
			e.printStackTrace();
		}finally {
			JDBCUtil.close(conn, pstmt);
		}
	}
	
	// 카드 전체 보기
	public List<BankDTO> getBankList(String member_id){
		String sql = "select * from bank where member_id = ?";
		List<BankDTO> bankList = new ArrayList<BankDTO>();
		BankDTO bank = null;
		
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member_id);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				bank = new BankDTO();
				bank.setCard_no(rs.getString("card_no"));
				bank.setCard_com(rs.getString("card_com"));
				bank.setMember_id(rs.getString("member_id"));
				bank.setMember_name(rs.getString("member_name"));
				bankList.add(bank);
			}
		}catch(Exception e){
			System.out.println("=> getBank() 메소드 에러");
			e.printStackTrace();
		}finally {
			JDBCUtil.close(conn, pstmt, rs);
		}
		return bankList;
	}
}
