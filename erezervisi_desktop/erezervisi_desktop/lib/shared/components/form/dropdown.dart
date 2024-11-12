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
  Icon? labelIcon;
  final String? Function(num?)? validator;
  bool? withSearch;
  double? padding;
  bool? outline;

  Dropdown(
      {super.key,
      required this.value,
      required this.placeholder,
      required this.items,
      required this.controller,
      required this.onChanged,
      this.label,
      this.hintText,
      this.labelIcon,
      this.validator,
      this.withSearch = true,
      this.padding,
      this.outline = false});

  @override
  State<Dropdown> createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: widget.padding ?? 50.0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    widget.labelIcon ?? SizedBox.shrink(),
                    widget.labelIcon != null
                        ? const SizedBox(width: 10)
                        : const SizedBox.shrink(),
                    Text(
                      widget.label ?? "",
                      style: const TextStyle(fontSize: 10, color: Colors.black),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: widget.padding ?? 50.0, vertical: 10),
          child: DropdownButtonFormField2<num>(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: widget.validator,
            decoration: widget.outline != null && widget.outline! ? const InputDecoration(
              border: OutlineInputBorder() 
            ) : null,
            isExpanded: true,
            hint: Text(
              widget.placeholder,
              style: TextStyle(
                fontSize: 11,
                color: Theme.of(context).hintColor,
              ),
            ),
            items: widget.items
                .map((item) => DropdownMenuItem<num>(
                      value: item.key, // Set value to item.key
                      child: Text(
                        item.value,
                        style: const TextStyle(
                          fontSize: 11,
                        ),
                      ),
                    ))
                .toList(),
            value: widget.value, // categoryId should match a key from the items
            onChanged: (value) {
              widget.onChanged
                  ?.call(value); // Call onChanged with the new value
            },
            dropdownStyleData: const DropdownStyleData(
              maxHeight: 300,
            ),
            menuItemStyleData: const MenuItemStyleData(
              height: 40,
            ),
            dropdownSearchData: DropdownSearchData(
              searchMatchFn: (item, searchValue) {
                // Cast the item to DropdownMenuItem<num> to access its child (which contains the text).
                final dropdownMenuItem = item;
                // Find the corresponding DropdownItem by matching the key.
                final dropdownItem = widget.items.firstWhere(
                  (element) => element.key == dropdownMenuItem.value,
                  orElse: () => DropdownItem(key: 0, value: ""),
                );
                return dropdownItem.value
                    .toLowerCase()
                    .contains(searchValue.toLowerCase());
              },
              searchController: widget.controller,
              searchInnerWidgetHeight: 50,
              searchInnerWidget:
                  widget.withSearch != null && !widget.withSearch!
                      ? SizedBox.shrink()
                      : Container(
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
                            style: const TextStyle(fontSize: 11),
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
            ),
          ),
        ),
      ],
    );
  }
}
