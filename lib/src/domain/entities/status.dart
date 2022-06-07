import 'package:json_annotation/json_annotation.dart';

/// 啟用狀態
enum EnabledStatus {
  @JsonValue('ON')
  on, // 啟用
  @JsonValue('OFF')
  off, // 關閉
}
