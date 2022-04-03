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
    <A href="./list_by_pcateno_search_paging.do?pcateno=${pcateVO.pcateno }">기본 목록형</A>
  </ASIDE> 

  <DIV class='menu_line'></DIV>
  
  <div style='width: 100%;'> <%-- 갤러리 Layout 시작 --%>
    <c:forEach var="pcontentsVO" items="${list }" varStatus="status">
      <c:set var="pcontentsno" value="${pcontentsVO.pcontentsno }" />
      <c:set var="title" value="${pcontentsVO.title }" />
      <c:set var="content" value="${pcontentsVO.content }" />
      <c:set var="file1" value="${pcontentsVO.file1 }" />
      <c:set var="size1" value="${pcontentsVO.size1 }" />
      <c:set var="thumb1" value="${pcontentsVO.thumb1 }" />
      
      <c:set var="price" value="${pcontentsVO.price }" />
      <c:set var="dc" value="${pcontentsVO.dc }" />
      <c:set var="saleprice" value="${pcontentsVO.saleprice }" />
      <c:set var="point" value="${pcontentsVO.point }" />

      <%-- 하나의 행에 이미지를 4개씩 출력후 행 변경, index는 0부터 시작 --%>
      <c:if test="${status.index % 4 == 0 && status.index != 0 }"> 
        <HR class='menu_line'>
      </c:if>
      
      <!-- 하나의 이미지, 24 * 4 = 96% -->
      <DIV style='width: 24%; 
              float: left; 
              margin: 0.5%; padding: 0.5%; background-color: #EEEFFF; text-align: center;'>
        <c:choose>
          <c:when test="${size1 > 0}"> <!-- 파일이 존재하면 -->
            <c:choose> 
              <c:when test="${thumb1.endsWith('jpg') || thumb1.endsWith('png') || thumb1.endsWith('gif')}"> <!-- 이미지 인경우 -->
                <a href="./read.do?pcontentsno=${pcontentsno}">               
                  <IMG src="./storage/${thumb1 }" style='width: 100%; height: 150px;'>
                </a><br>
                ${title} <br>
                <del><fmt:formatNumber value="${price}" pattern="#,###" /></del>
                <span style="color: #FF0000; font-size: 1.0em;">${dc} %</span>
                <strong><fmt:formatNumber value="${saleprice}" pattern="#,###" /></strong>
              </c:when>
              <c:otherwise> <!-- 이미지가 아닌 일반 파일 -->
                <DIV style='width: 100%; height: 150px; display: table; border: solid 1px #CCCCCC;'>
                  <DIV style='display: table-cell; vertical-align: middle; text-align: center;'> <!-- 수직 가운데 정렬 -->
                    <a href="./read.do?pcontentsno=${pcontentsno}">${file1}</a><br>
                  </DIV>
                </DIV>
                ${title} (${cnt})              
              </c:otherwise>
            </c:choose>
          </c:when>
          <c:otherwise> <%-- 파일이 없는 경우 기본 이미지 출력 --%>
            <a href="./read.do?pcontentsno=${pcontentsno}">
              <img src='/pcontents/images/none1.png' style='width: 100%; height: 150px;'>
            </a><br>
            이미지를 등록해주세요.
          </c:otherwise>
        </c:choose>         
      </DIV>  
    </c:forEach>
    <!-- 갤러리 Layout 종료 -->
    <br><br>
  </div>

</DIV>

 
<jsp:include page="../menu/bottom.jsp" />
</body>
 
</html>