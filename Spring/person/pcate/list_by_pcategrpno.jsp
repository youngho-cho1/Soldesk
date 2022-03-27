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
 
<DIV class='title_line'><A href="../pcategrp/list.do" class='title_link'>카테고리 그룹</A> > ${pcategrpVO.name }</DIV>

<DIV class='content_body'>

  <DIV id='panel_create' style='padding: 10px 0px 10px 0px; background-color: #F9F9F9; width: 100%; text-align: center;'>
    <FORM name='frm_create' id='frm_create' method='POST' action='./create.do'>
      <label>카테고리 그룹 번호</label>
      <input type='text' name='pcategrpno' value='${param.pcategrpno }' > 
    
      <label>카테고리 이름</label>
      <input type='text' name='name' value='' required="required" style='width: 25%;' autofocus="autofocus">
  
      <button type="submit" id='submit'>등록</button>
      <button type="button" onclick="cancel();">취소</button>
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
      <TH class="th_bs">등록일</TH>
      <TH class="th_bs">관련<br> 자료수</TH>
      <TH class="th_bs">기타</TH>
    </TR>
    </thead>
    
    <tbody>
    <c:forEach var="pcateVO" items="${list}">
      <c:set var="pcateno" value="${pcateVO.pcateno }" />
      <TR>
        <TD class="td_bs">${pcateVO.pcateno }</TD>
        <TD class="td_bs">${pcateVO.pcategrpno }</TD>
        <TD class="td_bs_left"><A href="/pcontents/list_by_pcateno_search_paging.do?pcateno=${pcateno}">${pcateVO.name }</A></TD>
        <TD class="td_bs">${pcateVO.rdate.substring(0, 10) }</TD>
        <TD class="td_bs">${pcateVO.cnt }</TD>
        <TD class="td_bs">
          <A href="./read_update.do?pcateno=${pcateno }" title="수정"><span class="glyphicon glyphicon-pencil"></span></A>
          <A href="./read_delete.do?pcateno=${pcateno }" title="삭제"><span class="glyphicon glyphicon-trash"></span></A>
        </TD>   
      </TR>   
    </c:forEach> 
    </tbody>
   
  </TABLE>
</DIV>

 
<jsp:include page="../menu/bottom.jsp" />
</body>
 
</html>