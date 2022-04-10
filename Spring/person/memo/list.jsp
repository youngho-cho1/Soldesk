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
<link href="/css/button.css" rel="Stylesheet">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    
<script type="text/javascript">
 
  
</script>
 
</head> 
  
<body>
<jsp:include page="../menu/top.jsp" />
 
<DIV class='title_line'>
  <A href="../memo/list.do" class='title_link'>메모장</A> 
</DIV>

<DIV class='content_body'>
  <ASIDE class="aside_right">
    <A href="./create.do}">등록</A>
    <span class='menu_divide' >│</span>
    <A href="javascript:location.reload();">새로고침</A>
  </ASIDE> 

  <DIV style="text-align: right; clear: both;">  
    <form name='frm' id='frm' method='get' action='./list.do'>
      <%-- <input type='hidden' name='pcateno' value='${pcateVO.pcateno }'> --%>
      <input type='text' name='word' id='word' value='${param.word }' style='width: 20%;'>
      <button type='submit'>검색</button>
      <c:if test="${param.word.length() > 0 }">
        <button type='button' 
                     onclick="location.href='./list.do&word='">검색 취소</button>  
      </c:if>    
    </form>
  </DIV>
  
  <DIV class='menu_line'></DIV>
  
  <table class="table table-striped" style='width: 100%;'>
    <colgroup>
      <col style="width: 10%;"></col>
      <col style="width: 60%;"></col>
      <col style="width: 20%;"></col>
      <col style="width: 10%;"></col>
    </colgroup>
    <tbody>
      <c:forEach var="memoVO" items="${list }">
        <c:set var="memono" value="${memoVO.memono }" />
        <c:set var="title" value="${memoVO.title }" />
        <c:set var="content" value="${memoVO.content }" />
        <c:set var="file1" value="${memoVO.file1 }" />
        <c:set var="file1saved" value="${memoVO.file1saved }" />
        <c:set var="thumb1" value="${memoVO.thumb1 }" />
        <c:set var="size1" value="${memoVO.size1 }" />
        <c:set var="sw" value="${memoVO.sw }" />
        <c:set var="rdate" value="${memoVO.rdate }" />
 
             
        <tr> 
          <td style='vertical-align: middle; text-align: center;'>
            <c:choose>
              <c:when test="${thumb1.endsWith('jpg') || thumb1.endsWith('png') || thumb1.endsWith('gif')}">        
                <a href="./read.do?memono=${memono}&now_page=${param.now_page }"><IMG src="/memo/storage/${thumb1 }" style="width: 120px; height: 80px;"></a>  
              </c:when>
              <c:otherwise> <!-- 기본 이미지 출력 -->
                <IMG src="/memo/images/none1.PNG" style="width: 120px; height: 80px;">
              </c:otherwise>
            </c:choose>
          </td>  
          <td style='vertical-align: middle;'>
            <a href="./read.do?memono=${memono}&now_page=${param.now_page }"><strong>${title}</strong> ${content}</a>  
          </td> 
          <td style='vertical-align: middle; text-align: center;'>
             <c:if test="${sw=='A'}"> <button class="w-btn w-btn-gra1 w-btn-gra-anim" type="button">기타</button> </c:if>
             <c:if test="${sw=='B'}"> <button class="w-btn w-btn-gra2 w-btn-gra-anim" type="button">할일</button> </c:if>
             <c:if test="${sw=='C'}"> <button class="w-btn w-btn-gra3 w-btn-gra-anim" type="button">진행중</button> </c:if>
          </td>
          <td style='vertical-align: middle; text-align: center;'>
            <A href="./update_text.do?memono=${memono}&now_page=${now_page }"><span class="glyphicon glyphicon-pencil"></span></A>
            <A href="./delete.do?memono=${memono}&now_page=${now_page }"><span class="glyphicon glyphicon-trash"></span></A>
          </td>
        </tr>
      </c:forEach>
      
    </tbody>
  </table>
  
  <!-- 페이지 목록 출력 부분 시작 -->
  <DIV class='bottom_menu'>${paging }</DIV> <%-- 페이지 리스트 --%>
  <!-- 페이지 목록 출력 부분 종료 -->
  
</DIV>

 
<jsp:include page="../menu/bottom.jsp" />
</body>
 
</html>
