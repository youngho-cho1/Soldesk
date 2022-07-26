1. 챗봇 엔진 입력 처리 과정(Tensorflow model이 진행: 의도 탐색 모델, 개체명 탐색 모델)
![image](https://user-images.githubusercontent.com/74487628/180914261-545ccc2f-498a-4a63-acca-2587954134c0.png)
2. 챗봇 엔진 답변 처리 과정(SQL, WHERE 절에서 intent, NER을 검색하여 answer를 답변)
![image](https://user-images.githubusercontent.com/74487628/180914272-a21d7362-b216-4829-85a3-2e1ac09d7d16.png)
3. 폴더 구조
   - /NLP/chatbot/train_tools: 챗봇 학습툴 관련 파일
   - /NLP/chatbot/train_tools/qna: 
   - /NLP/chatbot/models: 챗봇 엔진에서 사용하는 딥러닝 모델 관련 파일
   - /NLP/chatbot/models/intent: 의도 분류 모델 관련 파일
   - /NLP/chatbot/models/ner: 개체 인식 모델 관련 파일
   - /NLP/chatbot/utils: 챗봇 개발에 필요한 유틸리티 라이브러리
   - /NLP/chatbot/config: 챗봇 개발에 필요한 설정
   - /NLP/chatbot/dict: 고유명사등의 사용자 사전 파일 저장


4. 테이블 구조
![image](https://user-images.githubusercontent.com/74487628/180914300-ca257a9d-8aee-445a-b8ca-727605918499.png)
