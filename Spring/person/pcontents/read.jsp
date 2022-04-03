<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="pcontentsno" value="${pcontentsVO.pcontentsno }" />
<c:set var="pcateno" value="${pcontentsVO.pcateno }" />
<c:set var="title" value="${pcontentsVO.title }" />        
<c:set var="price" value="${pcontentsVO.price }" />
<c:set var="dc" value="${pcontentsVO.dc }" />
<c:set var="saleprice" value="${pcontentsVO.saleprice }" />
<c:set var="point" value="${pcontentsVO.point }" />
<c:set var="salecnt" value="${pcontentsVO.salecnt }" />
<c:set var="file1" value="${pcontentsVO.file1 }" />
<c:set var="file1saved" value="${pcontentsVO.file1saved }" />
<c:set var="thumb1" value="${pcontentsVO.thumb1 }" />
<c:set var="content" value="${pcontentsVO.content }" />
<c:set var="word" value="${pcontentsVO.word }" />
<c:set var="size1_label" value="${pcontentsVO.size1_label }" />
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>Resort world</title>
 
<link href="/css/style.css" rel="Stylesheet" type="text/css">
 
<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<!-- Bootstrap -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    
<script type="text/javascript">
  $(function(){
 
  });
</script>
 
</head> 
 
<body>
<jsp:include page="../menu/top.jsp" flush='false' />
 
<DIV class='title_line'>
  <A href="../pcategrp/list.do" class='title_link'>카테고리 그룹</A> > 
  <A href="../pcate/list_by_pcategrpno.do?pcategrpno=${pcategrpVO.pcategrpno }" class='title_link'>${pcategrpVO.name }</A> >
  <A href="./list_by_pcateno_search_paging.do?pcateno=${pcateVO.pcateno }" class='title_link'>${pcateVO.name }</A>
</DIV>

<DIV class='content_body'>
  <ASIDE class="aside_right">
    <A href="./create.do?pcateno=${pcateVO.pcateno }">등록</A>
    <span class='menu_divide' >│</span>
    <A href="javascript:location.reload();">새로고침</A>
    <span class='menu_divide' >│</span>
    <A href="./list_by_pcateno_search_paging.do?pcateno=${pcateVO.pcateno }&now_page=${param.now_page}&word=${param.word }">기본 목록형</A>    
    <span class='menu_divide' >│</span>
    <A href="./list_by_pcateno_grid.do?pcateno=${pcateVO.pcateno }">갤러리형</A>
    <span class='menu_divide' >│</span>
    <A href="./update_text.do?pcontentsno=${pcontentsno}&now_page=${param.now_page}">수정</A>
    <span class='menu_divide' >│</span>
    <A href="./update_file.do?pcontentsno=${pcontentsno}&now_page=${param.now_page}">파일 수정</A>  
    <span class='menu_divide' >│</span>
    <A href="./delete.do?pcontentsno=${pcontentsno}&now_page=${param.now_page}&pcateno=${pcateno}">삭제</A>  
  </ASIDE> 
  
  <DIV style="text-align: right; clear: both;">  
    <form name='frm' id='frm' method='get' action='./list_by_pcateno_search.do'>
      <input type='hidden' name='pcateno' value='${pcateVO.pcateno }'>
      <c:choose>
        <c:when test="${param.word != '' }"> <%-- 검색하는 경우 --%>
          <input type='text' name='word' id='word' value='${param.word }' style='width: 20%;'>
        </c:when>
        <c:otherwise> <%-- 검색하지 않는 경우 --%>
          <input type='text' name='word' id='word' value='' style='width: 20%;'>
        </c:otherwise>
      </c:choose>
      <button type='submit'>검색</button>
      <c:if test="${param.word.length() > 0 }">
        <button type='button' 
                     onclick="location.href='./list_by_pcateno_search.do?pcateno=${pcateVO.pcateno}&word='">검색 취소</button>  
      </c:if>    
    </form>
  </DIV>
  
  <DIV class='menu_line'></DIV>

  <fieldset class="fieldset_basic">
    <ul>
      <li class="li_none">
        <c:set var="file1saved" value="${file1saved.toLowerCase() }" />
        <DIV style="width: 50%; float: left; margin-right: 10px;">
            <c:choose>
              <c:when test="${thumb1.endsWith('jpg') || thumb1.endsWith('png') || thumb1.endsWith('gif')}">
                <%-- /static/pcontents/storage/ --%>
                <IMG src="/pcontents/storage/${file1saved }" style="width: 100%;"> 
              </c:when>
              <c:otherwise> <!-- 기본 이미지 출력 -->
                <IMG src="/pcontents/images/none1.png" style="width: 100%;"> 
              </c:otherwise>
            </c:choose>
        </DIV>
        <DIV style="width: 47%; height: 260px; float: left; margin-right: 10px; margin-bottom: 30px;">
          <span style="font-size: 1.5em; font-weight: bold;">${title }</span><br>
          <span style="color: #FF0000; font-size: 2.0em;">${dc} %</span>
          <span style="font-size: 1.5em; font-weight: bold;"><fmt:formatNumber value="${saleprice}" pattern="#,###" /> 원</span>
          <del><fmt:formatNumber value="${price}" pattern="#,###" /> 원</del><br>
          <span style="font-size: 1.2em;">포인트: <fmt:formatNumber value="${point}" pattern="#,###" /> 원</span><br>
          <span style="font-size: 1.0em;">(보유수량: <fmt:formatNumber value="${salecnt}" pattern="#,###" /> 개)</span><br>
          <span style="font-size: 1.0em;">수량</span><br>
          <form>
          <input type='number' name='ordercnt' value='1' required="required" 
                     min="1" max="99999" step="1" class="form-control" style='width: 30%;'><br>
          <button type='button' onclick="" class="btn btn-info">장바 구니</button>           
          <button type='button' onclick="" class="btn btn-info">바로 구매</button>
          <button type='button' onclick="" class="btn btn-info">관심 상품</button>
          </form>
        </DIV> 

        <DIV>${content }</DIV>
      </li>
      <li class="li_none">
        <DIV style='text-decoration: none;'>
          검색어(키워드): ${word }
        </DIV>
      </li>
      <li class="li_none">
        <DIV>
          <c:if test="${file1.trim().length() > 0 }">
            첨부 파일: <A href='/download?dir=/pcontents/storage&filename=${file1saved}&downname=${file1}'>${file1}</A> (${size1_label})  
          </c:if>
        </DIV>
      </li>   
    </ul>
  </fieldset>

</DIV>
 
<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
 
</html>