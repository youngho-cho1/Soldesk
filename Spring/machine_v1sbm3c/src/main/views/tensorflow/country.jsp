<%@ page contentType="text/html; charset=UTF-8" %>
 
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>http://localhost:9091/tensorflow/country.do</title>
    <link href="/css/style.css" rel="Stylesheet" type="text/css">

	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
	
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v6.1.1/css/all.css"></head>

    <script type="text/javascript">
      $(function() { // 자동 실행, 동적 이벤트 등록, 마우스 클릭시 실행할 함수 선언
        $('#btn_country').on('click', country);
        $('#btn_city').on('click', city);
        $('#btn_send').on('click', send);
        // document.getElementById('btn_send').addEventListener('click', send); 동일
        $('#btn_reset').on('click', function() {$("#panel").html("");}); // panel 내용 지우기
        $('#btn_close').on('click', function() { window.close(); });     // 윈도우 닫기
      });

      function send() {
        var params = $('#frm').serialize(); // 직렬화, 폼의 데이터를 키와 값의 구조로 조합
        // alert('params: ' + params);  // 수신 데이터 확인
        $.ajax({
          url: 'http://localhost:8000/country_proc', // Spring Boot -> Django
          type: 'get',  // get or post
          cache: false, // 응답 결과 임시 저장 취소
          async: true,  // true: 비동기 통신
          dataType: 'json', // 응답 형식: json, html, xml...
          data: params,      // 데이터
          success: function(rdata) { // Django -> Spring Boot ★
            // alert(rdata.result);
            var str = '';
            str += "<ul>";
            str += '<li>' + 'data: ' + rdata.data + '</li>';
            str += '<li style="list-style: none;"><br>예측 결과(적응률): '+rdata.result+' % </li>';

            if (rdata.result >= 50) {
                str += '<li style="list-style: none;">시골형: 시골에 적응 할 수 있습니다.</li>';
            } else {
                str += '<li style="list-style: none;">도시형: 시골에 적응이 불가능합니다.</li>';
            }
            str += '</ul>';
            $('#panel').html(str);  // document.getElementById('panel').innerHTML=str;
         },
          // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우
          error: function(request, status, error) { // callback 함수
            console.log(error);
          }
        });

        // $('#panel').html('처리중입니다....');  // 텍스트를 출력하는 경우
        $('#panel').html("<img src='/images/ani04.gif' style='width: 10%;'>");
        $('#panel').show(); // 숨겨진 태그의 출력
      }

      // 시골형: 2,1,1,10,1,2
      function country() {
        $('#drink').val(2);
        $("input:radio[name='life']:radio[value='1']").prop('checked', true);
        $("input:radio[name='cousin']:radio[value='1']").prop('checked', true);
        $('#trip').val(10);
        $("input:radio[name='house']:radio[value='1']").prop('checked', true);
        $("input:radio[name='land']:radio[value='2']").prop('checked', true);
      }

      // 도시형: 2,1,0,7,1,0
      function city () {
        $('#drink').val(2);
        $("input:radio[name='life']:radio[value='1']").prop('checked', true);
        $("input:radio[name='cousin']:radio[value='0']").prop('checked', true);
        $('#trip').val(7);
        $("input:radio[name='house']:radio[value='1']").prop('checked', true);
        $("input:radio[name='land']:radio[value='0']").prop('checked', true);
      }
    </script>
</head>
<body>
<DIV class="container">
    <H1>귀농귀촌 적응 예측 시스템</H1>

    <DIV id='panel' style='display: none; margin: 10px auto; width: 90%;'></DIV>
    <div id='chart' style='width: 80%; display: none;'></div>

    <form id='frm' name='frm' action='/country/proc' method='GET'>
        <br>
        <OL>
          <LI class="li_question">
              주당 음주 횟수: 0 ~ 3(3회 이상):
              <input name="drink" id="drink" type="number" min = "0" max="3" step="1" value="">
          </LI>
          <LI class="li_question">
              농촌에서 생활적이 있다:
              <label style="cursor: pointer;">
                  <input name="life" id="life1" type="radio" value="1"> 있음
              </label>
              <label style="cursor: pointer;">
                  <input name="life"  id="life0" type="radio" value="0"> 없음
              </label>
          </LI>
          <LI class="li_question">
              가족중에 농촌에서 생활하고 있는 친척있는 여부:
              <label style="cursor: pointer;">
                  <input name="cousin" id="cousin1" type="radio" value="1"> 있음
              </label>
              <label style="cursor: pointer;">
                  <input name="cousin" id="cousin0" type="radio" value="0"> 없음
              </label>
          </LI>
          <LI class="li_question">
              1년동안의 여행 횟수: 0 ~ 12 (등산/캠핑, 당일, 국내, 국외 모두 해당)
              <input name="trip" id="trip" type="number" min = "0" max="12" step="1" value="">
          </LI>
          <LI class="li_question">
              집을 소유 할 수 있는 경제력:
              <label style="cursor: pointer;">
                  <input name="house" id="house1" type="radio" value="1"> 있음
              </label>
              <label style="cursor: pointer;">
                  <input name="house" id="house0" type="radio" value="0"> 없음
              </label>
          </LI>
          <LI class="li_question">
              경작 할 수 있는 토지 평수: 0 ~ (평)<br>
              <label style="cursor: pointer;">
                  <input name="land" id="land0" type="radio" value="0"> 없음
              </label>
              <label style="cursor: pointer;">
                  <input name="land" id="land1" type="radio" value="1"> 1 ~ 2000 미만
              </label>
              <label style="cursor: pointer;">
                  <input name="land" id="land2" type="radio" value="2"> 2000이상 ~ 3000미만
              </label>
              <label style="cursor: pointer;">
                  <input name="land" id="land3" type="radio" value="3"> 3000이상
              </label>
          </LI>
        </OL>

        <br>
        <DIV style="text-align:center;">
            <button type='button' id='btn_country' class='btn btn-info'>시골형 데이터 설정</button>
            <button type='button' id='btn_city' class='btn btn-info'>도시형 데이터 설정</button>
            <button type='button' id='btn_send' class='btn btn-info'>예측</button>
            <button type='button' id='btn_close' class='btn btn-info'>닫기</button>
        </DIV>
    </form>
</DIV>
</body>
</html>

 
 
