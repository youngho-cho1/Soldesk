import pymysql
import pymysql.cursors
import logging


class Database:
    '''
    database 제어
    '''

    def __init__(self, host, user, password, db_name, charset='utf8'): # 생성자
        self.host = host
        self.user = user
        self.password = password
        self.charset = charset
        self.db_name = db_name
        self.conn = None

    # DB 연결
    def connect(self):
        if self.conn != None: # 이미 연결이 되어 있는 경우
            return

        self.conn = pymysql.connect( # 연결 객체 생성, self.conn == this.conn
            host=self.host,
            user=self.user,
            password=self.password,
            db=self.db_name,
            charset=self.charset
        )

    # DB 연결 닫기
    def close(self):
        if self.conn is None:
            return

        if not self.conn.open: # close가 된 상태이고 객체는 살아있는 상태
            self.conn = None
            return
        
        self.conn.close()
        self.conn = None

    # SQL 구문 실행
    def execute(self, sql):
        last_row_id = -1
        try:
            with self.conn.cursor() as cursor: # 자동으로 close 진행
                cursor.execute(sql) # 전달받은 sql 실행
            self.conn.commit()
            last_row_id = cursor.lastrowid # PK 추출
            # logging.debug("excute last_row_id : %d", last_row_id)
        except Exception as ex:
            logging.error(ex)

        finally:
            return last_row_id  # PK 리턴

    # SELECT 구문 실행 후, 단 1개의 데이터 ROW만 불러옴
    def select_one(self, sql):
        result = None

        try:
            with self.conn.cursor(pymysql.cursors.DictCursor) as cursor:
                cursor.execute(sql)
                result = cursor.fetchone() # 1개의 데이터 ROW만 불러옴
        except Exception as ex:
            logging.error(ex)

        finally:
            return result

    # SELECT 구문 실행 후, 전체 데이터 ROW만 불러옴
    def select_all(self, sql):
        result = None

        try:
            with self.conn.cursor(pymysql.cursors.DictCursor) as cursor:
                cursor.execute(sql)
                result = cursor.fetchall() # 전체 데이터 ROW만 불러옴
        except Exception as ex:
            logging.error(ex)

        finally:
            return result

