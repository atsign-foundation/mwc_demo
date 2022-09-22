import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:auto_size_text/auto_size_text.dart';

// Some Form templates to reuse in New and Edit for devices, recipients and
// data selections

FormBuilderTextField deviceAtsignForm(
    BuildContext context, String initialValue) {
  return FormBuilderTextField(
      initialValue: initialValue.toString(),
      name: '@device',
      decoration: const InputDecoration(
        labelText: 'Device\'s atSign',
        // fillColor: Colors.white,
        // focusColor: Colors.lightGreenAccent,
        labelStyle: TextStyle(fontWeight: FontWeight.bold),
      ),
      validator: FormBuilderValidators.required(),
      style: const TextStyle(fontSize: 20, letterSpacing: 5));
}

class DeviceSubmitForm extends StatelessWidget {
  const DeviceSubmitForm({
    Key? key,
    required GlobalKey<FormBuilderState> formKey,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormBuilderState> _formKey;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: MaterialButton(
        child: const AutoSizeText(
          "Reset",
          style: TextStyle(color: Colors.black),
          maxLines: 1,
          maxFontSize: 30,
          minFontSize: 10,
        ),
        onPressed: () {
          _formKey.currentState!.reset();
        },
      ),
    );
  }
}
