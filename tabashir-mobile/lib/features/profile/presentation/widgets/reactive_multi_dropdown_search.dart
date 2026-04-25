import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:tabashir/core/theme/app_theme.dart';

/// A reactive multi-select dropdown field with search functionality that stores values as a comma-separated string
class ReactiveMultiDropdownSearch<T> extends ReactiveFormField<String, String> {
  ReactiveMultiDropdownSearch({
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
         builder: (field) {
           final filteredItems = <T>[];

           return StatefulBuilder(
             builder: (context, setState) {
               // The currently selected values based on the control value
               List<String> getSelectedItems() {
                 if (field.value == null || field.value!.isEmpty) {
                   return [];
                 }
                 return field.value!
                     .split(',')
                     .map((e) => e.trim())
                     .where((e) => e.isNotEmpty)
                     .toList();
               }

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
                 // Clear search when opening
                 filteredItems.clear();
                 bool hasSearched = false;
                 
                 await showModalBottomSheet<void>(
                   context: context,
                   isScrollControlled: true,
                   backgroundColor: Colors.transparent,
                   builder: (context) => StatefulBuilder(
                     builder: (context, setModalState) {
                       final selectedItems = getSelectedItems();

                       return Container(
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
                               child: Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                 children: [
                                   Text(
                                     labelText ?? 'Select',
                                     style: Theme.of(context).textTheme.titleLarge
                                         ?.copyWith(
                                           fontWeight: FontWeight.bold,
                                         ),
                                   ),
                                   TextButton(
                                     onPressed: () => Navigator.pop(context),
                                     child: const Text('Done'),
                                   ),
                                 ],
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
                                   onChanged: (query) {
                                       setModalState(() {
                                       hasSearched = query.isNotEmpty;
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
                                   },
                                   autofocus: false,
                                 ),
                               ),
                             if (showSearch) SizedBox(height: AppTheme.spacingMd.h),
                             Expanded(
                               child: ListView.builder(
                                 itemCount: filteredItems.isEmpty && !hasSearched
                                     ? items.length
                                     : filteredItems.length,
                                 itemBuilder: (context, index) {
                                   final item = filteredItems.isEmpty && !hasSearched
                                       ? items[index]
                                       : filteredItems[index];
                                   final itemStr = itemAsString(item);
                                   final isSelected = selectedItems.contains(itemStr);

                                   return ListTile(
                                     title: Text(itemStr),
                                     trailing: isSelected 
                                         ? Icon(Icons.check, color: Theme.of(context).colorScheme.primary) 
                                         : null,
                                     onTap: () {
                                       if (isSelected) {
                                         selectedItems.remove(itemStr);
                                       } else {
                                         selectedItems.add(itemStr);
                                       }
                                       field.didChange(selectedItems.join(', '));
                                       setModalState(() {});
                                       setState(() {});
                                     },
                                   );
                                 },
                               ),
                             ),
                           ],
                         ),
                       );
                     },
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
                     field.value != null && field.value!.isNotEmpty
                         ? field.value!
                         : hintText ?? 'Select options',
                     style: field.value != null && field.value!.isNotEmpty
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
