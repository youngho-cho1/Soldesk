/**********************************/
/* Table Name: 유튜브 그룹 */
/**********************************/
CREATE TABLE ytgrp(
		ytgrpno                       		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		title                         		VARCHAR2(50)		 NOT NULL,
		cnt                           		NUMBER(10)		 DEFAULT 0		 NOT NULL,
		visible                       		CHAR(1)		 DEFAULT 'Y'		 NOT NULL,
		rdate                         		DATE		 NOT NULL
);

COMMENT ON TABLE ytgrp is '유튜브 그룹';
COMMENT ON COLUMN ytgrp.ytgrpno is '유튜브 그룹번호';
COMMENT ON COLUMN ytgrp.title is '제목';
COMMENT ON COLUMN ytgrp.cnt is '카운트';
COMMENT ON COLUMN ytgrp.visible is '출력 모드';
COMMENT ON COLUMN ytgrp.rdate is '그룹 생성일';


/**********************************/
/* Table Name: 유튜브 내용 */
/**********************************/
CREATE TABLE you(
		youno                         		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		ytitle                         		VARCHAR2(50)		 NOT NULL,
		url                           		VARCHAR2(50)		 NOT NULL,
		rdate                         		DATE		 NOT NULL,
		ytgrpno                       		NUMBER(10)		 NOT NULL,
        cnt                                 NUMBER(30)      NOT NULL,
  FOREIGN KEY (ytgrpno) REFERENCES ytgrp (ytgrpno)
);

COMMENT ON TABLE you is '유튜브 내용';
COMMENT ON COLUMN you.youno is '유튜브번호';
COMMENT ON COLUMN you.ytitle is '제목';
COMMENT ON COLUMN you.url is 'URL주소';
COMMENT ON COLUMN you.rdate is '날짜';
COMMENT ON COLUMN you.ytgrpno is '유튜브 그룹번호';
COMMENT ON COLUMN you.cnt is '조회수';

-- ytgrpno 정렬
SELECT ytgrpno, title, cnt, visible, rdate
FROM ytgrp
ORDER BY ytgrpno ASC;

-- 조회, 수정폼
SELECT urlgrpno, title, cnt, visible, rdate 
FROM urlgrp
WHERE urlgrpno = 1;
  URLGRPNO TITLE                                                     CNT V RDATE              
---------- -------------------------------------------------- ---------- - -------------------
         1 카페                                                        0 Y 2022-03-15 12:22:44
-- 수정
UPDATE ytgrp
SET title='업무 양식', cnt = 3, visible='Y'
WHERE ytgrpno = 3;

commit;

-- 조회 + 수정폼 + 삭제폼
SELECT ytgrpno, title, cnt, visible, rdate 
FROM ytgrp
WHERE ytgrpno = 1;
---------- -------------------------------------------------- ---------- - -------------------
         1 카페                                                        0 Y 2022-03-15 12:22:44
-- 삭제 처리
DELETE FROM ytgrp
WHERE ytgrpno = 1;

DELETE FROM ytgrp
WHERE cnt = 2;  -- X

SELECT * FROM ytgrp;

rollback;

SELECT * FROM ytgrp;

commit;
-- cnt 정렬
SELECT ytgrpno, title, cnt, visible, rdate
FROM ytgrp
ORDER BY cnt ASC;

-- 출력 순서에따른 전체 목록
SELECT ytgrpno, title, cnt, visible, rdate
FROM ytgrp
ORDER BY cnt ASC;
 
-- 출력 순서 올림(상향), 10 ─▷ 1
UPDATE ytgrp
SET cnt = cnt - 1
WHERE ytgrpno=1;
 
-- 출력순서 내림(하향), 1 ─▷ 10
UPDATE ytgrp
SET cnt = cnt + 1
WHERE ytgrpno=1;

commit;

-- 출력 모드의 변경
UPDATE ytgrp
SET visible='Y'
WHERE ytgrpno=1;

SELECT * FROM ytgrp;

UPDATE ytgrp
SET visible='N'
WHERE ytgrpno=1;

commit;
