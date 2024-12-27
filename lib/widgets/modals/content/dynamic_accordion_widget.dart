import 'package:flutter/material.dart';
import 'package:accordion/accordion.dart';

class DynamicAccordion extends StatelessWidget {
  final bool isOpen;
  final Widget header;
  final Widget content;

  DynamicAccordion({
    required this.isOpen,
    required this.header,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    final accordionStyle = getAccordionStyle();

    return Accordion(
      rightIcon: Icon(Icons.arrow_drop_down, color: Colors.black),
      maxOpenSections: accordionStyle['maxOpenSections'],
      headerPadding: accordionStyle['headerPadding'],
      headerBackgroundColor: accordionStyle['headerBackgroundColor'],
      contentBackgroundColor: accordionStyle['contentBackgroundColor'],
      contentBorderColor: accordionStyle['contentBorderColor'],
      contentBorderWidth: accordionStyle['contentBorderWidth'],
      contentBorderRadius: accordionStyle['contentBorderRadius'],
      contentHorizontalPadding: accordionStyle['contentHorizontalPadding'],
      contentVerticalPadding: accordionStyle['contentVerticalPadding'],
      paddingListHorizontal: accordionStyle['paddingListHorizontal'],
      paddingListTop: accordionStyle['paddingListTop'],
      paddingListBottom: accordionStyle['paddingListBottom'],
      headerBorderColorOpened: accordionStyle['headerBorderColorOpened'],
      scaleWhenAnimating: accordionStyle['scaleWhenAnimating'],
      children: [
        AccordionSection(
          isOpen: isOpen, header: header, content: content,
        ),
      ],
    );
  }

  Map<String, dynamic> getAccordionStyle() {
    return {
      'maxOpenSections': 1,
      'headerPadding': EdgeInsets.zero,
      'headerBackgroundColor': const Color(0x22EFEFEF),
      'contentBackgroundColor': Colors.white70,
      'contentBorderColor': Colors.white70,
      'contentBorderWidth': 0.0,
      'contentBorderRadius': 0.0,
      'contentHorizontalPadding': 0.0,
      'contentVerticalPadding': 0.0,
      'paddingListHorizontal': 0.0,
      'paddingListTop': 10.0,
      'paddingListBottom': 10.0,
      'headerBorderColorOpened': Colors.white70,
      'scaleWhenAnimating': false,
    };
  }
}