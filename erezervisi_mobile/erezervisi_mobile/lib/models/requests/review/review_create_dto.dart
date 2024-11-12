class ReviewCreateDto {
  late num rating;
  String? note;

  ReviewCreateDto({required this.rating, this.note});

  Map<String, dynamic> toJson() {
    return {'rating': rating, 'note': note};
  }
}
