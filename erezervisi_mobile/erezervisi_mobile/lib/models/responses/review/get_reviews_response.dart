import 'package:erezervisi_mobile/models/responses/review/review_get_dto.dart';

class GetReviewsResponse {
  late List<ReviewGetDto> reviews;

  GetReviewsResponse({required this.reviews});

  factory GetReviewsResponse.fromJson(Map<String, dynamic> json) {
    List<ReviewGetDto> reviews =
        (json['reviews'] as List<ReviewGetDto>)
            .map((reviewJson) => ReviewGetDto.fromJson(json))
            .toList();

    return GetReviewsResponse(reviews: reviews);
  }
}
