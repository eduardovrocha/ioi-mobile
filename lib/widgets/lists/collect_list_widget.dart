import 'package:flutter/material.dart';
import 'package:mrcatcash/models/collect_list_item_data.dart';
import 'package:mrcatcash/models/profile_data.dart';
import '../../services/api_service.dart';
import 'content/collect_item_widget.dart';

class CollectListWidget extends StatefulWidget {
  const CollectListWidget({super.key});

  @override
  _CollectListWidgetState createState() => _CollectListWidgetState();
}

class _CollectListWidgetState extends State<CollectListWidget> {
  final ApiService apiService = ApiService();

  late Future<ProfileData> getProfileData = apiService.fetchProfileData();

  Image imageWithFallback(String assetPath) {
    return Image.asset(
      'assets/images/$assetPath.png', width: 24, height: 24,
      errorBuilder: (context, error, stackTrace) {
        return Image.asset(
            'assets/images/1091102.png', width: 24, height: 24
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Expanded(
      child: FutureBuilder<Map<String, dynamic>>(
        future: apiService.fetchCollects(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Container(
              constraints: const BoxConstraints(
                minHeight: 50,
                minWidth: double.infinity,
                maxWidth: double.infinity,
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
                                fontSize: 14,
                                color: Colors.black38,
                                height: 1.7),
                            children: <TextSpan>[
                              const TextSpan(
                                  text: 'Opa! Algo deu errado e já foi informado -> ',
                                  style:
                                      TextStyle(
                                          fontWeight: FontWeight.bold)
                              ),
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

                  final collectItem = CollectListItemData(
                    dataHealthDeb: item['attributes']['analysis']['percentage_empty'],
                    shopName: item['attributes']['shop'],
                    emptyPercentage: item['attributes']['analysis']['percentage_empty'],
                    currencyAmount: item['attributes']['currency_amount'].toString(),
                    tokenAmount: item['attributes']['token_amount'].toString(),
                    categoryNumber: item['attributes']['category']['cnae_id'].toString(),
                  );

                  return CollectItemWidget(
                    collectItem: collectItem,
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
                              color: Colors.blueGrey)
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
}
