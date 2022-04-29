-- FK를 무시하고 부모 테이블 삭제
-- DROP TABLE categrp CASCADE CONSTRAINTS;

1) 데이터 준비
SELECT * FROM categrp;
DELETE FROM categrp WHERE categrpno=9;
-- ORA-02292: 무결성 제약조건(KD1.SYS_C008063)이 위배되었습니다- 자식 레코드가 발견되었습니다.

SELECT * FROM cate;
SELECT * FROM cate WHERE categrpno=1;
DELETE FROM cate WHERE cateno=1;
ORA-02292: 무결성 제약조건(KD1.SYS_C008076)이 위배되었습니다- 자식 레코드가 발견되었습니다

SELECT * FROM contents;
DELETE FROM contents; -- 자식을 먼저 삭제
COMMIT;

SELECT * FROM cate ORDER BY cateno ASC;
DELETE FROM cate WHERE cateno > 3;
SELECT * FROM cate;
    CATENO  CATEGRPNO NAME                                               RDATE                      CNT
---------- ---------- -------------------------------------------------- ------------------- ----------
         1          1 분식                                               2022-04-29 09:48:38          0
         2          1 한식                                               2022-04-29 09:48:46          0
         3          1 양식                                               2022-04-29 09:48:49          0
    
SELECT * FROM categrp;
DELETE FROM categrp WHERE categrpno > 3;
SELECT * FROM categrp ORDER BY categrpno ASC;
CATEGRPNO NAME                                                    SEQNO V RDATE              
---------- -------------------------------------------------- ---------- - -------------------
         1 푸드 코트                                                   1 Y 2022-04-28 03:11:15
         2 여행                                                        2 Y 2022-04-28 03:11:15
         3 음악                                                        3 Y 2022-04-28 03:11:15

2) 부모 테이블 생성 후 SELECT 결과
SELECT categrpno, name, seqno, visible, rdate
FROM categrp
ORDER BY categrpno ASC;

CATEGRPNO NAME                                                    SEQNO V RDATE              
---------- -------------------------------------------------- ---------- - -------------------
         1 푸드 코트                                                   1 Y 2022-04-28 03:11:15
         2 여행                                                        2 Y 2022-04-28 03:11:15
         3 음악                                                        3 Y 2022-04-28 03:11:15

3) 자식 테이블 생성 후 SELECT 결과         
SELECT cateno, categrpno, name, rdate, cnt
FROM cate
ORDER BY cateno ASC;     

    CATENO  CATEGRPNO NAME                                               RDATE                      CNT
---------- ---------- -------------------------------------------------- ------------------- ----------
         1          1 분식                                               2022-04-29 09:48:38          0
         2          1 한식                                               2022-04-29 09:48:46          0
         3          1 양식                                               2022-04-29 09:48:49          0

4) Cross Join
- 정보로서 가치가 없음.
- 부모(PK) 테이블 레코드 3 건 x 자식(FK) 테이블 레코드 3건 = 9건
SELECT categrp.categrpno, categrp.name, categrp.seqno, cate.cateno, cate.name
FROM categrp, cate
ORDER BY categrp.categrpno ASC, cate.cateno ASC;

 CATEGRPNO NAME                                                    SEQNO     CATENO NAME                                              
---------- -------------------------------------------------- ---------- ---------- --------------------------------------------------
         1 푸드 코트                                                   1          1 분식                                              
         1 푸드 코트                                                   1          2 한식                                              
         1 푸드 코트                                                   1          3 양식                                              
         2 여행                                                        2          1 분식                                              
         2 여행                                                        2          2 한식                                              
         2 여행                                                        2          3 양식                                              
         3 음악                                                        3          1 분식                                              
         3 음악                                                        3          2 한식                                              
         3 음악                                                        3          3 양식                                              


-- 테이블 별명
SELECT r.categrpno, r.name, r.seqno, c.cateno, c.name
FROM categrp r, cate c
ORDER BY r.categrpno ASC, c.cateno ASC;

