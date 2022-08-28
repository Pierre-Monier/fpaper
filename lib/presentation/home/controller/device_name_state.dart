import 'package:flutter/material.dart';

@immutable
class DeviceNameState {
  const DeviceNameState({required this.name});

  final String name;

  DeviceNameState copyWith({String? name}) =>
      DeviceNameState(name: name ?? this.name);
}
