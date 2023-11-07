<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>장바구니 추가 테스트</title>
</head>
<body>
<%
String goodsNoString = request.getParameter("goodsNo");
int goodsNo = 0; // 기본값 설정

if (goodsNoString != null && !goodsNoString.isEmpty()) {
    try {
        goodsNo = Integer.parseInt(goodsNoString);
        // "goodsNo"를 정수로 변환
%>
    <p>장바구니에 상품 번호 <%= goodsNo %>를 추가했습니다.</p>
<%
    } catch (NumberFormatException e) {
        // 정수로 변환할 수 없는 경우
%>
    <p>상품 번호가 올바르지 않습니다.</p>
<%
    }
} else {
    // "goodsNo" 파라미터가 전달되지 않은 경우
%>
    <p>상품 번호가 전달되지 않았습니다.</p>
<%
}
%>
</body>
</html>
