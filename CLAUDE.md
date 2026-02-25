# 🎯 BLE Inspector MVP Architecture Agent Guide

# 🎯 BLE Inspector Lightweight Architecture Guide

## 1. 프로젝트 아키텍처 대원칙 (NO OVER-ENGINEERING)
이 프로젝트는 하드웨어를 제어하는 BLE 유틸리티 모듈입니다.
**경고: 절대로 Domain, Data, UseCase 계층을 나누는 무거운 클린 아키텍처를 적용하지 마십시오.** 스캔, 연결, 읽기/쓰기 등의 하드웨어 제어는 비즈니스 로직이 아니므로 UseCase를 만들 필요가 없습니다. 오직 **[BleManager + MVVM(또는 경량 MVP)]** 구조만 허용합니다.

## 2. 폴더 및 계층 구조 (Strict Rules)
```text
lib/
├── core/
│   └── ble/                          # ⭐️ 하드웨어 제어 핵심 계층 (단일 진실 공급원)
│       ├── ble_manager.dart          # flutter_blue_plus를 직접 다루는 유일한 클래스 (싱글톤 또는 Provider)
│       ├── ble_state.dart            # BLE 상태 모델 (Freezed)
│       └── ble_exceptions.dart       # 권한/연결 에러 처리
│
└── feature/
    └── ble_scan/                     # 📱 UI 및 화면 제어 계층
        ├── ble_scan_view_model.dart  # (또는 Presenter) BleManager를 호출하고 UI 상태만 관리
        └── view/
            ├── ble_scan_page.dart    # 화면 UI
            └── widgets/              # 하위 위젯들
```
## 3 **코드 제너레이션 (build_runner) 자동 실행:**
    - 네가 작성하거나 수정한 코드에 `@freezed`, `@riverpod`, `part 'xxx.g.dart'`, `part 'xxx.freezed.dart'`가 단 하나라도 포함되어 있다면, 코드를 저장한 직후 **반드시 터미널에서 아래 명령어를 스스로 실행**하라.
    - 실행 명령어: `dart run build_runner build --delete-conflicting-outputs`
    - 명령어를 실행한 후, 터미널 로그를 확인하여 에러가 났다면 스스로 코드를 수정하고 다시 실행하라. 성공(Succeeded) 로그를 확인하기 전까지는 작업을 완료하지 마라.
    - 
## 4. 자주 사용하는 스킬 및 명령어 (명령 실행 시 참고)
- **코드 자동 생성:** `dart run build_runner build --delete-conflicting-outputs`
- **macOS 권한 셋팅:** Mac에서 테스트할 때 블루투스 권한 에러가 나면 `sh scripts/setup_macos_ble.sh` 스킬을 실행하라.