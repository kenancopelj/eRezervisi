import 'package:erezervisi_desktop/helpers/custom_theme.dart';
import 'package:erezervisi_desktop/models/requests/guest/get_guests_request.dart';
import 'package:erezervisi_desktop/models/responses/base/paged_response.dart';
import 'package:erezervisi_desktop/models/responses/guest/guest_get_dto.dart';
import 'package:erezervisi_desktop/providers/guest_provider.dart';
import 'package:erezervisi_desktop/widgets/action_button.dart';
import 'package:erezervisi_desktop/widgets/empty.dart';
import 'package:erezervisi_desktop/widgets/guests/guest_item.dart';
import 'package:erezervisi_desktop/widgets/master_widget.dart';
import 'package:erezervisi_desktop/widgets/pagination.dart';
import 'package:flutter/material.dart';
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

  List<String> headers = ['Naziv', 'Cijena'];

  List<num> selectedGuests = [];

  bool selectAll = false;

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

  void handleSelectReservation(num guestId) {
    if (selectedGuests.any((x) => x == guestId) == false) {
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
                        text: 'Uredi',
                        onClick: () {
                          print('Save button clicked!');
                        },
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      ActionButton(
                        icon: Icons.delete,
                        text: 'Ukloni',
                        onClick: () {
                          print('Save button clicked!');
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
                  SizedBox(
                    width: 20,
                    child: Checkbox(
                      value: selectAll,
                      onChanged: (value) {},
                    ),
                  ),
                  const SizedBox(
                    width: 60,
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
                          "Adresa",
                          style: CustomTheme.sortByTextStyle,
                        ),
                      ],
                    ),
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
                          "Cijena",
                          style: CustomTheme.sortByTextStyle,
                        ),
                      ],
                    ),
                  )
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
                                selectedGuests.any((unit) => unit == item.id),
                            onSelected: (bool? value) =>
                                handleSelectReservation(item.id));
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
