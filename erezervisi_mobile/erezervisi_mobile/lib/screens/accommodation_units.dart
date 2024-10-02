import 'package:erezervisi_mobile/enums/accommodation_unit_filter.dart';
import 'package:erezervisi_mobile/models/requests/accommodation_unit/get_accommodation_units_request.dart';
import 'package:erezervisi_mobile/models/responses/accommodation_unit/accommodation_unit_get_dto.dart';
import 'package:erezervisi_mobile/models/responses/base/paged_response.dart';
import 'package:erezervisi_mobile/providers/accommodation_unit_provider.dart';
import 'package:erezervisi_mobile/widgets/home_custom/item_card.dart';
import 'package:erezervisi_mobile/widgets/master_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccommodationUnits extends StatefulWidget {
  final AccommodationUnitFilter filter;
  const AccommodationUnits({super.key, required this.filter});

  @override
  State<AccommodationUnits> createState() => _AccommodationUnitsState();
}

class _AccommodationUnitsState extends State<AccommodationUnits> {
  String title = 'Preporučeno';

  var accommodationUnits = PagedResponse<AccommodationUnitGetDto>.empty();
  var request = GetAccommodationUnitsRequest.def();

  late AccommodationUnitProvider accommodationUnitProvider;

  @override
  void initState() {
    super.initState();

    accommodationUnitProvider = context.read<AccommodationUnitProvider>();

    loadAccommodationUnits();
  }

  Future loadAccommodationUnits() async {
    dynamic response;

    switch (widget.filter) {
      case AccommodationUnitFilter.Popular:
        response = await accommodationUnitProvider.getPopularPaged(request);
        setState(() {
          title = 'Popularno';
        });
        break;
      case AccommodationUnitFilter.Latest:
        response = await accommodationUnitProvider.getLatestPaged(request);
        setState(() {
          title = 'Nove ponude';
        });
        break;
      default:
        response = await accommodationUnitProvider.getPaged(request);
    }

    response = await accommodationUnitProvider.getPaged(request);

    if (mounted) {
      setState(() {
        accommodationUnits = response;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MasterWidget(
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_ios_new),
                iconSize: 14,
                color: Colors.black,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Text(
                  title,
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: accommodationUnits.items.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ItemCard(
                    item: accommodationUnits.items[index],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
