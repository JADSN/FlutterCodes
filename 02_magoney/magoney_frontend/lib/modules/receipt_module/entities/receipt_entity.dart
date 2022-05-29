// ignore_for_file: public_member_api_docs, sort_constructors_first
class ReceiptReadAllEntity {
  // final int id;
  final String code; // * UUID
  final String collectionDate;
  final int donateWorldWork;
  final int localCongregationExpenses;
  final int receiptType;
  final int createdAt;
  final int updatedAt;

  ReceiptReadAllEntity({
    required this.code,
    required this.collectionDate,
    required this.donateWorldWork,
    required this.localCongregationExpenses,
    required this.receiptType,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ReceiptReadAllEntity.fromMap(map) {
    return ReceiptReadAllEntity(
      // id: map['id'] as int,
      code: map['code'] as String,
      collectionDate: map['collectionDate'] as String,
      donateWorldWork: map['donateWorldWork'] as int,
      receiptType: map['receiptType'] as int,
      localCongregationExpenses: map['localCongregationExpenses'] as int,
      createdAt: map['createdAt'] as int,
      updatedAt: map['updatedAt'] as int,
    );
  }

  @override
  String toString() {
    return 'ReceiptReadAllEntity(code: $code, collectionDate: $collectionDate, donateWorldWork: $donateWorldWork, localCongregationExpenses: $localCongregationExpenses, receiptType: $receiptType, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}

class ReceiptReadOneEntity {
  final String code; // * UUID
  final String collectionDate;
  final int donateWorldWork;
  final int localCongregationExpenses;
  final int receiptType;

  ReceiptReadOneEntity({
    required this.code,
    required this.collectionDate,
    required this.donateWorldWork,
    required this.localCongregationExpenses,
    required this.receiptType,
  });

  factory ReceiptReadOneEntity.fromMap(Map<String, dynamic> map) {
    return ReceiptReadOneEntity(
      code: map['code'] as String,
      collectionDate: map['collectionDate'] as String,
      donateWorldWork: map['donateWorldWork'] as int,
      localCongregationExpenses: map['localCongregationExpenses'] as int,
      receiptType: map['receiptType'] as int,
    );
  }
}

class ReceiptCreateEntity {
  final String collectionDate;
  final int donateWorldWork;
  final int localCongregationExpenses;
  final int receiptType;

  ReceiptCreateEntity({
    required this.collectionDate,
    required this.donateWorldWork,
    required this.localCongregationExpenses,
    required this.receiptType,
  });

  @override
  String toString() {
    return 'ReceiptCreateEntity(collectionDate: $collectionDate, donateWorldWork: $donateWorldWork, localCongregationExpenses: $localCongregationExpenses, receiptType: $receiptType)';
  }
}

class ReceiptUpdateEntity {
  final String collectionDate;
  final int donateWorldWork;
  final int localCongregationExpenses;
  final int receiptType;

  ReceiptUpdateEntity({
    required this.collectionDate,
    required this.donateWorldWork,
    required this.localCongregationExpenses,
    required this.receiptType,
  });

  @override
  String toString() {
    return 'ReceiptUpdateEntity(collectionDate: $collectionDate, donateWorldWork: $donateWorldWork, localCongregationExpenses: $localCongregationExpenses, receiptType: $receiptType)';
  }
}
