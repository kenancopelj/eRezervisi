// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:erezervisi_desktop/models/requests/reviews/get_reviews_request.dart';
import 'package:erezervisi_desktop/models/responses/base/paged_response.dart';
import 'package:erezervisi_desktop/models/responses/review/review_get_dto.dart';
import 'package:erezervisi_desktop/providers/accommodation_unit_provider.dart';
import 'package:erezervisi_desktop/screens/reviews/review_item.dart';
import 'package:erezervisi_desktop/widgets/empty.dart';
import 'package:erezervisi_desktop/widgets/master_widget.dart';
import 'package:erezervisi_desktop/widgets/pagination.dart';
import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();

    accommodationUnitProvider = context.read<AccommodationUnitProvider>();

    request.orderByColumn = "createdAt";
    request.orderBy = "desc";
    
    loadReviews();
  }

  Future loadReviews() async {
    setState(() {
      request.page = currentPage;
    });

    var response = await accommodationUnitProvider.getReviewsPaged(request);

    if (mounted) {
      setState(() {
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
            const Row(
              children: [
                Icon(
                  Icons.favorite_outlined,
                ),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Text("Recenzije",
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 20)),
                ),
              ],
            ),
            SizedBox(height: 30),
            Expanded(
              child: items.isEmpty
                  ? const EmptyPage()
                  : ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        var review = items[index];
                        return ReviewItem(review: review);
                      },
                    ),
            ),
            items.isEmpty
                ? const SizedBox.shrink()
                : Pagination(
                    currentPage: currentPage,
                    totalItems: reviews.totalItems.toInt(),
                    itemsPerPage: request.pageSize.toInt(),
                    onPageChanged: (newPage) {
                      setState(() {
                        currentPage = newPage;
                      });

                      loadReviews();
                    },
                  )
          ],
        ),
      ),
    );
  }
}
