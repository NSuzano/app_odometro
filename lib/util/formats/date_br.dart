import 'package:intl/intl.dart';

String convertIsoDateToBrazilian(String isoDate) {
  // Divide a data em componentes de ano, mês e dia
  List<String> parts = isoDate.split('-');
  if (parts.length != 3) {
    throw FormatException('Data inválida');
  }
  // Reorganiza os componentes para o formato DD/MM/YYYY
  return '${parts[2]}/${parts[1]}/${parts[0]}';
}


String formatDate(String dateStr) {
  // A entrada é assumida como '2024-03-20 23:59:00'
  List<String> parts = dateStr.split(' '); // Divide em data e hora
  List<String> dateParts = parts[0].split('-'); // Divide a data em [ano, mês, dia]

  // Reordena para DD/MM/YYYY e reanexa a hora
  return '${dateParts[2]}/${dateParts[1]}/${dateParts[0]} ${parts[1]}';
}

String formatDateTimeStamp(DateTime timestamp) {
  // Define o formato desejado
  DateFormat formatter = DateFormat('dd/MM/yyyy HH:mm:ss');
  // Converte o timestamp para string usando o formato definido
  return formatter.format(timestamp);
}
