# BLE Connection Manager

## 개요

Flutter 기반의 BLE(Bluetooth Low Energy) 디바이스 스캔 및 연결 관리 유틸리티 앱입니다.
디바이스 스캔·연결·읽기/쓰기 등 하드웨어 제어에 집중합니다.

```
lib/
├── core/
│   └── ble/
│       ├── ble_manager.dart       # BLE 하드웨어 제어 (단일 진실 공급원)
│       ├── ble_state.dart         # BLE 상태 모델 (Freezed)
│       └── ble_exceptions.dart    # 권한/연결 에러 처리
└── feature/
    └── ble_scan/
        ├── ble_scan_view_model.dart
        └── view/
            ├── ble_scan_page.dart
            └── widgets/
```

## 사용된 패키지

| 패키지 | 용도 |
|---|---|
| `flutter_blue_plus` | BLE 스캔 및 연결 |
| `flutter_riverpod` / `hooks_riverpod` | 상태 관리 |
| `flutter_hooks` | 훅 기반 위젯 |
| `riverpod_annotation` | Riverpod 코드 생성 어노테이션 |
| `freezed_annotation` | 불변 데이터 클래스 |
| `json_annotation` | JSON 직렬화 |
| `build_runner` | 코드 자동 생성 |

## 사용 방법

### 1. 스캔

`BleScanViewModel`을 통해 주변 BLE 디바이스를 스캔합니다.
스캔 결과는 RSSI(신호 세기) 기준으로 자동 정렬되며, 기본 타임아웃은 10초입니다.

```dart
// 스캔 시작
ref.read(bleScanViewModelProvider.notifier).startScan();

// 스캔 중지
ref.read(bleScanViewModelProvider.notifier).stopScan();

// 스캔 상태 및 결과 구독
final state = ref.watch(bleScanViewModelProvider);
// state.isScanning  - 스캔 중 여부
// state.devices     - 발견된 BleDevice 목록
// state.error       - 에러 메시지 (블루투스 꺼짐, 권한 없음 등)
```

### 2. 연결

스캔 결과의 `BleDevice`를 탭하면 `BleDeviceViewModel`이 자동으로 연결을 시도합니다.
연결 성공 시 서비스 목록도 자동으로 탐색(discover)합니다.

```dart
// 연결 (ViewModel 생성 시 자동 호출)
ref.read(bleDeviceViewModelProvider(device).notifier).connect();

// 연결 해제
ref.read(bleDeviceViewModelProvider(device).notifier).disconnect();

// 연결 상태 구독
final state = ref.watch(bleDeviceViewModelProvider(device));
// state.connectionState  - disconnected / connecting / connected
// state.services         - 탐색된 BleService 목록
```

### 3. Characteristic 읽기 / 쓰기 / 알림 구독

연결 후 각 Characteristic의 속성(`canRead`, `canWrite`, `canNotify`)에 따라 제어합니다.

```dart
final notifier = ref.read(bleDeviceViewModelProvider(device).notifier);

// 읽기
notifier.readCharacteristic(serviceUuid, charUuid);

// 쓰기 (바이트 배열 전달)
notifier.writeCharacteristic(serviceUuid, charUuid, [0x01, 0x02]);

// 알림 구독 / 해제 토글
notifier.toggleNotify(serviceUuid, charUuid);

// 읽은 값 조회 (HEX 문자열)
final state = ref.watch(bleDeviceViewModelProvider(device));
final bytes = state.characteristicValues[charUuid]; // List<int>
```

### 4. 에러 처리

`BleManager`는 내부 예외를 아래 타입으로 변환하여 던집니다.

| 예외 클래스 | 발생 상황 |
|---|---|
| `BluetoothOffException` | 블루투스가 꺼져 있음 |
| `PermissionDeniedException` | 블루투스 권한 거부 |
| `ConnectionException` | 연결 실패 |
| `DisconnectedException` | 연결 끊김 |
| `ServiceNotFoundException` | 서비스 UUID 미발견 |
| `CharacteristicNotFoundException` | Characteristic UUID 미발견 |
| `ReadException` | 기타 읽기/쓰기 실패 |