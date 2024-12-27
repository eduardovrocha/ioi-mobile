import 'package:flutter/material.dart';
import '../../services/api_service.dart';

class SectionCollectWidget extends StatefulWidget {

  const SectionCollectWidget({
    super.key
  });

  @override
  _SectionCollectWidgetState createState() =>
      _SectionCollectWidgetState();
}

class _SectionCollectWidgetState extends State<SectionCollectWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ApiService apiService = ApiService();

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 5, bottom: 5),
          child: Padding(
            padding: const EdgeInsets.only(
                left: 0, right: 0, top: 5, bottom: 5
            ),
            child: FutureBuilder<dynamic>(
              future: apiService.fetchJobExecutions('collect'),
              builder: (context, snapshot) {
                return RichText(
                    text: TextSpan(
                        style: const TextStyle(
                            fontSize: 14,
                            height: 1.5,
                            color: Colors.black,
                            letterSpacing: 1.5),
                        children: [
                      const TextSpan(text: 'Próxima colheita em: '),
                      TextSpan(
                        text: '${snapshot.data}',
                      )
                    ]));
              },
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 5, bottom: 5),
          child: Padding(
              padding: const EdgeInsets.only(
                  left: 0, right: 0,
                  top: 5, bottom: 5
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center, children: [
                Image.asset(
                  'assets/images/resources-029.png',
                  width: 24.0, height: 24.0,
                  fit: BoxFit.contain,
                ),
                const SizedBox(width: 8.0),
                FutureBuilder(
                    future: apiService.fetchProfileData(),
                    builder: (context, snapshot) {

                      return RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black38,
                              height: 1.7
                          ),
                          children: <TextSpan>[
                            const TextSpan(
                                text: '\$MC3 ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black
                                )
                            ),
                            TextSpan(
                                text: (snapshot.data != null) ? "${snapshot.data
                                    ?.tokens.amount}" : "...",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black
                                )
                            )
                          ],
                        ),
                      );
                    }
                )
              ],
            ),
          ),
        )
      ],
    );
  }

}
