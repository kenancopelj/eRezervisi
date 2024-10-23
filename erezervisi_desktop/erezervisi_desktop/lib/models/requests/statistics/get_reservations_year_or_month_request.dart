class GetReservationsYearOrMonthRequest{

  num? year;
  num? month;

  GetReservationsYearOrMonthRequest({
    this.year,
    this.month
  });

  GetReservationsYearOrMonthRequest.def();

  Map<String, dynamic> toJson() {
    return {
      'year': year,
      'month': month
    };
  }
}
