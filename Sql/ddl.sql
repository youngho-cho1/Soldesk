1. 테이블 구조

DROP TABLE itpay;  -- 테이블 삭제
 
CREATE TABLE itpay(
    payno    NUMBER(7)   NOT NULL,   -- -9999999 ~ 9999999, 1부터 사용
    sawon    VARCHAR(20) NOT NULL,  -- 사원명
    age       NUMBER(3)   NOT NULL,   -- 나이, 1 ~ 999
    mon      CHAR(6)     NOT NULL,    -- 급여달, 201905
    gdate    DATE                NULL,     -- 수령일
    PRIMARY KEY(payno)
);
  
2. 기초 데이터 추가
-- NOT NULL: 입력시 값 필수 선언, NULL: 입력시 값 생략 가능
INSERT INTO itpay VALUES(1, '가길동', 27, '201901');  -- X
INSERT INTO itpay VALUES(1, '가길동', 27, '201901', sysdate); -- O

-- 컬럼 명시를 권장
-- ORA-00001: 무결성 제약 조건(KD1.SYS_C007962)에 위배됩니다. payno 컬럼에 이미 1이 등록되어 있음.
INSERT INTO itpay(payno, sawon, age, mon, gdate)
VALUES(1, '가길순', 27, '201901', sysdate); 

-- sysdate는 날짜 가감이 가능함.        
INSERT INTO itpay(payno, sawon, age, mon, gdate)
VALUES(2, '나길동', 30, '201901', sysdate-5); -- 날짜수 변경
 
INSERT INTO itpay(payno, sawon, age, mon, gdate)
VALUES(3, '다길동', 34, '201901', sysdate-3);
 
INSERT INTO itpay(payno, sawon, age, mon, gdate)
VALUES(4, '라길동', 36,  '201902', sysdate-1);
 
INSERT INTO itpay(payno, sawon, age, mon) -- gdate는 null 임으로 생략 가능
VALUES(5, '마길동', 38, '201902');

SELECT * FROM itpay;
     PAYNO SAWON                       AGE MON    GDATE              
---------- -------------------- ---------- ------ -------------------
         1 가길동                       27 201901 2021-09-27 04:18:09
         2 나길동                       30 201901 2021-09-22 04:18:25
         3 다길동                       34 201901 2021-09-24 04:18:25
         4 라길동                       36 201902 2021-09-26 04:18:25
         5 마길동                       38 201902                  

rollback; -- INSERT SQL 실행 취소

SELECT * FROM itpay; -- INSERT SQL 실행 취소되어 레코드 없음.

INSERT INTO itpay(payno, sawon, age, mon, gdate) -- gdate는 null 임으로 생략 가능
VALUES(1, '홍길순', 38, '201902', sysdate);

commit;

SELECT * FROM itpay;
     PAYNO SAWON                       AGE MON    GDATE              
---------- -------------------- ---------- ------ -------------------
         1 홍길순                       38 201902 2022-02-22 04:48:44
         
rollback;

SELECT * FROM itpay; -- commit 한후에는 취소(rollback) 못함. 
     PAYNO SAWON                       AGE MON    GDATE              
---------- -------------------- ---------- ------ -------------------
         1 홍길순                       38 201902 2022-02-22 04:48:44

-- varchar(20) 저장할 수 있는 글자의 수는?
-- sawon   VARCHAR(20) NOT NULL,  -- 사원명
-- ERROR 
INSERT INTO itpay(payno, sawon, age, mon, gdate)
VALUES(7, '가나다라마바사', 29, '200804', sysdate);
 -- ORA-12899: "KD1"."ITPAY"."SAWON" 열에 대한 값이 너무 큼(실제: 21, 최대값: 20)

COMMIT;

--------------------------------------------------------------------------------------------
-- 테이블 구조의 변경
--------------------------------------------------------------------------------------------
1. 컬럼 추가
1) 기존에 데이터가 등록되어 있는 경우 컬럼 추가시 null이 지정됨.
DESC itpay;
이름    널?       유형           
----- -------- ------------ 
PAYNO NOT NULL NUMBER(7)    
SAWON NOT NULL VARCHAR2(20) 
AGE   NOT NULL NUMBER(3)    
MON   NOT NULL CHAR(6)      
GDATE          DATE         

ALTER TABLE itpay
ADD(test1 VARCHAR(10));

SELECT * FROM itpay;
     PAYNO SAWON                       AGE MON    GDATE               TEST1     
---------- -------------------- ---------- ------ ------------------- ----------
         1 홍길순                       38 201902 2022-02-22 04:48:44           
    
         
2) 기존에 데이터가 추가되어 있는 경우 NOT NULL 제약조건 적용 안됨, ERROR X
ALTER TABLE itpay
ADD(test2 VARCHAR(10) NOT NULL);
-- ORA-01758: 테이블에 컬럼을 추가하기 위해 (NOT NULL) 비어 있어야 합니다. 레코드가 없어야함.

