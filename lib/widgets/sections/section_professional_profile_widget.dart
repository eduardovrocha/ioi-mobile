import 'package:flutter/material.dart';
import 'package:mrcatcash/models/profile_data.dart';
import '../../services/api_service.dart';
import 'content/balance_widget.dart';

class SectionProfessionalProfileWidget extends StatefulWidget {

  const SectionProfessionalProfileWidget({
    Key? key
  }) : super(key: key);

  @override
  _SectionProfessionalProfileWidgetState createState() =>
      _SectionProfessionalProfileWidgetState();
}

class _SectionProfessionalProfileWidgetState extends State<SectionProfessionalProfileWidget> {
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
          margin: const EdgeInsets.only(top: 0, bottom: 5),
          child: const Padding(
            padding: EdgeInsets.only(
                left: 0, right: 0, top: 0, bottom: 5
            ),
            child: Row(),
            /* child: BalanceWidget(
                profileTokenAmount: '0',
                profileTokenAllocated: '0'
            ) */
            /* child: FutureBuilder<dynamic>(
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
                          const TextSpan(text: 'Próxima colheita em:'),
                          TextSpan(
                            text: '${snapshot.data}',
                          )
                        ]));
              },
            ) */
          ),
        ),
      ],
    );
  }

}

/* FutureBuilder<dynamic>(
      future: apiService.fetchJobExecutions(viewName),
      builder: (context, snapshot) {
        return RichText(text: TextSpan(
            style: const TextStyle(
                fontSize: 14,
                height: 1.5,
                color: Colors.black,
                letterSpacing: 1.5),
            children: [
              const TextSpan(
                  text: 'Próxima colheita em:'
              ),
              TextSpan(
                text: '${snapshot.data}',
              )
            ]
        ));
      },
    ) */
