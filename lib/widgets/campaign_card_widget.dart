import 'package:flutter/material.dart';
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
                  fontWeight: FontWeight.normal, fontSize: 12),
            ),
            const Divider(thickness: 1.2, height: 20),
            Text(
              'Intervalo:',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.normal, fontSize: 12),
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
                  fontWeight: FontWeight.normal, fontSize: 12),
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
                            fontSize: 12),
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

