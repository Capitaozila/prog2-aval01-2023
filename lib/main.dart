import 'dart:io';
import 'dart:convert';
import 'package:xml/xml.dart';

abstract class Data {
  void load(String fileName);
  void save(String fileName);
  void clear();
  bool get hasData;
  String get data;
  set data(String data);
  List<String> get fields;
}

abstract class DelimitedData implements Data {
  String get delimiter;
}

class CSVData implements DelimitedData {
  List<List<String>> _data = [];

  @override
  void load(String fileName) {
    final file = File(fileName);
    final lines = file.readAsLinesSync();
    _data = lines.map((line) => line.split(delimiter)).toList();
  }

  @override
  void save(String fileName) {
    final file = File(fileName);
    final lines = _data.map((row) => row.join(delimiter)).toList();
    file.writeAsStringSync(lines.join('\n'));
  }

  @override
  void clear() {
    _data.clear();
  }

  @override
  bool get hasData => _data.isNotEmpty;

  @override
  String get data => _data.map((row) => row.join(delimiter)).join('\n');

  @override
  set data(String data) {
    final rows = data.split('\n');
    _data = rows.map((row) => row.split(delimiter)).toList();
  }

  @override
  List<String> get fields {
    if (_data.isNotEmpty) {
      return _data.first;
    }
    return [];
  }

  @override
  String get delimiter => ',';
}

class TSVData implements DelimitedData {
  List<List<String>> _data = [];

  @override
  void load(String fileName) {
    final file = File(fileName);
    final lines = file.readAsLinesSync();
    _data = lines.map((line) => line.split(delimiter)).toList();
  }

  @override
  void save(String fileName) {
    final file = File(fileName);
    final lines = _data.map((row) => row.join(delimiter)).toList();
    file.writeAsStringSync(lines.join('\n'));
  }

  @override
  void clear() {
    _data.clear();
  }

  @override
  bool get hasData => _data.isNotEmpty;

  @override
  String get data => _data.map((row) => row.join(delimiter)).join('\n');

  @override
  set data(String data) {
    final rows = data.split('\n');
    _data = rows.map((row) => row.split(delimiter)).toList();
  }

  @override
  List<String> get fields {
    if (_data.isNotEmpty) {
      return _data.first;
    }
    return [];
  }

  @override
  String get delimiter => '\t';
}

class JSONData implements Data {
  Map<String, dynamic> _data = {};

  @override
  void load(String fileName) {
    final file = File(fileName);
    final jsonString = file.readAsStringSync();
    _data = json.decode(jsonString);
  }

  @override
  void save(String fileName) {
    final file = File(fileName);
    final jsonString = json.encode(_data);
    file.writeAsStringSync(jsonString);
  }

  @override
  void clear() {
    _data.clear();
  }

  @override
  bool get hasData => _data.isNotEmpty;

  @override
  String get data => json.encode(_data);

  @override
  set data(String data) {
    _data = json.decode(data);
  }

  @override
  List<String> get fields {
    if (_data.isNotEmpty) {
      return _data.keys.toList();
    }
    return [];
  }
}

class XMLData implements Data {
  XmlDocument _data = XmlDocument();

  @override
  void load(String fileName) {
    final file = File(fileName);
    final xmlString = file.readAsStringSync();
    _data = XmlDocument.parse(xmlString);
  }

  @override
  void save(String fileName) {
    final file = File(fileName);
    final xmlString = _data.toXmlString(pretty: true);
    file.writeAsStringSync(xmlString);
  }

  @override
  void clear() {
    _data = XmlDocument();
  }

  @override
  bool get hasData => _data.children.isNotEmpty;

  @override
  String get data => _data.toXmlString();

  @override
  set data(String data) {
    _data = XmlDocument.parse(data);
  }

  @override
  List<String> get fields {
    if (_data.children.isNotEmpty) {
      final firstElement = _data.children.whereType<XmlElement>().first;
      return firstElement.children
          .whereType<XmlElement>()
          .map((child) => child.getAttribute('name') ?? '')
          .toList();
    }
    return [];
  }
}
