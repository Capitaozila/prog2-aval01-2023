import 'package:teste1/imports.dart';

void main() {
  checkData(JsonData(), 'lib/files/sample.json');
  checkData(CsvData(), 'lib/files/sample.csv');
  checkData(TsvData(), 'lib/files/sample.tsv');
  checkData(XmlData(), 'lib/files/sample.xml');
}

void checkData(Data data, String fileName) {
  data.load(fileName);
  print('fileName: $fileName');
  print('fields\t: ${data.fields}');
  print('hasData\t: ${data.hasData}');
  if (data is DelimitedData) {
    final delim = (data.delimiter == ',') ? 'COMMA' : 'TAB';
    print('delim\t: $delim');
  }
  print('data:');
  print(data.data);
  print('');
}
