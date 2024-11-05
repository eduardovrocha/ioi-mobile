import 'package:flutter/material.dart';
import 'package:accordion/accordion.dart';
import 'package:mrcatcash/widgets/campaign_item_widget.dart';

class CampaignListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Accordion(
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
          isOpen: true,
          header: Container(
            child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 15,
                    bottom: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: RichText(
                        textAlign: TextAlign.left,
                        text: const TextSpan(
                          text: 'Campanha Mensal',
                          style: TextStyle(color: Colors.black, fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Expanded(
                      child: RichText(
                        textAlign: TextAlign.right,
                        text: const TextSpan(
                          text: '500 \$MC3',
                          style: TextStyle(color: Colors.black, fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                )
            ),
          ),
          content: const CampaignItemWidget(
            tokenMinRange: 500,
            tokenMaxRange: 2000,
            intervals: [30],
            summaries: ['Texto 01'],
          )
        ),
      ],
    );
  }
}
