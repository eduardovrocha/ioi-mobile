import 'package:flutter/material.dart';
import '../../services/api_service.dart';
import 'content/notes_summary_widget.dart';

class SectionReceivedNoteWidget extends StatefulWidget {

  const SectionReceivedNoteWidget({
    Key? key
  }) : super(key: key);

  @override
  _SectionReceivedNoteWidgetState createState() =>
      _SectionReceivedNoteWidgetState();
}

class _SectionReceivedNoteWidgetState extends State<SectionReceivedNoteWidget> {


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
              future: apiService.fetchJobExecutions('received_note'),
              builder: (context, snapshot) {
                return RichText(text: TextSpan(
                    style: const TextStyle(
                        fontSize: 14, height: 1.5,
                        color: Colors.black, letterSpacing: 1.5),
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
          margin: const EdgeInsets.only(top: 0, bottom: 0),
          child: const Padding(
            padding: EdgeInsets.only(
                left: 0, right: 0, top: 5, bottom: 5
            ),
            child: NotesSummaryWidget()
          ),
        )
      ],
    );
  }
}
