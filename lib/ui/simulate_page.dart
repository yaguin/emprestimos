import 'package:emprestimos/models/simulate_model.dart';
import 'package:emprestimos/service/simulate_services.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SimulatePage extends StatefulWidget {
  final String value;
  List institutions;
  List covenants;
  var installment;

  SimulatePage({super.key, required this.value, required this.institutions, required this.covenants, required this.installment});

  @override
  State<SimulatePage> createState() => _SimulatePageState();
}

class _SimulatePageState extends State<SimulatePage> {
  final SimulateService _service = SimulateService();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Simular Empréstimo'),
        ),
        body: FutureBuilder<List<SimulateModel>>(
          future: _service.simulate(widget.value, widget.institutions, widget.covenants, widget.installment),
          builder: (context, snapshot) {
            var data = snapshot.data;
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Text('Valor Solicitado: ${widget.value}'),
                  ),
                ),
                const Card(
                  clipBehavior: Clip.antiAlias,
                  child: ListTile(
                    title: Text('BMG'),
                    textColor: Colors.white,
                    tileColor: Colors.indigo,
                  ),
                ),
                data?[0].bmg?.length == null ? const Center(
                  child: Text('Nenhum resultado entrado para essa instituição.'),
                ) : Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: data?[0].bmg?.length,
                    itemBuilder: (context, index) {
                      final formatter = NumberFormat.currency(
                          locale: 'pt_Br', symbol: 'R\$');
                      String formattedValue = formatter.format(
                          (data?[0].bmg?[index].valorParcela)! / 100);
                      return Card(
                        clipBehavior: Clip.antiAlias,
                        child: Column(
                          children: [
                            ListTile(
                              title: Text('${data?[0].bmg?[index]
                                  .parcelas} parcelas de $formattedValue'),
                              subtitle: Text(
                                'Taxa: ${data?[0].bmg?[index].taxa}',
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.6)),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                'Convênio: ${data?[0].bmg?[index].convenio}',
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.6)),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const Card(
                  clipBehavior: Clip.antiAlias,
                  child: ListTile(
                    title: Text('Pan'),
                    textColor: Colors.white,
                    tileColor: Colors.indigo,
                  ),
                ),
                data?[0].pan?.length == null ? const Center(
                  child: Text('Nenhum resultado entrado para essa instituição.'),
                ) : Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: data?[0].pan?.length,
                    itemBuilder: (context, index) {
                      final formatter = NumberFormat.currency(
                          locale: 'pt_Br', symbol: 'R\$');
                      String formattedValue = formatter.format(
                          (data?[0].pan?[index].valorParcela)! / 100);
                      return Card(
                        clipBehavior: Clip.antiAlias,
                        child: Column(
                          children: [
                            ListTile(
                              title: Text('${data?[0].pan?[index]
                                  .parcelas} parcelas de $formattedValue'),
                              subtitle: Text(
                                'Taxa: ${data?[0].pan?[index].taxa}',
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.6)),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                'Convênio: ${data?[0].pan?[index].convenio}',
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.6)),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const Card(
                  clipBehavior: Clip.antiAlias,
                  child: ListTile(
                    title: Text('Ole'),
                    textColor: Colors.white,
                    tileColor: Colors.indigo,
                  ),
                ),
                data?[0].ole?.length == null ? const Center(
                  child: Text('Nenhum resultado entrado para essa instituição.'),
                ) : Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: data?[0].ole?.length,
                    itemBuilder: (context, index) {
                      final formatter = NumberFormat.currency(
                          locale: 'pt_Br', symbol: 'R\$');
                      String formattedValue = formatter.format(
                          (data?[0].ole?[index].valorParcela)! / 100);
                      return Card(
                        clipBehavior: Clip.antiAlias,
                        child: Column(
                          children: [
                            ListTile(
                              title: Text('${data?[0].ole?[index]
                                  .parcelas} parcelas de $formattedValue'),
                              subtitle: Text(
                                'Taxa: ${data?[0].ole?[index].taxa}',
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.6)),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                'Convênio: ${data?[0].ole?[index].convenio}',
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.6)),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
