String convertIsoDateToBrazilian(String isoDate) {
  // Divide a data em componentes de ano, mês e dia
  List<String> parts = isoDate.split('-');
  if (parts.length != 3) {
    throw FormatException('Data inválida');
  }
  // Reorganiza os componentes para o formato DD/MM/YYYY
  return '${parts[2]}/${parts[1]}/${parts[0]}';
}
