import 'package:teste1/data.dart';

void main() {
  // Exemplo de uso das classes

  // Criando uma instância da classe CSVData
  final csvData = CSVData();

  // Carregando dados de um arquivo CSV
  csvData.load('./lib/dados/json/data01.json');

  // Obtém os campos do arquivo CSV
  final csvFields = csvData.fields;
  print('CSV Fields: $csvFields');

  // Verificando se existem dados no arquivo CSV
  print('CSV hasData: ${csvData.hasData}');

  // Obtendo os dados do arquivo CSV  (se existirem)
  final csvDataContent = csvData.data;
  print('CSV dados armazenados:\n$csvDataContent');

  // salva os dados no arquivo CSV (se existirem)
  csvData.save('./lib/dados/newdate/new_data.csv');

  // Limpa os dados do arquivo CSV (se existirem)
  print('CSV hasData: ${csvData.hasData}');
}
