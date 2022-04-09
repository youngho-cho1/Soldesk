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
 
<DIV class='title_line'>
  <A href="../ytgrp/list.do" class='title_link'>카테고리 그룹</A> > 
  <A href="./list_by_ytgrpno.do?ytgrpno=${youVO.ytgrpno }" class='title_link'>${ytgrpVO.title }</A> > 
  ${youVO.title } 수정 
</DIV>

<DIV class='content_body'>

  <DIV id='panel_update' style='padding: 10px 0px 10px 0px; background-color: #F9F9F9; width: 100%; text-align: center;'>
    <FORM name='frm' id='frm' method='POST' action='./update.do'>
      <input type="hidden" name="youno" value="${param.youno }">
      
      <label>카테고리 그룹 번호</label>
      <input type='number' name='ytgrpno' value='${youVO.ytgrpno }' 
                 required="required" min="1" max="100" step="1" autofocus="autofocus">
      <label>카테고리 이름</label>
      <input type='text' name='name' value='${youVO.title }' required="required" style='width: 25%;'>
      <label>URL</label>
      <input type='number' name='url' value='${youVO.url }' 
                 required="required" min="0" max="10000000" step="1">    
  
      <button type="submit" id='submit'>저장</button>
      <button type="button" onclick="location.href='./list_by_ytgrpno.do?ytgrpno=${youVO.ytgrpno}'">취소</button>
    </FORM>
  </DIV>

  <TABLE class='table table-striped'>
    <colgroup>
      <col style='width: 10%;'/>
      <col style='width: 10%;'/>
      <col style='width: 40%;'/>
      <col style='width: 15%;'/>    
      <col style='width: 10%;'/>
      <col style='width: 15%;'/>
    </colgroup>
   
    <thead>  
    <TR>
      <TH class="th_bs">카테고리<br> 번호</TH>
      <TH class="th_bs">카테고리<br> 그룹 번호</TH>
      <TH class="th_bs">카테고리 이름</TH>
      <TH class="th_bs">주소</TH>
      <TH class="th_bs">등록일</TH>
      
    </TR>
    </thead>
    
    <tbody>
    <c:forEach var="youVO" items="${list}">
      <c:set var="youno" value="${youVO.youno }" />
      <c:set var="ytgrpno" value="${youVO.ytgrpno }" />
      <c:set var="title" value="${youVO.title }" />
      <c:set var="rdate" value="${youVO.rdate.substring(0, 10) }" />
      <c:set var="url" value="${youVO.url }" />
      <TR>
        <TD class="td_bs">${youno }</TD>
        <TD class="td_bs">${ytgrpno }</TD>
        <TD class="td_bs_left">${title }</TD>
        <TD class="td_bs">${url }</TD>
        <TD class="td_bs">${rdate }</TD>
        <TD class="td_bs">
          <A href="./read_update.do?youno=${youno }&ytgrpno=${ytgrpno }" title="수정"><span class="glyphicon glyphicon-pencil"></span></A>
          <A href="./read_delete.do?youno=${youno }&ytgrpno=${ytgrpno }" title="삭제"><span class="glyphicon glyphicon-trash"></span></A>
        </TD>   
      </TR>   
    </c:forEach> 
    </tbody>
   
  </TABLE>
</DIV>

 
<jsp:include page="../menu/bottom.jsp" />
</body>
 
</html>