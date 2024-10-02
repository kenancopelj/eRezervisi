// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:erezervisi_desktop/models/requests/reviews/get_reviews_request.dart';
import 'package:erezervisi_desktop/models/responses/base/paged_response.dart';
import 'package:erezervisi_desktop/models/responses/review/review_get_dto.dart';
import 'package:erezervisi_desktop/providers/accommodation_unit_provider.dart';
import 'package:erezervisi_desktop/widgets/empty.dart';
import 'package:erezervisi_desktop/widgets/master_widget.dart';
import 'package:erezervisi_desktop/widgets/pagination.dart';
import 'package:erezervisi_desktop/widgets/reviews_custom/review_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class Reviews extends StatefulWidget {
  const Reviews({super.key});

  @override
  State<Reviews> createState() => _ReviewsState();
}

class _ReviewsState extends State<Reviews> {
  var reviews = PagedResponse<ReviewGetDto>.empty();
  var request = GetReviewsRequest.def();

  late AccommodationUnitProvider accommodationUnitProvider;

  int currentPage = 1;
  final int itemsPerPage = 10;

  List<String> headers = ['Naziv', 'Cijena'];

  @override
  void initState() {
    super.initState();

    accommodationUnitProvider = context.read<AccommodationUnitProvider>();

    loadReviews();
  }

  Future loadReviews() async {
    var response = await accommodationUnitProvider.getReviewsPaged(request);

    if (mounted) {
      setState(() {
        print(response);
        reviews = response;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<ReviewGetDto> items = reviews.items;

    return MasterWidget(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: items.isEmpty
                  ? const EmptyPage()
                  : ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Card(
                            elevation: 4.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      items[index].title,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: Text(
                                      items[index].note,
                                      style: const TextStyle(fontSize: 16),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      "${items[index].rating}",
                                      style: const TextStyle(fontSize: 16),
                                      textAlign: TextAlign.right,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
            items.isEmpty
                ? const SizedBox.shrink()
                : Pagination(
                    currentPage: currentPage,
                    totalItems: reviews.totalItems.toInt(),
                    itemsPerPage: itemsPerPage,
                    onPageChanged: (newPage) {
                      setState(() {
                        currentPage = newPage;
                      });
                    },
                  )
          ],
        ),
      ),
    );
  }
}
