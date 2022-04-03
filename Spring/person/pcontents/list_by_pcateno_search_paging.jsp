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
 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    
<script type="text/javascript">
 
  
</script>
 
</head> 
  
<body>
<jsp:include page="../menu/top.jsp" />
 
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
    <A href="./list_by_pcateno_grid.do?pcateno=${pcateVO.pcateno }">갤러리형</A>
  </ASIDE> 

  <DIV style="text-align: right; clear: both;">  
    <form name='frm' id='frm' method='get' action='./list_by_pcateno_search_paging.do'>
      <input type='hidden' name='pcateno' value='${pcateVO.pcateno }'>
      <input type='text' name='word' id='word' value='${param.word }' style='width: 20%;'>
      <button type='submit'>검색</button>
      <c:if test="${param.word.length() > 0 }">
        <button type='button' 
                     onclick="location.href='./list_by_pcateno_search_paging.do?pcateno=${pcateVO.pcateno}&word='">검색 취소</button>  
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
    <%-- table 컬럼 --%>
<!--     <thead>
      <tr>
        <th style='text-align: center;'>파일</th>
        <th style='text-align: center;'>상품명</th>
        <th style='text-align: center;'>정가, 할인률, 판매가, 포인트</th>
        <th style='text-align: center;'>기타</th>
      </tr>
    
    </thead> -->
    
    <%-- table 내용 --%>
    <tbody>
      <c:forEach var="pcontentsVO" items="${list }">
        <c:set var="pcontentsno" value="${pcontentsVO.pcontentsno }" />
        <c:set var="pcateno" value="${pcontentsVO.pcateno }" />
        <c:set var="title" value="${pcontentsVO.title }" />
        <c:set var="content" value="${pcontentsVO.content }" />
        <c:set var="file1" value="${pcontentsVO.file1 }" />
        <c:set var="thumb1" value="${pcontentsVO.thumb1 }" />
        
        <c:set var="price" value="${pcontentsVO.price }" />
        <c:set var="dc" value="${pcontentsVO.dc }" />
        <c:set var="saleprice" value="${pcontentsVO.saleprice }" />
        <c:set var="point" value="${pcontentsVO.point }" />
        
        <tr> 
          <td style='vertical-align: middle; text-align: center;'>
            <c:choose>
              <c:when test="${thumb1.endsWith('jpg') || thumb1.endsWith('png') || thumb1.endsWith('gif')}">
                <%-- /static/pcontents/storage/ --%>
                <a href="./read.do?pcontentsno=${pcontentsno}&now_page=${param.now_page }"><IMG src="/pcontents/storage/${thumb1 }" style="width: 120px; height: 80px;"></a> 
              </c:when>
              <c:otherwise> <!-- 기본 이미지 출력 -->
                <IMG src="/pcontents/images/none1.png" style="width: 120px; height: 80px;">
              </c:otherwise>
            </c:choose>
          </td>  
          <td style='vertical-align: middle;'>
            <a href="./read.do?pcontentsno=${pcontentsno}&now_page=${param.now_page }"><strong>${title}</strong> ${content}</a> 
          </td> 
          <td style='vertical-align: middle; text-align: center;'>
            <del><fmt:formatNumber value="${price}" pattern="#,###" /></del><br>
            <span style="color: #FF0000; font-size: 1.2em;">${dc} %</span>
            <strong><fmt:formatNumber value="${saleprice}" pattern="#,###" /></strong><br>
            <span style="font-size: 0.8em;">포인트: <fmt:formatNumber value="${point}" pattern="#,###" /></span>
          </td>
          <td style='vertical-align: middle; text-align: center;'>
            <A href="./update_text.do?pcontentsno=${pcontentsno}&now_page=${now_page }"><span class="glyphicon glyphicon-pencil"></span></A>
            <A href="./delete.do?pcontentsno=${pcontentsno}&now_page=${now_page }&pcateno=${pcateno}"><span class="glyphicon glyphicon-trash"></span></A>
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

 


9. 페이징이 되는 목록으로 이동시 필요한 링크
<TD class="td_bs_left"><A href="../pcontents/list_by_pcateno_search_paging.do?pcateno=${pcateno }">${name }</A></TD>


10. 생성된 페이지 관련 태그

  <!-- 페이지 목록 출력 부분 시작 -->
  <DIV class='bottom_menu'>
    <style type='text/css'>
      #paging {text-align: center; margin-top: 5px; font-size: 1em;}  
      #paging A:link {text-decoration:none; color:black; font-size: 1em;}  
      #paging A:hover{text-decoration:none; background-color: #FFFFFF; color:black; font-size: 1em;}  
      #paging A:visited {text-decoration:none;color:black; font-size: 1em;}  
      .span_box_1{    text-align: center;    font-size: 1em;    border: 1px;    border-style: solid;    border-color: #cccccc;    
                            padding:1px 6px 1px 6px; /*위, 오른쪽, 아래, 왼쪽*/    margin:1px 2px 1px 2px; /*위, 오른쪽, 아래, 왼쪽*/  
      }  
      .span_box_2{    text-align: center;    background-color: #668db4;    color: #FFFFFF;    font-size: 1em;    
                            border: 1px;    border-style: solid;    border-color: #cccccc;    padding:1px 6px 1px 6px; /*위, 오른쪽, 아래, 왼쪽*/ 
                            margin:1px 2px 1px 2px; /*위, 오른쪽, 아래, 왼쪽*/  
      }
    </style>
    <DIV id='paging'>
      <span class='span_box_1'><A href='list_by_pcateno_search_paging.do?word=&now_page=1&pcateno=23'>1</A></span>
      <span class='span_box_2'>2</span>
      <span class='span_box_1'><A href='list_by_pcateno_search_paging.do?word=&now_page=3&pcateno=23'>3</A></span>
      <span class='span_box_1'><A href='list_by_pcateno_search_paging.do?word=&now_page=4&pcateno=23'>4</A></span>
    </DIV>
  </DIV> 
  <!-- 페이지 목록 출력 부분 종료 -->