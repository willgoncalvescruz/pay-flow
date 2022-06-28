import 'package:flutter/material.dart';

import 'package:animated_card/animated_card.dart';

import '../../shared/models/boleto_model.dart';
import '../../shared/themes/app_colors.dart';
import '../../shared/themes/app_text_styles.dart';
import '../../shared/widgets/boleto_list/boleto_list_controller.dart';
import '../../shared/widgets/boleto_list/boleto_list_widget.dart';
import '../../shared/widgets/boleto_info/boleto_info_widget.dart';

class MeusBoletosPage extends StatefulWidget {
  const MeusBoletosPage({Key? key}) : super(key: key);

  @override
  State<MeusBoletosPage> createState() => _MeusBoletosPageState();
}

class _MeusBoletosPageState extends State<MeusBoletosPage> {
  final controller = BoletoListController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 80,
            child: Stack(
              children: [
                Container(
                  color: AppColors.primary,
                  height: 40,
                  width: double.maxFinite,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: ValueListenableBuilder<List<BoletoModel>>(
                    valueListenable: controller.boletosNotifier,
                    builder: (_, boletos, __) => AnimatedCard(
                      direction: AnimatedCardDirection.top,
                      child: BoletoInfoWidget(
                        size: boletos.length,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 25,
            ),
            child: Row(
              children: [
                Text('Meus Boletos', style: TextStyles.titleBoldHeading),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Divider(color: AppColors.stroke),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: BoletoListWidget(controller: controller),
          )
        ],
      ),
    );
  }
}
