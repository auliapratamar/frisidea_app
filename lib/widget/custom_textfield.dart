import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextFormFieldWidget extends StatefulWidget {
  final TextInputType textInputType;
  final Widget prefixIcon;
  final String defaultText;
  final FocusNode focusNode;
  final bool obscureText;
  final TextEditingController controller;
  final Function functionValidate;
  final String parametersValidate;
  final TextInputAction actionKeyboard;
  final Function onSubmitField;
  final Function onFieldTap;
  final Function(String) onGetValue;
  final bool isReadOnly;

  const TextFormFieldWidget(
      {
      this.focusNode,
        this.textInputType,
        this.defaultText,
        this.obscureText = false,
        this.controller,
        this.functionValidate,
        this.parametersValidate,
        this.actionKeyboard = TextInputAction.next,
        this.onSubmitField,
        this.onFieldTap,
        this.prefixIcon,
        this.onGetValue,
        this.isReadOnly = false
      });

  @override
  _TextFormFieldWidgetState createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {
  double bottomPaddingToError = 12;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: Colors.black,
      obscureText: widget.obscureText,
      keyboardType: widget.textInputType,
      textInputAction: widget.actionKeyboard,
      focusNode: widget.focusNode,
      style: GoogleFonts.sourceSansPro(
          color: Colors.black,
          fontWeight: FontWeight.normal,
          fontSize: 14
      ),
      readOnly: widget.isReadOnly,
      initialValue: widget.defaultText,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 1.0),
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding: EdgeInsets.all(20),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 1.0),
          borderRadius: BorderRadius.circular(8),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 1.0),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 1.0),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      controller: widget.controller,
      validator: (value) {
        if (widget.functionValidate != null) {
          String resultValidate =
          widget.functionValidate(value, widget.parametersValidate);
          if (resultValidate != null) {
            return resultValidate;
          }
        }
        return null;
      },
      onFieldSubmitted: (value) {
        if (widget.onSubmitField != null) widget.onSubmitField();
      },
      onTap: () {
        if (widget.onFieldTap != null) widget.onFieldTap();
      },
      onEditingComplete: () => widget.focusNode.nextFocus(),
      onSaved: (a) => widget.onGetValue(a),
      onChanged: (a) => widget.onGetValue(a),
    );
  }
}

String commonValidation(String value, String messageError) {
  var required = requiredValidator(value, messageError);
  if (required != null) {
    return required;
  }
  return null;
}

String requiredValidator(value, messageError) {
  if (value.isEmpty) {
    return messageError;
  }
  return null;
}

void changeFocus(
    BuildContext context, {FocusNode currentFocus, FocusNode nextFocus}) {
  currentFocus.unfocus();
  FocusScope.of(context).requestFocus(nextFocus);
}