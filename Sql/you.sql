/**********************************/
/* Table Name: 유튜브 내용 */
/**********************************/
DROP TABLE you CASCADE CONSTRAINTS;
CREATE TABLE you(
      youno                               NUMBER(7)       NOT NULL       PRIMARY KEY,
      ytitle                               VARCHAR2(50)       NOT NULL,
      you                                 VARCHAR2(1000)       NOT NULL,
      rdate                               DATE       NOT NULL,
      ytgrpno                            NUMBER(7)       NOT NULL,
  FOREIGN KEY (ytgrpno) REFERENCES ytgrp (ytgrpno)
);

COMMENT ON TABLE you is '즐겨찾기 내용';
COMMENT ON COLUMN you.youno is '즐겨찾기 번호';
COMMENT ON COLUMN you.ytitle is '즐겨찾기 이름';
COMMENT ON COLUMN you.url is '주소';
COMMENT ON COLUMN you.rdate is '날짜';
COMMENT ON COLUMN you.ytgrpno is 'ytgrpno';

drop sequence you_seq;
CREATE SEQUENCE you_seq
  START WITH 1               -- 시작 번호
  INCREMENT BY 1           -- 증가값
  MAXVALUE 9999999999  -- 최대값: 9999999 --> NUMBER(7) 대응
  CACHE 2                       -- 2번은 메모리에서만 계산
  NOCYCLE;                     -- 다시 1부터 생성되는 것을 방지


commit;
INSERT INTO you(youno,title,url,rdate,ytgrpno)
VALUES(you_seq.nextval,'강화도 카페','http://www.naver.com',sysdate,1);
INSERT INTO you(youno,title,url,rdate,ytgrpno)
VALUES(you_seq.nextval,'서울 카페','http://www.naver.com',sysdate,2);
INSERT INTO you(youno,title,url,rdate,ytgrpno)
VALUES(you_seq.nextval,'자바 카페','http://www.naver.com',sysdate,3);

SELECT youno, title, url, rdate, ytgrpno
FROM you
ORDER BY youno ASC;
commit;
-- 목록
SELECT youno, title, url, rdate, ytgrpno
FROM you
ORDER BY youno ASC;
         
SELECT youno, title, url, rdate, ytgrpno
FROM you
WHERE ytgrpno = 1  
ORDER BY youno ASC;


SELECT r.ytgrpno as r_ytgrpno, r.title as r_title,
           c.youno, c.ytgrpno, c.title, c.rdate, c.url
FROM ytgrp r, you c
WHERE r.ytgrpno = c.ytgrpno
ORDER BY ytgrpno ASC, youno ASC;

-- 조회
SELECT youno, ytgrpno, title, rdate, url
FROM you
WHERE youno=2;

-- 수정
UPDATE you
SET ytgrpno=1, title='코믹'
WHERE youno = 3;

SELECT * FROM you;

commit;

-- 삭제
DELETE you
WHERE youno = 7;

SELECT * FROM you;

DELETE FROM you
WHERE youno = 6;

commit;
