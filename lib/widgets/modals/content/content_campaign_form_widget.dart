import 'package:flutter/material.dart';
import 'package:accordion/accordion.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:intl/intl.dart';

import '../../../services/api_service.dart';

class ContentCampaignFormWidget extends StatefulWidget {
  const ContentCampaignFormWidget({Key? key}) : super(key: key);

  @override
  _ContentCampaignFormState createState() => _ContentCampaignFormState();
}

class _ContentCampaignFormState extends State<ContentCampaignFormWidget> {
  final _formKey = GlobalKey<FormState>();
  final ApiService apiService = ApiService();

  final _nameController = TextEditingController();
  final _daysController = TextEditingController();
  final _allocatedController = TextEditingController();
  /* final _allocatedController = MaskedTextController(mask: '000.000.000,00000'); */

  final int decimalPlaces = 5;

  final ValueNotifier<String> _campaignName = ValueNotifier<String>('Nome da Campanha');
  final ValueNotifier<String> _campaignAllocated = ValueNotifier<String>('0');
  final ValueNotifier<String> _campaignDays = ValueNotifier<String>('00');

  int tokenAmount = 0;
  int currentStep = 1;

  String selectedInterval = '30 dias';
  List<String> intervals = ['30 dias', '45 dias', '60 dias'];

  String campaignName = '';
  bool agreeToCreateCampaign = false;
  bool isFirstStep = true;

  void _nextStep() {
    if (currentStep < 4) {
      setState(() {
        currentStep++;
      });
    }
  }
  void _previousStep() {
    if (currentStep > 1) {
      setState(() {
        currentStep--;
      });
    }
  }

