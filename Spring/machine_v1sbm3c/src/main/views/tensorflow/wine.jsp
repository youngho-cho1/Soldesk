<%@ page contentType="text/html; charset=UTF-8" %>
 
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>http://localhost:9091/tensorflow/wine.do</title>
    <link href="/css/style.css" rel="Stylesheet" type="text/css">

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
    
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v6.1.1/css/all.css"></head>

    <script type="text/javascript">
      $(function() { // 자동 실행
        // id가 'btn_send'인 태그를 찾아 'click' 이벤트 처리자(핸들러)로 send 함수를 등록
        $('#btn_send').on('click', send);
        // document.getElementById('btn_send').addEventListener('click', send); 동일
        // panel 내용 지우기, $("#chart").hide(): 그래프는 숨겨야함.
        $('#btn_reset').on('click', function() {$("#panel").html(""); });
        $('#btn_close').on('click', function() { window.close(); });     // 윈도우 닫기
      });

      function send() {
        var params = $('#frm').serialize(); // 직렬화, 폼의 데이터를 키와 값의 구조로 조합
        // alert('params: ' + params);  // 수신 데이터 확인
        $.ajax({
          url: 'http://localhost:8000/wine_proc',
          type: 'get',  // get or post
          cache: false, // 응답 결과 임시 저장 취소
          async: true,  // true: 비동기 통신
          dataType: 'json', // 응답 형식: json, html, xml...
          data: params,      // 데이터
          success: function(rdata) { // 응답이 온경우
            red_probability = rdata.result.toFixed(1);  // RED 와인 확률, 소수 첫째자리까지 반올림
            white_probability = (100 - rdata.result).toFixed(1); // White 와인 확률
            // alert(rdata);
            var str = '';
            str += "<ul>";
            str += '<li>' + 'data: ' + rdata.data + '</li>';
            str += '<li style="list-style: none;"><br>예측 결과</li>';
            str += '<li>' + 'RED 와인 확률:' + red_probability + '</li>';
            str += '<li>' + 'White 와인 확률:' + white_probability + '</li>';
            str += '</ul>';
            $('#panel').html(str);  // 텍스트 출력
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
    </script>
</head>
<body>
<DIV class="container">
    <H1>Wine</H1>

    <DIV id='panel' style='display: none; margin: 10px auto; width: 90%;'></DIV>

    <form id='frm' name='frm' method='GET'>
        <br>
        <OL>
          <LI class="li_question">
              데이터:
              <input name="data" id="data" type="text" min = "0" max="1000" step="1" style="width: 80%;"
                     value="6.7,0.675,0.07,2.4,0.089,17,82,0.9958,3.35,0.54,10.1,5"><br>
              Red 와인 데이터 예: 6.7,0.675,0.07,2.4,0.089,17,82,0.9958,3.35,0.54,10.1,5<br>
              White 와인 데이터 예: 7.2,0.32,0.36,2,0.033,37,114,0.9906,3.1,0.71,12.3,7<br>
          </LI>
        </OL>

        <br>
        <DIV style="text-align:center;">
            <button type='button' id='btn_send' class='btn btn-info'>처리</button>
            <button type='button' id='btn_reset' class='btn btn-info'>결과 지우기</button>
            <button type='button' id='btn_close' class='btn btn-info'>닫기</button>
        </DIV>

    </form>
</DIV>
</body>
</html>

