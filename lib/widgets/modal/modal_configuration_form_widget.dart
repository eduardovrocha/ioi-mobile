import 'package:flutter/material.dart';
import 'package:mrcatcash/models/profile_data.dart';
import '../content/content_configuration_form_widget.dart';

class ModalConfigurationFormWidget extends StatelessWidget {

  const ModalConfigurationFormWidget({
    super.key, required this.profileData, required this.profilePresences
  });
  
  final ProfileData profileData;
  final List profilePresences;

  static void show(BuildContext context, profileData, profilePresences) {

    print(profilePresences);

    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        return Center(
          child: Material(
            color: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.symmetric(horizontal: 24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
              ),
              child: ContentConfigurationFormWidget(profilePresences)
              /* child: ContentConfigurationFormWidget(profilePresences), */
            ),
          ),
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: animation,
            child: child,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
