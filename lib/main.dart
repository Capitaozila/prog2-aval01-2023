import 'package:teste1/data.dart';

void main() {
  // Exemplo de uso das classes

  // Criando uma instância da classe CSVData
  final csvData = CSVData();

  // Carregando dados de um arquivo CSV
  csvData.load('./lib/dados/csv/data01.csv');

  // Obtendo os nomes dos campos
  final csvFields = csvData.fields;
  print('CSV Fields: $csvFields');

  // Verificando se existem dados carregados
  print('CSV hasData: ${csvData.hasData}');

  // Obtendo os dados armazenados
  final csvDataContent = csvData.data;
  print('CSV dados armazenados:\n$csvDataContent');

  // Salvando os dados em um novo arquivo CSV
  csvData.save('./lib/dados/newdate/new_data.csv');

  // Limpando os dados
  csvData.clear();
  print('CSV hasData: ${csvData.hasData}');
}
