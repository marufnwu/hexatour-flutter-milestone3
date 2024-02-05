
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:hexatour/core/theme/colors.dart';

class AutoCompleteField extends StatelessWidget {
  final List? suggestions;
  final String? hint;
  final String? title;
  final String? icon;
  final double? height;
  final TextEditingController? selectedSuggestion;
  final ValueChanged<String>? onChanged;
  final FutureOr<Iterable<Object?>> Function(String)? suggestionsCallback;
  final Function(dynamic)? onSuggestionSelected;
  final bool? isRequired;
  final bool? isMultiple;

  const AutoCompleteField(
      {Key? key,
      this.suggestions,
      this.selectedSuggestion,
      this.onChanged,
      this.hint,
      this.icon,
      this.height,
      this.suggestionsCallback,
      this.onSuggestionSelected,
      this.isRequired,
      this.isMultiple,
      this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    //
    return TypeAheadFormField(
      itemBuilder: (context, item) => ListTile(
      
          title: Text(
        item.toString(),
        maxLines: 1,
        style: textTheme.bodyLarge!.copyWith(color: Color.fromARGB(255, 90, 89, 89),
        ),
      ),
      ),
      suggestionsCallback: suggestionsCallback ??
          (pattern) async {
            return suggestions!
                .where((suggestion) => suggestion
                    .toString()
                    .toLowerCase()
                    .contains(pattern.toLowerCase()))
                .toList();
          },
      onSuggestionSelected: onSuggestionSelected ??
          (value) {
            selectedSuggestion!.text = value.toString();
            onChanged!(value.toString());
          },
      suggestionsBoxDecoration: SuggestionsBoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: Color.fromARGB(255, 255, 255, 255),
      ),
      debounceDuration: Duration(milliseconds: 5),
      getImmediateSuggestions: true,
      hideSuggestionsOnKeyboardHide: true,
      hideOnEmpty: false,
      keepSuggestionsOnSuggestionSelected: true,
      noItemsFoundBuilder: (context) => Padding(
        padding: const EdgeInsets.all(7.0),
        
        child: Text(
          'No Item Found',
          style: textTheme.headlineMedium!.copyWith(color: ColorConst.blackColor),
        ),
      ),
      textFieldConfiguration: TextFieldConfiguration(
        scrollPadding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        style: textTheme.headlineMedium!.copyWith(color: ColorConst.blackColor),
        decoration: InputDecoration(
          hintText: hint,
          filled: true,
          fillColor: Color.fromARGB(255, 255, 250, 250),
          // label: Text(hint),
          prefixIcon: Icon(Icons.search,
          color: ColorConst.blackColor,),
          border: InputBorder.none,
          //    enabledBorder: UnderlineInputBorder(
          //   borderSide: BorderSide(color: Colors.white),
          //   borderRadius: BorderRadius.circular(10),
          // ),
          hintStyle:
              textTheme.headlineMedium?.copyWith(color: ColorConst.blackColor),
          labelStyle:
              textTheme.headlineMedium!.copyWith(color: ColorConst.blackColor),
         
        ),
        controller: selectedSuggestion,
        cursorColor: ColorConst.blackColor,
      ),
    );
  }
}
