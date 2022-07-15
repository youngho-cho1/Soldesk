순환신경망(RNN: Recurrent Neural Network), 시계열 자료의 처리
- 일정한 시간 간격으로 배치된 시계열 데이터의 처리
- NLP(자연어 처리), 텍스트등의 순차 데이터의 처리
- 완전 연결 신경망(DNN)이나 CNN은 이전에 학습된 데이터를 기억하지 않고 처리후 메모리에서 삭제됨.
- 순환 신경망은 이전 데이터를 메모리에 기록함.
- 이전 데이터의 처리 결과가 다음 데이터 입력시 영향을 주는 구조

1. 순환 신경망 구조
1) 현재 데이터와 은닉층에서 출력된 데이터가 같이 사용됨. 
![image](https://user-images.githubusercontent.com/74487628/179210792-9f659bfc-db2d-42d3-a1c4-e93e79520438.png)
2) 순환 신경망의 node를 Cell 이라고함.
  . x: 입력, h: 출력, hp: 이전 타임 스텝의 은식 상태
![image](https://user-images.githubusercontent.com/74487628/179210818-e69a0918-a3e1-4b67-897e-dbe0b5883357.png)
3) 출력값 계산
    X: 입력값
    Hp: 이전 타임 스텝의 은식 상태
    Wx: X에 곱해지는 가중치
    Wh: Hp에 곱해지는 가중치
    b: 편향,y 절편
    H: 출력, 활성화 함수로 tanh(Hyperbolic tangent) 사용
![image](https://user-images.githubusercontent.com/74487628/179210834-28db3f0a-444f-4b02-a2b0-31b13f9b675f.png)
4) 활성화 함수로 tanH가 많이 사용됨, Relu도 사용됨.
![image](https://user-images.githubusercontent.com/74487628/179210924-049a2a2c-8e0e-455c-901b-d15753fe551e.png)
2. 가중치의 흐름: 전결합 층에 출력 상태를 저장하는 기능이 추가됨.
![image](https://user-images.githubusercontent.com/74487628/179210945-9d73ac01-a2a9-4432-ad02-8fc157766821.png)
3. 데이터 A가 입력되어 처리된후 2가지의 출력이 발생하며 1가지는 이후에 재사용됨.
![image](https://user-images.githubusercontent.com/74487628/179210976-7534b8b1-1d7f-4f92-bb6a-9a220d5b1750.png)
- 데이터 B가 입력되어 사용되는 경우 A의 출력 결과가 재사용됨.
![image](https://user-images.githubusercontent.com/74487628/179211000-37c67b0b-4fe4-46d8-a76a-3ef0ec1a0b3b.png)
- 데이터 C가 입력되어 사용되는 경우 B의 출력 결과가 재사용됨,
  이때 미약하지만 A 데이터의 영향이 C에까지 전달됨,
  여기서는 A, B, C 데이터임으로 『타임 스텝』은 3이됨.
![image](https://user-images.githubusercontent.com/74487628/179211039-8cf9824b-a484-4f5d-8989-da89e6e8e574.png)
- 셀의 출력은 은닉 상태가 됨.
![image](https://user-images.githubusercontent.com/74487628/179211086-34a49444-c24e-4e14-a467-f40e85dfdc08.png)
4. '하나의 rnn cell'에서의 hidden 레이어의 출력값 전달 흐름
   - 하나의 셀은 2개의 가중치 파라미터, 절편 1개, 상태 저장용 파라미터 1개, 출력용 파라미터 1개로 구성됨.
![image](https://user-images.githubusercontent.com/74487628/179211123-dc712bac-5db0-4106-b8af-73e6afb15d0f.png)
- 입력값 3개가 하나의 rnn cell에 입력되는 경우
     . 첫번째 타임 스텝에서 h0는 0을 가지고 있음
     . 연산이 일어난 후 첫번째 타임 스텝 출력 h1이 2번째 타임 스텝 Wh와 곱해져서 입력됨
     . 두번째 타임 스텝 출력 h2가 3번째 타임 스텝 Wh와 곱해져서 입력됨
![image](https://user-images.githubusercontent.com/74487628/179211147-d929dcb8-79e7-4723-82f9-108f6277bc74.png)
5. 3개의 셀은 어떤 rnn 셀에 데이터가 전달되더라도 서로 가중치를 전달함으로 rnn셀이 3개이면 가중치는 9개가 발생함.
![image](https://user-images.githubusercontent.com/74487628/179211177-6cf8a244-631f-4222-859e-c61a2f95f6d9.png)
- 파라미터 계산: 순환 신경망 갯수 x 3 = 9 개의 가중치가 발생함.
![image](https://user-images.githubusercontent.com/74487628/179211208-17981e3b-3b7b-4d14-9aa3-04c380aa40b7.png)
6. 처리되는 데이터는 타임 스텝이라고 함
   - 입력되는 데이터는 주로 2차원의 형태를 가지고 있음.
   - 하나의 sample을 sequence(문장)라고함, 시퀀스 안에는 여러개의 아이템(단어)이 들어가 있음.
   - 시퀀스의 길이(단어의 개수)가 타임스텝(소그룹)의 길이가 됨. ★
   - 각단어를 3개의 숫자로 표현하면서 4개의 단어로 구성되는 문장의 타임 스텝: 4
![image](https://user-images.githubusercontent.com/74487628/179211254-b44f94c4-cf23-42e9-82b7-1f6887a48a63.png)
순환층 통과후 아래의 결과가 됨, rnn 뉴런의 수가 출력(1차원 배열의 형태) 갯수가됨.
![image](https://user-images.githubusercontent.com/74487628/179211276-e4fd6347-ec31-46d2-a7d6-45851a35658b.png)
7. 최종 출력은 마지막 타임 스텝의 은닉 상태가 결과로 출력됨.
![image](https://user-images.githubusercontent.com/74487628/179211307-7136e5a7-72b4-434f-a30c-b0c1ad4df32c.png)
8. 2개의 rnn 셀이 있는 경우
   - 첫번째 셀은 모든 타임 스텝의 은닉 상태 출력, 마지막 셀은 마지막 타임 스텝의 은닉 상태만 출력
   - I: 처음에는 가장 앞쪽의 타입스텝의 값이 입력
   - am ← I
   - a ← am ← I
   - boy ← a ← am ← I: 마지막 스텝인 boy 데이터의 은닉 상태가 출력됨.
![image](https://user-images.githubusercontent.com/74487628/179211361-99de5fb1-3145-49e0-b7ed-f7346643d070.png)
9. 전체적인 흐름
   - 100개의 단어(표현)들중 20개(단어수)의 단어(타임 스텝)로 이루어진 sample(문장, 숫자 배열...) 입력
   - rnn Cell이 10개임으로 10개의 출력 발생
   - 출력이 1차원임으로 Flatten 함수를 사용하지 않음.
![image](https://user-images.githubusercontent.com/74487628/179211399-75e54e54-4eaf-4d28-8871-3d95bf740aba.png)




