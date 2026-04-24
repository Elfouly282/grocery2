class Pagination {
  final int currentPage;
  final int lastPage;
  final int perPage;
  final int total;
  final int from;
  final int to;

  Pagination({
    required this.currentPage,
    required this.lastPage,
    required this.perPage,
    required this.total,
    required this.from,
    required this.to,
  });
  bool get hasNextPage => currentPage < lastPage;
  Map<String, dynamic> toJson() {
    return {
      'currentPage': currentPage,
      'lastPage': lastPage,
      'perPage': perPage,
      'total': total,
      'from': from,
      'to': to,
    };
  }

  factory Pagination.fromJson(Map<String, dynamic> map) {
    return Pagination(
      currentPage: _parseInt(map['currentPage']),
      lastPage: _parseInt(map['lastPage']),
      perPage: _parseInt(map['perPage']),
      total: _parseInt(map['total']),
      from: _parseInt(map['from']),   // ← this is the null one
      to: _parseInt(map['to']),
    );
  }

  static int _parseInt(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    if (value is double) return value.toInt();
    return int.tryParse(value.toString()) ?? 0;
  }
}