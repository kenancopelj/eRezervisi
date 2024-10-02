class BaseGetAllRequest {
  late String searchTerm;

  BaseGetAllRequest({required this.searchTerm});

  BaseGetAllRequest.def() {
    searchTerm = "";
  }

  Map<String, dynamic> toJson() {
    return {
      'searchTerm': searchTerm,
    };
  }
}
