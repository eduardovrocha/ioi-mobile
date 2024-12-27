import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mrcatcash/widgets/components/custom_snackbar_widget.dart';

class CampaignCardWidget extends StatefulWidget {
  @override
  _CampaignCardWidgetState createState() => _CampaignCardWidgetState();
}

class _CampaignCardWidgetState extends State<CampaignCardWidget> {
  TextEditingController numericController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  final double maxNumericValue = 1063; // Valor máximo para o campo numérico
  bool isEditMode = true; // Define o estado inicial como "Editar"

  int daysDifference = 0;
  int hoursDifference = 0;
  int minutesDifference = 0;

  void _toggleMode() {
    setState(() {
      isEditMode = !isEditMode; // Alterna entre "Editar" e "Salvar"
    });
  }

  // Método para formatar o número em tempo de execução
  void _formatNumericInput() {
    String input = numericController.text.replaceAll(RegExp(r'\D'), ''); // Remove caracteres não numéricos
    if (input.isEmpty) {
      numericController.value = TextEditingValue(text: '');
      return;
    }

    double value = double.tryParse(input) ?? 0.0;

    // Verificar se o valor é maior que o máximo permitido
    if (value / 100000 > maxNumericValue) {
      value = maxNumericValue * 100000;
    }

    // Formatar o valor para incluir '.' a cada 3 dígitos e com 5 casas decimais
    String formattedValue = NumberFormat.currency(
      locale: 'pt_BR',
      symbol: '',
      decimalDigits: 5,
    ).format(value / 100000);

    numericController.value = TextEditingValue(
      text: formattedValue,
      selection: TextSelection.fromPosition(
        TextPosition(offset: formattedValue.length),
      ),
    );
  }

  Future<void> _selectDateTime(TextEditingController controller, {
    bool isStartDate = false}) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData(
            colorScheme: const ColorScheme.light(
              primary: Colors.amber,
              onPrimary: Colors.black,
              onSurface: Colors.black,
            ),
            dialogBackgroundColor: Colors.white, // Fundo do diálogo.
            textTheme: const TextTheme(
              bodyMedium: TextStyle(color: Colors.black), // Texto geral.
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        DateTime pickedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        // Atualizar o campo de data e validar o intervalo mínimo de 30 dias
        if (isStartDate) {
          // startDateController.text = DateFormat('dd/MM/yyyy HH:mm:ss').format(pickedDateTime);
          startDateController.text = DateFormat('dd/MM/yyyy HH:mm').format(pickedDateTime);
        } else {
          DateTime? startDate = _parseDate(startDateController.text);
          if (startDate != null && pickedDateTime.difference(startDate).inDays < 30) {
            CustomSnackbarWidget.show(context,
                message: 'O intervalo entre as datas deve ser de no mínimo 30'
                    ' dias a partir do início. Intervalos menores de dias não'
                    ' surtem resultados.',
                type: MessageType.info,
                actionLabel: "ok",
                onActionPressed: () {
                  print('oi');
                }
            );
            return;
          }
          // endDateController.text = DateFormat('dd/MM/yyyy HH:mm:ss').format(pickedDateTime);
          endDateController.text = DateFormat('dd/MM/yyyy HH:mm').format(pickedDateTime);
          // _calculateDifference();
        }
      }
    }

