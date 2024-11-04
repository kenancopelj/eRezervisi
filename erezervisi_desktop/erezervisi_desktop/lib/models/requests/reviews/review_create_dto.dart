class ReviewCreateDto {
  late String title;
  late String note;
  late num rating;

  ReviewCreateDto(
      {required this.title, required this.note, required this.rating});

  Map<String, dynamic> toJson() {
    return {'title': title, 'note': note, 'rating': rating};
  }
}
