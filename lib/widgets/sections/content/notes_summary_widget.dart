import 'package:flutter/material.dart';

import '../../../services/api_service.dart';

class NotesSummaryWidget extends StatelessWidget {

  const NotesSummaryWidget({
    super.key
  });

  @override
  Widget build(BuildContext context) {
    final ApiService apiService = ApiService();

    return FutureBuilder(
        future: apiService.fetchProfileData(),
        builder: (context, snapshot) {

          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RichText(
                text: TextSpan(
                  style: const TextStyle(
                      fontSize: 14, color: Colors.black, height: 1.5),
                  children: <TextSpan>[
                    const TextSpan(text: 'Recebidos: '),
                    TextSpan(
                      text: (snapshot.data?.vouchers != null) ? snapshot.data?.vouchers.count : '....',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 15),
              RichText(
                text: TextSpan(
                  children: [
                    WidgetSpan(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 15),
                        padding: const EdgeInsets.only(
                            top: 4, bottom: 8, right: 15, left: 15),
                        decoration: const BoxDecoration(
                          color: Colors.white38,
                          border: Border(
                            bottom: BorderSide(color: Colors.black12, width: 1),
                            top: BorderSide(color: Colors.black12, width: 0),
                          ),
                        ),
                        child: Row(
                          children: [
                            RichText(
                              text: TextSpan(
                                style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    height: 1.5,
                                    fontWeight: FontWeight.bold),
                                children: [
                                  TextSpan(
                                    text: 'Válidos ${
                                        (snapshot.data?.vouchers != null) ? snapshot.data?.vouchers.valid : '....'
                                    }',
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8.0),
                            Image.asset(
                              'assets/images/resources-027.png',
                              width: 16.0,
                              height: 16.0,
                              fit: BoxFit.contain,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 15),
              RichText(
                text: TextSpan(
                  style: const TextStyle(
                      fontSize: 14, color: Colors.black, height: 1.5),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Inválidos ${
                          (snapshot.data?.vouchers != null) ? snapshot.data?.vouchers.invalid : '....'
                      }',
                    ),
                  ],
                ),
              ),
            ],
          );
        }
    );
  }
}
