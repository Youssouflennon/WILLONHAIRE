import 'package:flutter/material.dart';

import '../color_constants.dart';

class InputWidget extends StatelessWidget {
  final String? hintText;
  final String? errorText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final double? height;
  final String? topLabel;
  final bool? obscureText;
  final FormFieldSetter<String>? onSaved;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final Function()? onTap;
  final TextInputType? keyboardType;
  final Key? kKey;
  final TextEditingController? kController;
  final String? kInitialValue;

  InputWidget({
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.height = 48.0,
    this.topLabel = "",
    this.obscureText = false,
    required this.onSaved,
    this.onTap,
    this.keyboardType,
    this.errorText,
    this.onChanged,
    this.validator,
    this.kKey,
    this.kController,
    this.kInitialValue,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(this.topLabel!, style: TextStyle(color: Colors.black)),
        SizedBox(height: 4.0),
        Container(
          height: 50,
          decoration: BoxDecoration(
            color: textFieldColor,
            //color: Theme.of(context).buttonColor,
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: TextFormField(
            initialValue: this.kInitialValue,
            controller: this.kController,
            key: this.kKey,
            keyboardType: this.keyboardType,
            onSaved: this.onSaved,
            onChanged: this.onChanged,
            onTap: this.onTap,
            validator: this.validator,
            obscureText: this.obscureText!,
            decoration: InputDecoration(
                prefixIcon: this.prefixIcon,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  //gapPadding: 16,
                  borderSide: BorderSide(
                    color: textFieldColor,
                  ),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                /*errorStyle: TextStyle(height: 0, color: Colors.red),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).errorColor,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  gapPadding: 16,
                  borderSide: BorderSide(
                    color: Theme.of(context).errorColor,
                  ),
                ),*/
                hintText: this.hintText,
                hintStyle: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Colors.grey),
                suffixIcon: this.suffixIcon,
                errorText: this.errorText),
          ),
        )
      ],
    );
  }
}

class InputPasswordWidget extends StatelessWidget {
  final String? hintText;
  final String? errorText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final double? height;
  final String? topLabel;
  final bool? obscureText;
  final FormFieldSetter<String>? onSaved;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;
  final Key? kKey;
  final TextEditingController? kController;
  final String? kInitialValue;

  InputPasswordWidget({
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.height = 48.0,
    this.topLabel = "",
    this.obscureText = false,
    required this.onSaved,
    this.keyboardType,
    this.errorText,
    this.onChanged,
    this.validator,
    this.kKey,
    this.kController,
    this.kInitialValue,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(this.topLabel!, style: TextStyle(color: Colors.black)),
        SizedBox(height: 4.0),
        Container(
          height: 55,
          decoration: BoxDecoration(
            color: textFieldColor,
            //color: Theme.of(context).buttonColor,
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: TextFormField(
            initialValue: this.kInitialValue,
            controller: this.kController,
            key: this.kKey,
            keyboardType: this.keyboardType,
            onSaved: this.onSaved,
            onChanged: this.onChanged,
            validator: this.validator,
            obscureText: this.obscureText!,
            decoration: InputDecoration(
                prefixIcon: this.prefixIcon,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  //gapPadding: 16,
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                /*errorStyle: TextStyle(height: 0, color: Colors.red),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).errorColor,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  //gapPadding: 16,
                  borderSide: BorderSide(
                    color: Theme.of(context).errorColor,
                  ),
                ),*/
                hintText: this.hintText,
                hintStyle: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Colors.grey),
                suffixIcon: this.suffixIcon,
                errorText: this.errorText),
          ),
        )
      ],
    );
  }
}
class InputMultilineWidget extends StatelessWidget {
  final String? hintText;
  final String? errorText;
  final double? height;
  final String? topLabel;
  final bool? obscureText;
  final int? minLines;
  final int? maxLines;
  final FormFieldSetter<String>? onSaved;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;
  final Key? kKey;
  final TextEditingController? kController;
  final String? kInitialValue;

  InputMultilineWidget({
    this.hintText,
    this.height = 48.0,
    this.topLabel = "",
    this.obscureText = false,
    this.minLines,
    this.maxLines,
    required this.onSaved,
    this.keyboardType,
    this.errorText,
    this.onChanged,
    this.validator,
    this.kKey,
    this.kController,
    this.kInitialValue,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(this.topLabel!, style: TextStyle(color: Colors.black)),
            SizedBox(width: 5),
            Icon(Icons.description_outlined)
          ],
        ),
        SizedBox(height: 4.0),
        Container(
          height: 100,
          decoration: BoxDecoration(
            color: textFieldColor,
            //color: Theme.of(context).buttonColor,
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: TextFormField(
            initialValue: this.kInitialValue,
            controller: this.kController,
            key: this.kKey,
            keyboardType: this.keyboardType,
            onSaved: this.onSaved,
            onChanged: this.onChanged,
            minLines: this.minLines,
            maxLines: this.maxLines,
            validator: this.validator,
            obscureText: this.obscureText!,
            decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  //gapPadding: 16,
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                /*errorStyle: TextStyle(height: 0, color: Colors.red),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).errorColor,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  //gapPadding: 16,
                  borderSide: BorderSide(
                    color: Theme.of(context).errorColor,
                  ),
                ),*/
                hintText: this.hintText,
                hintStyle: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Colors.grey),
                errorText: this.errorText),
          ),
        )
      ],
    );
  }
}