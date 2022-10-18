package mall.review;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import util.JDBCUtil;

public class ReviewDAO {
// singleton Pattern 
	private ReviewDAO() {}
	
	private static ReviewDAO reviewDAO = new ReviewDAO();
	
	public static ReviewDAO getInstance() {
		return reviewDAO;
	}
	
	// DB 연결, 질의에 사용할 객체 선언
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	
	// 상품 리뷰 등록 메소드 (원글)
	public void insertReview(ReviewDTO review) {
		String sql = "insert into review(member_id, product_id, subject, content) "
				+ "values(?, ?, ?, ?)";
		try {
			conn= JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, review.getMember_id());
			pstmt.setInt(2, review.getProduct_id());
			pstmt.setString(3, review.getSubject());
			pstmt.setString(4, review.getContent());
			pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			JDBCUtil.close(conn, pstmt);
		}
	}
	
	
	// 상품별 리뷰(전체) 보기 메소드 -> 페이징처리 (한페이지에 5건의 리뷰를 나타도록 페이징처리함)
	public List<ReviewDTO> getReviewList(int start, int size, int product_id) {
		List<ReviewDTO> reviewList = new ArrayList<ReviewDTO>();
		ReviewDTO review = null;
		String sql = "select * from review where product_id =? order by num desc limit ?, ?";
		
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, product_id);
			pstmt.setInt(2, start-1);	//limit는 0번부터 시작하기 때문에 1을 빼줌
			pstmt.setInt(3, size);		// size는 개수 (크기)
			rs = pstmt.executeQuery();
			
			// 1단계 - 리뷰번호, 회원아이디, 상품아이디, 리뷰제목, 리뷰내용, 리뷰등록일, 조회수 7가지 정보 review에 저장
			// 2단계 - review를 reviewList에 저장
			while(rs.next()) {
				review = new ReviewDTO();
				review.setNum(rs.getInt("num"));
				review.setMember_id(rs.getString("member_id"));
				review.setProduct_id(rs.getInt("product_id"));
				review.setSubject(rs.getString("subject"));
				review.setContent(rs.getNString("content"));
				review.setRegDate(rs.getTimestamp("regDate"));
				review.setReadcount(rs.getInt("readcount"));
				reviewList.add(review);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			JDBCUtil.close(conn, pstmt, rs);
		}
		return reviewList;
	}
	
	// 리뷰 (1건) 보기 메소드
	public ReviewDTO getReview(int num) {
		ReviewDTO review = new ReviewDTO();
		String sql1 = "update review set readcount=readcount+1 where num = ?";
		String sql2 = "select * from review where num =?";
		
		try {
			conn = JDBCUtil.getConnection();
			// 조회수 보기
			pstmt = conn.prepareStatement(sql1);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
			
			//리뷰 상세보기
			pstmt = conn.prepareStatement(sql2);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				review.setNum(rs.getInt("num"));
				review.setMember_id(rs.getString("member_id"));
				review.setProduct_id(rs.getInt("product_id"));
				review.setSubject(rs.getString("subject"));
				review.setContent(rs.getNString("content"));
				review.setRegDate(rs.getTimestamp("regDate"));
				review.setReadcount(rs.getInt("readcount"));
			}	
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			JDBCUtil.close(conn, pstmt, rs);
		}
		return review;
	}
	
	// 상품리뷰 수정 메소드
	public void updateReview(ReviewDTO review) {
		String sql = "update review set subject=?, content=? where num =?";
		
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, review.getSubject());
			pstmt.setString(2, review.getContent());
			pstmt.setInt(3, review.getNum());
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			JDBCUtil.close(conn, pstmt);
		}
	}
	
	// 상품 리뷰 삭제 메소드
	public void deleteReview(int num) {
		String sql = "delete from review where num = ?";
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();	
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			JDBCUtil.close(conn, pstmt);
		}
	}
	
	// 상품리뷰 수 획득
	public int getReviewCount(int product_id) {
		String sql = "select count(*) from review where product_id=?";
		int cnt = 0;
		
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, product_id);
			rs = pstmt.executeQuery();
			
			rs.next();
			cnt = rs.getInt(1);
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			JDBCUtil.close(conn, pstmt, rs);
		}
		return cnt;
	}
}
