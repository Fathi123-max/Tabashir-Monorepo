import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// A reactive dropdown field widget for selecting from a list of options
class ReactiveDropdownField<T> extends ReactiveFormField<T, T> {
  ReactiveDropdownField({
    required String super.formControlName,
    super.key,
    this.labelText,
    this.hintText,
    this.items,
    this.showSearch = false,
    this.validationMessages,
  }) : super(
         validationMessages: validationMessages,
         builder: (ReactiveFormFieldState<T, T> field) => InputDecorator(
           decoration: _buildDecoration(field, labelText, hintText),
           child: DropdownButtonHideUnderline(
             child: DropdownButton<T>(
               value: field.value,
               isExpanded: true,
               items: items,
               onChanged: field.didChange,
             ),
           ),
         ),
       );

  /// The label text for the dropdown
  final String? labelText;

  /// The hint text for the dropdown
  final String? hintText;

  /// List of dropdown items
  final List<DropdownMenuItem<T>>? items;

  /// Whether to show search functionality
  final bool showSearch;

  /// Validator messages map
  @override
  final Map<String, String Function(Object)>? validationMessages;

  static InputDecoration _buildDecoration<T>(
    ReactiveFormFieldState<T, T> field,
    String? labelText,
    String? hintText,
  ) => InputDecoration(
    labelText: labelText,
    hintText: hintText,
    border: const OutlineInputBorder(),
    errorText: field.errorText,
  );
}
