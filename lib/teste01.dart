import 'dart:io';

abstract class Data {
  void load(String fileName);
  void save(String fileName);
  void clear();
  bool get hasData;
  String get data;
  set data(String data);
  List<String> get fields;
}

abstract class DelimitedData {
  String get delimiter;
}

class CSVData implements Data, DelimitedData {
  List<List<String>> _data = [];
  List<String> _fields = [];
  String _delimiter = ',';

  @override
  void load(String fileName) {
    final file = File(fileName);
    final lines = file.readAsLinesSync();
    _fields = lines.first.split(_delimiter);
    _data = lines.skip(1).map((line) => line.split(_delimiter)).toList();
  }

  @override
  void save(String fileName) {
    final file = File(fileName);
    final lines = <String>[];
    lines.add(_fields.join(_delimiter));
    lines.addAll(_data.map((row) => row.join(_delimiter)));
    file.writeAsStringSync(lines.join('\n'));
  }

  @override
  void clear() {
    _data.clear();
    _fields.clear();
  }

  @override
  bool get hasData => _data.isNotEmpty;

  @override
  String get data => _data.map((row) => row.join(_delimiter)).join('\n');

  @override
  set data(String data) {
    _data = data.split('\n').map((line) => line.split(_delimiter)).toList();
  }

  @override
  List<String> get fields => List.from(_fields);

  @override
  String get delimiter => _delimiter;
}

void main() {
  final csvData = CSVData();
  csvData.load('data.csv');
  print('Data Fields: ${csvData.fields}');
  print('Has Data: ${csvData.hasData}');
  print('Data:');
  print(csvData.data);

  csvData.clear();
  print('Has Data: ${csvData.hasData}');

  csvData.data = 'Name,Age,City\nJohn,25,New York\nJane,30,San Francisco';
  csvData.save('new_data.csv');
}
