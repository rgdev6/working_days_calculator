import "package:flutter/material.dart";

enum DateToUpdate { initial, ending }

class DateToUpdateSegmentedButton extends StatefulWidget {
  const DateToUpdateSegmentedButton({super.key, this.datesView = DateToUpdate.ending, this.onSelectionChanged});

  final DateToUpdate datesView;
  final void Function(Set<DateToUpdate>)? onSelectionChanged;

  @override
  State<DateToUpdateSegmentedButton> createState() => _DateToUpdateSegmentedButtonState();
}

class _DateToUpdateSegmentedButtonState extends State<DateToUpdateSegmentedButton> {
  DateToUpdate? datesView;
  @override
  Widget build(BuildContext context) {
    return SegmentedButton<DateToUpdate>(
      segments: const <ButtonSegment<DateToUpdate>>[
        ButtonSegment<DateToUpdate>(
            value: DateToUpdate.initial,
            label: Text("Data Inicial"),
            icon: Icon(Icons.date_range)),
        ButtonSegment<DateToUpdate>(
            value: DateToUpdate.ending,
            label: Text("Data Final"),
            icon: Icon(Icons.date_range)),
      ],
      selected: <DateToUpdate>{datesView ?? widget.datesView},
      onSelectionChanged: (Set<DateToUpdate> newSelection) {
        setState(() {
          datesView = newSelection.first;
          if (widget.onSelectionChanged != null) {
            widget.onSelectionChanged!(newSelection);
          }
        });
      },
    );
  }
}
