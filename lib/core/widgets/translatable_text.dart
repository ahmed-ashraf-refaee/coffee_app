import 'package:flutter/material.dart';
import '../services/translation_service.dart';

class TranslatableText extends StatefulWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  const TranslatableText(
    this.text, {
    super.key,
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
  });

  @override
  State<TranslatableText> createState() => _TranslatableTextState();
}

class _TranslatableTextState extends State<TranslatableText> {
  final _service = TranslationService();
  String? _translated;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _translate();
  }

  Future<void> _translate() async {
    final translated = await _service.translateText(widget.text);
    if (mounted) {
      setState(() => _translated = translated);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _translated ?? widget.text, // fallback to original while loading
      style: widget.style,
      textAlign: widget.textAlign,
      maxLines: widget.maxLines,
      overflow: widget.overflow,
    );
  }
}
