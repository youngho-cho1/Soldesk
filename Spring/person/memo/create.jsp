<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
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
  <A href="../pcategrp/list.do" class='title_link'>메모장</A> > 
  글 등록
</DIV>

<DIV class='content_body'>
  <ASIDE class="aside_right">
    <A href="./create.do">등록</A>
    <span class='menu_divide' >│</span>
    <A href="javascript:location.reload();">새로고침</A>
    <span class='menu_divide' >│</span>
  </ASIDE> 
  
    <DIV style="text-align: right; clear: both;">  
    <form name='frm' id='frm' method='get' action='./list.do'>
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
                     onclick="location.href='./list.do&word='">검색 취소</button>  
      </c:if>    
    </form>
  </DIV>
  
  <DIV class='menu_line'></DIV>
  
  <FORM name='frm' method='POST' action='./create.do' class="form-horizontal"
             enctype="multipart/form-data">
    <input type="hidden" name="adminno" value="1"> <%-- 관리자 개발후 변경 필요 --%>    
    <div class="form-group">
       <label class="control-label col-md-2">메모장 제목</label>
       <div class="col-md-10">
         <input type='text' name='title' value='제목을 입력하세요.' required="required" 
                   autofocus="autofocus" class="form-control" style='width: 100%;'>
       </div>
    </div>
    <div class="form-group">
       <label class="control-label col-md-2">메모장  내용</label>
       <div class="col-md-10">
         <textarea name='content' required="required" class="form-control" rows="12" style='width: 100%;'>내용을 적어주세요.</textarea>
       </div>
    </div>
    <div class="form-group">
       <label class="control-label col-md-2">검색어</label>
       <div class="col-md-10">
         <input type='text' name='word' value='검색어를 입력해주세요' required="required" 
                    class="form-control" style='width: 100%;'>
       </div>
    </div>   
    <div class="form-group">
       <label class="control-label col-md-2">이미지</label>
       <div class="col-md-10">
         <input type='file' class="form-control" name='file1MF' id='file1MF' 
                    value='' placeholder="파일 선택">
       </div>
    </div>   
    <div class="form-group">
       <label class="control-label col-md-2">현재 상태</label>
       <div class="col-md-10">
         기타 <input type='radio' name='sw' value='A' checked style='width:5%'  > 
         할 일 <input type='radio' name='sw' value='B' style='width:5%'> 
         진행중 <input type='radio' name='sw' value='C' style='width:5%'> 
       </div>
    </div>   
    <div class="content_body_bottom">
      <button type="submit" class="btn btn-primary">등록</button>
      <button type="button" onclick="location.href='./list.do'" class="btn btn-primary">목록</button>
    </div>
    </FORM>
</DIV>
  

<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
 
</html>
