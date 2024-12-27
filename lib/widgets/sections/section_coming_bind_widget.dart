import 'package:flutter/material.dart';
import '../../services/api_service.dart';

class SectionComingBindWidget extends StatefulWidget {

  const SectionComingBindWidget({
    super.key
  });

  @override
  _SectionComingBindWidgetState createState() =>
      _SectionComingBindWidgetState();
}

class _SectionComingBindWidgetState extends State<SectionComingBindWidget> {

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
                left: 0, right: 0,
                top: 5, bottom: 5
            ),
            child: FutureBuilder<dynamic>(
              future: apiService.fetchJobExecutions('coming_bind'),
              builder: (context, snapshot) {
                return RichText(text: TextSpan(
                    style: const TextStyle(
                        fontSize: 14,
                        height: 1.5,
                        color: Colors.black,
                        letterSpacing: 1.5),
                    children: [
                      const TextSpan(
                          text: 'Próxima colheita em: '
                      ),
                      TextSpan(
                        text: '${snapshot.data}',
                      )
                    ]
                ));
              },
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 5, bottom: 5),
          child: Padding(
            padding: const EdgeInsets.only(
                left: 0, right: 0, top: 5, bottom: 5
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/resources-037.png',
                  width: 24.0,
                  height: 24.0,
                  fit: BoxFit.contain,
                ),
                const SizedBox(width: 15.0),
                FutureBuilder<dynamic>(
                  future: apiService.fetchProfileData(),
                  builder: (context, snapshot) {
                    /* late Future<String> currencyAmount = apiService.fetchProfileData()
                        .then((onValue) { return onValue.currency.amount; }); */
                    var currencyAmount = (snapshot.hasData) ? snapshot.data.currency.amount : '0,00';
                    return snapshot.hasData ? RichText(
                      text: TextSpan(
                        style: const TextStyle(
                            fontSize: 14, height: 1.5, color: Colors.black, letterSpacing: 1.5
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'R\$ ${currencyAmount}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ) : RichText(
                      text: const TextSpan(
                        style: TextStyle(
                            fontSize: 14,
                            height: 1.5,
                            color: Colors.black,
                            letterSpacing: 1.5),
                        children: <TextSpan>[
                          TextSpan(
                            text: '...',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
