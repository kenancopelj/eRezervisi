class PagedResponse<T> {
  late num totalItems;
  late num totalPages;
  late num pageSize;
  late List<T> items;

  PagedResponse(
      {required this.totalItems,
      required this.totalPages,
      required this.pageSize,
      required this.items});

  PagedResponse.empty() {
    totalItems = 0;
    totalPages = 0;
    pageSize = 0;
    items = [];
  }

  factory PagedResponse.fromJson(Map<String, dynamic> json) {
    return PagedResponse(
        items: (json['items'] as List<dynamic>).toList() as List<T>,
        totalItems: json['totalItems'] as num,
        totalPages: json['totalPages'] as num,
        pageSize: json['pageSize'] as num);
  }
}
