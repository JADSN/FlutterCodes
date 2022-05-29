// ignore_for_file: public_member_api_docs, sort_constructors_first
class RecordReadAllEntity {
  // final int id;
  final String code;
  final String recordDate;
  final String description;
  final int donateInput;
  final int donateOutput;
  final int bankAccountInput;
  final int bankAccountOutput;
  final int otherInput;
  final int otherOutput;
  final int symbol;

  RecordReadAllEntity({
    required this.code,
    required this.recordDate,
    required this.description,
    required this.donateInput,
    required this.donateOutput,
    required this.bankAccountInput,
    required this.bankAccountOutput,
    required this.otherInput,
    required this.otherOutput,
    required this.symbol,
  });

  factory RecordReadAllEntity.fromMap(map) {
    return RecordReadAllEntity(
      code: map['code'] as String,
      recordDate: map['recordDate'] as String,
      description: map['description'] as String,
      donateInput: map['donateInput'] as int,
      donateOutput: map['donateOutput'] as int,
      bankAccountInput: map['bankAccountInput'] as int,
      bankAccountOutput: map['bankAccountOutput'] as int,
      otherInput: map['otherInput'] as int,
      otherOutput: map['otherOutput'] as int,
      symbol: map['symbol'] as int,
    );
  }

  @override
  String toString() {
    return 'RecordReadAllEntity(code: $code, recordDate: $recordDate, description: $description, donateInput: $donateInput, donateOutput: $donateOutput, bankAccountInput: $bankAccountInput, bankAccountOutput: $bankAccountOutput, otherInput: $otherInput, otherOutput: $otherOutput, symbol: $symbol)';
  }
}

class RecordCreateEntity {
  final String recordDate;
  final String description;
  final int donateInput;
  final int donateOutput;
  final int bankAccountInput;
  final int bankAccountOutput;
  final int otherInput;
  final int otherOutput;
  final int symbol;

  RecordCreateEntity({
    required this.recordDate,
    required this.description,
    required this.donateInput,
    required this.donateOutput,
    required this.bankAccountInput,
    required this.bankAccountOutput,
    required this.otherInput,
    required this.otherOutput,
    required this.symbol,
  });

  @override
  String toString() {
    return 'RecordCreateEntity(recordDate: $recordDate, description: $description, donateInput: $donateInput, donateOutput: $donateOutput, bankAccountInput: $bankAccountInput, bankAccountOutput: $bankAccountOutput, otherInput: $otherInput, otherOutput: $otherOutput, symbol: $symbol)';
  }
}

class RecordUpdateEntity {
  final String recordDate;
  final String description;
  final int donateInput;
  final int donateOutput;
  final int bankAccountInput;
  final int bankAccountOutput;
  final int otherInput;
  final int otherOutput;
  final int symbol;

  RecordUpdateEntity({
    required this.recordDate,
    required this.description,
    required this.donateInput,
    required this.donateOutput,
    required this.bankAccountInput,
    required this.bankAccountOutput,
    required this.otherInput,
    required this.otherOutput,
    required this.symbol,
  });

  @override
  String toString() {
    return 'RecordUpdateEntity(recordDate: $recordDate, description: $description, donateInput: $donateInput, donateOutput: $donateOutput, bankAccountInput: $bankAccountInput, bankAccountOutput: $bankAccountOutput, otherInput: $otherInput, otherOutput: $otherOutput, symbol: $symbol)';
  }
}
