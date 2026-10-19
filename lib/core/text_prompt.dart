import 'package:flutter/material.dart';
import 'package:gramnota/l10n/l10n.dart';

/// Asks for one line of text. The field's controller lives on the dialog
/// state, so closing the route cannot use a controller that was already
/// disposed.
Future<String?> promptForText(
  BuildContext context, {
  required String title,
  required String label,
  String initialText = '',
  String? confirmLabel,
  TextInputType? keyboardType,
}) {
  final resolvedConfirm = confirmLabel ?? context.l10n.actionSave;
  return showDialog<String>(
    context: context,
    builder: (context) => _TextPromptDialog(
      title: title,
      label: label,
      initialText: initialText,
      confirmLabel: resolvedConfirm,
      keyboardType: keyboardType,
    ),
  );
}

class _TextPromptDialog extends StatefulWidget {
  const _TextPromptDialog({
    required this.title,
    required this.label,
    required this.initialText,
    required this.confirmLabel,
    required this.keyboardType,
  });

  final String title;
  final String label;
  final String initialText;
  final String confirmLabel;
  final TextInputType? keyboardType;

  @override
  State<_TextPromptDialog> createState() => _TextPromptDialogState();
}

class _TextPromptDialogState extends State<_TextPromptDialog> {
  late final TextEditingController _text = TextEditingController(
    text: widget.initialText,
  );

  @override
  void dispose() {
    _text.dispose();
    super.dispose();
  }

  void _save() {
    final value = _text.text.trim();
    Navigator.pop(context, value.isEmpty ? null : value);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: TextField(
        controller: _text,
        decoration: InputDecoration(labelText: widget.label),
        keyboardType: widget.keyboardType,
        autofocus: true,
        onSubmitted: (_) => _save(),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(context.l10n.actionCancel),
        ),
        FilledButton(onPressed: _save, child: Text(widget.confirmLabel)),
      ],
    );
  }
}
