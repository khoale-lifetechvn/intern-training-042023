import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:travel_social_app/ui/resources/color_manager.dart';

class LFFormPickerDate extends FormField<DateTime> {
  final String? labelText;
  final DateTime? initialDate;
  final String hintText;

  LFFormPickerDate({
    Key? key,
    this.labelText,
    this.initialDate,
    this.hintText = 'Enter your date',
    FormFieldSetter<DateTime>? onSaved,
    FormFieldValidator<DateTime>? validator,
  }) : super(
          key: key,
          onSaved: onSaved,
          validator: validator ??
              (v) {
                if (v == null) {
                  return 'Không được để trống';
                }
                return null;
              },
          initialValue: initialDate,
          builder: (FormFieldState<DateTime> state) {
            return InkWell(
              onTap: () async {
                final DateTime? pickedDate = await showDatePicker(
                  context: state.context,
                  initialDate: initialDate ?? DateTime.now(),
                  firstDate: DateTime(1900, 1),
                  lastDate: DateTime.now(),
                );

                if (pickedDate != null) {
                  state.didChange(pickedDate);
                }
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.date_range),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                              color: ColorManager.greyTF,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: ColorManager.greyForm)),
                          child: state.value == null
                              ? Text(
                                  hintText,
                                  style: const TextStyle(color: Colors.grey),
                                )
                              : Text(
                                  state.value!.toStr(),
                                  style: const TextStyle(color: Colors.black),
                                ),
                        ),
                      ),
                    ],
                  ),
                  if (state.hasError) ...[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        Text(
                          state.errorText ?? 'No empty',
                          style:
                              const TextStyle(color: Colors.red, fontSize: 12),
                        )
                      ],
                    )
                  ]
                ],
              ),
            );
          },
        );
}

extension DateTimeFormat on DateTime {
  String toStr() {
    return DateFormat('dd-MM-yyyy').format(this);
  }
}
