CREATE SEQUENCE memo_seq
  START WITH 1           -- 시작 번호
  INCREMENT BY 1       -- 증가값
  MAXVALUE 99999999  -- 최대값: 99999999 --> NUMBER(8) 대응
  CACHE 2                  -- 2번은 메모리에서만 계산
  NOCYCLE;                 -- 다시 1부터 생성되는 것을 방지
  
DROP SEQUENCE memo_seq;

SELECT memo_seq.nextval; -- X, FROM이 반드시 선언되어야함.

-- dual 테이블: SQL 구조를 지원하는 시스템 테이블, 삭제하면 안됨, MySQL은 FROM 생략 가능
SELECT * FROM dual;
    D
---------
    X
    
-- sequence 사용, nextval 사용시 시퀀스는 증가되어 사용됨.
SELECT memo_seq.nextval FROM dual;
   NEXTVAL
----------
         1
         
-- 현재 sequence 확인, currval은 호출해도 값이 증가되지 않음.
SELECT memo_seq.currval FROM dual;

-- 테이블에서의 Sequence 사용
DROP TABLE memo;  -- "table or view does not exist"

CREATE TABLE memo(
  memono NUMBER(7)      NOT NULL,
  title        VARCHAR(100) NOT NULL,
  PRIMARY KEY(memono)
);

INSERT INTO memo(memono, title)
VALUES(memo_seq.nextval, '공지사항 개발');

INSERT INTO memo(memono, title)
VALUES(memo_seq.nextval, '공지사항 테스트');

INSERT INTO memo(memono, title)
VALUES(memo_seq.nextval, '공지사항 배포');

SELECT memono, title FROM memo ORDER BY memono ASC;
    MEMONO TITLE                                                                                               
---------- ----------------------------------------------------------------------------------------------------
         2 공지사항 개발                                                                                       
         3 공지사항 테스트                                                                                     
         4 공지사항 배포     
         
-- 마지막에 등록한 레코드 삭제
DELETE FROM memo WHERE memono = 15;

INSERT INTO memo(memono, title)
VALUES(memo_seq.nextval, '공지사항 교육');

-- 한번 삭제된 번호는 다시 생성되지 않음.         
SELECT memono, title FROM memo ORDER BY memono ASC;         
    MEMONO TITLE                                                                                               
---------- ----------------------------------------------------------------------------------------------------
         2 공지사항 개발                                                                                       
         3 공지사항 테스트                                                                                     
         5 공지사항 교육       

-- 생성된 Sequence의 확인         
SELECT * FROM user_sequences;

SEQUENCE_NAME                   MIN_VALUE  MAX_VALUE INCREMENT_BY C O CACHE_SIZE LAST_NUMBER
------------------------------ ---------- ---------- ------------ - - ---------- -----------
MEMO_SEQ                                1   99999999            1 N N          2           5
SALES_SEQ                               1   99999999            1 N N          2          11