-- 컬럼 별명, 동일한 컬럼명 NAME이 존재하는 경우
SELECT r.categrpno, r.name as r_name, r.seqno, c.cateno, c.name as c_name
FROM categrp r, cate c
ORDER BY r.categrpno ASC, c.cateno ASC;
 CATEGRPNO R_NAME                                                  SEQNO     CATENO C_NAME                                            
---------- -------------------------------------------------- ---------- ---------- --------------------------------------------------
         1 영화                                                        1          1 SF                                                
         1 영화                                                        1          2 드라마                                            
         1 영화                                                        1          3 퇴마                                              
         2 여행                                                        1          1 SF                                                
         2 여행                                                        1          2 드라마                                            
         2 여행                                                        1          3 퇴마                                              
         3 캠핑                                                        1          1 SF                                                
         3 캠핑                                                        1          2 드라마                                            
         3 캠핑                                                        1          3 퇴마                                              


-- ANSI(결과는 동일)
SELECT r.categrpno, r.name as r_name, r.seqno, c.cateno, c.name as c_name
FROM categrp r CROSS JOIN cate c
ORDER BY r.categrpno ASC, c.cateno ASC;


5) Equal JOIN(INNER JOIN)
- 2개의 테이블에서 categrpno 컬럼의 값이 일치하는 레코드만 병합하여 출력
SELECT r.categrpno as r_categrpno, r.name as r_name, r.seqno,
       c.cateno, c.categrpno as c_categrpno, c.name as c_name
FROM categrp r, cate c
WHERE r.categrpno = c.categrpno  -- PK = FK 비교
ORDER BY r.categrpno ASC, c.cateno ASC;

R_CATEGRPNO R_NAME                                                  SEQNO     CATENO C_NAME                                            
----------- -------------------------------------------------- ---------- ---------- --------------------------------------------------
          1 푸드 코트                                                   1          1 분식                                              
          1 푸드 코트                                                   1          2 한식                                              
          1 푸드 코트                                                   1          3 양식                                              
                                    
          
-- ANSI
SELECT r.categrpno as r_categrpno, r.name as r_name, r.seqno, c.cateno, c.name as c_name
FROM categrp r INNER JOIN cate c ON r.categrpno = c.categrpno
ORDER BY r.categrpno ASC, c.cateno ASC;

R_CATEGRPNO R_NAME                                                  SEQNO     CATENO C_NAME                                            
----------- -------------------------------------------------- ---------- ---------- --------------------------------------------------
          1 푸드 코트                                                   1          1 분식                                              
          1 푸드 코트                                                   1          2 한식                                              
          1 푸드 코트                                                   1          3 양식                                              

-- 테이블 순서를 변경해도 결과는 같음.          
SELECT r.categrpno as r_categrpno, r.name as r_name, r.seqno,
       c.cateno, c.categrpno as c_categrpno, c.name as c_name
FROM cate c, categrp r 
WHERE c.categrpno = r.categrpno   -- FK = PK 비교
ORDER BY r.categrpno ASC, c.cateno ASC;

R_CATEGRPNO R_NAME                                                  SEQNO     CATENO C_NAME                                            
----------- -------------------------------------------------- ---------- ---------- --------------------------------------------------
          1 푸드 코트                                                   1          1 분식                                              
          1 푸드 코트                                                   1          2 한식                                              
          1 푸드 코트                                                   1          3 양식                                              
      
-- ANSI, 테이블 순서를 변경해도 결과는 같음.   
SELECT r.categrpno as r_categrpno, r.name as r_name, r.seqno, c.cateno, c.name as c_name
FROM cate c INNER JOIN categrp r ON c.categrpno = r.categrpno
ORDER BY r.categrpno ASC, c.cateno ASC;

R_CATEGRPNO R_NAME                                                  SEQNO     CATENO C_NAME                                            
----------- -------------------------------------------------- ---------- ---------- --------------------------------------------------
          1 푸드 코트                                                   1          1 분식                                              
          1 푸드 코트                                                   1          2 한식                                              
          1 푸드 코트                                                   1          3 양식                                              


★ FK 레코드 갯수 만큼 부모테이블의 레코드가 대응함 ★

