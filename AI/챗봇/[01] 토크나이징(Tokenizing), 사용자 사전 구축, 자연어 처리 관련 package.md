[01] 토크나이징(Tokenizing)
   - 자연어는 수치 연산을 처리하는 컴퓨터는 이해 할 수 없음.
   - 문장을 이해 할 수 없음으로 최소 의미를 갖는 단어의 형태인 형태소로 분할해야하며 이렇게 분할된 단어를 토큰이라고함.
   - 토큰으로 분리하는 토크나이징은 언어의 문법을 알아야하며 이런 과정은 어렵기 때문에 각 언어를 지원하는 토크나이징 package를 이용함.
   - 한국어 토크나이징을 위해서 KoNLPy가 존재함.

1. 한국어 품사의 분류
![image](https://user-images.githubusercontent.com/74487628/178012725-c44d9cce-e524-4c87-840a-165b7e0447d8.png)
[02] KoNLPy 실습

   - 형태소(의미를 갖는 최소 단위) 분석기
![image](https://user-images.githubusercontent.com/74487628/178012915-d2494516-de30-4140-b92c-4499f90dc167.png)
1. Kkma 품사 태그
   - http://kkma.snu.ac.kr
   - NNG: 일반 명사
   - JKS: 주격 조사
   - JKM: 부사격 조사
   - VV: 동사
   - EFN: 평서형 종결 어미
   - SF: 마치표, 물음표, 느낌표


2. Komoran 형태소 분석기 품사 태그표
   - https://docs.komoran.kr/index.html
   - NNG: 일반 명사
   - JKS: 주격 조사
   - JKB: 부사격 조사
   - VV: 동사
   - EF: 종결 어미
   - SF: 마치표, 물음표, 느낌표


3. Okt 형태소 분석기 품사 태그표
   - Noun: 명사
   - Verb: 동사
   - Adjective: 형용사
   - Josa: 조사
   - Punctuation: 구두점
