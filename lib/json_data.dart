import 'imports.dart';

class JSONData implements Data {
  List<Map<String, dynamic>> _data = [];

  @override
  void load(String fileName) {
    try {
      final file = File(fileName);
      final jsonString = file.readAsStringSync();
      final dataList = json.decode(jsonString) as List<dynamic>;

      _data = dataList.cast<Map<String, dynamic>>();
    } catch (e) {
      throw InvalidDataFormatException('Invalid JSON data format: $e');
    }
  }

  @override
  void save(String fileName) {
    try {
      final file = File(fileName);
      final jsonString = json.encode(_data);
      file.writeAsStringSync(jsonString);
    } catch (e) {
      throw InvalidDataFormatException('Error saving JSON data: $e');
    }
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
    try {
      final dataList = json.decode(data) as List<dynamic>;
      _data = dataList.cast<Map<String, dynamic>>();
    } catch (e) {
      throw InvalidDataFormatException('Invalid JSON data format: $e');
    }
  }

  @override
  List<String> get fields {
    if (_data.isNotEmpty) {
      return _data.first.keys.toList();
    }
    return [];
  }
}