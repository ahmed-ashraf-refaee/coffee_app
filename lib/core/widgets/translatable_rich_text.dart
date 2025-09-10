import 'package:flutter/material.dart';
import '../services/translation_service.dart';

class TranslatableRichText extends StatefulWidget {
  final List<String> texts;
  final List<TextStyle?>? styles;
  final TextAlign textAlign;
  final TextStyle? defaultStyle;

  const TranslatableRichText({
    super.key,
    required this.texts,
    this.styles,
    this.textAlign = TextAlign.start,
    this.defaultStyle,
  }) : assert(styles == null || styles.length == texts.length);

  @override
  State<TranslatableRichText> createState() => _TranslatableRichTextState();
}

class _TranslatableRichTextState extends State<TranslatableRichText> {
  final _service = TranslationService();
  List<String>? _translated;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _translateAll();
  }

  Future<void> _translateAll() async {
    final locale = Localizations.localeOf(context);
    final results = <String>[];

    for (final text in widget.texts) {
      final translated = await _service.translateText(text, locale);
      results.add(translated);
    }

    if (mounted) {
      setState(() => _translated = results);
    }
  }

  @override
  Widget build(BuildContext context) {
    final spans = <TextSpan>[];

    final effectiveTexts = _translated ?? widget.texts;

    for (int i = 0; i < effectiveTexts.length; i++) {
      spans.add(
        TextSpan(
          text: effectiveTexts[i],
          style: widget.styles != null
              ? widget.styles![i]
              : widget.defaultStyle,
        ),
      );
    }

    return RichText(
      textAlign: widget.textAlign,
      text: TextSpan(children: spans),
    );
  }
}
