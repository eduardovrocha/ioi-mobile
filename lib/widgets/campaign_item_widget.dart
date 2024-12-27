import 'package:flutter/material.dart';

class CampaignItemWidget extends StatelessWidget {
  final int tokenMinRange;
  final int tokenMaxRange;
  final List<int> intervals;
  final List<String> summaries;

  const CampaignItemWidget({
    Key? key,
    this.tokenMinRange = 500,
    this.tokenMaxRange = 2000,
    this.intervals = const [30, 45, 50],
    this.summaries = const ['Texto 01', 'Texto 02', 'Texto 03'],
  }) : super(key: key);

  String formatDuration(int totalSeconds) {
    Duration duration = Duration(seconds: totalSeconds);

    int days = duration.inDays;
    int hours = duration.inHours.remainder(24);
    int minutes = duration.inMinutes.remainder(60);
    int seconds = duration.inSeconds.remainder(60);

    return '${days}d ${hours}h:${minutes}m:${seconds}s';
  }

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
        padding:
            const EdgeInsets.only(top: 15, bottom: 10, left: 10, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Color(0xFFFBF8BA), // Define o fundo amarelo
                borderRadius: BorderRadius.circular(6), // Define o raio dos

                // cantos arredondados
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 5, bottom: 5, left: 15, right: 15),
                child: Text(
                  'Quantidade de Tokens',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              '\$MC3: $tokenMinRange UN',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.w600, fontSize: 14),
            ),
            /**/

            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: Color(0xFFFBF8BA), // Define o fundo amarelo
                borderRadius: BorderRadius.circular(6), // Define o raio dos

                // cantos arredondados
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 5, bottom: 5, left: 15, right: 15),
                child: Text(
                  'Intervalo',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: intervals
                  .map((interval) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          children: [
                            // Primeiro item: intervalo (30% do espaço)
                            Expanded(
                              flex: 3,
                              child: Row(
                                children: [
                                  Icon(Icons.schedule,
                                      size: 16, color: Colors.grey),
                                  const SizedBox(width: 8),
                                  Text('$interval dias',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge
                                          ?.copyWith(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14,
                                          )),
                                ],
                              ),
                            ),
                            // Segundo item: data (70% do espaço)
                            Expanded(
                              flex: 7,
                              child: Row(
                                children: [
                                  Icon(Icons.calendar_today,
                                      size: 16, color: Colors.grey),
                                  const SizedBox(width: 8),
                                  Text('Termina em 00/00/0000',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge
                                          ?.copyWith(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14,
                                          )),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ))
                  .toList(),
            ),
            /**/

            const SizedBox(height: 20),
            Container(
                decoration: BoxDecoration(
                  color: Color(0xFFFBF8BA), // Define o fundo amarelo
                  borderRadius: BorderRadius.circular(6), // Define o raio dos

                  // cantos arredondados
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 5, bottom: 5, left: 15, right: 15),
                  child: Text(
                    'Resumo',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                  ),
                )),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: Colors.white, // Define o fundo amarelo
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Padding(
                padding:
                    EdgeInsets.only(top: 5, bottom: 5, left: 15, right: 15),
                child: Row(
                  /* Distribui o espaço igualmente entre os itens */
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Column(
                        children: [
                          Icon(
                            Icons.check_circle,
                            size: 32,
                            color: Colors.black45,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'Status',
                            style: TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Column(
                        children: [
                          Icon(
                            Icons.access_time,
                            size: 32,
                            color: Colors.black45,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            '5d 8h:45m:27s',
                            style: TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Column(
                        children: [
                          Icon(
                            Icons.people,
                            size: 32,
                            color: Colors.black45,
                          ),
                          const SizedBox(height: 5), // Espaço entre o ícone e o texto
                          Text(
                            '27 perfis',
                            style: TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )

            /* Column(
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
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.normal, fontSize: 15
                        ),
                      ),
                    ),
                  ],
                ),
              ))
                  .toList(),
            ) */
          ],
        ),
      ),
    );
  }
}
