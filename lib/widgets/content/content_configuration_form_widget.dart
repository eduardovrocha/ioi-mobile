import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:accordion/accordion.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:mrcatcash/views/configurations_view.dart';
import 'package:mrcatcash/views/received_notes_view.dart';

import '../../main.dart';
import '../../services/api_service.dart';
import '../update_profile_screen_widget.dart';

class ContentConfigurationFormWidget extends StatefulWidget {
  final List profilePresences;

  const ContentConfigurationFormWidget(this.profilePresences, {super.key});

  @override
  _ContentConfigurationFormWidgetState createState() =>
      _ContentConfigurationFormWidgetState();
}

class _ContentConfigurationFormWidgetState
    extends State<ContentConfigurationFormWidget> {
  final ApiService apiService = ApiService();

  late final _contactController = TextEditingController();
  final _cnpjController = MaskedTextController(mask: '00.000.000/0000-00');
  final _phoneController = MaskedTextController(mask: '(00) 0 0000-0000');
  bool isButtonEnabled = false;

  final ValueNotifier<String> _contactName =
      ValueNotifier<String>('Nome do Contato');
  final ValueNotifier<String> _contactNumber =
      ValueNotifier<String>('(00) 0 0000-0000');
  final ValueNotifier<String> _companyId =
      ValueNotifier<String>('00.000.000/0000-00');

  final _formKey = GlobalKey<FormState>();
  late List profilePresences = widget.profilePresences;

  _validateForm(String stepName) {
    switch (stepName) {
      case 'selectOption':
        return selectedOption.isNotEmpty;
      case 'companyId':
        if (_cnpjController.text.isNotEmpty &&
            _cnpjController.text.length == 18) {
          return true;
        } else {
          return false;
        }
      case 'contactName':
        return _contactController.text.isNotEmpty;
      case 'contactNumber':
        if (_phoneController.text.isNotEmpty &&
            _cnpjController.text.length >= 15) {
          return true;
        } else {
          return false;
        }
      default:
        print('Status desconhecido.');
    }
  }

  String selectedOption = '';
  String currentStep = 'buildFirstStep';

  bool _cnpj = false;
  bool _driveLicense = false;
  bool _cpf = false;
  bool _passport = false;

  bool _companyIdValid = false;
  bool _contactNameValid = false;
  bool _contactNumberValid = false;
  bool isFieldEnabled = true;

  String _presence = '';

  bool isFormValid = false;

  bool isLoading = false;
  bool isSuccess = false;
  bool isError = false;

  /* Map<String, dynamic> presenceConfigData = {
    "profile_id": 0,
    "unique_id": "",
    "setup": 0,
    "doc_type": 0,
    "doc": "",
    "contact_name": "",
    "phone_number": ""
  }; */

  void _goToStep(String goToStep) {
    if (currentStep != null) {
      setState(() {
        currentStep = goToStep;
      });
    }
  }

  void getPresence(type) async {
    _presence = await apiService.getPresence(type);
    setState(() {}); /* Update the UI if this is in a StatefulWidget */
  }

  void checkCNPJ() async {
    var getCNPJ = await apiService.profileGotPresence('cnpj');
    print('---> getCNPJ: $getCNPJ');

    if (getCNPJ == null) {
      _cnpj = false;
    } else {
      _cnpj = true;
    }

    setState(() {}); // Update the UI if this is in a StatefulWidget
  }

  void checkPassport() async {
    var getPassport = await apiService.profileGotPresence('passport');
    if (getPassport == null) {
      _passport = false;
      setState(() {}); // Update the UI if this is in a StatefulWidget
    }
  }

  void checkDriveLicense() async {
    var getDriveLicense = await apiService.profileGotPresence('drive_license');
    if (getDriveLicense == null) {
      _driveLicense = false;
      setState(() {}); // Update the UI if this is in a StatefulWidget
    }
  }

  void checkCPF() async {
    var getCPF = await apiService.profileGotPresence('cpf');
    if (getCPF == null) {
      _cpf = false;
      setState(() {}); // Update the UI if this is in a StatefulWidget
    }
  }

  _checkCnpjComplete() {
    if (_cnpjController.value.text.length == 18) {
      setState(() {
        _companyIdValid = true;
      });
    } else {
      setState(() {
        _companyIdValid = false;
      });
    }
  }

  _checkContactName() {
    if (_contactController.value.text.length > 5) {
      setState(() {
        _contactNameValid = true;
      });
    } else {
      setState(() {
        _contactNameValid = false;
      });
    }
  }

  _checkContactNumber() {
    if (_phoneController.value.text.length > 15) {
      setState(() {
        _contactNumberValid = true;
      });
    } else {
      setState(() {
        _contactNumberValid = false;
      });
    }
  }

  Map<String, dynamic>? extractInfo(
      List<Map<String, dynamic>> array, String docType) {
    /* find's on presences array the element with received doc_type */
    for (var element in array) {
      if (element['attributes'] != null &&
          element['attributes']['doc_type'] == docType) {
        return element['attributes'];
      }
    }
    return null;
  }

  String _validateAndFormat(String text) {
    final words = text.split(' ').where((word) => word.isNotEmpty).toList();
    if (words.length > 2) {
      return _contactName.value;
    }
    return words
        .map((word) => word[0].toUpperCase() + word.substring(1).toLowerCase())
        .join(' ');
  }

  @override
  void initState() {
    super.initState();

    _cnpjController.addListener(_checkCnpjComplete);
    _cnpjController.addListener(() {
      _companyId.value = _cnpjController.text;
    });
    _contactController.addListener(_checkContactName);
    _contactController.addListener(() {
      final text = _contactController.text;
      final initials = _validateAndFormat(text);

      _contactName.value =
          initials.length > 24 ? initials.substring(0, 24) : initials;
    });
    _phoneController.addListener(() {
      _contactNumber.value = _phoneController.text;
    });
    _phoneController.addListener(_checkContactNumber);

    if (profilePresences.isNotEmpty) {
      profilePresences.map((element) {
        var attributes = element['attributes'];
        apiService.setProfilePresence(
            '${attributes['contact']},${attributes['phone']},${attributes['doc']},${attributes['doc_type']},${attributes['uniqueId']},${attributes['created_at']}');
      }).join('\n');
    }

    checkCNPJ();
    checkPassport();
    checkDriveLicense();
    checkCPF();
  }

  @override
  void dispose() {
    _cnpjController.dispose();
    _contactController.dispose();
    _phoneController.dispose();

    _contactName.dispose();
    _contactNumber.dispose();
    _companyId.dispose();

    _cnpjController.removeListener(_checkCnpjComplete);
    _contactController.removeListener(_checkContactName);
    _phoneController.removeListener(_checkContactNumber);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              /* height size adapted by child height size */
              children: [
                if (currentStep == 'buildFirstStep') _buildFirstStep(),
                if (currentStep == 'buildPersonal') _buildPersonal(),
                if (currentStep == 'buildProfessional') _buildProfessional(),
                if (currentStep == 'buildFourthStep') _buildFourthStep(),
                if (currentStep == 'buildFifthStep') _buildFifthStep(),
                if (currentStep == 'buildSixthStep') _buildSixthStep(),
              ],
            ),
          ),
          Positioned(
            top: -8,
            right: -14,
            child: IconButton(
              icon: Icon(Icons.close, color: Colors.grey[700]),
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o modal ou formulário
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfessional() {
    return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            textAlign: TextAlign.left,
            text: const TextSpan(
              style: TextStyle(
                fontSize: 14,
                color: Colors.black38,
                height: 1.7,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: 'Modo Business',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          RichText(
            textAlign: TextAlign.left,
            text: const TextSpan(
              style: TextStyle(
                fontSize: 14,
                color: Colors.black38,
                height: 1.7,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: 'Como funciona ?\n\n',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
                TextSpan(
                    text: "   No modo profissional, o usuário que é "
                        "um empresário a frente do seu negócio, cria  "
                        "'Campanhas de Pontos e Benefícios' para "
                        "destacar seus produtos ou serviços, incentivando o consumo.\n\n   Com "
                        "a campanha personalizada, é possível distribuir pontos "
                        "além daqueles que o app ",
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                      color: Colors.black,
                    )),
                TextSpan(
                    text: "Mr. Cat Cash",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    )),
                TextSpan(
                    text: " já oferece, incentivando a recorrência de compras"
                        " e novos clientes.\n\n   Com  o app, o empresário  "
                        "gerencia campanhas customizadas, atrai "
                        "mais clientes e se destaca no mercado.\n\n",
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                      color: Colors.black,
                    ))
              ],
            ),
          ),
          /**/
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: ElevatedButton(
                  onPressed: true
                      ? () {
                          _goToStep('buildFirstStep');
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue,
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(14),
                  ),
                  child: const Icon(Icons.arrow_back),
                ),
              ),
              // /* const SendButton() */
              ElevatedButton(
                onPressed: true
                    ? () {
                        _goToStep('buildFourthStep');
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue,
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(14),
                ),
                child: const Icon(Icons.arrow_forward),
              )
            ],
          ),
        ]);
  }

  Widget _buildPersonal() {
    return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            textAlign: TextAlign.left,
            text: const TextSpan(
              style: TextStyle(
                fontSize: 14,
                color: Colors.black38,
                height: 1.7,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: 'Modo Pessoal',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          RichText(
            textAlign: TextAlign.left,
            text: const TextSpan(
              style: TextStyle(
                fontSize: 14,
                color: Colors.black38,
                height: 1.7,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: 'O quê oferece ?\n',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
                TextSpan(
                  text: "   Precisamos saber um pouco da atuação do seu "
                      "Business. Por medida de segurança, em futuras "
                      "visualizações, o",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 14,
                    color: Colors.black,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 16),
          /**/
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: ElevatedButton(
                  onPressed: null,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue,
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(14),
                  ),
                  child: const Icon(Icons.arrow_back),
                ),
              ),
              /* const SendButton() */
              ElevatedButton(
                onPressed: true
                    ? () {
                        _goToStep('buildFourthStep');
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue,
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(14),
                ),
                child: const Icon(Icons.arrow_forward),
              )
            ],
          ),
        ]);
  }

  /* select profile configuration doc_type */
  Widget _buildFirstStep() {
    print('\n\n----> $profilePresences \n\n');

    bool isDisabled = true;

    String contactName = _presence.isEmpty ? '' : _presence.split(',')[0];
    String phoneNumber = _presence.isEmpty ? '' : _presence.split(',')[1];
    String doc = _presence.isEmpty ? '' : _presence.split(',')[2];

    String formatCNPJ(String cnpj) {
      final controllerText = MaskedTextController(mask: '00.000.000/0000-00');
      controllerText.text = cnpj;
      return controllerText.text;
    }

    String formatPhone(String phone) {
      final controllerText = MaskedTextController(mask: '(00) 0 0000-0000');
      controllerText.text = phone;
      return controllerText.text;
    }

    if (_presence.isNotEmpty) {
      print(
          '-> cpf: ${_cpf}, -> cnpj: ${_cnpj}, -> habilitaça: ${_driveLicense}, -> passaporte: ${_passport}, ');
      print(
          '-> nome: ${_presence.split(',')[0]}, -> phone: ${_presence.split(',')[1]}, doc: ${_presence.split(',')[2]}');
    }

    Map<String, dynamic>? extractInfo(List profilePresences, String docType) {
      for (var element in profilePresences) {
        if (element['attributes'] != null &&
            element['attributes']['doc_type'] == docType) {
          return element['attributes'] as Map<String, dynamic>;
        }
      }
      return null;
    }

    var info = extractInfo(profilePresences, 'cnpj');

    if (info?['doc'] != null) {
      _cnpjController.text = info!['doc']!;
    }
    if (info?['phone'] != null) {
      _phoneController.text = info!['phone']!;
    }

    final String formatedCNPJ = info?['doc'] != null ? formatCNPJ(info?['doc']) : 'CNPJ não disponível';
    final String formatedPhone = info?['phone'] != null ? formatPhone(info?['phone']) : 'não possui telefone';



    print('info -->');
    print(formatedCNPJ);
    print('info -->');




    /* var info = extractInfo(profilePresences, 'cnpj');
    _cnpjController.text = info!.isNotEmpty ? info['doc'] : "";
    _phoneController.text = info!.isNotEmpty ? info['phone'] : ""; */

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          textAlign: TextAlign.left,
          text: const TextSpan(
            style: TextStyle(
              fontSize: 14,
              color: Colors.black38,
              height: 1.7,
            ),
            children: <TextSpan>[
              TextSpan(
                text: 'Configurar meu aplicativo ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Accordion(
          maxOpenSections: 1,
          headerBackgroundColor: Color(0xFFFAFAFA),
          contentBackgroundColor: Colors.white70,
          contentBorderColor: Colors.white70,
          contentBorderWidth: 0,
          contentBorderRadius: 0,
          contentHorizontalPadding: 0,
          contentVerticalPadding: 0,
          paddingListHorizontal: 10,
          paddingListTop: 10,
          paddingListBottom: 10,
          headerBorderColorOpened: Colors.white70,
          scaleWhenAnimating: false,
          children: [
            AccordionSection(
              isOpen: false,
              header: Container(
                child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: RichText(
                            textAlign: TextAlign.left,
                            text: const TextSpan(
                              text: "Modo Pessoal",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
              content: Container(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      RichText(
                        textAlign: TextAlign.left,
                        text: const TextSpan(
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black38,
                            height: 1.7,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: "- Cashback e Prêmios em criptomoedas por "
                                  "compras e engajamento. No uso pessoal,"
                                  " o aplicativo distribui valores que "
                                  "podem ser convertidos em outros ativos"
                                  " digitais ou utilizados para novas "
                                  "compras, oferecendo um incentivo "
                                  "financeiro direto ao consumo e participação.",
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // RadioButton para "Meu Perfil"
                      RadioListTile<String>(
                        title: const Text(
                          'Modo Pessoal',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        value: 'personal',
                        groupValue: selectedOption,
                        onChanged: isDisabled
                            ? null
                            : (String? value) {
                                setState(() {
                                  selectedOption = value ?? '';
                                });
                              },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            AccordionSection(
              isOpen: true,
              header: Container(
                child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: RichText(
                            textAlign: TextAlign.left,
                            text: const TextSpan(
                              text: "Modo Business",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
              content: Container(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: _cnpj
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              'assets/images/resources-022.png',
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: RichText(
                                text: TextSpan(
                                  style: const TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                      fontSize: 14,
                                      height: 1.7),
                                  children: [
                                    TextSpan(
                                      text: '${info?['contact']}\n',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text: '${formatedPhone}\n',
                                    ),
                                    TextSpan(
                                      text: '${formatedCNPJ}\n',
                                        // _cnpjController.text
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 8,
                              right: 8,
                              child: Container(
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors
                                      .green, // Cor do status (pode ser alterada conforme o status)
                                ),
                                padding: const EdgeInsets.all(5.0),
                                child: const Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 12,
                                ),
                              ),
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            RichText(
                                textAlign: TextAlign.left,
                                text: const TextSpan(
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black38,
                                    height: 1.7,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: "   Atraia e fidelize clientes "
                                          "distribuindo pontos de premiação. Além dos "
                                          "benefícios de cashback oferecidos pelo "
                                          "app, o empreendedor cria campanhas "
                                          "personalizadas, incentivando o consumo "
                                          "com recompensas exclusivas.",
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                )),
                            RadioListTile<String>(
                              title: const Text('Modo Business',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  )),
                              value: 'professional',
                              groupValue: selectedOption,
                              onChanged: (String? value) {
                                setState(() {
                                  selectedOption = value ?? '';
                                });
                              },
                            ),
                          ],
                        ),
                ),
              ),
            ),
          ],
        ),
        Align(
          alignment: Alignment.centerRight,
          child: ElevatedButton(
            onPressed: _validateForm('selectOption')
                ? () {
                    _goToStep('buildProfessional');
                  }
                : null,
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.blue,
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(14),
            ),
            child: const Icon(Icons.arrow_forward),
          ),
        )
      ],
    );
  }

  /* professional profile - cnpj */
  Widget _buildFourthStep() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          textAlign: TextAlign.left,
          text: const TextSpan(
            style: TextStyle(
              fontSize: 14,
              color: Colors.black38,
              height: 1.7,
            ),
            children: <TextSpan>[
              TextSpan(
                text: 'Sobre meu Business',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        RichText(
          textAlign: TextAlign.left,
          text: const TextSpan(
            style: TextStyle(
              fontSize: 14,
              color: Colors.black38,
              height: 1.7,
            ),
            children: <TextSpan>[
              TextSpan(
                text: '01 - ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ),
              TextSpan(
                text: "CNPJ\n\n",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
              TextSpan(
                text: "   Precisamos saber um pouco da atuação do seu "
                    "Business. Por medida de segurança, em futuras "
                    "visualizações, o",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
              TextSpan(
                text: " CNPJ será ofuscado.\n",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _cnpjController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: "CNPJ",
          ),
          keyboardType: TextInputType.text,
          enabled: isFieldEnabled,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Informe um CNPJ válido';
            }
            return null;
          },
        ),
        const SizedBox(height: 10),
        ValueListenableBuilder<String>(
          valueListenable: _companyId,
          builder: (context, value, child) {
            return RichText(
              text: TextSpan(
                text: value.isEmpty ? ' \n\n\n' : "$value \n\n\n",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
            );
          },
        ),

        /**/
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: ElevatedButton(
                onPressed: true
                    ? () {
                        _goToStep('buildProfessional');
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue,
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(14),
                ),
                child: const Icon(Icons.arrow_back),
              ),
            ),
            /* const SendButton() */
            ElevatedButton(
              onPressed: _companyIdValid
                  ? () {
                      _goToStep('buildFifthStep');
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue,
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(14),
              ),
              child: const Icon(Icons.arrow_forward),
            )
          ],
        ),
      ],
    );
  }

  /* professional profile - contact name */
  Widget _buildFifthStep() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          textAlign: TextAlign.left,
          text: const TextSpan(
            style: TextStyle(
              fontSize: 14,
              color: Colors.black38,
              height: 1.7,
            ),
            children: <TextSpan>[
              TextSpan(
                text: 'Sobre meu Business',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        RichText(
          textAlign: TextAlign.left,
          text: const TextSpan(
            style: TextStyle(
              fontSize: 14,
              color: Colors.black38,
              height: 1.7,
            ),
            children: <TextSpan>[
              TextSpan(
                text: '02 - ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ),
              TextSpan(
                text: 'O responsável\n\n',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
              TextSpan(
                text: '   A conta ficará associada ao produto/serviço '
                    'informado durante essa configuração. É importante '
                    'perceber como funciona seu empreendimento ',
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
              TextSpan(
                text: '(nome e sobrenome).\n',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.black,
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _contactController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Responsável",
          ),
          enabled: isFieldEnabled,
          keyboardType: TextInputType.text,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Informe um Responsável';
            }
            return null;
          },
        ),
        const SizedBox(height: 10),
        ValueListenableBuilder<String>(
          valueListenable: _contactName,
          builder: (context, value, child) {
            return RichText(
              text: TextSpan(
                text: value.isEmpty ? 'Nome do Contato \n\n' : "$value \n\n\n",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
            );
          },
        ),

        /**/
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: ElevatedButton(
                onPressed: true
                    ? () {
                        _goToStep('buildFourthStep');
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue,
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(14),
                ),
                child: const Icon(Icons.arrow_back),
              ),
            ),
            ElevatedButton(
              onPressed: _contactNameValid
                  ? () {
                      _goToStep('buildSixthStep');
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue,
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(14),
              ),
              child: const Icon(Icons.arrow_forward),
            )
          ],
        ),
        /**/
      ],
    );
  }

  /* professional profile - whatsapp phone contact */
  Widget _buildSixthStep() {
    Future<void> delayedExecution(Function action) async {
      await Future.delayed(const Duration(seconds: 3));
      action();
    }

    Future<void> handleSubmit() async {
      print('\n---> on handleSubmit\n');

      var profileId = await apiService.getProfileId();
      var uniqueId = await apiService.getUniqueId();

      setState(() {
        isLoading = true;
      });

      delayedExecution(() {
        Navigator.of(context).pop(); // Fecha o modal ou formulário
      });

      setState(() {
        isLoading = false;
        isSuccess = true;
        isFieldEnabled = false;
      });

      String capitalizeEachWord(String input) {
        return input.split(' ').map((word) {
          if (word.isNotEmpty) {
            return word[0].toUpperCase() + word.substring(1).toLowerCase();
          }
          return word;
        }).join(' ');
      }

      final Map<String, String> data = {
        'contact_name': capitalizeEachWord(_contactController.value.text),
        'phone_number':
            _phoneController.value.text.replaceAll(RegExp(r'[^a-zA-Z0-9]'), ''),
        'doc': _cnpjController.text.replaceAll(RegExp(r'[^a-zA-Z0-9]'), ''),
        'doc_type': '3',
        'setup': '1',
        'unique_id': uniqueId,
        'profile_id': profileId,
      };
      /*  */

      apiService.createPresence(data).then((result) {
        print(result);
      });

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (context) => const UpdateProfileScreenWidget()),
        result: (Route<dynamic> route) => route.isFirst,
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          textAlign: TextAlign.left,
          text: const TextSpan(
            style: TextStyle(
              fontSize: 14,
              color: Colors.black38,
              height: 1.7,
            ),
            children: <TextSpan>[
              TextSpan(
                text: 'Sobre meu Business',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        RichText(
          textAlign: TextAlign.left,
          text: const TextSpan(
            style: TextStyle(
              fontSize: 14,
              color: Colors.black38,
              height: 1.7,
            ),
            children: <TextSpan>[
              TextSpan(
                text: '03 - Telefone para contato\n\n',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ),
              TextSpan(
                text: '   Whatsapp ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
              TextSpan(
                text: ", para que o Suporte possa contactar o "
                    "responsável pela conta e auxiliar a experiência de "
                    "uso. ",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
              TextSpan(
                text: 'Não compartilhamos dados de empresas.\n',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _phoneController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Telefone",
          ),
          enabled: isFieldEnabled,
          keyboardType: TextInputType.text,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Informe um telefone válido';
            }
            return null;
          },
        ),
        const SizedBox(height: 10),
        ValueListenableBuilder<String>(
          valueListenable: _contactNumber,
          builder: (context, value, child) {
            return RichText(
              text: TextSpan(
                text: value.isEmpty ? " \n\n" : "$value \n\n\n",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
            );
          },
        ),

        /**/
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: ElevatedButton(
                onPressed: true
                    ? () {
                        _goToStep('buildFifthStep');
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue,
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(14),
                ),
                child: const Icon(Icons.arrow_back),
              ),
            ),
            Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed:
                      (_phoneController.value.text.length > 15 && !isLoading) &&
                              !isSuccess
                          ? handleSubmit
                          : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isSuccess ? Colors.green : Colors.blue,
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(8),
                  ),
                  child: isLoading
                      ? const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircularProgressIndicator(
                                strokeWidth: 1, color: Colors.white),
                          ],
                        )
                      : Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                isSuccess ? Icons.check : Icons.save,
                                color: Colors.white,
                                size: 22.0,
                              ),
                            ),
                          ],
                        ),
                ))
          ],
        ),
      ],
    );
  }
}
