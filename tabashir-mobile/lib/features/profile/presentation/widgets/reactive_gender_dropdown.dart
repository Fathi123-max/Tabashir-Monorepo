import 'package:flutter/material.dart';
import '../../../../core/constants/profile_options.dart';
import 'reactive_dropdown_search.dart';

/// A reactive dropdown specifically for gender selection with search
/// functionality
class ReactiveGenderDropdown extends StatelessWidget {
  /// Creates a gender dropdown field
  const ReactiveGenderDropdown({
    required this.formControlName,
    super.key,
    this.labelText,
    this.hintText,
    this.validationMessages,
  });

  /// The form control name
  final String formControlName;

  /// Label text for the dropdown
  final String? labelText;

  /// Hint text for the dropdown
  final String? hintText;

  /// Validation messages
  final Map<String, String Function(Object)>? validationMessages;

  @override
  Widget build(BuildContext context) => ReactiveDropdownSearch<String>(
    formControlName: formControlName,
    items: genderOptions,
    showSearch: false,
    itemAsString: (item) => item,
    labelText: labelText ?? 'Gender',
    hintText: hintText ?? 'Select gender',
    validationMessages: validationMessages,
  );
}
