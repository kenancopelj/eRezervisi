import 'package:erezervisi_desktop/models/responses/reservation/reservation_get_short_dto.dart';
import 'package:erezervisi_desktop/models/responses/review/review_get_dto.dart';

class DashboardDataResponse {
  late num expectedArrivals;
  late num availableAccommodationUnits;
  late num numberOfGuests;
  late num numberOfReviews;
  late List<ReviewGetDto> latestReviews;
  late List<ReservationGetShortDto> latestReservations;

  DashboardDataResponse(
      {required this.expectedArrivals,
      required this.availableAccommodationUnits,
      required this.numberOfGuests,
      required this.numberOfReviews,
      required this.latestReviews,
      required this.latestReservations});

  factory DashboardDataResponse.fromJson(Map<String, dynamic> json) {
    var latestReviewsArray = json['latestReviews'] as List<dynamic>;
    var latestReservationsArray = json['latestReservations'] as List<dynamic>;

    return DashboardDataResponse(
      expectedArrivals: json['expectedArrivals'],
      availableAccommodationUnits: json['availableAccommodationUnits'],
      numberOfGuests: json['numberOfGuests'],
      numberOfReviews: json['numberOfReviews'],
      latestReviews: latestReviewsArray.isEmpty
          ? []
          : latestReviewsArray
              .map((reviewJson) =>
                  ReviewGetDto.fromJson(reviewJson as Map<String, dynamic>))
              .toList(),
      latestReservations: latestReservationsArray.isEmpty
          ? []
          : latestReservationsArray
              .map((reservationJson) => ReservationGetShortDto.fromJson(
                  reservationJson as Map<String, dynamic>))
              .toList(),
    );
  }
}
