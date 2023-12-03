import "package:flutter/material.dart";

import "../../utils/uf.dart";

class BrazilStatesDropdownButton extends StatefulWidget {
  const BrazilStatesDropdownButton({super.key, this.onSelectionChanged});
  final void Function(BrazilStates states)? onSelectionChanged;

  @override
  State<BrazilStatesDropdownButton> createState() =>
      _BrazilStatesDropdownButtonState();
}

class _BrazilStatesDropdownButtonState
    extends State<BrazilStatesDropdownButton> {
  var options = BrazilStates.values;

  late BrazilStates dropdownValue;

  @override
  Widget build(BuildContext context) {
    dropdownValue = BrazilStates.SP;
    return DropdownMenu<BrazilStates>(
        initialSelection: dropdownValue,
        onSelected: (BrazilStates? value) {
          setState(() {
            dropdownValue = value!;
            if (widget.onSelectionChanged != null) {
              widget.onSelectionChanged!(value);
            }
          });
        },
        dropdownMenuEntries:
        options.map<DropdownMenuEntry<BrazilStates>>((BrazilStates state) {
          return DropdownMenuEntry<BrazilStates>(
              value: state, label: state.name);
        }).toList());
  }
}