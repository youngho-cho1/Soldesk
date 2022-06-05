/**********************************/
/* Table Name: ��Ʃ�� �׷� */
/**********************************/
CREATE TABLE ytgrp(
		ytgrpno                       		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		title                         		VARCHAR2(50)		 NOT NULL,
		cnt                           		NUMBER(10)		 DEFAULT 0		 NOT NULL,
		visible                       		CHAR(1)		 DEFAULT 'Y'		 NOT NULL,
		rdate                         		DATE		 NOT NULL
);

COMMENT ON TABLE ytgrp is '��Ʃ�� �׷�';
COMMENT ON COLUMN ytgrp.ytgrpno is '��Ʃ�� �׷��ȣ';
COMMENT ON COLUMN ytgrp.title is '����';
COMMENT ON COLUMN ytgrp.cnt is 'ī��Ʈ';
COMMENT ON COLUMN ytgrp.visible is '��� ���';
COMMENT ON COLUMN ytgrp.rdate is '�׷� ������';


/**********************************/
/* Table Name: ��Ʃ�� ���� */
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

COMMENT ON TABLE you is '��Ʃ�� ����';
COMMENT ON COLUMN you.youno is '��Ʃ���ȣ';
COMMENT ON COLUMN you.ytitle is '����';
COMMENT ON COLUMN you.url is 'URL�ּ�';
COMMENT ON COLUMN you.rdate is '��¥';
COMMENT ON COLUMN you.ytgrpno is '��Ʃ�� �׷��ȣ';
COMMENT ON COLUMN you.cnt is '��ȸ��';

-- ytgrpno ����
SELECT ytgrpno, title, cnt, visible, rdate
FROM ytgrp
ORDER BY ytgrpno ASC;

-- ��ȸ, ������
SELECT urlgrpno, title, cnt, visible, rdate 
FROM urlgrp
WHERE urlgrpno = 1;
  URLGRPNO TITLE                                                     CNT V RDATE              
---------- -------------------------------------------------- ---------- - -------------------
         1 ī��                                                        0 Y 2022-03-15 12:22:44
-- ����
UPDATE ytgrp
SET title='���� ���', cnt = 3, visible='Y'
WHERE ytgrpno = 3;

commit;

-- ��ȸ + ������ + ������
SELECT ytgrpno, title, cnt, visible, rdate 
FROM ytgrp
WHERE ytgrpno = 1;
---------- -------------------------------------------------- ---------- - -------------------
         1 ī��                                                        0 Y 2022-03-15 12:22:44
-- ���� ó��
DELETE FROM ytgrp
WHERE ytgrpno = 1;

DELETE FROM ytgrp
WHERE cnt = 2;  -- X

SELECT * FROM ytgrp;

rollback;

SELECT * FROM ytgrp;

commit;
-- cnt ����
SELECT ytgrpno, title, cnt, visible, rdate
FROM ytgrp
ORDER BY cnt ASC;

-- ��� ���������� ��ü ���
SELECT ytgrpno, title, cnt, visible, rdate
FROM ytgrp
ORDER BY cnt ASC;
 
-- ��� ���� �ø�(����), 10 ���� 1
UPDATE ytgrp
SET cnt = cnt - 1
WHERE ytgrpno=1;
 
-- ��¼��� ����(����), 1 ���� 10
UPDATE ytgrp
SET cnt = cnt + 1
WHERE ytgrpno=1;

commit;

-- ��� ����� ����
UPDATE ytgrp
SET visible='Y'
WHERE ytgrpno=1;

SELECT * FROM ytgrp;

UPDATE ytgrp
SET visible='N'
WHERE ytgrpno=1;

commit;
