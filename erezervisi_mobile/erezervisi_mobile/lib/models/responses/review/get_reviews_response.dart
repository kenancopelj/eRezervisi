import 'package:erezervisi_mobile/models/responses/review/review_get_dto.dart';

class GetReviewsResponse {
  late List<ReviewGetDto> reviews;
  late num average;

  GetReviewsResponse({required this.reviews, required this.average});

  factory GetReviewsResponse.fromJson(Map<String, dynamic> json) {
    List<ReviewGetDto> reviews =
        (json['reviews'] as List<ReviewGetDto>)
            .map((reviewJson) => ReviewGetDto.fromJson(json))
            .toList();
    
    var average = json['average'];

    return GetReviewsResponse(reviews: reviews, average: average);
  }
}
