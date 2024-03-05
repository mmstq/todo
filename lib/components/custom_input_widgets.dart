import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

class DropDown extends StatefulWidget {
  final bool enabled;
  final Color fillColor;
  final dynamic items;
  final String? label;
  final FormFieldValidator<String>? validator;
  final String? errorText;

  final double maxMenuHeight;
  final double height;
  final String? initialValue;
  final GestureTapCallback? onTap;
  final void Function(String?) onChanged;
  final Widget? prefixIcon;

  const DropDown(
      {super.key,
      this.enabled = true,
      this.fillColor = Colors.white,
      this.label,
      required this.items,
      this.height = 64,
      this.maxMenuHeight = 300,
      this.errorText,
      required this.initialValue,
      this.onTap,
      required this.onChanged,
      this.prefixIcon,
      this.validator});

  @override
  State<DropDown> createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  bool showError = false;
  String? validatorString;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            alignment: Alignment.center,
            height: widget.height,
            margin: EdgeInsets.only(bottom: validatorString == null ? 16 : 0),
            padding: EdgeInsets.fromLTRB(
                widget.prefixIcon == null ? 16 : 12, 0, 12, 0),
            decoration: BoxDecoration(
              color: widget.fillColor,
              border: Border.all(
                  color: widget.errorText != null || showError
                      ? Colors.red
                      : Colors.grey.shade200,
                  width: 1.5),
              borderRadius: const BorderRadius.all(
                Radius.circular(18),
              ),
            ),
            child: DropdownButtonFormField<String>(
                borderRadius: BorderRadius.circular(16),
                value: widget.initialValue,
                menuMaxHeight: widget.maxMenuHeight,
                validator: validatorLocal,
                itemHeight: null,
                decoration: InputDecoration(
                  constraints: BoxConstraints(maxHeight: widget.height),
                  prefixIcon: widget.prefixIcon != null
                      ? Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: widget.prefixIcon,
                        )
                      : null,
                  prefixIconConstraints: const BoxConstraints(maxWidth: 28),
                  suffixIconConstraints: const BoxConstraints(maxWidth: 28),
                  errorText: '',
                  errorStyle: const TextStyle(fontSize: 0),
                  floatingLabelStyle:
                       TextStyle(color: Colors.grey.shade400, height: 1.6),
                  counterText: '',
                  suffixIcon: const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: Colors.lightGreen,
                  ),
                  fillColor: widget.fillColor,
                  labelText: widget.label,
                  labelStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      height: 1.5,
                      color: widget.errorText != null || showError
                          ? Colors.red
                          : Colors.grey.shade200),
                  contentPadding: const EdgeInsets.only(top: 4),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
                ),
                iconSize: 0,
                onChanged: widget.onChanged,
                items: widget.items is Map
                    ? (widget.items as Map<String, String>)
                        .entries
                        .map((entry) => DropdownMenuItem<String>(
                              value: entry.key,
                              child: SizedBox(
                                  width: Get.size.width * 0.5,
                                  child: Text(
                                    entry.value,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  )),
                            ))
                        .toList()
                    : widget.items is List<String>
                        ? (widget.items as List<String>)
                            .map((entry) => DropdownMenuItem<String>(
                                  value: entry,
                                  child: SizedBox(
                                    width: Get.width * 0.5,
                                    child: Text(
                                      entry,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ))
                            .toList()
                        : widget.items as List<DropdownMenuItem<String>>)),
        if (widget.errorText != null || showError)
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 4, 8, 12),
            child: Text(
              validatorString ?? '',
              style: const TextStyle(
                  color: Colors.red,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  height: 1.5),
            ),
          )
      ],
    );
  }

  String? validatorLocal(String? value) {
    validatorString = widget.validator?.call(value);
    if (validatorString != null) {
      // If the external validator returns an error message, update the state to show error.
      setState(() {
        showError = true;
      });
      return '';
    } else {
      // If the external validator passes, ensure error state is cleared.
      setState(() {
        showError = false;
      });
    }
    // Call the external validator function if it's provided.
    // This allows the external validation logic to run and possibly override local validation.

    return null;
  }
}

class DatePicker extends StatefulWidget {
  final bool enabled;
  final Color fillColor;
  final bool hasLabel;

