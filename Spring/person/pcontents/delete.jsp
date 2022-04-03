<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="pcontentsno" value="${pcontentsVO.pcontentsno }" />
<c:set var="title" value="${pcontentsVO.title }" />
 
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
    <A href="./list_by_pcateno_search_paging.do?pcateno=${pcateVO.pcateno }">기본 목록형</A>    
    <span class='menu_divide' >│</span>
    <A href="./list_by_pcateno_grid.do?pcateno=${pcateVO.pcateno }">갤러리형</A>
    <span class='menu_divide' >│</span>
    <A href="./update_text.do?pcontentsno=${pcontentsno}">수정</A>
    <span class='menu_divide' >│</span>
    <A href="./update_text.do?pcontentsno=${pcontentsno}">파일 수정</A>  
  </ASIDE> 
  
    <DIV style="text-align: right; clear: both;">  
    <form name='frm' id='frm' method='get' action='./list_by_pcateno_search.do'>
      <input type='hidden' name='pcateno' value='${pcateVO.pcateno }'>
      <input type='text' name='word' id='word' value='${param.word }' style='width: 20%;'>
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
        <DIV style='text-align: center; width: 50%; float: left;'>
          <c:set var="file1saved" value="${pcontentsVO.file1saved.toLowerCase() }" />
          <c:set var="thumb1" value="${pcontentsVO.thumb1 }" />
          <c:choose>
            <c:when test="${thumb1.endsWith('jpg') || thumb1.endsWith('png') || thumb1.endsWith('gif')}">
              <IMG src="/pcontents/storage/${file1saved }" style='width: 90%;'> 
            </c:when>
            <c:otherwise> <!-- 이미지가 없는 경우 -->
              상품 관련 이미지가 없습니다.
            </c:otherwise>
          </c:choose>
        </DIV>

        <DIV style='text-align: left; width: 47%; float: left;'>
          <span style='font-size: 1.5em;'>${title}</span>
          <br>
          <FORM name='frm' method='POST' action='./delete.do'>
              <input type='hidden' name='pcontentsno' value='${param.pcontentsno}'>
              <input type='hidden' name='pcateno' value='${param.pcateno}'>
              <input type='hidden' name='now_page' value='${param.now_page}'>
              
              <DIV id='panel1' style="width: 40%; text-align: center; margin: 10px auto;"></DIV>
                    
              <div class="form-group">   
                <div class="col-md-12" style='text-align: center; margin: 10px auto;'>
                  <span style="color: #FF0000; font-weight: bold;">삭제를 진행 하시겠습니까? 삭제하시면 복구 할 수 없습니다.</span><br><br>
                  패스워드 <input type='password' name='passwd' value='' required="required" style='width: 30%;' autofocus="autofocus">
                  <br><br>
                  <button type = "submit" class="btn btn-primary">삭제 진행</button>
                  <button type = "button" onclick = "history.back()" class="btn btn-primary">취소</button>
                </div>
              </div>   
          </FORM>
        </DIV>
      </li>
      <li class="li_none">

      </li>   
    </ul>
  </fieldset>

</DIV>
 
<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
 
</html>