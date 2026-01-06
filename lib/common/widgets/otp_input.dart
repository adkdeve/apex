import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../app/core/resources/r.dart';

class OTPInput extends StatefulWidget {
  const OTPInput({
    Key? key,
    required this.length,
    required this.onCompleted,
    this.boxSize = 56,
    this.space = 12,
  }) : super(key: key);

  final int length;
  final double boxSize;
  final double space;
  final ValueChanged<String> onCompleted;

  @override
  State<OTPInput> createState() => _OTPInputState();
}

class _OTPInputState extends State<OTPInput> {
  late List<TextEditingController> _controllers;
  late List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(widget.length, (_) => TextEditingController());
    _focusNodes = List.generate(widget.length, (_) => FocusNode());
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  void _onChanged(String value, int index) {
    if (value.isNotEmpty) {
      _controllers[index].text = value.characters.last;
      if (index + 1 < widget.length) {
        _focusNodes[index + 1].requestFocus();
      } else {
        // completed
        final code = _controllers.map((c) => c.text).join();
        widget.onCompleted(code);
      }
    } else {
      if (index - 1 >= 0) {
        _focusNodes[index - 1].requestFocus();
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget.length, (index) {
        return Padding(
          padding: EdgeInsets.only(
            right: index == widget.length - 1 ? 0 : widget.space,
          ),
          child: SizedBox(
            width: widget.boxSize,
            height: widget.boxSize,
            child: TextField(
              key: Key('otp-field-$index'),
              controller: _controllers[index],
              focusNode: _focusNodes[index],
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
              keyboardType: TextInputType.number,
              maxLength: 1,
              decoration: InputDecoration(
                counterText: '',
                filled: true,
                fillColor: Colors.transparent,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: R.theme.inputBorder),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: R.theme.primary),
                ),
              ),
              onChanged: (v) => _onChanged(v, index),
            ),
          ),
        );
      }),
    );
  }
}
