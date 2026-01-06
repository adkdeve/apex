import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../app/core/resources/r.dart';

class AuthTextField extends StatefulWidget {
  const AuthTextField({
    Key? key,
    required this.label,
    required this.hint,
    required this.controller,
    this.obscureText = false,
    this.readOnly = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.onChanged,
    this.inputFormatters,
  }) : super(key: key);

  final String label;
  final String hint;
  final TextEditingController controller;
  final bool obscureText;
  final bool readOnly;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final List<TextInputFormatter>? inputFormatters;

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  final FocusNode _focusNode = FocusNode();
  bool _hasError = false;
  String? _errorText;
  bool _passwordVisible = false;

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
    _focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final borderColor = _hasError ? R.theme.error : R.theme.inputBorder;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).textTheme.bodyLarge?.color,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          key: const Key('auth-field-container'),
          padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(R.theme.inputBorderRadius),
            border: Border.all(color: borderColor),
            color: Colors.transparent,
          ),
          child: TextFormField(
            focusNode: _focusNode,
            readOnly: widget.readOnly,
            obscureText: widget.obscureText ? !_passwordVisible : false,
            controller: widget.controller,
            keyboardType: widget.keyboardType,
            inputFormatters: widget.inputFormatters,
            onChanged: (v) {
              widget.onChanged?.call(v);
              if (_hasError) {
                setState(() {
                  _hasError = false;
                  _errorText = null;
                });
              }
            },
            validator: (value) {
              final result = widget.validator?.call(value);
              setState(() {
                _hasError = result != null && result.isNotEmpty;
                _errorText = result;
              });
              return null; // we show errors below
            },
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
            decoration: InputDecoration(
              isDense: true,
              border: InputBorder.none,
              hintText: widget.hint,
              hintStyle: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: R.theme.inputPlaceholder,
              ),
              suffixIcon: widget.obscureText
                  ? IconButton(
                      icon: Icon(
                        _passwordVisible
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        size: 20,
                        color: R.theme.color400,
                      ),
                      onPressed: () {
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                    )
                  : null,
            ),
          ),
        ),
        if (_hasError && _errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 6, left: 6),
            child: Text(
              _errorText!,
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: R.theme.error,
                height: 1.2,
              ),
            ),
          ),
      ],
    );
  }
}
