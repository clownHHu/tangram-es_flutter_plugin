import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
class CounterStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/data.txt');
  }

  Future<String> readContents() async {
    try {
      final file = await _localFile;

      // Read the file
      final contents = await file.readAsString();

      return contents;
    } catch (e) {
      // If encountering an error, return 0
      return "error";
    }
  }

  Future<File> writeData(List<int> time,List<double> speed,List<double> averspeed,List<double> distance) async {
    final file = await _localFile;

    // Write the file
    return file.writeAsString('times:$time,speeds:$speed,averSpeeds:$averspeed,distances:$distance');
  }
}