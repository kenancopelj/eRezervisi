import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:erezervisi_desktop/models/dropdown_item.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Dropdown extends StatefulWidget {
  final num? value;
  final String placeholder;
  final String? label;
  final List<DropdownItem> items;
  final TextEditingController controller;
  String? hintText;
  final void Function(dynamic)? onChanged;
  Dropdown(
      {super.key,
      required this.value,
      required this.placeholder,
      required this.items,
      required this.controller,
      required this.onChanged,
      this.label,
      this.hintText});

  @override
  State<Dropdown> createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50.0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.label ?? "",
                  style: const TextStyle(fontSize: 10, color: Colors.black),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 10),
          child: DropdownButtonFormField2<dynamic>(
            isExpanded: true,
            hint: Text(
              widget.placeholder,
              style: TextStyle(
                fontSize: 11,
                color: Theme.of(context).hintColor,
              ),
            ),
            items: widget.items
                .map((item) => DropdownMenuItem(
                      value: item,
                      child: Text(
                        item.value,
                        style: const TextStyle(
                          fontSize: 11,
                        ),
                      ),
                    ))
                .toList(),
            value: widget.value,
            onChanged: widget.onChanged,
            dropdownStyleData: const DropdownStyleData(
              maxHeight: 300,
            ),
            menuItemStyleData: const MenuItemStyleData(
              height: 40,
            ),
            dropdownSearchData: DropdownSearchData(
              searchController: widget.controller,
              searchInnerWidgetHeight: 50,
              searchInnerWidget: Container(
                height: 50,
                padding: const EdgeInsets.only(
                  top: 8,
                  bottom: 4,
                  right: 8,
                  left: 8,
                ),
                child: TextFormField(
                  expands: true,
                  maxLines: null,
                  controller: widget.controller,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 8,
                    ),
                    hintText: widget.hintText,
                    hintStyle: const TextStyle(fontSize: 11),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              searchMatchFn: (item, searchValue) {
                return item.value.toString().contains(searchValue);
              },
            ),
            onMenuStateChange: (isOpen) {
              if (!isOpen) {
                widget.controller.clear();
              }
            },
          ),
        ),
      ],
    );
  }
}
