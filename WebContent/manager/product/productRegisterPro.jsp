<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="manager.product.*, java.util.*, manager.product.*" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 등록 처리</title>
</head>
<body>
<% 
request.setCharacterEncoding("utf-8");

// 폼의 입력 정보 획득
// 파일 업로드 폼 -> cos.jar 라이브러리의 MultipartRequest 클래스를 사용
// request, 업로드 폴더, 파일의 최대크기, encType, 파일명 중복정책
String realFolder = "c:/images_puppyLover";
int maxSize = 1024 * 1024 * 30; // 5MB
String encType = "utf-8";
MultipartRequest multi = null;

//String fileName = "";
List<String> fileList = new ArrayList<String>();

try {
	multi = new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());
	
	Enumeration<?> files = multi.getFileNames();
	while(files.hasMoreElements()) {
		String name = (String)files.nextElement();
		fileList.add(multi.getFilesystemName(name));
	}
	
} catch(Exception e) {
	System.out.println("productRegisterPro.jsp 파일: " + e.getMessage());
	e.printStackTrace();
}

// 폼에서 넘어오는 10개의 필드 값을 획득 - 제외) product_id, reg_date
String product_kind = multi.getParameter("product_kind");
String product_name = multi.getParameter("product_name");
String product_color = multi.getParameter("product_color");
String product_size = multi.getParameter("product_size");
int product_price = Integer.parseInt(multi.getParameter("product_price"));
int product_count = Integer.parseInt(multi.getParameter("product_count"));
//String product_image1 = multi.getParameter("product_image1");
//String product_image2 = multi.getParameter("product_image2");
//String product_image3 = multi.getParameter("product_image3");
//String product_content = multi.getParameter("product_content");
int discount_rate = Integer.parseInt(multi.getParameter("discount_rate"));

// ProductDTO 객체 생성하고 setter 메소드를 사용하여 값을 설정
ProductDTO product = new ProductDTO();
product.setProduct_kind(product_kind);
product.setProduct_name(product_name);
product.setProduct_color(product_color);
product.setProduct_size(product_size);
product.setProduct_price(product_price);
product.setProduct_count(product_count);
product.setDiscount_rate(discount_rate);

product.setProduct_image1(fileList.get(3));
product.setProduct_image2(fileList.get(1));
product.setProduct_image3(fileList.get(0));
product.setProduct_content(fileList.get(2));

// 상품 이미지가 null일 때 nothing.jpg로 변경하여 저장
if(product.getProduct_image2() == null) product.setProduct_image2("nothing.jpg");
if(product.getProduct_image3() == null) product.setProduct_image3("nothing.jpg");
if(product.getProduct_content() == null) product.setProduct_content("nothing.jpg");

// 상품 product 확인
System.out.println("product 객체: " + product);

// DB 연결, product 테이블에 상품 추가 처리
ProductDAO productDAO = ProductDAO.getInstance();
productDAO.insertProduct(product);
response.sendRedirect("productList.jsp");

%>
</body>
</html>