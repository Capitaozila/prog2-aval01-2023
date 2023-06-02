import './imports.dart';

class CSVData implements DelimitedData {
  List<List<String>> _data = [];

  @override
  void load(String fileName) {
    try {
      final file = File(fileName);
      final lines = file.readAsLinesSync();
      _data = lines.map((line) => line.split(delimiter)).toList();
    } catch (e) {
      throw InvalidDataFormatException('Failed to load data from file: $e');
    }
  }

  @override
  void save(String fileName) {
    try {
      final file = File(fileName);
      final lines = _data.map((row) => row.join(delimiter)).toList();
      file.writeAsStringSync(lines.join('\n'));
    } catch (e) {
      throw InvalidDataFormatException('Failed to save data to file: $e');
    }
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
    try {
      final rows = data.split('\n');
      _data = rows.map((row) => row.split(delimiter)).toList();
    } catch (e) {
      throw InvalidDataFormatException('Invalid data format: $e');
    }
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
