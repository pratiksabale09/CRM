import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class PanelWidget extends StatelessWidget {
  final ScrollController controller;
  final PanelController panelController;
  final String data;
  const PanelWidget(
      {Key? key, required this.controller, required this.panelController, required this.data})
      : super(key: key);
  @override
  Widget build(BuildContext context) => ListView(
        padding: EdgeInsets.zero,
        controller: controller,
        children: <Widget>[
          const SizedBox(height: 12),
          buildDragHandle(),
          const SizedBox(height: 18),
         Center(
            child: Text(
              data,
              style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 30),
            ),
          ),
          const SizedBox(height: 36),
          buildAboutText(),
          const SizedBox(height: 24),
        ],
      );

  Widget buildDragHandle() => GestureDetector(
        child: Center(
          child: Container(
            width: 30,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        onTap: togglePanel,
      );

  void togglePanel() => panelController.isPanelOpen
      ? panelController.close()
      : panelController.open();
  Widget buildAboutText() => Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
      );
}
