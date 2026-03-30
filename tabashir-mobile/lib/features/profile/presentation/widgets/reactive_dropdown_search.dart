import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:tabashir/core/theme/app_theme.dart';

/// A reactive dropdown field with search functionality
class ReactiveDropdownSearch<T> extends ReactiveFormField<T, T> {
  ReactiveDropdownSearch({
    required String super.formControlName,
    required this.items,
    required this.itemAsString,
    super.key,
    this.filterFn,
    this.labelText,
    this.hintText,
    this.validationMessages,
    this.showSearch = true,
    this.decoration,
  }) : super(
         validationMessages: validationMessages,
         builder: (ReactiveFormFieldState<T, T> field) {
           final filteredItems = <T>[];

           return StatefulBuilder(
             builder: (context, setState) {
               void updateSearch(String query) {
                 setState(() {
                   filteredItems
                     ..clear()
                     ..addAll(
                       items.where((item) {
                         final matches =
                             filterFn?.call(item, query) ??
                             itemAsString(
                               item,
                             ).toLowerCase().contains(query.toLowerCase());
                         return matches;
                       }).toList(),
                     );
                 });
               }

               Future<void> showDropdown() async {
                 await showModalBottomSheet<T>(
                   context: context,
                   isScrollControlled: true,
                   backgroundColor: Colors.transparent,
                   builder: (context) => Container(
                     height: MediaQuery.of(context).size.height * 0.75,
                     decoration: BoxDecoration(
                       color: Theme.of(context).scaffoldBackgroundColor,
                       borderRadius: BorderRadius.vertical(
                         top: Radius.circular(20.r),
                       ),
                     ),
                     child: Column(
                       children: [
                         Container(
                           padding: EdgeInsets.all(AppTheme.spacingMd.w),
                           child: Text(
                             labelText ?? 'Select',
                             style: Theme.of(context).textTheme.titleLarge
                                 ?.copyWith(
                                   fontWeight: FontWeight.bold,
                                 ),
                           ),
                         ),
                         if (showSearch)
                           Padding(
                             padding: EdgeInsets.symmetric(
                               horizontal: AppTheme.spacingMd.w,
                             ),
                             child: TextField(
                               decoration: const InputDecoration(
                                 labelText: 'Search',
                                 prefixIcon: Icon(Icons.search),
                                 border: OutlineInputBorder(),
                               ),
                               onChanged: updateSearch,
                               autofocus: true,
                             ),
                           ),
                         if (showSearch) SizedBox(height: AppTheme.spacingMd.h),
                         Expanded(
                           child: ListView.builder(
                             itemCount: filteredItems.isEmpty
                                 ? items.length
                                 : filteredItems.length,
                             itemBuilder: (context, index) {
                               final item = filteredItems.isEmpty
                                   ? items[index]
                                   : filteredItems[index];

                               return ListTile(
                                 title: Text(itemAsString(item)),
                                 onTap: () {
                                   field.didChange(item);
                                   Navigator.pop(context, item);
                                 },
                               );
                             },
                           ),
                         ),
                       ],
                     ),
                   ),
                 );
               }

               return InkWell(
                 onTap: showDropdown,
                 child: InputDecorator(
                   decoration: (decoration ?? const InputDecoration()).copyWith(
                     labelText: labelText,
                     hintText: hintText,
                     errorText: field.errorText,
                     suffixIcon: const Icon(Icons.arrow_drop_down),
                   ),
                   child: Text(
                     field.value != null
                         ? itemAsString(field.value as T)
                         : hintText ?? 'Select an option',
                     style: field.value != null
                         ? Theme.of(context).textTheme.titleMedium
                         : Theme.of(context).textTheme.titleMedium?.copyWith(
                             color: Theme.of(
                               context,
                             ).colorScheme.onSurface.withValues(alpha: 0.6),
                           ),
                   ),
                 ),
               );
             },
           );
         },
       );

  /// Dropdown button decoration
  final InputDecoration? decoration;

  /// List of all available items
  final List<T> items;

  /// Display function for items
  final String Function(T) itemAsString;

  /// Filter function for search
  final bool Function(T, String)? filterFn;

  /// Dropdown button decoration
  final String? labelText;

  /// Hint text
  final String? hintText;

  /// Validator messages
  @override
  final Map<String, String Function(Object)>? validationMessages;

  /// Whether to show search functionality
  final bool showSearch;
}
