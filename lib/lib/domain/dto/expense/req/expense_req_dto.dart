class ExpenseReqDto {
  const ExpenseReqDto({
    required this.userId,
    required this.categoryId,
    required this.amount,
    required this.date,
    this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  final String userId;
  final String categoryId;
  final String amount;
  final DateTime date;
  final String? description;
  final DateTime createdAt;
  final DateTime updatedAt;

  Map<String, dynamic> toJson() => {
    'user_id': userId,
    'category_id': categoryId,
    'amount': amount,
    'date': date.toIso8601String(),
    'description': description,
    'created_at': createdAt.toIso8601String(),
    'updated_at': updatedAt.toIso8601String(),
  };
}
