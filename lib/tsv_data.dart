import 'imports.dart';

class TSVData implements DelimitedData {
  List<List<String>> _data = [];

  @override
  void load(String fileName) {
    try {
      final file = File(fileName);
      final lines = file.readAsLinesSync();
      _data = lines.map((line) => line.split(separator)).toList();
    } catch (e) {
      throw InvalidDataFormatException('Failed to load TSV data: $e');
    }
  }

  @override
  void save(String fileName) {
    try {
      final file = File(fileName);
      final lines = _data.map((row) => row.join(separator)).toList();
      file.writeAsStringSync(lines.join('\n'));
    } catch (e) {
      throw InvalidDataFormatException('Failed to save TSV data: $e');
    }
  }

  @override
  void clear() {
    _data.clear();
  }

  @override
  bool get hasData => _data.isNotEmpty;

  @override
  String get data => _data.map((row) => row.join(separator)).join('\n');

  @override
  set data(String data) {
    try {
      final rows = data.split('\n');
      if (rows.isNotEmpty) {
        final firstRow = rows[0];
        final fields = firstRow.split(separator);
        if (fields.isNotEmpty) {
          _data = rows.map((row) => row.split(separator)).toList();
          return;
        }
      }
      throw InvalidDataFormatException('Invalid TSV data format');
    } catch (e) {
      throw InvalidDataFormatException('Failed to set TSV data: $e');
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
  String get separator => '\t';
}

