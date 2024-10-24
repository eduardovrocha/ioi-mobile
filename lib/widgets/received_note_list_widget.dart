import 'package:flutter/material.dart';
import '../models/profile_data.dart';
import '../services/api_service.dart';

/* funcional */
class ReceivedNoteListWidget extends StatefulWidget {
  /* Declare the parameter */
  // const ReceivedNoteListWidget({super.key, required this.profileData});

  @override
  _ReceivedNoteListWidgetState createState() => _ReceivedNoteListWidgetState();
}

class _ReceivedNoteListWidgetState extends State<ReceivedNoteListWidget> {
  final ApiService apiService = ApiService();
  late ProfileData profile = ProfileData(
      uniqueId: '',
      createdAt: DateTime.now(),
      vouchers: Vouchers(valid: 0, invalid: 0, count: 0),
      tokens: Tokens(amount: '0.0', collected: 0),
      currency: Currency(amount: '0.0')
  );
  Map<String, dynamic>? meta;

  @override
  Widget build(BuildContext context) {
    apiService.fetchProfileData().then((response) {
      profile = response;
    });

    // Obtendo as dimensões da tela
    var screenSize = MediaQuery.of(context).size;
    var screenWidth = screenSize.width;
    print(screenSize);

    return Expanded(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 30, top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RichText(
                  text: TextSpan(
                    style: const TextStyle(
                        fontSize: 14,
                        height: 1.5,
                        color: Colors.black,
                        letterSpacing: 1.5
                    ),
                    children: <TextSpan>[
                      const TextSpan(
                        text: 'Recebidos: ',
                      ),
                      TextSpan(
                        text: '${profile.vouchers.count}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const TextSpan(
                        text: ' | ',
                      ),
                      const TextSpan(
                        text: 'Válidos: ',
                      ),
                      TextSpan(
                        text: '${profile.vouchers.valid}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                RichText(text: TextSpan(
                  style:  const TextStyle(
                    fontSize: 14,
                    height: 1.5,
                    color: Colors.black,
                    letterSpacing: 1.5
                  ),
                  children: [
                    const TextSpan(
                      text: ' | ',
                    ),
                    const TextSpan(
                      text: 'Inválidos: ',
                    ),
                    TextSpan(
                      text: '${profile.vouchers.invalid}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ]
                ))
              ],
            ),
          ),
          FutureBuilder<Map<String, dynamic>>(
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
                                    fontSize: 12,
                                    color: Colors.black38,
                                    height: 1.7),
                                children: <TextSpan>[
                                  const TextSpan(
                                      text:
                                          'Opa! Algo deu errado e já foi informado -> ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
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
                // Extract 'data' and 'meta' from the snapshot
                final data = snapshot.data!['data'] as List<dynamic>;
                final meta = snapshot.data!['meta'] as Map<String, dynamic>;

                if (data.isNotEmpty) {
                  return Expanded(
                      child: Padding(
                          padding: const EdgeInsets.only(
                              bottom: 0, top: 0, right: 5, left: 5),
                          child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10.0,
                              mainAxisSpacing: 10.0,
                              childAspectRatio: 1.0,
                            ),
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              var noteItem = data[index];

                              return Container(
                                margin: const EdgeInsets.all(0.0),
                                decoration: BoxDecoration(
                                  color: Colors.white70,
                                  borderRadius: BorderRadius.circular(10.0),
                                  border: Border.all(
                                    color: Colors.black12,
                                    width: 0.0,
                                  ),
                                ),
                                child: Stack(
                                  children: [
                                    Positioned(
                                      top: 10, left: 10, right: 0,
                                      child: Padding(
                                        padding: const EdgeInsets.all(0.0),
                                          /* ListTile(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                          ),
                                          leading: Image.asset(
                                            'assets/images/resources-004.png',
                                            width: 20,
                                            height: 20,
                                            fit: BoxFit.cover,
                                          ),
                                          title: Text(
                                            '${noteItem['attributes']['crea''ted_at']}',
                                            style: TextStyle(
                                                fontSize: screenWidth < 400 ? 11 : 13,
                                                fontWeight: screenWidth < 400 ?
                                                FontWeight.normal : FontWeight.normal
                                            ), //
                                          ),
                                          /* title: Text(
                                            '${noteItem['attributes']['created_at']}',
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ), */
                                        ), */
                                        child: Row(
                                          children: [
                                            RichText(
                                                text: TextSpan(
                                                    style: const TextStyle(
                                                        fontSize: 13,
                                                        height: 1.5,
                                                        color: Colors.black,
                                                        letterSpacing: 1
                                                    ),
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                        text: '${noteItem['attributes']['crea''ted_at']}',
                                                      )
                                                    ]))
                                          ],
                                        )
                                      ),
                                    ),
                                    Positioned(
                                      top: 60, left: 60, bottom: 20, right: 20,
                                      child: Opacity(
                                        /* noteItem['attributes']['realized']
                                                ? 0.8
                                                : 0.1, */
                                        opacity: noteItem['attributes']['realized'] ? 0.8 : 0.1,
                                        child: Image.asset(
                                          'assets/images/resources-004-small.png',
                                          fit: BoxFit.fill, // Ajusta a imagem
                                          width: 30, height: 30,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 0, left: 0, right: 10,
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
                          ))); // Wrap GridView.builder in Expanded
                } else {
                  return const Stack(
                    children: [
                      /* version 1.0.1 */
                      /* Positioned.fill(
                        child: SvgPicture.asset(
                          'assets/images/empty-list.svg',
                          color: Colors.blue,  // Optional: apply color to the SVG
                          colorBlendMode: BlendMode.srcIn, // Optional: blending mode for the color
                          fit: BoxFit.cover, // Adjust this to fit your needs (BoxFit.cover, contain, etc.)
                        ),
                      ), */
                      SizedBox(
                          width: double.infinity,
                          // Makes the width 100% of the parent
                          child: Text(
                              'não encontrei vouchers associado ao seu perfil ',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 16,
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
        ],
      ),
    );
  }

  fetchReceivedNotes() {
    return apiService.fetchReceivedNotes();
  }
}
