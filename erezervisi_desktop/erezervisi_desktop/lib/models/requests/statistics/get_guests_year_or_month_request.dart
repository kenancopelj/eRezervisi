class GetGuestsYearOrMonthRequest {
  num? year;
  num? month;

  GetGuestsYearOrMonthRequest({this.year, this.month});

  GetGuestsYearOrMonthRequest.def();

  Map<String, dynamic> toJson() {
    return {'year': year, 'month': month};
  }
}
