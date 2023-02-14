class SimulateModel {
  List<Institution>? bmg;
  List<Institution>? pan;
  List<Institution>? ole;

  SimulateModel({this.bmg, this.pan, this.ole});

  SimulateModel.fromJson(Map<String, dynamic> json) {
    if (json['BMG'] != null) {
      bmg = <Institution>[];
      json['BMG'].forEach((v) {
        bmg!.add(Institution.fromJson(v, 'bmg'));
      });
    }
    if (json['PAN'] != null) {
      pan = <Institution>[];
      json['PAN'].forEach((v) {
        pan!.add(Institution.fromJson(v, 'pan'));
      });
    }
    if (json['OLE'] != null) {
      ole = <Institution>[];
      json['OLE'].forEach((v) {
        ole!.add(Institution.fromJson(v, 'ole'));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (bmg != null) {
      data['BMG'] = bmg!.map((v) => v.toJson()).toList();
    }
    if (pan != null) {
      data['PAN'] = pan!.map((v) => v.toJson()).toList();
    }
    if (ole != null) {
      data['OLE'] = ole!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Institution {
  double? taxa;
  int? parcelas;
  double? valorParcela;
  String? convenio;
  String? instituicao;

  Institution({this.taxa, this.parcelas, this.valorParcela, this.convenio, this.instituicao});

  Institution.fromJson(Map<String, dynamic> json, String institution) {
    taxa = json['taxa'];
    parcelas = json['parcelas'];
    valorParcela = json['valor_parcela'];
    convenio = json['convenio'];
    instituicao = institution;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['taxa'] = this.taxa;
    data['parcelas'] = this.parcelas;
    data['valor_parcela'] = this.valorParcela;
    data['convenio'] = this.convenio;
    data['instituicao'] = this.instituicao;
    return data;
  }
}