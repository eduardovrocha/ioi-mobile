import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:accordion/accordion.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:mrcatcash/widgets/components/badges_component.dart';
import 'package:mrcatcash/widgets/modals/content/dynamic_accordion_widget.dart';

import '../../../main.dart';
import '../../../services/api_service.dart';
import '../../update_profile_screen_widget.dart';

class ContentConfigurationFormWidget extends StatefulWidget {
  const ContentConfigurationFormWidget({super.key});

  @override
  _ContentConfigurationFormWidgetState createState() =>
      _ContentConfigurationFormWidgetState();
}

class _ContentConfigurationFormWidgetState
    extends State<ContentConfigurationFormWidget> {
  final apiService = ApiService();
  final _contactController = TextEditingController();
  final _cnpjController = MaskedTextController(mask: '00.000.000/0000-00');
  final _phoneController = MaskedTextController(mask: '(00) 0 0000-0000');

  final ValueNotifier<String> _contactName =
      ValueNotifier<String>('Nome do Contato');
  final ValueNotifier<String> _contactNumber =
      ValueNotifier<String>('(00) 0 0000-0000');
  final ValueNotifier<String> _companyId =
      ValueNotifier<String>('00.000.000/0000-00');

  final _formKey = GlobalKey<FormState>();

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
    }
  }

  String selectedOption = 'professional';
  String currentStep = 'buildFirstStep';

  bool isButtonEnabled = false;

  bool _cnpj = false;
  bool _driveLicense = false;
  bool _cpf = false;
  bool _passport = false;

  bool _companyIdValid = false;
  bool _contactNameValid = false;
  bool _contactNumberValid = false;

  bool isFieldEnabled = true;
  bool isFormValid = false;

  bool isLoading = false;
  bool isSuccess = false;
  bool isError = false;

  bool isProfessionalPresenceActivated = false;
  bool isPersonalPresenceActivated = false;

  void _goToStep(String goToStep) {
    if (currentStep != null) {
      setState(() {
        currentStep = goToStep;
      });
    }
    ;
  }

  // precisa ser revisto
  /* function definition
  name: 'checkCNPJ'
  description: 'verify if presences has professional id'
  signature:
  return: boolean
  */
  void checkCNPJ() async {
    var getCNPJ = await apiService.profileGotPresence('cnpj');

    if (getCNPJ == null) {
      _cnpj = false;
    } else {
      _cnpj = true;
    }

    setState(() {});
  }

  /* function definition
  name: 'checkPassport'
  description: 'verify if presences has personal id'
  signature:
  return: boolean
  */
  void checkPassport() async {
    var getPassport = await apiService.profileGotPresence('passport');
    if (getPassport == null) {
      _passport = false;

      setState(() {});
    }
  }

  /* function definition
  name: 'checkDriveLicense'
  description: 'verify if presences has personal id'
  signature:
  return: boolean
  */
  void checkDriveLicense() async {
    var getDriveLicense = await apiService.profileGotPresence('drive_license');
    if (getDriveLicense == null) {
      _driveLicense = false;

      setState(() {}); // Update the UI if this is in a StatefulWidget
    }
  }

  /* function definition
  name: 'checkCPF'
  description: 'verify if presences has personal id'
  signature:
  return: boolean
  */
  void checkCPF() async {
    var getCPF = await apiService.profileGotPresence('cpf');
    if (getCPF == null) {
      _cpf = false;

      setState(() {}); // Update the UI if this is in a StatefulWidget
    }
  }

  // até aqui

  Future<Map<String, dynamic>> handleProfessionalPresence() async {
    var pres = await fetchPresence('cnpj').then((value) {
      if (value != null) {
        isProfessionalPresenceActivated = true;
      }

      return value;
    });

    return {
      'contact': '${pres?['contact']}', 'phone': '${pres?['phone']}',
      'setup': '${pres?['setup']}', 'doc': '${pres?['doc']}',
      'created': '${pres?['created_at']}'
    };
  }

  Future<Map<String, dynamic>> handlePersonalPresence() async {
    var cpf = await fetchPresence('cpf');
    var passport = await fetchPresence('passport');
    var cnh = await fetchPresence('cnh');

    var presence = (cpf == null)
        ? passport
        : (cnh != null)
            ? cnh
            : cpf;

    return {
      'contact': '${presence?['contact']}',
      'phone': '${presence?['phone']}',
      'setup': '${presence?['setup']}',
      'doc': '${presence?['doc']}',
      'created': '${presence?['created_at']}'
    };
  }

  /* function definition
  name: 'isValidCNPJ'
  description: 'verify consistency for "CNPJ" field'
  signature:
  return: boolean
  */
  void isValidCNPJ() {
    var cnpj = _cnpjController.value.text;
    cnpj = cnpj.replaceAll(RegExp(r'[^0-9]'), '');
    if (cnpj.length != 14) {
      setState(() {
        _companyIdValid = false;
      });
    }

    if (RegExp(r'^(\d)\1*$').hasMatch(cnpj)) {
      setState(() {
        _companyIdValid = false;
      });
    }

    int calcVerifierDigit(String cnpj, int endPosition) {
      const weights = [6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2];
      int sum = 0;

      for (int i = 0; i < endPosition; i++) {
        sum += int.parse(cnpj[i]) * weights[i + (weights.length - endPosition)];
      }

      int remainder = sum % 11;
      return (remainder < 2) ? 0 : 11 - remainder;
    }

    int firstVerifierDigit = calcVerifierDigit(cnpj, 12);
    int secondVerifierDigit = calcVerifierDigit(cnpj, 13);

    setState(() {
      _companyIdValid = firstVerifierDigit == int.parse(cnpj[12]) &&
          secondVerifierDigit == int.parse(cnpj[13]);
    });
  }

  void updateControllers() async {
    final professionalPresence = await fetchPresence('cnpj');
    if (professionalPresence != null) {
      _cnpjController.text = professionalPresence['doc'] ?? '';
      _phoneController.text = professionalPresence['phone'] ?? '';
    } else {
      _cnpjController.text = '';
      _phoneController.text = '';
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

  Future<Map<String, dynamic>?> fetchPresence(String docType) async {
    var profilePresences = await apiService.fetchPresences();
    var presenceByDocument = extractInfo(profilePresences['data'], docType);

    return presenceByDocument;
  }

  Map<String, dynamic>? extractInfo(List<dynamic> array, String docType) {
    for (var element in array) {
      if (element is Map<String, dynamic> &&
          element['attributes'] is Map<String, dynamic> &&
          element['attributes']['doc_type'] == docType) {
        return element['attributes'] as Map<String, dynamic>;
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

    _cnpjController.addListener(isValidCNPJ);
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

    selectedOption = 'professional';

    /* precisa ser revisto */
    checkCNPJ();
    checkPassport();
    checkDriveLicense();
    checkCPF();
    /* precisa ser revisto */
  }

  @override
  void dispose() {
    _cnpjController.dispose();
    _contactController.dispose();
    _phoneController.dispose();

    _contactName.dispose();
    _contactNumber.dispose();
    _companyId.dispose();

    _cnpjController.removeListener(isValidCNPJ);
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
              children: [
                if (currentStep == 'buildFirstStep') _buildFirstStep(),
                if (currentStep == 'buildPersonal') _buildPersonalContent(),
                if (currentStep == 'buildProfessional')
                  _buildProfessionalContent(),
                if (currentStep == 'buildFourthStep')
                  _professionalProfileCompanyDoc(),
                if (currentStep == 'buildFifthStep')
                  _professionalProfileContact(),
                if (currentStep == 'buildSixthStep')
                  _professionalContactPhone(),
              ],
            ),
          ),
          Positioned(
            top: -8,
            right: -14,
            child: IconButton(
              icon: Icon(Icons.close, color: Colors.grey[700]),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfessionalContent() {
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
                    backgroundColor: Colors.blue.shade200,
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(14),
                  ),
                  child: const Icon(Icons.arrow_back),
                ),
              ),
              ElevatedButton(
                onPressed: !isProfessionalPresenceActivated ? () {
                        _goToStep('buildFourthStep');
                      } : null,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue.shade200,
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(14),
                ),
                child: const Icon(Icons.arrow_forward),
              )
            ],
          ),
        ]);
  }

  Widget _buildPersonalContent() {
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
          // const Spacer(),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: ElevatedButton(
                  onPressed: null,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue.shade200,
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(14),
                  ),
                  child: const Icon(Icons.arrow_back),
                ),
              ),
              ElevatedButton(
                onPressed: !isProfessionalPresenceActivated
                    ? () {
                        _goToStep('buildFourthStep');
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue.shade200,
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(14),
                ),
                child: const Icon(Icons.arrow_forward),
              )
            ],
          ),
        ]);
  }

  Widget _buildFirstStep() {
    bool isDisabled = true;

    /* var professionalPresence = handleProfessionalPresence();
    var personalPresence = handlePersonalPresence(); */

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: RichText(
                textAlign: TextAlign.left,
                text: const TextSpan(
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black38,
                    height: 1.7,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Configurar meu Aplicativo ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 8),
          ],
        ),
        DynamicAccordion(
          isOpen: true,
          header: Container(
            width: double.infinity, margin: EdgeInsets.zero,
            padding: const EdgeInsets.only(
                left: 15, right: 0, top: 15, bottom: 15
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: RichText(
                            text: const TextSpan(
                              text: 'Modo Comercial',
                              style: TextStyle(
                                  color: Colors.black, fontSize: 14,
                                  fontWeight: FontWeight.bold
                              ),
                            ))),
                    const BadgesComponent(status: 'success', label: 'ativo'),
                  ],
                )
            ),
          ),
          content: Padding(
            padding: const EdgeInsets.all(10.0),
            child: FutureBuilder<Map<String, dynamic>>(
              future: handleProfessionalPresence(),
              builder: (context, snapshot) {
                /* isProfessionalPresenceActivated
                        ? Column(
                      children: [
                        Row(
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
                                text: const TextSpan(
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                      fontSize: 14,
                                      height: 1.7),
                                  children: [
                                    TextSpan(
                                      // text: '$formatedContact\n',
                                      text: '',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      // text: '$formatedPhone\n',
                                      text: '',
                                    ),
                                    TextSpan(
                                      // text: '$formatedCNPJ\n',
                                      text: '',
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
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
                          title: const Text(
                            'Modo Comercial',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          value: 'professional',
                          groupValue: selectedOption,
                          onChanged: isProfessionalPresenceActivated
                              ? null
                              : (String? value) {
                            setState(() {
                              selectedOption = value ?? '';
                            });
                          },
                        )
                      ],
                    ), */
                var presenceLoaded = snapshot;
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasData) {

                  print('!!! --> ');
                  print(snapshot.data);
                  print('!!! --> ');

                  if (isProfessionalPresenceActivated) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/images/resources-022.png',
                          width: 50, height: 50,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              style: const TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black, fontSize: 14, height: 1.7
                              ),
                              children: [
                                TextSpan(
                                  text: '${presenceLoaded.data?['contact']}\n',
                                ),
                                TextSpan(
                                  text: 'Contato: ${presenceLoaded.data?['phone']}\n',
                                ),
                                TextSpan(
                                  text: 'ID N#: ${presenceLoaded.data?['doc']}\n',
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Column(
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
                          title: const Text(
                            'Modo Comercial', style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold,
                          ),
                          ), value: 'professional',
                          groupValue: selectedOption,
                          onChanged: isProfessionalPresenceActivated ? null : (String? value) {
                            setState(() {
                              selectedOption = value ?? '';
                            });
                          },
                        )
                      ],
                    );
                  }
                } else {
                  return Row();
                }
              },
            ),
          ),
        ),
        DynamicAccordion(
          isOpen: true,
          header: Container(
          width: double.infinity,
          margin: EdgeInsets.zero,
          padding: const EdgeInsets.only(
              left: 15, right: 0, top: 15, bottom: 15
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: RichText(text: const TextSpan(
                        text: 'Modo Pessoal',
                        style: TextStyle(
                            color: Colors.black, fontSize: 14,
                            fontWeight: FontWeight.bold
                        ),
                      ))
                  ),
                  const BadgesComponent(
                      status: 'inactive', label: 'desativado'
                  ),
                ],
              )),
        ),
          content: Padding(
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
                    ? null : (String? value) {
                  setState(() {
                    selectedOption = value ?? '';
                  });
                },
              ),
            ]),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: ElevatedButton(
            onPressed: !isProfessionalPresenceActivated
                ? _validateForm('selectOption')
                ? () {_goToStep('buildProfessional');
            } : null : null,
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.blue.shade200,
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(14),
            ),
            child: const Icon(Icons.arrow_forward),
          ),
        )
      ],
    );
  }

  Widget _professionalProfileCompanyDoc() {
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
                  backgroundColor: Colors.blue.shade200,
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(14),
                ),
                child: const Icon(Icons.arrow_back),
              ),
            ),
            /* const SendButton() */
            ElevatedButton(
              onPressed: (_companyIdValid && !isProfessionalPresenceActivated)
                  ? () {
                      _goToStep('buildFifthStep');
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue.shade200,
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

  Widget _professionalProfileContact() {
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
                  backgroundColor: Colors.blue.shade200,
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
                backgroundColor: Colors.blue.shade200,
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

  Widget _professionalContactPhone() {
    Future<void> delayedExecution(Function action) async {
      await Future.delayed(const Duration(seconds: 3));
      /* action(); */
    }

    cleanPhone(String phoneNumber) {
      return _phoneController.value.text
          .replaceAll(RegExp(r'[^a-zA-Z0-9]'), '');
    }

    ;
    cleanCnpj(String cnpj) {
      return _cnpjController.text.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '');
    }

    ;
    Future<void> handleSubmit() async {
      setState(() {
        isLoading = true;
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
        'phone_number': cleanPhone(_cnpjController.text),
        'doc': cleanCnpj(_cnpjController.text),
        'doc_type': '3',
        'setup': '1',
      };

      apiService.createPresence(data).then((result) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
              builder: (context) => const UpdateProfileScreenWidget(message: {
                    "type": "success",
                    "message": "perfil atualizado com sucesso"
                  })),
          result: (Route<dynamic> route) => route.isFirst,
        );
      });
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
                  backgroundColor: Colors.blue.shade200,
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
                    backgroundColor: isSuccess ? Colors.green : Colors.blue.shade200,
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
