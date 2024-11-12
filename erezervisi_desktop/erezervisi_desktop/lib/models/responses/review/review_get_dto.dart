class ReviewGetDto {
  late num id;
  late num rating;
  String? note;
  late num reviewerId;
  late String reviewer;
  String? reviewerImage;
  late num minutesAgo;
  late num hoursAgo;
  late num daysAgo;

  ReviewGetDto({
    required this.id,
    required this.rating,
    this.note,
    required this.reviewerId,
    required this.reviewer,
    this.reviewerImage,
    required this.minutesAgo,
    required this.hoursAgo,
    required this.daysAgo,
  });

  factory ReviewGetDto.fromJson(Map<String, dynamic> json) {
    return ReviewGetDto(
      id: json['id'] as num,
      rating: json['rating'] as num,
      note: json['note'],
      reviewerId: json['reviewerId'] as num,
      reviewer: json['reviewer'],
      reviewerImage: json['reviewerImage'],
      minutesAgo: json['minutesAgo'],
      hoursAgo: json['hoursAgo'],
      daysAgo: json['daysAgo'],
    );
  }
}
