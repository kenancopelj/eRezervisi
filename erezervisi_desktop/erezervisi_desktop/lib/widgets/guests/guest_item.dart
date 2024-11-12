import 'package:erezervisi_desktop/models/responses/guest/guest_get_dto.dart';
import 'package:erezervisi_desktop/providers/guest_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GuestItem extends StatefulWidget {
  final GuestGetDto item;
  final bool isSelected;
  final ValueChanged<bool?> onSelected;
  const GuestItem(
      {super.key,
      required this.item,
      required this.isSelected,
      required this.onSelected});

  @override
  State<GuestItem> createState() => _GuestItemState();
}

class _GuestItemState extends State<GuestItem> {
  late GuestProvider guestProvider;

  @override
  void initState() {
    super.initState();

    guestProvider = context.read<GuestProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        height: 80,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 20,
                child: Checkbox(
                  value: widget.isSelected,
                  onChanged: widget.onSelected,
                ),
              ),
              SizedBox(width: 120, child: Text(widget.item.fullName)),
              SizedBox(
                  width: 250, child: Text(widget.item.accommodationUnitTitle!)),
              SizedBox(
                  width: 200,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(widget.item.phone),
                      Text(widget.item.email),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
