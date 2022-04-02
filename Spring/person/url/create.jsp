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
 
<DIV class='title_line'>즐겨찾기 등록</DIV>

<DIV class='content_body'>
  <FORM name='frm' method='POST' action='./create.do' class="form-horizontal">
    <!-- 
    부모테이블 urlgrpno PK 컬럼 값 이용, FK 선언
    http://localhost:9091/url/create.do
    http://localhost:9091/url/create.do?urlgrpno=1
     -->
    <input type="hidden" name="urlgrpno" value="${param.urlgrpno }"> 
    
    <div class="form-group">
       <label class="control-label col-md-3">즐겨찾기 이름</label>
       <div class="col-md-9">
         <input type='text' name='title' value='' required="required" 
                   autofocus="autofocus" class="form-control" style='width: 50%;'>
       </div>
       <label class="control-label col-md-3">URL</label>
       <div class="col-md-9">
         <input type='text' name='url' value='' required="required" 
                   autofocus="autofocus" class="form-control" style='width: 50%;'>
          (부모 즐겨찾기 번호: ${param.urlgrpno })         
       </div>
    </div>
    <div class="content_body_bottom" style="padding-right: 20%;">
      <button type="submit" class="btn btn-primary">등록</button>
      <button type="button" onclick="location.href='./list_by_urlgrp.do'" class="btn btn-primary">목록</button>
    </div>
  
  </FORM>
</DIV>
 
<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
 
</html>
