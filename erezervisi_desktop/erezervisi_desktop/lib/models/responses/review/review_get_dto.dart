class ReviewGetDto {
  late num id;
  late String title;
  late num rating;
  late String note;
  late num reviewerId;
  late String reviewer;

  ReviewGetDto({
    required this.id,
    required this.title,
    required this.rating,
    required this.note,
    required this.reviewerId,
    required this.reviewer,
  });

  factory ReviewGetDto.fromJson(Map<String, dynamic> json) {
    return ReviewGetDto(
      id: json['id'] as num,
      title: json['title'],
      rating: json['rating'] as num,
      note: json['note'],
      reviewerId: json['reviewerId'] as num,
      reviewer: json['reviewer'],
    );
  }
}
