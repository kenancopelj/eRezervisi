class BasePagedRequest {
  late num page;
  late num pageSize;
  late String searchTerm;
  late String orderByColumn;
  late String orderBy;

  BasePagedRequest(
      {required this.page,
      required this.pageSize,
      required this.searchTerm,
      required this.orderByColumn,
      required this.orderBy});

  Map<String, dynamic> toJson() {
    return {
      'page': page,
      'pageSize': pageSize,
      'searchTerm': searchTerm,
      'orderByColumn': orderByColumn,
      'orderBy': orderBy
    };
  }
}
