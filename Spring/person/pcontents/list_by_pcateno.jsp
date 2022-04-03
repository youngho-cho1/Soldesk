<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>Resort world</title>
 
<link href="/css/style.css" rel="Stylesheet" type="text/css">
 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    
<script type="text/javascript">
 
  
</script>
 
</head> 
 
<body>
<jsp:include page="../menu/top.jsp" />
 
<DIV class='title_line'>
  <A href="../pcategrp/list.do" class='title_link'>카테고리 그룹</A> > 
  <A href="../pcate/list_by_pcategrpno.do?pcategrpno=${pcategrpVO.pcategrpno }" class='title_link'>${pcategrpVO.name }</A> >
  <A href="./list_by_pcateno.do?pcateno=${pcateVO.pcateno }" class='title_link'>${pcateVO.name }</A>
</DIV>

<DIV class='content_body'>
  <ASIDE class="aside_right">
    <A href="./create.do?pcateno=${pcateVO.pcateno }">등록</A>
    <span class='menu_divide' >│</span>
    <A href="javascript:location.reload();">새로고침</A>
    <span class='menu_divide' >│</span>
    <A href="./list_by_pcateno_grid1.do?pcateno=${pcateVO.pcateno }">갤러리형</A>
  </ASIDE> 

  <DIV class='menu_line'></DIV>
  
  <table class="table table-striped" style='width: 100%;'>
    <colgroup>
      <col style="width: 10%;"></col>
      <col style="width: 60%;"></col>
      <col style="width: 20%;"></col>
      <col style="width: 10%;"></col>
    </colgroup>
    <%-- table 컬럼 --%>
<!--     <thead>
      <tr>
        <th style='text-align: center;'>파일</th>
        <th style='text-align: center;'>상품명</th>
        <th style='text-align: center;'>정가, 할인률, 판매가, 포인트</th>
        <th style='text-align: center;'>기타</th>
      </tr>
    
    </thead> -->
    
    <%-- table 내용 --%>
    <tbody>
      <c:forEach var="pcontentsVO" items="${list }">
        <c:set var="pcontentsno" value="${pcontentsVO.pcontentsno }" />
        <c:set var="thumb1" value="${pcontentsVO.thumb1 }" />
        
        <tr> 
          <td style='vertical-align: middle; text-align: center;'>
            <c:choose>
              <c:when test="${thumb1.endsWith('jpg') || thumb1.endsWith('png') || thumb1.endsWith('gif')}">
                <%-- /static/pcontents/storage/ --%>
                <a href="./read.do?pcontentsno=${pcontentsno}&now_page=${param.now_page }"><IMG src="/pcontents/storage/${thumb1 }" style="width: 120px; height: 80px;"></a> 
              </c:when>
              <c:otherwise> <!-- 기본 이미지 출력 -->
                <IMG src="/pcontents/images/none1.png" style="width: 120px; height: 80px;">
              </c:otherwise>
            </c:choose>
          </td>  
          <td style='vertical-align: middle;'>
            <a href="./read.do?pcontentsno=${pcontentsno}"><strong>${pcontentsVO.title}</strong> ${pcontentsVO.content}</a> 
          </td> 
          <td style='vertical-align: middle; text-align: center;'>
            <del><fmt:formatNumber value="${pcontentsVO.price}" pattern="#,###" /></del><br>
            <span style="color: #FF0000; font-size: 1.2em;">${pcontentsVO.dc} %</span>
            <strong><fmt:formatNumber value="${pcontentsVO.saleprice}" pattern="#,###" /></strong><br>
            <span style="font-size: 0.8em;">포인트: <fmt:formatNumber value="${pcontentsVO.point}" pattern="#,###" /></span>
          </td>
          <td style='vertical-align: middle; text-align: center;'>수정/삭제<br>상품 정보</td>
        </tr>
      </c:forEach>
      
    </tbody>
  </table>
</DIV>

 
<jsp:include page="../menu/bottom.jsp" />
</body>
 
</html>