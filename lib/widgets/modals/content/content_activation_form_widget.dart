import 'package:flutter/material.dart';
import 'package:mrcatcash/views/professional_account_view.dart';
import 'package:mrcatcash/widgets/components/custom_snackbar_widget.dart';
import 'package:mrcatcash/widgets/modals/modal_activation_proffesional_account_form_widget.dart';
import '../../../services/api_service.dart';
import '../../update_profile_screen_widget.dart';
import '../../whats_app_support_button_widget.dart';

class ContentActivationFormWidget extends StatefulWidget {
  const ContentActivationFormWidget(this.profilePresences, {super.key});

  final List profilePresences;

  @override
  _ContentActivationFormWidgetState createState() =>
      _ContentActivationFormWidgetState();
}

class _ContentActivationFormWidgetState
    extends State<ContentActivationFormWidget> {

  final ApiService apiService = ApiService();
  final _keyController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late List profilePresences = widget.profilePresences;

  bool isButtonEnabled = false;
  bool _isKeyValid = false;

  bool isFieldEnabled = false;
  bool isFormValid = false;

  bool isLoading = false;
  bool isSuccess = false;
  bool isError = false;

  String currentStep = 'buildActivation';

  String _presence = '';
  String _cnpj = '';

  _checkValidKey() {
    if (_keyController.value.text.length == 64) {
      setState(() {
        _isKeyValid = true;
      });
    } else {
      setState(() {
        _isKeyValid = false;
      });
    }
    return _isKeyValid;
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

  Map<String, dynamic>? activeProfessionalProfile(List<Map<String, dynamic>> array) {
    return array.firstWhere(
          (element) => element['attributes']?['doc_type'] == 'cnpj',
      orElse: () => {},
    );
  }

  String formatCNPJ(String cnpj) {
    // Remove quaisquer caracteres não numéricos, caso existam
    cnpj = cnpj.replaceAll(RegExp(r'[^0-9]'), '');

    // Verifica se o CNPJ tem exatamente 14 dígitos
    if (cnpj.length != 14) {
      throw ArgumentError('O CNPJ deve ter 14 dígitos.');
    }

    // Aplica a formatação
    return '${cnpj.substring(0, 2)}.${cnpj.substring(2, 5)}.${cnpj.substring(5, 8)}/${cnpj.substring(8, 12)}-${cnpj.substring(12, 14)}';
  }

  @override
  void initState() {
    super.initState();
    _keyController.addListener(_checkValidKey);
  }

  @override
  void dispose() {
    _keyController.dispose();
    _keyController.removeListener(_checkValidKey);

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
              /* height size adapted by child height size */
              mainAxisSize: MainAxisSize.min,
              children: [
                if (currentStep == 'buildActivation') _buildActivation()
              ],
            ),
          ),
          Positioned(
            top: -8, right: -14,
            child: IconButton(
              icon: Icon(Icons.close, color: Colors.grey[700]),
              onPressed: () { /* close activation dialog */
                Map<String, dynamic>? result = {"status": "closed"};
                Navigator.of(context).pop(result);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivation() {
    Future<void> handleButtonPress() async {
      setState(() {
        isLoading = true;
        isSuccess = false;
        isError = false;
        isFieldEnabled = false;
      });

      var result = await apiService.updateActivation({"key": _keyController.text});
      await Future.delayed(const Duration(seconds: 1));

      if (result == "success") {
        setState(() {
          isSuccess = true;
          isError = false;
          isLoading = false;
          isFieldEnabled = false;
        });

        await Future.delayed(const Duration(seconds: 1));
        // Navigator.of(context).pop();

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
              builder: (context) => const UpdateProfileScreenWidget(message: {
                "type": "success",
                "message": "Perfil atualizado com sucesso"
              })),
          result: (Route<dynamic> route) => route.isFirst,
        );

      } else {
        setState(() {
          isSuccess = false;
          isError = true;
          isLoading = false;
          isFieldEnabled = true;
        });

        await Future.delayed(const Duration(seconds: 3));
        setState(() {
          isSuccess = false;
          isError = false;
          isLoading = false;
        });
      }
    }

    List<dynamic> data = profilePresences;
    var presence = activeProfessionalProfile(List<Map<String, dynamic>>.from(data));
    String formatedCnpj = formatCNPJ(presence?['attributes']['doc']);

    // Success
    Color successColor = const Color(0xFFE8D662);
    Color errorColor = const Color(0xFFD37373);
    Color infoColor = const Color(0xFFF4D25C);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
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
                      text: 'Ativar Conta',
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
                      text: "Copie a chave recebida durante o contato feito "
                          "com o Suporte, cole no campo logo abaixo:",
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 14, color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _keyController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "chave de ativação",
                ),
                keyboardType: TextInputType.text,
                enabled: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'chave inválida';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),

              Center(
                child: RichText(
                  text: TextSpan(
                    children: [
                      WidgetSpan(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Image.asset(
                            'assets/images/resources-024.png',
                            width: 16, height: 16,
                          ),
                        ),
                      ),
                      TextSpan(
                        text: formatedCnpj,
                        style: const TextStyle(
                          fontSize: 14,
                          color: true ? Colors.grey : Colors.black12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Align(
                alignment: Alignment.centerLeft,
                child: WhatsAppSupportButtonWidget()),
            ElevatedButton(
              onPressed: _isKeyValid ? handleButtonPress : null,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: isSuccess
                    ? successColor
                    : isError
                        ? errorColor
                        : infoColor,
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(14),
              ),
              child: isLoading
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : isSuccess
                      ? const Icon(Icons.check)
                      : isError
                          ? const Icon(Icons.error_outline)
                          : const Icon(Icons.arrow_forward),
            )
          ],
        ),
      ],
    );
  }
}
