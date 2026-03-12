import 'package:flutter/material.dart';

/// Custom text field widget
class CustomTextField extends StatelessWidget {
  const CustomTextField({
    required this.label,
    super.key,
    this.hint,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.keyboardType,
    this.obscureText = false,
    this.readOnly = false,
    this.initialValue,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixIconPressed,
    this.maxLines = 1,
    this.minLines,
    this.expands = false,
    this.enabled,
    this.errorText,
  });
  final String label;
  final String? hint;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final TextInputType? keyboardType;
  final bool obscureText;
  final bool readOnly;
  final String? initialValue;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixIconPressed;
  final int? maxLines;
  final int? minLines;
  final bool expands;
  final bool? enabled;
  final String? Function(String?)? errorText;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      if (label.isNotEmpty)
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(label, style: Theme.of(context).textTheme.titleSmall),
        ),
      TextFormField(
        initialValue: initialValue,
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
          suffixIcon: suffixIcon != null
              ? IconButton(
                  icon: Icon(suffixIcon),
                  onPressed: onSuffixIconPressed,
                )
              : null,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 16,
          ),
        ),
        validator: validator,
        onChanged: onChanged,
        onFieldSubmitted: onSubmitted,
        keyboardType: keyboardType,
        obscureText: obscureText,
        readOnly: readOnly,
        maxLines: maxLines,
        minLines: minLines,
        expands: expands,
        enabled: enabled,
      ),
    ],
  );
}

/// Reactive form text field widget
class ReactiveTextField extends StatelessWidget {
  const ReactiveTextField({
    required this.formControlName,
    required this.label,
    super.key,
    this.hint,
    this.keyboardType,
    this.obscureText = false,
    this.readOnly = false,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixIconPressed,
    this.maxLines = 1,
    this.minLines,
    this.expands = false,
    this.enabled,
    this.decoration,
  });
  final String formControlName;
  final String label;
  final String? hint;
  final TextInputType? keyboardType;
  final bool obscureText;
  final bool readOnly;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixIconPressed;
  final int? maxLines;
  final int? minLines;
  final bool expands;
  final bool? enabled;
  final InputDecoration? decoration;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      if (label.isNotEmpty)
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(label, style: Theme.of(context).textTheme.titleSmall),
        ),
      ReactiveTextField(
        formControlName: formControlName,
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
          suffixIcon: suffixIcon != null
              ? IconButton(
                  icon: Icon(suffixIcon),
                  onPressed: onSuffixIconPressed,
                )
              : null,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 16,
          ),
        ),
        keyboardType: keyboardType,
        obscureText: obscureText,
        readOnly: readOnly,
        maxLines: maxLines,
        minLines: minLines,
        expands: expands,
        enabled: enabled,
        label: label,
      ),
    ],
  );
}

/// Password field widget
class PasswordField extends StatefulWidget {
  const PasswordField({
    required this.label,
    super.key,
    this.hint,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.initialValue,
  });
  final String label;
  final String? hint;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final String? initialValue;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) => CustomTextField(
    label: widget.label,
    hint: widget.hint,
    validator: widget.validator,
    onChanged: widget.onChanged,
    onSubmitted: widget.onSubmitted,
    initialValue: widget.initialValue,
    obscureText: _obscureText,
    suffixIcon: _obscureText
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined,
    onSuffixIconPressed: () {
      setState(() {
        _obscureText = !_obscureText;
      });
    },
    keyboardType: TextInputType.visiblePassword,
  );
}
