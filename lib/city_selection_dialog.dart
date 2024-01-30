import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class CitySelectionDialog extends StatefulWidget {
  final TextEditingController cityController;
  final Future<Iterable<String>> Function(String) onSuggestionCallback;
  final Function(String? city) onSuggestionSelected;
  final Function(bool) onPopInvoked;

  const CitySelectionDialog({
    super.key,
    required this.cityController,
    required this.onSuggestionCallback,
    required this.onSuggestionSelected,
    required this.onPopInvoked,
  });

  @override
  State<CitySelectionDialog> createState() => _CitySelectionDialogState();
}

class _CitySelectionDialogState extends State<CitySelectionDialog> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: widget.onPopInvoked,
      child: AlertDialog(
        title: const Text(
          "Choose Your City",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        content: SingleChildScrollView(
          child: TypeAheadFormField(
            noItemsFoundBuilder: (context) => const SizedBox(
              height: 70,
              child: Center(
                child: Text('No Item Found'),
              ),
            ),
            suggestionsBoxDecoration: const SuggestionsBoxDecoration(
                elevation: 5,
                borderRadius: BorderRadius.all(Radius.circular(20)),
                constraints: BoxConstraints(maxHeight: 300)),
            debounceDuration: const Duration(milliseconds: 400),
            textFieldConfiguration: TextFieldConfiguration(
              controller: widget.cityController,
              decoration: InputDecoration(
                labelText: "City",
                //hintText: "Select City",
                hintStyle: const TextStyle(
                    color: Color.fromARGB(135, 159, 158, 158), fontSize: 15),
                labelStyle: TextStyle(color: Colors.grey[600], fontSize: 15),
                //filled: true,
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide:
                        const BorderSide(width: 0, style: BorderStyle.solid)),
              ),
            ),
            // suggestionsCallback: (value) async {
            //   return cities;
            // },
            suggestionsCallback: widget.onSuggestionCallback,
            itemBuilder: (context, String suggestion) {
              return Row(
                children: [
                  const SizedBox(
                    width: 10,
                    height: 50,
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Text(
                        suggestion,
                        maxLines: 6,
                      ),
                    ),
                  )
                ],
              );
            },
            onSuggestionSelected: (String suggestion) {
              setState(() {
                widget.cityController.text = suggestion;
                widget.onSuggestionSelected(widget.cityController.text);
              });
            },
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 45,
                width: 100,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(15)),
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.resolveWith((states) {
                        return Colors.white;
                      }),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)))),
                  onPressed: () {
                    widget.cityController.clear();
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'OK',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
