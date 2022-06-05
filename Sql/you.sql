/**********************************/
/* Table Name: ��Ʃ�� ���� */
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

COMMENT ON TABLE you is '���ã�� ����';
COMMENT ON COLUMN you.youno is '���ã�� ��ȣ';
COMMENT ON COLUMN you.ytitle is '���ã�� �̸�';
COMMENT ON COLUMN you.url is '�ּ�';
COMMENT ON COLUMN you.rdate is '��¥';
COMMENT ON COLUMN you.ytgrpno is 'ytgrpno';

drop sequence you_seq;
CREATE SEQUENCE you_seq
  START WITH 1               -- ���� ��ȣ
  INCREMENT BY 1           -- ������
  MAXVALUE 9999999999  -- �ִ밪: 9999999 --> NUMBER(7) ����
  CACHE 2                       -- 2���� �޸𸮿����� ���
  NOCYCLE;                     -- �ٽ� 1���� �����Ǵ� ���� ����


commit;
INSERT INTO you(youno,title,url,rdate,ytgrpno)
VALUES(you_seq.nextval,'��ȭ�� ī��','http://www.naver.com',sysdate,1);
INSERT INTO you(youno,title,url,rdate,ytgrpno)
VALUES(you_seq.nextval,'���� ī��','http://www.naver.com',sysdate,2);
INSERT INTO you(youno,title,url,rdate,ytgrpno)
VALUES(you_seq.nextval,'�ڹ� ī��','http://www.naver.com',sysdate,3);

SELECT youno, title, url, rdate, ytgrpno
FROM you
ORDER BY youno ASC;
commit;
-- ���
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

-- ��ȸ
SELECT youno, ytgrpno, title, rdate, url
FROM you
WHERE youno=2;

-- ����
UPDATE you
SET ytgrpno=1, title='�ڹ�'
WHERE youno = 3;

SELECT * FROM you;

commit;

-- ����
DELETE you
WHERE youno = 7;

SELECT * FROM you;

DELETE FROM you
WHERE youno = 6;

commit;
