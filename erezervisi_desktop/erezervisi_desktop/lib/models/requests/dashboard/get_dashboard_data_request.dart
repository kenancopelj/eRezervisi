class GetDashboardDataRequest {
  late num month;
  late num year;

  GetDashboardDataRequest({required this.month, required this.year});

  Map<String, dynamic> toJson() {
    return {
      'month': month,
      'year': year,
    };
  }
}
