import 'imports.dart';

class XmlData implements Data {
  XmlDocument _data = XmlDocument();

  @override
  void load(String fileName) {
    try {
      final file = File(fileName);
      final xmlString = file.readAsStringSync();
      _data = XmlDocument.parse(xmlString);
    } catch (e) {
      throw InvalidDataFormatException('Failed to load XML data: $e');
    }
  }

  @override
  void save(String fileName) {
    try {
      final file = File(fileName);
      final xmlString = _data.toXmlString(pretty: true);
      file.writeAsStringSync(xmlString);
    } catch (e) {
      throw InvalidDataFormatException('Failed to save XML data: $e');
    }
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
      throw InvalidDataFormatException('Invalid XML data format: $e');
    }
  }

  @override
  List<String> get fields {
    final rootElement = _data.rootElement;
    final children = rootElement.children;
    if (children.isNotEmpty) {
      return children
          .whereType<XmlElement>()
          .first
          .attributes
          .map((attr) => attr.name.qualified)
          .toList();
    }
    return [];
  }
}
