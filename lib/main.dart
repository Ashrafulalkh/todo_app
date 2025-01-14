import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/app.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo_app/ui/utils/const.dart';

Future<void> main() async{
  await Supabase.initialize(url: supabaseUrl, anonKey: supabaseKey);
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => const TodoApp(), // Wrap your app
    ),
  );
}