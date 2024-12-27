import 'package:flutter/material.dart';
import 'package:mrcatcash/widgets/sections/section_collect_widget.dart';
import 'package:mrcatcash/widgets/sections/section_coming_bind_widget.dart';
import 'package:mrcatcash/widgets/sections/section_professional_profile_widget.dart';
import 'package:mrcatcash/widgets/sections/section_received_note_widget.dart';
import '../components/copyable_wallet_number_widget.dart';

class SectionAreaPanelWidget extends StatefulWidget {
  final String uniqueId;
  final String viewNameFor;

  const SectionAreaPanelWidget({
    Key? key, required this.uniqueId, required this.viewNameFor
  }) :super(key: key);

  @override
  _SectionAreaPanelWidgetState createState() => _SectionAreaPanelWidgetState();
}

class _SectionAreaPanelWidgetState extends State<SectionAreaPanelWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String uniqueId = widget.uniqueId;
    String viewName = widget.viewNameFor;

    return Container(
      margin: const EdgeInsets.only(top: 15, bottom: 15),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(5),
            child: CopyableWalletNumberWidget(
                uniqueId: uniqueId
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(5),
              child: (viewName == 'received_note')
                  ? const SectionReceivedNoteWidget()
                  : (viewName == 'coming_bind')
                      ? const SectionComingBindWidget()
                      : (viewName == 'professional_account')
                          ? const SectionProfessionalProfileWidget()
                          : const SectionCollectWidget()
          )
        ],
      ),
    );
  }
}