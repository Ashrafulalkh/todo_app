import 'package:flutter/material.dart';
import 'package:todo_app/app.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo_app/ui/utils/const.dart';

Future<void> main() async{
  await Supabase.initialize(url: supabaseUrl, anonKey: supabaseKey);
  runApp(const TodoApp());
}