DELETE FROM itpay; -- 모든 레코드 삭제
COMMIT; -- DBMS 서버에 적용

ALTER TABLE itpay
ADD(test2 VARCHAR(10) NOT NULL); -- 추가 가능

3) 컬럼의 삭제
ALTER TABLE itpay
DROP COLUMN test1;

DESC itpay;
이름    널?       유형           
----- -------- ------------ 
PAYNO NOT NULL NUMBER(7)    
SAWON NOT NULL VARCHAR2(20) 
AGE   NOT NULL NUMBER(3)    
MON   NOT NULL CHAR(6)      
GDATE          DATE         
TEST2 NOT NULL VARCHAR2(10) 

ALTER TABLE itpay
DROP COLUMN test2;

DESC itpay;
이름    널?       유형           
----- -------- ------------ 
PAYNO NOT NULL NUMBER(7)    
SAWON NOT NULL VARCHAR2(20) 
AGE   NOT NULL NUMBER(3)    
MON   NOT NULL CHAR(6)      
GDATE          DATE         

4) DEFAULT를 선언하면 NOT NULL 제약 조건을 이용 할 수 있음, 데이터가 등록되어 있어도 가능
INSERT INTO itpay(payno, sawon, age, mon, gdate)
VALUES(1, '가길순', 27, '201901', sysdate);

INSERT INTO itpay(payno, sawon, age, mon, gdate)
VALUES(2, '나길순', 28, '201901', sysdate);

INSERT INTO itpay(payno, sawon, age, mon, gdate)
VALUES(3, '다길순', 29, '201901', sysdate);

SELECT * FROM itpay;
     PAYNO SAWON                       AGE MON    GDATE              
---------- -------------------- ---------- ------ -------------------
         1 가길순                       27 201901 2022-02-23 10:36:25
         2 나길순                       28 201901 2022-02-23 10:36:25
         3 다길순                       29 201901 2022-02-23 10:36:25

ALTER TABLE itpay
ADD (test1 VARCHAR(10) DEFAULT '-' NOT NULL);

SELECT * FROM itpay;
              PAYNO SAWON                       AGE MON    GDATE     TEST1     
---------- -------------------- ---------- ------ ------------------- ----------
         1 가길순                       27 201901 2021-09-27 04:56:03      -         
         2 나길순                       28 201901 2021-09-27 04:56:03      -         
         3 다길순                       29 201901 2021-09-27 04:56:03      -         

ALTER TABLE itpay
ADD COLUMN (test2 VARCHAR(10)  NOT NULL DEFAULT '-'); -- 'COLUMN' 문자열 명시 못함 X

ALTER TABLE itpay
ADD (test2 VARCHAR(10)  NOT NULL DEFAULT '-'); -- DEFAULT 순서 에러 X


2. 컬럼 속성 수정
DESC itpay;
이름    널?       유형           
----- -------- ------------ 
PAYNO NOT NULL NUMBER(7)    
SAWON NOT NULL VARCHAR2(20) 
AGE   NOT NULL NUMBER(3)    
MON   NOT NULL CHAR(6)      
GDATE          DATE         
TEST1 NOT NULL VARCHAR2(10)

ALTER TABLE itpay
MODIFY(test1 VARCHAR(30));

DESC itpay;
이름    널?       유형           
----- -------- ------------ 
PAYNO NOT NULL NUMBER(7)    
SAWON NOT NULL VARCHAR2(20) 
AGE   NOT NULL NUMBER(3)    
MON   NOT NULL CHAR(6)      
GDATE          DATE         
TEST1 NOT NULL VARCHAR2(30) 

ALTER TABLE itpay
MODIFY(test1 VARCHAR(30) NULL); -- NULL로 변경

DESC itpay;
이름    널?       유형           
----- -------- ------------ 
PAYNO NOT NULL NUMBER(7)    
SAWON NOT NULL VARCHAR2(20) 
AGE   NOT NULL NUMBER(3)    
MON   NOT NULL CHAR(6)      
GDATE          DATE         
TEST1          VARCHAR2(30) 
 
3. 컬럼명 수정
ALTER TABLE itpay
RENAME COLUMN test1 to etc;

DESC itpay;
이름    널?       유형           
----- -------- ------------ 
PAYNO NOT NULL NUMBER(7)    
SAWON NOT NULL VARCHAR2(20) 
AGE   NOT NULL NUMBER(3)    
MON   NOT NULL CHAR(6)      
GDATE          DATE         
ETC            VARCHAR2(30) 

4. 컬럼 삭제
ALTER TABLE itpay
DROP COLUMN etc;

DESC itpay;
이름    널?       유형           
----- -------- ------------ 
PAYNO NOT NULL NUMBER(7)    
SAWON NOT NULL VARCHAR2(20) 
AGE   NOT NULL NUMBER(3)    
MON   NOT NULL CHAR(6)      
GDATE          DATE         

COMMIT;


5. 테이블 삭제
DROP TABLE itpay;


