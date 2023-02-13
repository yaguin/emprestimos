import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:dio/dio.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = TextEditingController();

  List institutionsList = [];
  void getInstitutions() async {
    var response = await Dio().get('http://localhost:8000/api/instituicao');
    final String jsonString = response.data;
    final List jsonDecoded = json.decode(jsonString) as List;
    setState(() {
      institutionsList = jsonDecoded;
    });
  }

  List covenantsList = [];
  void getCovenants() async {
    var response = await Dio().get('http://localhost:8000/api/convenio');
    final String jsonString = response.data;
    final List jsonDecoded = json.decode(jsonString) as List;
    setState(() {
      covenantsList = jsonDecoded;
    });
  }

  List dropdownCovenantsValue = [];
  List dropdownInstitutionsValue = [];

  String? dropdownInstallmentsValue;
  void dropDownCInstallmentsCallBack(String? selectedValue) {
    if (selectedValue is String) {
      setState(() {
        dropdownInstallmentsValue = selectedValue;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getInstitutions();
    getCovenants();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Simular Empréstimo'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextFormField(
              controller: _controller,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                CurrencyInputFormatter(),
              ],
              decoration: const InputDecoration(
                  labelText: 'Valor do empréstimo',
                  border: OutlineInputBorder()),
            ),
            MultiSelectDialogField(
              items: institutionsList.map((e) => MultiSelectItem(e['chave'], e['valor'])).toList(),
              listType: MultiSelectListType.CHIP,
              onConfirm: (values) {
                dropdownInstitutionsValue = values;
              },
            ),
            MultiSelectDialogField(
              items: covenantsList.map((e) => MultiSelectItem(e['chave'], e['valor'])).toList(),
              listType: MultiSelectListType.CHIP,
              onConfirm: (values) {
                dropdownCovenantsValue = values;
              },
            ),
            DropdownButton(
              isExpanded: true,
              value: dropdownInstallmentsValue,
              items: installments.map((item) {
                return DropdownMenuItem(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
              onChanged: dropDownCInstallmentsCallBack,
            ),
          ],
        )
    );
  }
}

class CurrencyInputFormatter extends TextInputFormatter {
  CurrencyInputFormatter({this.maxDigits = 10});

  final int maxDigits;

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }
    if (newValue.selection.baseOffset > maxDigits) {
      return oldValue;
    }

    final oldValueText = oldValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    String newValueText = newValue.text;

    // We manually remove the value we want to remove
    // If oldValueText == newValue.text it means we deleted a non digit number.
    if (oldValueText == newValue.text) {
      newValueText = newValueText.substring(0, newValue.selection.end - 1) +
          newValueText.substring(newValue.selection.end, newValueText.length);
    }

    double value = double.parse(newValueText);
    final formatter = NumberFormat.currency(locale: 'pt_Br', symbol: 'R\$');
    String newText = formatter.format(value / 100);

    return newValue.copyWith(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length));
  }
}

const List<String> installments = <String>[
  '36', '48', '60', '72', '84'
];
