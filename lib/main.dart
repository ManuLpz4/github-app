import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:github_app/src/app.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(App());
} 
