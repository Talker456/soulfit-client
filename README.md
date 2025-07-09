# soulfit_client

Flutter Project for Soulfit client


## 디렉토리 구성 계획

lib/
├── core/                      # 전역 공통 코드 (에러 처리, 공통 위젯, 유틸 등)
├── feature/                   # 기능(도메인) 단위 모듈 (auth, profile 등)
│   └── [feature_name]/
│       ├── data/              # 데이터 계층 (API, 모델, 저장소 구현 등)
│       │   ├── datasources/
│       │   ├── models/
│       │   └── repositories/
│       ├── domain/            # 도메인 계층 (엔티티, 유즈케이스, 인터페이스)
│       │   ├── entities/
│       │   ├── repositories/
│       │   └── usecases/
│       └── presentation/      # UI 계층 (Bloc/Provider, 화면, 위젯 등)
│           ├── riverpod/
│           ├── screens/
│           └── widgets/
├── config/                    # 앱 전역 설정 (라우팅, DI, 환경설정 등)
│   ├── di/
│   ├── router/
│   └── env/
└── main.dart                  # 앱 실행 진입점



