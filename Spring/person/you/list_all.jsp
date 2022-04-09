<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
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
 
<DIV class='title_line'>즐겨찾기 전체 목록 > 전체 카테고리</DIV>

<DIV class='content_body'>
  <TABLE class='table table-striped'>
    <colgroup>
      <col style='width: 10%;'/>
      <col style='width: 10%;'/>
      <col style='width: 35%;'/>
      <col style='width: 15%;'/>    
      <col style='width: 10%;'/>
      <col style='width: 20%;'/>
    </colgroup>
   
    <thead>  
    <TR>
      <TH class="th_bs">카테고리<br> 번호</TH>
      <TH class="th_bs">제목</TH>
      <TH class="th_bs">주소</TH>
      <TH class="th_bs">날짜</TH>
      <TH class="th_bs">카테고리<br> 그룹 번호</TH>
    </TR>
    </thead>
    
    <tbody>
    <c:forEach var="youVO" items="${list}">
      <c:set var="youno" value="${youVO.youno }" />
      <c:set var="title" value="${youVO.title }" />
      <c:set var="url" value="${youVO.url }" />
      <c:set var="rdate" value="${youVO.rdate.substring(0, 10) }" />
      <c:set var="ytgrpno" value="${youVO.ytgrpno }" />
      
      <TR>
        <TD class="td_bs">${youno }</TD>
        <TD class="td_bs">${title }</TD>
        <TD class="td_bs_left">${url }</TD>
        <TD class="td_bs">${rdate }</TD>
        <TD class="td_bs">${ytgrpno }</TD>
        <TD class="td_bs">
          <A href="./read_update.do?youno=${youno }" title="수정"><span class="glyphicon glyphicon-pencil"></span></A>
          <A href="./read_delete.do?youno=${youno }" title="삭제"><span class="glyphicon glyphicon-trash"></span></A>
        </TD>   
      </TR>   
    </c:forEach> 
    </tbody>
   
  </TABLE>
</DIV>

 
<jsp:include page="../menu/bottom.jsp" />
</body>
 
</html>