-- ANSI + WHERE
SELECT r.categrpno as r_categrpno, r.name as r_name, r.seqno, c.cateno, c.name as c_name
FROM categrp r INNER JOIN cate c ON r.categrpno = c.categrpno
WHERE c.name = '드라마'
ORDER BY r.categrpno ASC, c.cateno ASC;

R_CATEGRPNO R_NAME                                                  SEQNO     CATENO C_NAME                                            
----------- -------------------------------------------------- ---------- ---------- --------------------------------------------------
          1 영화                                                        1          2 드라마                             
          
SELECT r.categrpno as r_categrpno, r.name as r_name, r.seqno, c.cateno, c.name as c_name
FROM categrp r, cate c
WHERE (r.categrpno = c.categrpno) AND c.name = 'SF'  -- 'sf' Error
ORDER BY r.categrpno ASC, c.cateno ASC;

R_CATEGRPNO R_NAME                                                  SEQNO     CATENO C_NAME                                            
----------- -------------------------------------------------- ---------- ---------- --------------------------------------------------
          1 영화                                                        1          1 SF                                                


5. LEFT Outer join(부모 테이블 레코드 모두 출력), 일치하지않는 레코드의 출력, +: +의 반대편 테이블은 모든 레코드 출력
SELECT r.categrpno as r_categrpno, r.name as r_name, r.seqno, c.cateno, c.name as c_name
FROM categrp r, cate c
WHERE r.categrpno = c.categrpno(+) -- 부모 PK = 자식 FK + 의 반대편 테이블에 모든 레코드 출력
ORDER BY r.categrpno ASC, c.cateno ASC;

R_CATEGRPNO R_NAME                                                  SEQNO     CATENO C_NAME                                            
----------- -------------------------------------------------- ---------- ---------- --------------------------------------------------
          1 푸드 코트                                                   1          1 분식                                              
          1 푸드 코트                                                   1          2 한식                                              
          1 푸드 코트                                                   1          3 양식                                              
          2 여행                                                        2                                                              
          3 음악                                                        3
-- ANSI
SELECT r.categrpno as r_categrpno, r.name as r_name, r.seqno, c.cateno, c.name as c_name
FROM categrp r LEFT OUTER JOIN cate c ON r.categrpno = c.categrpno
ORDER BY r.categrpno ASC, c.cateno ASC;

R_CATEGRPNO R_NAME                                                  SEQNO     CATENO C_NAME                                            
----------- -------------------------------------------------- ---------- ---------- --------------------------------------------------
          1 푸드 코트                                                   1          1 분식                                              
          1 푸드 코트                                                   1          2 한식                                              
          1 푸드 코트                                                   1          3 양식                                              
          2 여행                                                        2                                                              
          3 음악                                                        3                                                              


6. RIGHT Outer join(부모 테이블이 없을때 레코드가 추가된 경우)
- SELECT 결과가 없어야 정상적인 경우임, FK 값이 없는 레코드가 존재하는 비정상적인 경우
SELECT r.categrpno as r_categrpno, r.name as r_name, r.seqno, c.cateno, c.name as c_name
FROM categrp r, cate c
WHERE r.categrpno(+) = c.categrpno
ORDER BY r.categrpno ASC, c.cateno ASC;

R_CATEGRPNO R_NAME                                                  SEQNO     CATENO C_NAME                                            
----------- -------------------------------------------------- ---------- ---------- --------------------------------------------------
          1 푸드 코트                                                   1          1 분식                                              
          1 푸드 코트                                                   1          2 한식                                              
          1 푸드 코트                                                   1          3 양식                                              

         
SELECT r.categrpno as r_categrpno, r.name as r_name, r.seqno, c.cateno, c.name as c_name
FROM categrp r RIGHT OUTER JOIN cate c ON r.categrpno = c.categrpno
ORDER BY r.categrpno ASC, c.cateno ASC;

R_CATEGRPNO R_NAME                                                  SEQNO     CATENO C_NAME                                            
----------- -------------------------------------------------- ---------- ---------- --------------------------------------------------
          1 푸드 코트                                                   1          1 분식                                              
          1 푸드 코트                                                   1          2 한식                                              
          1 푸드 코트                                                   1          3 양식                                              

