import 'dart:async';
import 'dart:ffi';
import 'dart:io';
import 'package:ffi/ffi.dart';
import 'package:flutter/services.dart';

final DynamicLibrary nameGeneratorPlugin = Platform.isAndroid
    ? DynamicLibrary.open("libname-generator-plugin.so")
    : DynamicLibrary.process();

typedef name = Pointer<Utf8> Function(Int32 age);
typedef Name = Pointer<Utf8> Function(int age);

class FlutterCppPlayground {
  static const MethodChannel _channel =
      const MethodChannel('flutter_cpp_playground');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static String generateName(int age) {
    final namePointer =
        nameGeneratorPlugin.lookup<NativeFunction<name>>('generate_name');
    final nameGenerator = namePointer.asFunction<Name>();
    return Utf8.fromUtf8(nameGenerator(age));
  }
}
