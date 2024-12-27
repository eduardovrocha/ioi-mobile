import 'package:flutter/material.dart';
import '../../services/api_service.dart';
import 'content/value_exchange_widget.dart';

class ComingBindListWidget extends StatefulWidget {
  const ComingBindListWidget({super.key});

  @override
  _ComingBindListWidgetState createState() => _ComingBindListWidgetState();
}

class _ComingBindListWidgetState extends State<ComingBindListWidget> {
  final ApiService apiService = ApiService();
  Map<String, dynamic>? meta;

  @override
  Widget build(BuildContext context) {

    return Expanded(
      child: FutureBuilder<Map<String, dynamic>>(
        future: fetchComingBinds(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Stack(
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 16.0, top: 8.0, right: 24.0, bottom: 12.0,
                        ),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: const TextStyle(
                                fontSize: 14, color: Colors.black38, height: 1.7
                            ),
                            children: <TextSpan>[
                              const TextSpan(
                                  text:
                                      'Opa! Algo deu errado e já foi informado -> ',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(text: '${snapshot.error}')
                            ],
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            );
          } else if (snapshot.hasData) {
            final data = snapshot.data!['data'] as List<dynamic>;
            if (data.isNotEmpty) {

              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  var item = data[index];
                  var comingBindItem = item;

                  return Container(
                    margin: const EdgeInsets.only(
                      left: 15.0, top: 5, right: 15.0, bottom: 10.0
                    ),
                    decoration: BoxDecoration(
                      boxShadow: [
                        if (true)
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 2, offset: Offset(0, 1),
                          ),
                      ],
                      color: Colors.white,
                      border: const Border(
                        bottom: BorderSide(
                          color: Colors.black12,
                          width: 1,
                        ),
                        top: BorderSide(
                          color: Colors.black12,
                          width: 1,
                        ),
                        right: BorderSide(
                          color: Colors.black12,
                          width: 1,
                        ),
                        left: BorderSide(
                          color: Colors.black12,
                          width: 1,
                        ),
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 16.0, right: 16.0,
                                  top: 16.0, bottom: 16.0
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      margin: const EdgeInsets.only(
                                          bottom: 25.0
                                      ),
                                      width: double.infinity,
                                      decoration: const BoxDecoration(
                                      ),
                                    child: Text('${comingBindItem['attributes']['company_name']}')
                                  ),
                                  ValueExchangeWidget(itemListed: comingBindItem)
                                ],
                          ))
                        ),
                      ],
                    ),
                  );
                },
              );
            } else {
              return const Stack(
                children: [
                  SizedBox(
                      width: double.infinity,
                      child: Text(
                          'não encontrei itens que já foram processados',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.blueGrey) // Center the
                          ))
                ],
              );
            }
          } else {
            return const Center(child: Text('No notes found.'));
          }
        },
      ),
    );
  }

  fetchComingBinds() {
    return apiService.fetchComingBinds();
  }
}
