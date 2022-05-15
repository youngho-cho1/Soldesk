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
]

from django.conf.urls.static import static
from django.conf import settings

# /media 폴더는 보안상 접근이 안됨으로 static 기능을 부여하여 접근 가능하도록 설정함.
urlpatterns += \
    static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)

