import 'package:erezervisi_desktop/enums/toast_type.dart';
import 'package:erezervisi_desktop/helpers/custom_theme.dart';
import 'package:erezervisi_desktop/models/requests/guest/get_guests_request.dart';
import 'package:erezervisi_desktop/models/requests/reviews/review_create_dto.dart';
import 'package:erezervisi_desktop/models/responses/base/paged_response.dart';
import 'package:erezervisi_desktop/models/responses/guest/guest_get_dto.dart';
import 'package:erezervisi_desktop/providers/guest_provider.dart';
import 'package:erezervisi_desktop/shared/components/form/input.dart';
import 'package:erezervisi_desktop/shared/globals.dart';
import 'package:erezervisi_desktop/widgets/action_button.dart';
import 'package:erezervisi_desktop/widgets/confirmation_dialog.dart';
import 'package:erezervisi_desktop/widgets/empty.dart';
import 'package:erezervisi_desktop/widgets/guests/guest_item.dart';
import 'package:erezervisi_desktop/widgets/master_widget.dart';
import 'package:erezervisi_desktop/widgets/pagination.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class Guests extends StatefulWidget {
  const Guests({super.key});

  @override
  State<Guests> createState() => _GuestsState();
}

class _GuestsState extends State<Guests> {
  var guests = PagedResponse<GuestGetDto>.empty();
  var request = GetGuestsRequest.def();

  late GuestProvider guestProvider;

  int currentPage = 1;
  final int pageSize = 5;

  List<num> selectedGuests = [];

  var reviewNoteController = TextEditingController();

  @override
  void initState() {
    super.initState();

    guestProvider = context.read<GuestProvider>();

    loadGuests();
  }

  Future loadGuests() async {
    request.pageSize = pageSize;
    request.page = currentPage;
    var response = await guestProvider.getPaged(request);

    if (mounted) {
      setState(() {
        guests = response;
      });
    }
  }

  Future createGuestReview(num guestId, ReviewCreateDto request) async {
    await guestProvider.createReview(guestId, request);

    setState(() {
      reviewNoteController.text = "";
    });

    loadGuests();
  }

  void handleSelectGuest(num guestId) {
    print(guestId);
    if (selectedGuests.any((x) => x == guestId) == false) {
      print('uslo');
      setState(() {
        selectedGuests.add(guestId);
      });
    } else {
      setState(() {
        selectedGuests.remove(guestId);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<GuestGetDto> items = guests.items;

    return MasterWidget(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(
                  Icons.people_outline_outlined,
                ),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Text("Gosti",
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 20)),
                ),
              ],
            ),
            const Divider(
              thickness: 2,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      ActionButton(
                        icon: Icons.edit,
                        text: 'Ostavi dojam',
                        onClick: () {
                          if (selectedGuests.isEmpty) {
                            Globals.notifier.setInfo(
                                "Odaberite jednog gosta", ToastType.Info);
                            return;
                          }

                          if (selectedGuests.length > 1) {
                            return;
                          }

                          var selectedGuest = items
                              .where((x) => x.id == selectedGuests.first)
                              .first;

                          var _rating = 0.0;

                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(selectedGuest.fullName),
                                content: SizedBox(
                                  width: 300,
                                  height: 100,
                                  child: Column(
                                    children: [
                                      Input(
                                          label: 'Dojam',
                                          controller: reviewNoteController),
                                      Column(
                                        children: [
                                          RatingBar.builder(
                                              minRating: 1,
                                              maxRating: 5,
                                              itemCount: 5,
                                              initialRating: 1,
                                              itemSize: 24,
                                              itemBuilder: (context, _) => Icon(
                                                    Icons.star,
                                                    color: CustomTheme
                                                        .bluePrimaryColor,
                                                  ),
                                              onRatingUpdate: (rating) {
                                                setState(() {
                                                  _rating = rating;
                                                });
                                              }),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Odustani'),
                                  ),
                                  ElevatedButton(
                                    onPressed: () async {
                                      if (reviewNoteController.text.isEmpty) {
                                        Globals.notifier.setInfo(
                                            "Molimo unesite sva obavezna polja",
                                            ToastType.Error);
                                        return;
                                      }

                                      Navigator.of(context).pop();
                                      createGuestReview(
                                          selectedGuest.id,
                                          ReviewCreateDto(
                                              title: "test",
                                              note: reviewNoteController.text,
                                              rating: _rating));
                                    },
                                    style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      backgroundColor:
                                          CustomTheme.bluePrimaryColor,
                                    ),
                                    child: const Text('Potvrdi'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 120,
                    child: Row(
                      children: [
                        Icon(
                          Icons.filter_list_outlined,
                          color: CustomTheme.sortByColor,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Filtriraj",
                          style: CustomTheme.sortByTextStyle,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 66),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    width: 20
                  ),
                  SizedBox(
                    width: 120,
                    child: Row(
                      children: [
                        Icon(
                          Icons.sort,
                          color: CustomTheme.sortByColor,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Ime i prezime",
                          style: CustomTheme.sortByTextStyle,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 250,
                    child: Row(
                      children: [
                        Icon(
                          Icons.sort,
                          color: CustomTheme.sortByColor,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Objekat",
                          style: CustomTheme.sortByTextStyle,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 200,
                    child: Row(
                      children: [
                        Icon(
                          Icons.sort,
                          color: CustomTheme.sortByColor,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Kontakt",
                          style: CustomTheme.sortByTextStyle,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              thickness: 2,
            ),
            Expanded(
              child: items.isEmpty
                  ? const EmptyPage()
                  : ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        var item = items[index];

                        return GuestItem(
                            item: item,
                            isSelected:
                                selectedGuests.any((guest) => guest == item.id),
                            onSelected: (bool? value) =>
                                handleSelectGuest(item.id));
                      },
                    ),
            ),
            items.isEmpty
                ? const SizedBox.shrink()
                : Pagination(
                    currentPage: currentPage,
                    totalItems: guests.totalItems.toInt(),
                    itemsPerPage: pageSize,
                    onPageChanged: (newPage) {
                      setState(() {
                        currentPage = newPage;
                      });

                      guests.items = [];

                      loadGuests();
                    },
                  )
          ],
        ),
      ),
    );
  }
}