  final DateTime? initialDate;
  final DateTime? currentDate;
  final DateTime? lastDate;

  final double height;
  final String label;
  final FormFieldValidator<String>? validator;
  final String? errorText;
  final String? initialValue;
  final GestureTapCallback? onTap;
  final VoidCallback? onClear;
  final Function(String val)? onChanged;
  final Widget? prefix;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  const DatePicker(
      {super.key,
      this.enabled = true,
      this.fillColor = Colors.white,
      this.hasLabel = true,
      this.label = 'Date',
      this.errorText,
      this.height = 64,
      this.initialValue,
      this.onTap,
      this.onClear,
      this.onChanged,
      this.prefix,
      this.prefixIcon,
      this.suffixIcon,
      this.validator,
      this.initialDate,
      this.currentDate,
      this.lastDate});

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  bool showError = false;
  String? validatorString;
  late final TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController(text: widget.initialValue);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.center,
          height: widget.height,
          margin: EdgeInsets.only(bottom: validatorString == null ? 16 : 0),
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          decoration: BoxDecoration(
            color: widget.fillColor,
            border: Border.all(
                color: widget.errorText != null || showError
                    ? Colors.red
                    : Colors.grey.shade200,
                width: 1.5),
            borderRadius: const BorderRadius.all(
              Radius.circular(18),
            ),
          ),
          child: Theme(
            data: ThemeData(
                textSelectionTheme: const TextSelectionThemeData(
                  cursorColor: Colors.lightGreen,
                  selectionColor: Colors.lightGreen,
                  selectionHandleColor: Colors.lightGreen,
                ),
                colorScheme:
                    const ColorScheme.light(primary: Colors.lightGreen)),
            child: TextFormField(
              controller: controller,
              enableInteractiveSelection: false,
              enabled: widget.enabled,
              onTap: onTap,
              keyboardType: TextInputType.none,
              showCursor: true,
              readOnly: true,
              validator: validatorLocal,
              style:
                  TextStyle(color: Colors.grey.shade900),
              decoration: InputDecoration(
                prefix: widget.prefix,
                prefixIcon: widget.prefixIcon != null
                    ? Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: widget.prefixIcon,
                      )
                    : null,
                prefixIconConstraints: const BoxConstraints(maxWidth: 28),
                suffixIconConstraints: const BoxConstraints(maxWidth: 28),
                errorText: '',
                errorStyle: const TextStyle(fontSize: 0),
                floatingLabelStyle:  TextStyle(color: Colors.grey.shade800),
                counterText: '',
                fillColor: widget.fillColor,
                label: Text(
                  widget.label,
                ),
                labelStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    height: 1.3,
                    color: widget.errorText != null || showError
                        ? Colors.red
                        : Colors.grey.shade800),
                contentPadding: const EdgeInsets.symmetric(vertical: 4),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
              ),
            ),
          ),
        ),
        if (widget.errorText != null || showError)
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 4, 8, 12),
            child: Text(
              validatorString ?? '',
              style: const TextStyle(
                  color: Colors.red,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  height: 1.5),
            ),
          )
      ],
    );
  }

  void onTap() async {
    final date = await showDatePicker(
      context: context,
      initialDate: widget.currentDate,
      firstDate: widget.initialDate??DateTime.parse('1900-01-01'),
      lastDate: widget.lastDate??DateTime.parse('2029-12-31'),
    );
    if (date != null) {
      controller.text = DateFormat('yyyy-MM-dd').format(date);
      widget.onChanged?.call(controller.text);
    }
  }

  String? validatorLocal(String? value) {
    validatorString = widget.validator?.call(value);
    if (validatorString != null) {
      // If the external validator returns an error message, update the state to show error.
      setState(() {
        showError = true;
      });
      return '';
    } else {
      // If the external validator passes, ensure error state is cleared.
      setState(() {
        showError = false;
      });
    }

    // Call the external validator function if it's provided.
    // This allows the external validation logic to run and possibly override local validation.

    return null;
  }
}

