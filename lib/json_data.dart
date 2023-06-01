import 'imports.dart';

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
    try {
      _data = json.decode(data);
    } catch (e) {
      throw InvalidDataFormatException('Invalid data format');
    }
  }

  @override
  List<String> get fields {
    if (_data.isNotEmpty) {
      return _data.keys.toList();
    }
    return [];
  }
}
