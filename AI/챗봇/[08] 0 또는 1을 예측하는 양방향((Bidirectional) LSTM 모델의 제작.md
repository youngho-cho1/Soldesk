0 또는 1을 예측하는 양방향 LSTM 모델의 제작
   - 양방향에서 문장의 패턴을 분석 할 수 있는 패턴으로 LSTM 대비 정확도가 향상됨.
   - 문장이 긴 경우 단방향 LSTM의 경우 정확도가 떨어지는 문제를 해결
   - 문장에서 중요단어가 뒤에 있는 경우 정확도가 떨어지는 문제를 해결함.
     예) 유럽 여행중 ________ 타고 창밖 풍경을 보는사이 어느세 종착역에 도착했다. 

1. 양방향 LSTM 구조
![image](https://user-images.githubusercontent.com/74487628/180231087-2efc604d-005e-40f2-b6db-745fdbcaff18.png)
2. TimeDistributed: Dense가 3차원 데이터를 받을 수 있도록 처리함.
![image](https://user-images.githubusercontent.com/74487628/180231135-4bc77d5d-02af-436e-b1cc-a7d61e427def.png)
