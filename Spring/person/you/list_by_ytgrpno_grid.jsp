<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>Person world</title>
 
<link href="/css/style.css" rel="Stylesheet" type="text/css">
 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    
<script type="text/javascript">
</script>
</head> 
<body>
<jsp:include page="../menu/top.jsp" />
 
<DIV class='title_line'><A href="../ytgrp/list.do" class='title_link'>유튜브 그룹</A> > ${ytgrpVO.title }</DIV>

  <DIV class='content_body'>
  <ASIDE class="aside_right">
    <A href="./create.do?ytgrpno=${ytgrpVO.ytgrpno }">등록</A>
    <span class='menu_divide' >│</span>
    <A href="javascript:location.reload();">새로고침</A>
    <span class='menu_divide' >│</span>
    <A href="./list_by_ytgrpno.do?ytgrpno=${ytgrpVO.ytgrpno }">기본 목록형</A>
  </ASIDE> 
  <DIV class='menu_line'></DIV>
  
  <div style='width: 100%;'> <%-- 갤러리 Layout 시작 --%>  
    <c:forEach var="youVO" items="${list }" varStatus="status">
      <c:set var="youno" value="${youVO.youno }" />
      <c:set var="title" value="${youVO.title }" />
      <c:set var="url" value="${youVO.url }" />
      
      
      
     <c:if test="${status.index % 4 == 0 && status.index != 0 }"> 
        <HR class='menu_line'>
      </c:if> 
      <!-- 하나의 이미지, 24 * 4 = 96% -->
      <DIV style='width: 24%; 
              float: left; 
              margin: 0.5%; padding: 0.5%; background-color: #EEEFFF; text-align: center;'>
                <DIV style='width: 100%; height: 150px; display: table; border: solid 1px #CCCCCC;'>
                  <DIV style='display: table-cell; vertical-align: middle; text-align: center;'> <!-- 수직 가운데 정렬 -->
                   ${url } <br>
                   ${title} <br>  
                  </DIV>      
      </DIV>  
</DIV>
    </c:forEach>
    <!-- 갤러리 Layout 종료 -->
    <br><br>
  </div>

</DIV>
<jsp:include page="../menu/bottom.jsp" />
</body>
 
</html>