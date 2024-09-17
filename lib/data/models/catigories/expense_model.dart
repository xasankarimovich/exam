class ExpenseModel {
  final String id;
  final int summa;
  final String category;
  final DateTime dateTime;
  final String comment;

  ExpenseModel({
    required this.id,
    required this.summa,
    required this.category,
    required this.dateTime,
    required this.comment,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'summa': summa,
      'category': category,
      'dateTime': dateTime.toIso8601String(),
      'comment': comment,
    };
  }

  factory ExpenseModel.fromMap(Map<String, dynamic> map) {
    return ExpenseModel(
      id: map['id'],
      summa: map['summa'],
      category: map['category'],
      dateTime: DateTime.parse(map['dateTime']),
      comment: map['comment'],
    );
  }

}
