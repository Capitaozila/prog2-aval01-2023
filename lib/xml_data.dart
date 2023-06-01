import 'imports.dart';

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
    try {
      _data = XmlDocument.parse(data);
    } catch (e) {
      throw InvalidDataFormatException('Invalid data format');
    }
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