class TextInputField extends StatefulWidget {
  final bool enableCopyPaste;
  final bool enabled;
  final Color fillColor;
  final int? maxLength;
  final TextEditingController? controller;
  final bool hasLabel;
  final String label;
  final FormFieldValidator<String>? validator;
  final String? errorText;
  final String? initialValue;
  final FocusNode? focusNode;
  final TextCapitalization textCapitalization;
  final GestureTapCallback? onTap;
  final VoidCallback? onClear;
  final Function(String val)? onChanged;
  final VoidCallback? onEditingComplete;
  final Widget? prefix;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final double? height;
  final TextInputType keyboardType;
  final TextInputAction? textInputAction;
  final int? maxLines;

  const TextInputField(
      {super.key,
      this.enableCopyPaste = true,
      this.enabled = true,
      this.fillColor = Colors.white,
      this.maxLength,
      this.controller,
      this.height,
      this.hasLabel = true,
      this.label = 'Label',
      this.errorText,
      this.initialValue,
      this.focusNode,
      this.onTap,
      this.onClear,
      this.onChanged,
      this.onEditingComplete,
      this.prefix,
      this.prefixIcon,
      this.suffixIcon,
      this.maxLines = 1,
      this.keyboardType = TextInputType.text,
      this.textInputAction = TextInputAction.next,
      this.textCapitalization = TextCapitalization.words,
      this.validator});

  @override
  State<TextInputField> createState() => _TextInputState();
}

class _TextInputState extends State<TextInputField> {
  bool showError = false;
  String? validatorString;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.center,
          height: widget.height,
          constraints: BoxConstraints(minHeight: widget.height ?? 64),
          margin: EdgeInsets.only(bottom: validatorString == null ? 16 : 0),
          padding: const EdgeInsets.fromLTRB(16, 0, 12, 0),
          decoration: BoxDecoration(
            color: widget.fillColor,
            border: Border.all(
                color: widget.errorText != null || showError
                    ? Colors.red
                    : Colors.grey.shade200,
                width: 1.5),
            borderRadius: const BorderRadius.all(
              Radius.circular(18),
            ),
          ),
          child: Theme(
            data: ThemeData(
                textSelectionTheme: const TextSelectionThemeData(
                  cursorColor: Colors.lightGreen,
                  selectionColor: Colors.lightGreen,
                  selectionHandleColor: Colors.lightGreen,
                ),
                colorScheme:
                    const ColorScheme.light(primary: Colors.lightGreen)),
            child: TextFormField(
              onChanged: widget.onChanged,
              enableInteractiveSelection: widget.enableCopyPaste,
              enabled: widget.enabled,
              initialValue: widget.initialValue,
              onTap: widget.onTap,
              maxLength: widget.maxLength,
              validator: validatorLocal,
              onEditingComplete: widget.onEditingComplete,
              textCapitalization: widget.textCapitalization,
              textInputAction: widget.textInputAction,
              focusNode: widget.focusNode,
              controller: widget.controller,
              maxLines: widget.maxLines,
              keyboardType: widget.keyboardType,
              style:
                  TextStyle(color: Colors.grey.shade800),
              decoration: InputDecoration(
                prefix: widget.prefix,
                prefixIcon: widget.prefixIcon,
                suffixIcon: widget.suffixIcon,
                errorText: '',
                errorStyle: const TextStyle(fontSize: 0),
                floatingLabelStyle: TextStyle(color:  Colors.grey.shade600),
                counterText: '',
                fillColor: widget.fillColor,
                label: Text(
                  widget.label,
                ),
                labelStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    height: 1.3,
                    color: widget.errorText != null || showError
                        ? Colors.red
                        : Colors.grey.shade800),
                contentPadding: const EdgeInsets.symmetric(vertical: 4),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
              ),
            ),
          ),
        ),
        if (widget.errorText != null || showError)
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 4, 8, 12),
            child: Text(
              validatorString ?? '',
              style: const TextStyle(
                  color: Colors.red,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  height: 1.5),
            ),
          )
      ],
    );
  }

  String? validatorLocal(String? value) {
    validatorString = widget.validator?.call(value);
    if (validatorString != null) {
      // If the external validator returns an error message, update the state to show error.
      setState(() {
        showError = true;
      });
      return '';
    } else {
      // If the external validator passes, ensure error state is cleared.
      setState(() {
        showError = false;
      });
    }

    // Call the external validator function if it's provided.
    // This allows the external validation logic to run and possibly override local validation.

    return null;
  }
}
