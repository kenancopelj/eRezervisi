import 'package:erezervisi_desktop/shared/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_debouncer/flutter_debouncer.dart';

class SearchInput extends StatelessWidget {
  final dynamic Function(String value) onChanged;
  SearchInput({super.key, required this.onChanged});

  final Debouncer _debouncer = Debouncer();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      height: 40,
      child: TextField(
        style: const TextStyle(fontSize: 12),
        onChanged: (value) {
          _debouncer.debounce(
              duration: Globals.debounceTimeout,
              onDebounce: () {
                onChanged(value);
              });
        },
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.search_outlined),
          hintText: "Pretraži...",
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
