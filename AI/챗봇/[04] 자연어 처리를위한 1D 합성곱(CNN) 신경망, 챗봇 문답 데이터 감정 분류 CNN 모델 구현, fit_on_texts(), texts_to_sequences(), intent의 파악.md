1. 1D CNN 합성곱신경망
1) 'wait for the video and don't rent it'이라는 문장이 있을 때,
   이 문장이 토큰화, 패딩, 임베딩 층(Embedding layer)을 거친다면 다음과 같은 문장 형태의 행렬로 변환될 것임
   아래 그림에서 n은 문장의 길이, k는 임베딩 벡터의 차원(단어를 표현하는 숫자(scalar)의 개수)입니다.
![image](https://user-images.githubusercontent.com/74487628/178752338-87b18f42-2f02-4915-bb38-c3be63e2657c.png)
2) 커널의 차원은 이미 결정이되어 있음으로 커널의 높이만으로 커널의 크기를 설정,
   커널의 크기가 2인경우, 너비는 임베딩 벡터의 차원(k)이 사용됨.
![image](https://user-images.githubusercontent.com/74487628/178752382-4f276544-4dba-422a-accc-d532696f5e37.png)
 - 2D와는 다르게 오른쪽으로 이동할 공간이 없음으로 아래쪽으로만 움직임.
![image](https://user-images.githubusercontent.com/74487628/178752454-217217ca-63d2-466b-b1ec-9eb803e60f40.png)
- 커널의 크기가 3인 경우
![image](https://user-images.githubusercontent.com/74487628/178752507-e77735a0-4ea1-449f-a72c-914b335b0b92.png)
3) Max-pooling
![image](https://user-images.githubusercontent.com/74487628/178752572-a6aed9ee-067a-49b5-80c2-759a40aa98b6.png)
4) 일반적인 설계 형태
![image](https://user-images.githubusercontent.com/74487628/178752705-7fc99b6a-eaa4-472e-9771-2893354d62cf.png)
[02] 챗봇 문답 데이터 감정 분류 CNN 모델 구현
   - 대화의 의도(intent)를 파악하는 모델 제작

1. 데이터
1) 데이터 파일
![image](https://user-images.githubusercontent.com/74487628/178752758-a655e873-42fd-4282-b8c6-8b8773912fb6.png)
2) 레이블
   0: 일상 다반사
   1: 이별(부정)
   2: 사랑(긍정)


2. 모델 제작

1) 문장의 읽기 -> 문장을 토큰화하여 말뭉치에 추가(토큰화) -> 문장의 토큰을 sequence(수치화) 
![image](https://user-images.githubusercontent.com/74487628/178752826-98ef81eb-831c-4cca-a86d-cfbdb715faad.png)
2) 수치화된 토큰을 입력 차원에 일치하도록 pad_sequences() 함수로 padding 처리
   - 문장의 길이에 비하여 입력층의 차원이 너무 작으면 데이터가 손실되며, 너무 크면 자원이 낭비됨.
   - 문장을 구성하는 토큰수의 평균이나 중앙값을 이용하여 최적의 토큰 수 결정
![image](https://user-images.githubusercontent.com/74487628/178752918-05d7055c-b3e1-4ca0-a7e9-ee0473ba50c5.png)
3) 감정 클래스 분류 CNN 모델 블록도
![image](https://user-images.githubusercontent.com/74487628/178752954-3c01e22f-708f-45c4-aeed-a8e597757337.png)
4) 토큰을 빈도수 기준으로 단어 집합 생성
   tokenizer = preprocessing.text.Tokenizer()
   tokenizer.fit_on_texts(corpus) # 토큰을 빈도수 기준으로 단어 집합 생성

5) 전처리 순서
   - text_to_word_sequence: 문장을 형태소로 분리한후 토큰(단어)을 list에 추가
   - fit_on_texts(corpus): 토큰을 빈도수 기준으로 단어 집합 생성
   - texts_to_sequences(corpus): 토큰에 할당된 번호를 기준으로 문장을 시퀀스 번호로 변환
   - 진행 순서: text_to_word_sequence -> fit_on_texts(corpus) -> texts_to_sequences(corpus)




