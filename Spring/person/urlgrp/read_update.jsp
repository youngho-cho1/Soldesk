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
 
<DIV class='title_line'>카테고리 그룹 > ${urlgrpVO.title } 조회(수정)</DIV>

<DIV class='content_body'>
  <DIV id='panel_create' style='padding: 10px 0px 10px 0px; background-color: #F9F9F9; width: 100%; text-align: center;'>
    <FORM name='frm_update' id='frm_update' method='POST' action='./update.do'>
      <input type='hidden' name='urlgrpno' id='urlgrpno' value='${urlgrpVO.urlgrpno }'>
        
      <label>그룹 이름</label>
      <input type='text' name='title' value="${urlgrpVO.title }" required="required" 
                 autofocus="autofocus" style='width: 25%;'>
 
      <label>순서</label>
      <input type='number' name='cnt' value="${urlgrpVO.cnt }" required="required" 
                min='1' max='1000' step='1' style='width: 5%;'>
  
      <label>형식</label>
      <select name='visible'>
        <option value='Y' ${urlgrpVO.visible == 'Y' ? "selected='selected'":"" }>Y</option>
        <option value='N' ${urlgrpVO.visible == 'N' ? "selected='selected'":""}>N</option>
      </select>
       
      <button type="submit" id='submit'>저장</button>
      <button type="button" onclick="location.href='./list.do'">취소</button>
    </FORM>
  </DIV>
   
  <TABLE class='table table-striped'>
    <colgroup>
      <col style='width: 10%;'/>
      <col style='width: 40%;'/>
      <col style='width: 20%;'/>
      <col style='width: 10%;'/>    
      <col style='width: 20%;'/>
    </colgroup>
   
    <thead>  
    <TR>
      <TH class="th_bs">순서</TH>
      <TH class="th_bs">대분류명</TH>
      <TH class="th_bs">등록일</TH>
      <TH class="th_bs">출력</TH>
      <TH class="th_bs">기타</TH>
    </TR>
    </thead>
    
    <tbody>
    <c:forEach var="urlgrpVO" items="${list}">
      <c:set var="urlgrpno" value="${urlgrpVO.urlgrpno }" />
      <TR>
        <TD class="td_bs">${urlgrpVO.cnt }</TD>
        <TD class="td_bs_left">${urlgrpVO.title }</TD>
        <TD class="td_bs">${urlgrpVO.rdate.substring(0, 10) }</TD>
        <TD class="td_bs">${urlgrpVO.visible }</TD>
        <TD class="td_bs">
          <A href="./read_update.do?urlgrpno=${urlgrpno }" title="수정"><span class="glyphicon glyphicon-pencil"></span></A>
          <A href="./read_delete.do?urlgrpno=${urlgrpno }" title="삭제"><span class="glyphicon glyphicon-trash"></span></A>
<%--           <A href="./update_cnt_up.do?urlgrpno=${urlgrpno }" title="우선순위 상향"><span class="glyphicon glyphicon-arrow-up"></span></A>
          <A href="./update_cnt_down.do?urlgrpno=${urlgrpno }" title="우선순위 하향"><span class="glyphicon glyphicon-arrow-down"></span></A>   --%>       
         </TD>  
  
      </TR>   
    </c:forEach> 
    </tbody>
   
  </TABLE>
</DIV>
 
<jsp:include page="../menu/bottom.jsp" />
</body>
 
</html>
 