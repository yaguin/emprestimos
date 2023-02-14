import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:dio/dio.dart';
import 'package:emprestimos/models/simulate_model.dart';

class SimulateService {
  var data = [];
  List<SimulateModel> results = [];
  String url = "http://localhost:8000/api";


  Future<List<SimulateModel>> simulate(String value, institutions, covenants, installment) async {
try {
  var response = await Dio().post('${url}/simular', data: {
    "valor_emprestimo": value,
    "instituicoes": institutions,
    "convenios": covenants,
    "parcela": installment
  });
  print(response);
  if (response.statusCode == 200) {
    final String jsonString = "[${response.data}]";
    final List jsonDecoded = json.decode(jsonString) as List;
    results = jsonDecoded.map((e) => SimulateModel.fromJson(e)).toList();
  }
} catch (e) {
  print(e);
}


    return results;
  }

}