import 'package:flutter/material.dart';
import 'package:mrcatcash/models/profile_data.dart';
import '../services/api_service.dart';

/* funcional */

class ComingBindListWidget extends StatefulWidget {
  final ProfileData profileData;
  const ComingBindListWidget({super.key, required this.profileData});

  @override
  _ComingBindListWidgetState createState() => _ComingBindListWidgetState();
}

class _ComingBindListWidgetState extends State<ComingBindListWidget> {
  final ApiService apiService = ApiService();
  Map<String, dynamic>? meta; // State variable to hold the 'meta' data

  @override
  Widget build(BuildContext context) {
    final profile = widget.profileData;

    return Expanded(
      child: Column(
        children: [
          const Padding(
            // padding: const EdgeInsets.all(10.0),
            padding: EdgeInsets.only(bottom: 0, top: 10)
          ),
          FutureBuilder<Map<String, dynamic>>(
            future: fetchComingBinds(),
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
                                    fontSize: 12,
                                    color: Colors.black38, height: 1.7
                                ),
                                children: <TextSpan>[
                                  const TextSpan(
                                      text: 'Opa! Algo deu errado e já foi informado -> ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(text: '${snapshot.error}')
                                ],
                              ),
                            ),
                          )],
                      )
                    ],
                  ),
                );
              } else if (snapshot.hasData) {
                // Extract 'data' and 'meta' from the snapshot
                final data = snapshot.data!['data'] as List<dynamic>;
                final meta = snapshot.data!['meta'] as Map<String, dynamic>;

                if (data.isNotEmpty) {
                  return Expanded(  // Wrap GridView.builder in Expanded
                    child: Padding(padding: const EdgeInsets.only(
                      bottom: 0, top: 0, right: 5, left: 5
                    ),
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 10.0,
                        childAspectRatio: 1.0,
                      ),
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        var comingBindItem = data[index];
                        // var itemComingBind = comingBinds[index];

                        return Container(
                            constraints: const BoxConstraints(
                              minWidth: double.infinity,
                              maxWidth: double.infinity,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(
                                color: Colors.black12,
                                width: 0.0,
                              ),
                            ),
                            child: Stack(
                              children: [
                                Padding(
                                    padding: const EdgeInsets.only(
                                        top: 15.0, left: 10.0, right: 10.0
                                    ),
                                    child: Column(
                                      children: [
                                        Text(
                                            '${comingBindItem['attributes']['company_name']}',
                                            style: const TextStyle(
                                                fontSize: 14, fontWeight: FontWeight.bold
                                            )),
                                        Padding(
                                            padding: const EdgeInsets.only(
                                              top: 10, left: 10, right: 10,
                                            ),
                                            child: Row(
                                                children: [
                                                  Image.asset(
                                                    'assets/images/resources-006.png',
                                                    width: 20, height: 20, fit: BoxFit.cover,
                                                  ),
                                                  const SizedBox(width: 8.0),
                                                  Text(
                                                      'R\$ ${comingBindItem['attributes']['total_currency_amount']}',
                                                      style: const TextStyle(
                                                          fontSize: 14
                                                      ))
                                                ])),
                                        Padding(
                                            padding: const EdgeInsets.only(
                                              top: 10, left: 10, right: 10,
                                            ),
                                            child: Row(
                                                children: [
                                                  Image.asset(
                                                    'assets/images/resources-020.png',
                                                    width: 20, height: 20, fit: BoxFit.cover,
                                                  ),
                                                  const SizedBox(width: 8.0),
                                                  Text(
                                                      '\$MC3 ${comingBindItem['attributes']['total_token_amount']}',
                                                      style: const TextStyle(
                                                          fontSize: 14
                                                      ))
                                                ])),
                                      ],
                                    )
                                ),
                                Positioned(
                                  bottom: 0, left: 0, right: 0,
                                  child: Padding(
                                    padding: const EdgeInsets.all(0.0),
                                    child: ListTile(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5.0),
                                      ),
                                      title: Text(
                                        '${comingBindItem['attributes']['protocol']}',
                                        style: const TextStyle(
                                            fontSize: 14, fontWeight: FontWeight.bold
                                        ),
                                        textAlign: TextAlign.right,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ));
                        // return Container(
                        //   margin: const EdgeInsets.all(0.0),
                        //   decoration: BoxDecoration(
                        //     color: Colors.white70,
                        //     borderRadius: BorderRadius.circular(10.0),
                        //     border: Border.all(
                        //       color: Colors.black12,
                        //       width: 0.0,
                        //     ),
                        //   ),
                        //   child: Stack(
                        //     children: [
                        //       Positioned(
                        //         top: 60,
                        //         left: 60,
                        //         bottom: 20,
                        //         right: 20,
                        //         child: Opacity(
                        //           opacity: 0.3,
                        //           child: SizedBox(
                        //             width: 100,
                        //             height: 100,
                        //             child: Image.asset(
                        //               'assets/images/resources-003.png',
                        //               fit: BoxFit.cover,
                        //             ),
                        //           ),
                        //         ),
                        //       ),
                        //       Positioned(
                        //         top: 0,
                        //         left: 0,
                        //         right: 0,
                        //         child: Padding(
                        //           padding: const EdgeInsets.all(0.0),
                        //           child: ListTile(
                        //             shape: RoundedRectangleBorder(
                        //               borderRadius: BorderRadius.circular(15.0),
                        //             ),
                        //             leading: Image.asset(
                        //               'assets/images/6819843.png',
                        //               width: 20,
                        //               height: 20,
                        //               fit: BoxFit.cover,
                        //             ),
                        //             title: Text(
                        //               '${noteItem['attributes']['created_at']}',
                        //               style: const TextStyle(
                        //                 fontSize: 14,
                        //                 fontWeight: FontWeight.bold,
                        //               ),
                        //             ),
                        //           ),
                        //         ),
                        //       ),
                        //       Positioned(
                        //         bottom: 0,
                        //         left: 0,
                        //         right: 10,
                        //         child: Padding(
                        //           padding: const EdgeInsets.all(0.0),
                        //           child: ListTile(
                        //             leading: Image.asset(
                        //               noteItem['attributes']['realized']
                        //                   ? 'assets/images/resources-014.png'
                        //                   : 'assets/images/resources-013.png',
                        //               width: 20,
                        //               height: 20,
                        //             ),
                        //           ),
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // );
                      },
                    )));
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
                          width: double.infinity,  // Makes the width 100% of the parent
                          child: Text(
                              'não encontrei itens que já foram processados',
                              textAlign: TextAlign.center, style: TextStyle
                            (fontSize: 16, color: Colors.blueGrey)// Center the
                          )
                      )
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

  fetchComingBinds() {
    return apiService.fetchComingBinds();
  }
}
