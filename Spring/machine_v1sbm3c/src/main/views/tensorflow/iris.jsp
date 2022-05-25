<%@ page contentType="text/html; charset=UTF-8" %>
 
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>http://localhost:9091/tensorflow/iris.do</title>
    <link href="/css/style.css" rel="Stylesheet" type="text/css">

    <script type="text/JavaScript" src="http://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

    <script type="text/javascript">
      $(function() {
        $('#btn_send').on('click', send);
        $('#btn_reset').on('click', function() {
          $("#panel").html("");
        });
        $('#btn_close').on('click', function() { 
          window.close(); 
        });
      });

      function send() {
        var params = $('#frm').serialize(); // 직렬화, 폼의 데이터를 키와 값의 구조로 조합
        alert('params: ' + params);  // 수신 데이터 확인
        $.ajax({
          url: 'http://127.0.0.1:8000/iris_proc',  // Spring Boot -> Django
          type: 'get',  // get or post
          cache: false, // 응답 결과 임시 저장 취소
          async: true,  // true: 비동기 통신
          dataType: 'json', // 응답 형식: json, html, xml...
          data: params,      // 데이터
          success: function(rdata) { // 응답이 온경우, Django -> Spring Boot
            // alert(rdata);
            var str = '';
            str += '<table style="width: 100%;">';
            str += '  <row>';
            str += '    <td style="width: 50%; text-align: center;">';      
            str += '      <span style="font-size: 20px;">예측 결과</span><br>';
            if (rdata.result == 0) {         // Iris-setosa
                str += '<IMG src="/images/Iris-setosa.jpg" style="width: 70%;">';
            } else if (rdata.result == 1) { // Iris-versicolor
                str += '<IMG src="/images/Iris-versicolor.jpg" style="width: 70%;">';
            } else if (rdata.result == 2) { // Iris-virginica
                str += '<IMG src="/images/Iris-virginica.jpg" style="width: 70%;">';
            }
            str += '    </td>';      
            str += '    <td style="width: 50%;">';      
            str += "      <ul>";
            str += '        <li>' + '꽃받힘 길이(sepal_length): ' + rdata.sepal_length + '</li>';
            str += '        <li>' + '꽃받힘 너비(sepal_width): ' + rdata.sepal_width + '</li>';
            str += '        <li>' + '꽃잎 길이(petal_length): ' + rdata.petal_length + '</li>';
            str += '        <li>' + '꽃잎 너비(petal_width): ' + rdata.petal_width + '</li>';
            str += "      </ul>";
            str += '    </td>';      
            str += '  </row>';  
            str += '</table>';

            $('#panel').html(str);  // 결과 이미지 출력

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
    <DIV style='font-size: 30px;'>IRIS</DIV>

    <DIV id='panel' style='display: none; margin: 5px auto; width: 100%;'></DIV>

    <form id='frm' name='frm' action='/wine_proc/' method='GET'>
        <DIV style='margin: 10px auto;'>
              데이터:
              <!-- <input name="data" id="data" type="text" min = "0" max="1000" step="1" style="width: 80%;"
                     value="5.1,3.5,1.4,0.2"><br> -->
              꽃받힘 길이(sepal_length): <input type='number' name='sepal_length' min='0' max='100' step='0.1' 
                                                          value='5.1' style='width: 30%;'> cm<br>      
              꽃받힘 너비(sepal_width): <input type='number' name='sepal_width' min='0' max='100' step='0.1' 
                                                          value='3.5' style='width: 30%;'> cm<br>      
              꽃잎 길이(petal_length): <input type='number' name='petal_length' min='0' max='100' step='0.1' 
                                                        value='1.4' style='width: 30%;'> cm<br>      
              꽃잎 너비(petal_width): <input type='number' name='petal_width' min='0' max='100' step='0.1' 
                                                       value='0.2' style='width: 30%;'> cm<br><br>      
              Iris-setosa 데이터 예: 5.1,3.5,1.4,0.2<br> <!-- sepal_length, sepal_width, petal_length, petal_width -->
              Iris-versicolor 데이터 예: 5.0,2.0,3.5,1.0<br>
              Iris-virginica 데이터 예: 6.5,3.2,5.1,2.0<br>
        </DIV>
        <DIV style="text-align:center;">
            <button type='button' id='btn_send'>처리</button>
            <button type='button' id='btn_reset'>결과 지우기</button>
            <button type='button' id='btn_close'>닫기</button>
        </DIV>
    </form>
</DIV>
</body>
</html>