  void _saveCampaign() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Campanha salva com sucesso!')),
      );
      Navigator.of(context).pop();
    }
  }

  void _formatInput() {
    // Remove todos os caracteres não numéricos para formatar
    String text = _allocatedController.text.replaceAll(RegExp(r'[^0-9]'), '');

    if (text.isEmpty) {
      _allocatedController.value = TextEditingValue(text: '');
      return;
    }

    // Separa inteiros e decimais
    final intPart = text.length > 5 ? text.substring(0, text.length - 5) : '0';
    final decimalPart = text.substring(text.length - 5);

    // Formata os inteiros com separador de milhar
    final formattedInt = NumberFormat('#,###').format(int.parse(intPart));

    // Junta a parte inteira e decimal com vírgula
    final newText = '$formattedInt,$decimalPart';

    _allocatedController.value = TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }

  @override
  void initState() {
    super.initState();
    /* _allocatedController.addListener(_formatInput); */
  }

  @override
  void dispose() {
    /* _allocatedController.removeListener(_formatInput); */

    _allocatedController.dispose();
    _nameController.dispose();
    _campaignAllocated.dispose();

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
              mainAxisSize: MainAxisSize.min, // Adapta o tamanho vertical ao conteúdo
              children: [
                if (currentStep == 1) _buildFirstStep(),
                if (currentStep == 2) _buildSecondStep(),
                if (currentStep == 3) _buildThirdStep(),
                if (currentStep == 4) _buildFourthStep(),
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

  Widget _buildFirstStep() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          textAlign: TextAlign.left,
          text: const TextSpan(
            style: TextStyle(
              fontSize: 15,
              color: Colors.black38,
              height: 1.7,
            ),
            children: <TextSpan>[
              TextSpan(
                text: 'Criar Campanha',
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
          paddingListHorizontal: 0,
          paddingListTop: 10,
          paddingListBottom: 10,
          headerBorderColorOpened: Colors.white70,
          scaleWhenAnimating: false,
          children: [
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
                              text: "O que é uma Campanha de Pontos ?",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
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
                            fontSize: 15,
                            color: Colors.black38,
                            height: 1.7,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text:
                                  "- Semelhante às milhas de viagem, uma Campanha de Pontos "
                                  "recompensa seus clientes com Criptomoedas, "
                                      "um ativo que possui valor de mercado.",
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
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
                              text: "Como ela promove meu negócio ?",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
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
                              fontSize: 15,
                              color: Colors.black38,
                              height: 1.7,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text:
                                    "- A Campanha pode aumentar o "
                                        "engajamento do cliente ao "
                                        "fidelizá-lo, e dispertar o interesse"
                                        " de novos visitantes. A criptomoeda "
                                    "oferece uma forma 'exclusiva' de incentiver "
                                    "o relacionamento dos adeptos a sua marca.",
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ))
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
                              text: "Quanto me custa cada Campanha ?",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
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
                              fontSize: 15,
                              color: Colors.black38,
                              height: 1.7,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text:
                                    "- A quantidade mínima de ",
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
                                ),
                              ),
                              TextSpan(
                                text:
                                    "tokens ou moedas \$MC3 ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              TextSpan(
                                text:
                                    "para criar uma Campanha são 500 unidade. "
                                    "Convertido em valores, algo próximo de R"
                                        "\$ 50,00.",
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ))
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),

        const Divider(thickness: 1.2, height: 20),
        const SizedBox(height: 8),
        CheckboxListTile(
          title: const Text(
              'Ok.',
              style: TextStyle(
            fontSize: 15,
            color: Colors.black,
            height: 1.7,
          )),
          value: agreeToCreateCampaign,
          onChanged: (value) {
            setState(() {
              agreeToCreateCampaign = value ?? false;
            });
          },
        ),
        const SizedBox(height: 8),
        const Divider(thickness: 1.2, height: 20),

        /**/
        Align(
          alignment: Alignment.centerRight,
          child: ElevatedButton(
            onPressed: agreeToCreateCampaign ? _nextStep : null,
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.blue,
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(16),
            ),
            child: const Icon(Icons.arrow_forward),
          ),
        )
      ],
    );
  }

  Widget _buildSecondStep() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          textAlign: TextAlign.left,
          text: const TextSpan(
            style: TextStyle(
              fontSize: 15,
              color: Colors.black38,
              height: 1.7,
            ),
            children: <TextSpan>[
              TextSpan(
                text: 'Criar Campanha',
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
              fontSize: 15,
              color: Colors.black38,
              height: 1.7,
            ),
            children: <TextSpan>[
              TextSpan(
                text: '01 - ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.black87,
                ),
              ),
              TextSpan(
                text:
                    "Escolha a quantidade de \$MC3 disponíveis da sua carteira "
                        "que deseja utilizar na campanha. É preciso ter saldo"
                        " suficiente para a operação.",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _allocatedController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Quantidade de Tokens \$MC3",
          ),
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          onChanged: (value) {
            setState(() {
              tokenAmount = int.tryParse(value) ?? 0;
            });
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Informe uma quantidade válida';
            }
            return null;
          },
        ),
        const SizedBox(height: 10),
        ValueListenableBuilder<String>(
          builder: (context, value, child) {
            return RichText(
              text: TextSpan(
                text: value.isEmpty ? '' : value,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
            );
          },
          valueListenable: _campaignAllocated,
        ),
        const Divider(thickness: 1.2, height: 20),

        /**/
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: ElevatedButton(
                onPressed: _previousStep,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue,
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(16),
                ),
                child: const Icon(Icons.arrow_back),
              ),
            ),
            /* const SendButton() */
            ElevatedButton(
              onPressed: _nextStep,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue,
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(16),
              ),
              child: const Icon(Icons.arrow_forward),
            )
          ],
        ),
      ],
    );
  }

  Widget _buildThirdStep() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          textAlign: TextAlign.left,
          text: const TextSpan(
            style: TextStyle(
              fontSize: 15,
              color: Colors.black38,
              height: 1.7,
            ),
            children: <TextSpan>[
              TextSpan(
                text: 'Criar Campanha',
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
              fontSize: 15,
              color: Colors.black38,
              height: 1.7,
            ),
            children: <TextSpan>[
              TextSpan(
                text: '02 - ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.black87,
                ),
              ),
              TextSpan(
                text: 'Estabeleça a duração da campanha. ',
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
              TextSpan(
                text: 'Este será o período em que os \$MC3 serão '
                    'distribuídos entre os clientes atuais e novos que '
                    'participaram no período',
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        DropdownButtonFormField<String>(
          value: selectedInterval,
          items: intervals
              .map((interval) => DropdownMenuItem(
                    value: interval,
                    child: Text(interval),
                  ))
              .toList(),
          onChanged: (value) {
            setState(() {
              selectedInterval = value!;
            });
          },
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 8),
        RichText(
          textAlign: TextAlign.left,
          text: const TextSpan(
            style: TextStyle(
              fontSize: 15,
              color: Colors.black38,
              height: 1.7,
            ),
            children: <TextSpan>[
              TextSpan(
                text: 'Termina em 00/00/0000',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
        const Divider(thickness: 1.2, height: 20),

        /**/
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: ElevatedButton(
                onPressed: _previousStep,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue,
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(16),
                ),
                child: const Icon(Icons.arrow_back),
              ),
            ),
            ElevatedButton(
              onPressed: _nextStep,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue,
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(16),
              ),
              child: const Icon(Icons.arrow_forward),
            )
          ],
        ),
        /**/
      ],
    );
  }

  Widget _buildFourthStep() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          textAlign: TextAlign.left,
          text: const TextSpan(
            style: TextStyle(
              fontSize: 15,
              color: Colors.black38,
              height: 1.7,
            ),
            children: <TextSpan>[
              TextSpan(
                text: 'Criar Campanha',
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
              fontSize: 15,
              color: Colors.black38,
              height: 1.7,
            ),
            children: <TextSpan>[
              TextSpan(
                text: '03 - ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.black87,
                ),
              ),
              TextSpan(
                text: 'Defina o nome para a Campanha, ela já possui um '
                    'númerdo de identificação único ',
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
              TextSpan(
                text: "#AG23489B490O",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
              TextSpan(
                text: '. Apesar disso, escolha um nome ',
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Nome da Campanha",
          ),
          onChanged: (value) {
            /* setState(() {
              campaignName = value;
            }); */
          },
        ),
        const SizedBox(height: 8),
        RichText(
          textAlign: TextAlign.left,
          text: const TextSpan(
            style: TextStyle(
              fontSize: 15,
              color: Colors.black38,
              height: 1.7,
            ),
            children: <TextSpan>[
              TextSpan(
                text: 'Termina em 00/00/0000',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
        const Divider(thickness: 1.2, height: 20),

        /**/
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: ElevatedButton(
                onPressed: _previousStep,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue,
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(16),
                ),
                child: const Icon(Icons.arrow_back),
              ),
            ),
            const SendButton()
          ],
        ),
      ],
    );
  }
}

/* sendButton */

class SendButton extends StatefulWidget {
  const SendButton({super.key});

  @override
  _SendButtonState createState() => _SendButtonState();
}

class _SendButtonState extends State<SendButton> {
  bool isSending = false;
  bool isSuccess = false;

  void _handleSend() async {
    setState(() {
      isSending = true;
      isSuccess = false;
    });

    // Simula um request assíncrono
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      isSending = false;
      isSuccess = true;
    });

    // Retorna ao estado inicial após 2 segundos
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      isSuccess = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ElevatedButton(
        onPressed: isSending ? null : _handleSend,
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.blue,
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(16),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(isSuccess ? Icons.check : Icons.save),
          ],
        ),
      ),
    );
  }
}
