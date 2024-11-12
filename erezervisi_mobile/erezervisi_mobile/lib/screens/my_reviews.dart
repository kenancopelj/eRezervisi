import 'package:erezervisi_mobile/helpers/custom_theme.dart';
import 'package:erezervisi_mobile/models/requests/review/get_users_reviews_request.dart';
import 'package:erezervisi_mobile/models/responses/base/paged_response.dart';
import 'package:erezervisi_mobile/models/responses/review/get_reviews_response.dart';
import 'package:erezervisi_mobile/models/responses/review/review_get_dto.dart';
import 'package:erezervisi_mobile/providers/user_provider.dart';
import 'package:erezervisi_mobile/shared/pagination.dart';
import 'package:erezervisi_mobile/widgets/master_widget.dart';
import 'package:erezervisi_mobile/widgets/reviews_custom/review_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class MyReviews extends StatefulWidget {
  const MyReviews({super.key});

  @override
  State<MyReviews> createState() => _MyChatState();
}

class _MyChatState extends State<MyReviews> {
  late UserProvider userProvider;

  var request = GetUsersReviewsRequest.def();

  var pagedResponse = PagedResponse<ReviewGetDto>.empty();

  int currentPage = 1;

  @override
  void initState() {
    super.initState();

    userProvider = context.read<UserProvider>();

    request.orderByColumn = "createdAt";
    request.orderBy = "desc";

    loadReviews();
  }

  Future loadReviews() async {
    setState(() {
      request.page = currentPage;
    });

    var response = await userProvider.getMyReviewsPaged(request);

    if (mounted) {
      setState(() {
        pagedResponse = response;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MasterWidget(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Text(
                  "Moje recenzije",
                  style: CustomTheme.mediumTextStyle,
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            pagedResponse.items.isEmpty
                ? SizedBox(
                    height: MediaQuery.of(context).size.height - 300,
                    child: const Center(child: Text("Vaša lista je prazna")),
                  )
                : Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: pagedResponse.items.length,
                      itemBuilder: (BuildContext context, int index) {
                        var review = pagedResponse.items[index];
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ReviewItem(review: review),
                        );
                      },
                    ),
                  ),
            if (pagedResponse.totalPages > 1)
              Pagination(
                currentPage: currentPage,
                totalItems: pagedResponse.totalItems.toInt(),
                itemsPerPage: pagedResponse.pageSize.toInt(),
                onPageChanged: (newPage) {
                  setState(() {
                    currentPage = newPage;
                  });

                  pagedResponse.items = [];

                  loadReviews();
                },
              )
          ],
        ),
      ),
    );
  }
}
