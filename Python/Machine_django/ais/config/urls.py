from django.contrib import admin
from django.urls import path
from ais import views # ais 패키지의 views.py 등록

urlpatterns = [
    path('admin/', admin.site.urls),
    # http://127.0.0.1:8000/
    path('', views.index),  # views 모듈(파일)의 index 함수 호출, index.html
    # http://127.0.0.1:8000/country_form/
    path('country_form/', views.country_form),  # 귀농귀촌 적응 예측 시스템 예측폼
    # http://127.0.0.1:8000/country_proc/
    path('country_proc/', views.country_proc),  # 귀농귀촌 적응 예측 시스템 처리
    # http://127.0.0.1:8000/wine_form/
    path('wine_form/', views.wine_form),          # 와인 분류 폼, Ajax form
    # http://127.0.0.1:8000/wine_proc/
    path('wine_proc/', views.wine_proc),           # 와인 분류 처리, Ajax proc
    # http://127.0.0.1:8000/iris_form/
    # path('iris_form/', views.iris_form),            # 와인 분류 폼, Ajax form
    # http://127.0.0.1:8000/iris_proc/
    # path('iris_proc/', views.iris_proc),             # 와인 분류 처리, Ajax proc
    # http://127.0.0.1:8000/iris_form/
    path('iris_form/', views.iris_form2),            # views.iris_form -> views.iris_form2
    # http://127.0.0.1:8000/iris_proc/
    path('iris_proc/', views.iris_proc2),             # views.iris_proc -> views.iris_proc2
    path('actor_form/', views.actor_form),       # Ajax proc, actor 파일 업로드 폼
    path('actor_form2/', views.actor_form2),   # local_actor_finder 파일 업로드 폼
    # 도서 추천 시스템,  http://127.0.0.1:8000/recommend_book/start/
    path('recommend_book/start/', views.recommend_book_start),
    path('recommend_book/form1/', views.recommend_book_form1),
    path('recommend_book/form2/', views.recommend_book_form2),
    path('recommend_book/form3/', views.recommend_book_form3),
    path('recommend_book/end/', views.recommend_book_end),
    path('recommend_book/end_ajax/', views.recommend_book_end_ajax),  # 결과를 ajax로 리턴
    path('recommend_movie/req/<int:user_id>/', views.recommend_book_req), # Tensorflow + MF + Django 기반 추천 요청
    path('chatbot_intent/chatting_intent/', views.chatting_intent),  # chatting.html
    path('chatbot_intent/chatting_intent_query/', views.chatting_intent_query),  # 결과를 ajax로 리턴
]

from django.conf.urls.static import static
from django.conf import settings

# /media 폴더는 보안상 접근이 안됨으로 static 기능을 부여하여 접근 가능하도록 설정함.
urlpatterns += \
    static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)

