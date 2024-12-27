import 'package:flutter/material.dart';
import '../../models/profile_data.dart';
import '../../services/api_service.dart';

/* funcional */
class ReceivedNoteListWidget extends StatefulWidget {
  /* Declare the parameter */
  // const ReceivedNoteListWidget({super.key, required this.profileData});

  @override
  _ReceivedNoteListWidgetState createState() => _ReceivedNoteListWidgetState();
}

class _ReceivedNoteListWidgetState extends State<ReceivedNoteListWidget> {
  final ApiService apiService = ApiService();

  /* late ProfileData profile = ProfileData(
      uniqueId: '',
      createdAt: '00/00/0000 - 00:00:00',
      vouchers: Vouchers(valid: '0', invalid: '0', count: '0'),
      tokens: Tokens(amount: '0,0', collected: '0,0', allocated: '0,0'),
      currency: Currency(amount: '0.0'),
      presences: Presences(
          professional: { 'created': DateTime(2024, 11, 09), 'active': false },
          personal: { 'created': DateTime(2024, 11, 09), 'active': false }
      )
  ); */

  Map<String, dynamic>? meta;

  @override
  Widget build(BuildContext context) {
    late List<dynamic> data;

    // Obtendo as dimensões da tela
    var screenSize = MediaQuery.of(context).size;
    var screenWidth = screenSize.width;
    var screenHeight = screenSize.height;
    print('screen dimensions: ${screenWidth} width, ${screenHeight}');

    return Expanded(child: FutureBuilder<Map<String, dynamic>>(
      future: fetchReceivedNotes(),
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
                        left: 16.0,
                        top: 8.0,
                        right: 24.0,
                        bottom: 12.0,
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
          data = snapshot.data!['data'] as List<dynamic>;

          if (true) {
            /*  */
            return Container(
              margin: const EdgeInsets.only(
                  left: 15.0, top: 5, right: 15.0, bottom: 10
              ),
              child: GridView.builder(
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 13.0,
                  mainAxisSpacing: 13,
                  childAspectRatio: 1.0,
                ),
                itemCount: data.length,
                itemBuilder: (context, index) {
                  var noteItem = data[index];

                  return Container(
                    decoration: BoxDecoration(
                      color:
                      (noteItem['attributes']['realized'] == true &&
                          noteItem['attributes']['processed'] ==
                              true)
                          ? Colors.white
                          : Colors.white70,
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
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: (noteItem['attributes']['realized'] == true &&
                              noteItem['attributes']['processed'] ==
                                  true)
                              ? 2
                              : 0,
                          offset: Offset(0, (noteItem['attributes']['realized'] == true &&
                              noteItem['attributes']['processed'] ==
                                  true) ? 1 : 0), // Deslocamento horizontal e
                        ),
                      ],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          top: 10,
                          left: 10,
                          right: 0,
                          child: Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Row(
                                children: [
                                  RichText(
                                      text: TextSpan(
                                          style: const TextStyle(
                                              fontSize: 12, height: 1.5,
                                              color: Colors.black,
                                              letterSpacing: 1),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: '${noteItem['attributes']['created_at']}\n',
                                            )
                                          ]))
                                ],
                              )),
                        ),
                        Positioned(
                          top: 60, left: 60, bottom: 20, right: 20,
                          child: Opacity(
                            opacity: (noteItem['attributes']
                            ['realized'] == true && noteItem['attributes']
                            ['processed'] == true) ? 0.8 : 0.1,
                            child: Image.asset(
                              'assets/images/resources-004-small.png',
                              fit: BoxFit.fill,
                              width: 30, height: 30,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 10,
                          child: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: ListTile(
                              leading: Image.asset(
                                noteItem['attributes']['realized']
                                    ? 'assets/images/resources-013.png'
                                    : 'assets/images/resources-013.png',
                                width: 20,
                                height: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          } else {
            return const Stack(
              children: [
                SizedBox(
                    width: double.infinity,
                    // Makes the width 100% of the parent
                    child: Text(
                        'não encontrei vouchers associado ao seu perfil ',
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
    ));
  }

  fetchReceivedNotes() {
    return apiService.fetchReceivedNotes();
  }
}