    if (pickedDate != null) {
      print("Data selecionada: $pickedDate");
    }
  }

  // Método para selecionar data e hora
  Future<void> _XselectDateTime(TextEditingController controller, {
    bool isStartDate = false}) async {

    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        DateTime selectedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        // Atualizar o campo de data e validar o intervalo mínimo de 30 dias
        if (isStartDate) {
          // startDateController.text = DateFormat('dd/MM/yyyy HH:mm:ss').format(selectedDateTime);
          startDateController.text = DateFormat('dd/MM/yyyy HH:mm').format(selectedDateTime);
        } else {
          DateTime? startDate = _parseDate(startDateController.text);
          if (startDate != null && selectedDateTime.difference(startDate).inDays < 30) {
            CustomSnackbarWidget.show(context,
                message: 'O intervalo entre as datas deve ser de no mínimo 30'
                    ' dias a partir do início. Intervalos menores de dias não'
                    ' surtem resultados.',
                type: MessageType.info,
                actionLabel: "ok",
                onActionPressed: () {
                  print('oi');
                }
            );
            return;
          }
          // endDateController.text = DateFormat('dd/MM/yyyy HH:mm:ss').format(selectedDateTime);
          endDateController.text = DateFormat('dd/MM/yyyy HH:mm').format(selectedDateTime);
          // _calculateDifference();
        }
      }
    }
  }

  DateTime? _parseDate(String date) {
    try {
      return DateFormat('dd/MM/yyyy HH:mm').parse(date);
    } catch (e) {
      return null;
    }
  }

  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  // Método para calcular a diferença de dias, horas e minutos
  void _calculateDifference() {
    DateTime? startDate = _parseDate(startDateController.text);
    DateTime? endDate = _parseDate(endDateController.text);

    if (startDate != null && endDate != null) {
      Duration difference = endDate.difference(startDate);
      setState(() {
        daysDifference = difference.inDays;
        hoursDifference = difference.inHours % 24;
        minutesDifference = difference.inMinutes % 60;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Padding(padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
            Row(
            mainAxisAlignment: MainAxisAlignment.start, // Alinha todos os elementos à esquerda
            children: [
              // Primeiro ícone e texto (Cadeado)
              const Row(
                children: [
                  Icon(
                    Icons.lock,
                    size: 18,
                    color: Colors.grey,
                  ),
                  SizedBox(width: 4), // Espaço entre o ícone e o texto
                  Text(
                    'Bloqueado',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
              const SizedBox(width: 20), // Espaço entre os ícones

              // Segundo ícone e texto (Execução)
              const Row(
                children: [
                  Icon(
                    Icons.play_circle_outline,
                    size: 18,
                    color: Colors.blue,
                  ),
                  SizedBox(width: 4), // Espaço entre o ícone e o texto
                  Text(
                    'Em execução',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
              const Spacer(), // Preenche o espaço restante entre os ícones e o botão

              // Botão "Editar/Salvar"
              ElevatedButton.icon(
                onPressed: _toggleMode, // Alterna o estado ao clicar
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                icon: Icon(
                  isEditMode ? Icons.edit : Icons.save, // Ícone de acordo com o estado
                  size: 18,
                ),
                label: Text(
                  isEditMode ? 'Editar' : 'Salvar', // Texto de acordo com o estado
                  style: const TextStyle(fontSize: 14),
                ),
              ),
            ],
          ),
              const SizedBox(height: 20),

              // Primeira Row
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildRichTextLabel('Tokens a serem distribuidos em #AVE83:'),
                        TextFormField(
                          textAlign: TextAlign.right,
                          controller: numericController,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                            hintText: '0,00000',
                          ),
                          style: TextStyle(fontSize: 14.0),
                          onChanged: (value) => _formatNumericInput(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Segunda Row
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildRichTextLabel('Momento de Início:'),
                        TextFormField(
                          controller: startDateController,
                          readOnly: true,
                          decoration: const InputDecoration(
                            suffixIcon: Icon(Icons.calendar_today),
                          ),
                          style: TextStyle(fontSize: 14.0),
                          onTap: () => _selectDateTime(startDateController, isStartDate: true),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildRichTextLabel('Finaliza em:'),
                        TextFormField(
                          controller: endDateController,
                          readOnly: true,
                          decoration: InputDecoration(
                            suffixIcon: Icon(Icons.calendar_today),
                          ),
                          style: TextStyle(fontSize: 14.0),
                          onTap: () => _selectDateTime(endDateController, isStartDate: false),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Terceira Row
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        // border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildRichTextRow(
                              'Status', 'Ativo',Icons.check_circle
                          ),
                          _buildRichTextRow(
                              'Duração', '30 dias 19 horas e 30 min',
                              Icons.timer_outlined
                          ),
                          _buildRichTextRow(
                              'Início', '00/00 00:00:00', Icons.calendar_today
                          ),
                          _buildRichTextRow(
                              'Finaliza', '00/00 00:00:00', Icons.calendar_today
                          ),
                          _buildRichTextRow(
                              'Perfis', '27', Icons.person
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),)
    );
  }

  // Método para construir RichText para os labels
  Widget _buildRichTextLabel(String text) {
    return RichText(
      text: TextSpan(
        text: text,
        style: TextStyle(fontSize: 14, color: Colors.black),
      ),
    );
  }

  // Método para construir RichText para as chaves e valores
  Widget _buildRichTextRow(String key, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: RichText(
              text: TextSpan(
                text: key,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black),
              ),
            ),
          ),
          Row(
            children: [
              RichText(
                text: TextSpan(
                  text: value,
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
              ),
              const SizedBox(width: 5),
              Icon(icon, size: 16),
            ],
          ),
        ],
      ),
    );
  }
}

/* import 'package:flutter/material.dart';
import 'modal/modal_campaign_form_widget.dart';

class CampaignCardWidget extends StatelessWidget {
  final int tokenMinRange;
  final List<int> intervals;
  final List<String> summaries;

  const CampaignCardWidget({
    Key? key,
    required this.tokenMinRange,
    required this.intervals,
    required this.summaries,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 0,
      margin: const EdgeInsets.all(5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Quantidade de Tokens:',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.normal, fontSize: 14),
                ),
                IconButton(
                  icon: Icon(Icons.edit, color: Colors.blue),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const AlertDialog(
                          contentPadding: EdgeInsets.all(10),
                          content: SizedBox(
                            width: double.maxFinite,
                            child: ModalCampaignFormWidget(),
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              '\$MC3: $tokenMinRange UN',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.normal, fontSize: 14),
            ),
            const Divider(thickness: 1.2, height: 20),
            Text(
              'Intervalo:',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.normal, fontSize: 14),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: intervals
                  .map((interval) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Row(
                        children: [
                          Icon(Icons.schedule,
                              size: 16, color: Colors.grey),
                          const SizedBox(width: 8),
                          Text(
                            '$interval dias',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 7,
                      child: Row(
                        children: [
                          Icon(Icons.calendar_today,
                              size: 16, color: Colors.grey),
                          const SizedBox(width: 8),
                          Text(
                            'Termina em 00/00/0000',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ))
                  .toList(),
            ),
            const Divider(thickness: 1.2, height: 10),
            Text(
              'Resumo:',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.normal, fontSize: 14),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: summaries
                  .map((summary) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    Icon(Icons.note, size: 16, color: Colors.grey),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        summary,
                        style: Theme.of(context).textTheme.titleLarge
                            ?.copyWith(
                            fontWeight: FontWeight.normal,
                            fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
 */