7. FULL Outer join
SELECT r.categrpno as r_categrpno, r.name as r_name, r.seqno, c.cateno, c.name as c_name
FROM categrp r FULL OUTER JOIN cate c ON r.categrpno = c.categrpno
ORDER BY r.categrpno ASC, c.cateno ASC;

R_CATEGRPNO R_NAME                                                  SEQNO     CATENO C_NAME                                            
----------- -------------------------------------------------- ---------- ---------- --------------------------------------------------
          1 푸드 코트                                                   1          1 분식                                              
          1 푸드 코트                                                   1          2 한식                                              
          1 푸드 코트                                                   1          3 양식                                              
          2 여행                                                        2                                                              
          3 음악                                                        3     
          
8) 테이블 3개 join

SELECT contentsno, adminno, cateno, SUBSTR(title, 1, 20) as title FROM contents;

CONTENTSNO    ADMINNO     CATENO TITLE               
---------- ---------- ---------- --------------------
         1          1          1 라면                
         2          1          2 김치찌개                  

SELECT r.categrpno as r_categrpno, SUBSTR(r.name, 1, 10) as r_name, r.seqno,
        c.cateno, c.categrpno as c_categrpno, SUBSTR(c.name, 1, 10) as c_name,
        t.contentsno, t.adminno, t.cateno as t_cateno, SUBSTR(title, 1, 20) as title
FROM categrp r, cate c, contents t
WHERE r.categrpno = c.categrpno AND c.cateno = t.cateno
ORDER BY r.categrpno ASC, c.cateno ASC, t.contentsno;

R_CATEGRPNO R_NAME          SEQNO     CATENO C_CATEGRPNO C_NAME     CONTENTSNO    ADMINNO   T_CATENO TITLE               
----------- ---------- ---------- ---------- ----------- ---------- ---------- ---------- ---------- --------------------
          1 푸드 코트           1          1           1 분식                1          1          1 라면                
          1 푸드 코트           1          2           1 한식                2          1          2 김치찌개            

-- 축적인 조건의 명시
SELECT r.categrpno as r_categrpno, SUBSTR(r.name, 1, 10) as r_name, r.seqno,
        c.cateno, c.categrpno as c_categrpno, SUBSTR(c.name, 1, 10) as c_name,
        t.contentsno, t.adminno, t.cateno as t_cateno, SUBSTR(title, 1, 20) as title
FROM categrp r, cate c, contents t
WHERE (r.categrpno = c.categrpno AND c.cateno = t.cateno) AND title LIKE '%찌개%'
ORDER BY r.categrpno ASC, c.cateno ASC, t.contentsno;

R_CATEGRPNO R_NAME          SEQNO     CATENO C_CATEGRPNO C_NAME     CONTENTSNO    ADMINNO   T_CATENO TITLE               
----------- ---------- ---------- ---------- ----------- ---------- ---------- ---------- ---------- --------------------
          1 푸드 코트           1          2           1 한식                2          1          2 김치찌개            

-- ANSI
SELECT r.categrpno as r_categrpno, SUBSTR(r.name, 1, 10) as r_name, r.seqno,
        c.cateno, c.categrpno as c_categrpno, SUBSTR(c.name, 1, 10) as c_name,
        t.contentsno, t.adminno, t.cateno as t_cateno, SUBSTR(title, 1, 20) as title
FROM categrp r INNER JOIN cate c ON r.categrpno = c.categrpno
                     INNER JOIN contents t ON c.cateno = t.cateno
WHERE title LIKE '%찌개%'
ORDER BY r.categrpno ASC, c.cateno ASC, t.contentsno;

R_CATEGRPNO R_NAME          SEQNO     CATENO C_CATEGRPNO C_NAME     CONTENTSNO    ADMINNO   T_CATENO TITLE               
----------- ---------- ---------- ---------- ----------- ---------- ---------- ---------- ---------- --------------------
          1 푸드 코트           1          2           1 한식                2          1          2 김치찌개            
