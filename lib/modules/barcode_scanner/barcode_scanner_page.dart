import 'package:flutter/material.dart';

import 'barcode_scanner_controller.dart';
import 'barcode_scanner_status.dart';
import '../../shared/themes/app_colors.dart';
import '../../shared/themes/app_text_styles.dart';
import '../../shared/widgets/bottom_sheet/bottom_sheet_widget.dart';
import '../../shared/widgets/set_label_buttons/set_label_buttons.dart';

class BarcodeScannerPage extends StatefulWidget {
  const BarcodeScannerPage({Key? key}) : super(key: key);

  @override
  _BarcodeScannerPageState createState() => _BarcodeScannerPageState();
}

class _BarcodeScannerPageState extends State<BarcodeScannerPage> {
  final controller = BarcodeScannerController();

  @override
  void initState() {
    controller.getAvailableCameras();
    controller.getAvailableCameras();
    controller.statusNotifier.addListener(() {
      if (controller.status.hasBarcode) {
        Navigator.pushReplacementNamed(
          context,
          '/insert_boleto',
          arguments: controller.status.barcode,
        );
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          ValueListenableBuilder<BarcodeScannerStatus>(
            valueListenable: controller.statusNotifier,
            builder: (_, status, __) {
              if (status.showCamera) {
                return Container(
                  child: controller.cameraController!.buildPreview(),
                );
              } else {
                return Container();
              }
            },
          ),
          RotatedBox(
            quarterTurns: 1,
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                backgroundColor: Colors.black,
                centerTitle: true,
                title: Text(
                  'Escaneie o código de barras do boleto',
                  style: TextStyles.buttonBackground,
                ),
                leading: BackButton(color: AppColors.background),
              ),
              body: Column(
                children: [
                  Expanded(
                    child: Container(
                        color: Colors.white30 /* .withOpacity(0.8) */),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(color: Colors.transparent),
                  ),
                  Expanded(
                    child: Container(
                        color: Colors.white30 /* .withOpacity(0.8) */),
                  )
                ],
              ),
              bottomNavigationBar: SetLabelButtons(
                labelPrimary: 'Inserir códgio do boleto',
                onTapPrimary: () {
                  Navigator.pushReplacementNamed(context, "/insert_boleto");
                },
                labelSecondary: 'Adicionar boleto da galeria',
                onTapSecondary: controller.scanWithImagePicker,
              ),
            ),
          ),
          ValueListenableBuilder<BarcodeScannerStatus>(
            valueListenable: controller.statusNotifier,
            builder: (_, status, __) {
              if (status.hasError) {
                return Align(
                  alignment: Alignment.bottomLeft,
                  child: BottomSheetWidget(
                    title: 'Não foi identificado o código de barras.',
                    subtitle:
                        'Tente escanear novamente o código ou digite o código do seu boleto.',
                    labelPrimary: 'Escanear novamente',
                    onTapPrimary: () {
                      controller.scanWithCamera();
                    },
                    labelSecondary: 'Digitar código',
                    onTapSecondary: () {
                      Navigator.pushReplacementNamed(context, "/insert_boleto");
                    },
                  ),
                );
              } else {
                return Container();
              }
            },
          ),
        ],
      ),
    );
  }
}
