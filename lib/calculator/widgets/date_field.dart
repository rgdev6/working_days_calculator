import "package:flutter/material.dart";
import "package:flutter/services.dart";

import "../../utils/date_utils.dart";
import "increment_date_button.dart";

class DateField extends StatefulWidget {
  const DateField(
      {super.key,
      required this.textEditingController,
      required this.labelText,
      required this.date});

  final TextEditingController textEditingController;
  final String labelText;
  final DateTime date;

  @override
  State<DateField> createState() => _DateFieldState();
}

class _DateFieldState extends State<DateField> {
  String? errorText() {
    if (widget.textEditingController.text.length != 10) {
      return "Data Inválida";
    } else {
      try {
        parseStrict(widget.textEditingController.text);
      } catch (e) {
        return "Data Inválida";
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.textEditingController.text.isEmpty) {
      widget.textEditingController.text = format(widget.date);
    }
    return Column(
      children: [
        TextField(
          controller: widget.textEditingController,
          inputFormatters: [DateInputFormatter()],
          keyboardType: TextInputType.datetime,
          onChanged: (value) {
            //TODO adapt
            if (value.isEmpty) return;
            setState(() {});
          },
          decoration: InputDecoration(
              filled: true,
              labelText: widget.labelText,
              errorText: errorText(),
              suffixIcon: IconButton(
                padding: const EdgeInsets.only(top: 16, left: 8, right: 8),
                icon: Icon(
                  Icons.date_range,
                  color: Theme.of(context).colorScheme.primary,
                ),
                onPressed: () async {
                  var selectedDate = await selectDate(context,
                      parse(widget.textEditingController.text));
                  widget.textEditingController.text =
                      format(selectedDate);
                },
              )),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  String date = widget.textEditingController.text;
                  var incrementedDate = parse(date).subtract(const Duration(days: 1));
                  widget.textEditingController.text = format(incrementedDate);
                  setState(() {});
                },
                label: const Icon(Icons.exposure_minus_1),
                icon: const Icon(Icons.calendar_today),
              ),
              const Spacer(),
              ElevatedButton.icon(
                onPressed: () {
                  String date = widget.textEditingController.text;
                  var incrementedDate = parse(date).add(const Duration(days: 1));
                  date = format(incrementedDate);
                  setState(() {
                    widget.textEditingController.text = format(incrementedDate);
                  });
                },
                label: const Icon(Icons.plus_one),
                icon: const Icon(Icons.calendar_today),
              ),
            ],
          ),
        )
      ],
    );
  }
}

Future<DateTime> selectDate(BuildContext context, DateTime initialDate) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: initialDate,
    firstDate: DateTime(2000), // Choose the starting date for the date picker
    lastDate: DateTime(2101), // Choose the ending date for the date picker
  );
  return picked ?? initialDate;
}

class DateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return TextEditingValue(
        text: newValue.text,
        selection: TextSelection.collapsed(offset: 0),
      );

    }
    if (newValue.text.length < oldValue.text.length) {
      if (oldValue.text.endsWith("/")) {
        return TextEditingValue(
          text: newValue.text.substring(0, newValue.text.length - 1),
          selection:
              TextSelection.collapsed(offset: newValue.selection.end - 1),
        );
      }
      return TextEditingValue(
        text: newValue.text,
        selection: TextSelection.collapsed(offset: newValue.selection.end),
      );
    }

    final textLength = newValue.text.length;
    int selectionIndex = newValue.selection.end;
    final newText = StringBuffer();

    newText.write(newValue.text);

    if (textLength == 2 || textLength == 5) {
      newText.write("/");
      selectionIndex++;
    }
    return TextEditingValue(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
