// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:payflow/modules/home/home_controller.dart';
import 'package:payflow/modules/meus_boletos/meus_boletos_page.dart';
import 'package:payflow/shared/models/user_model.dart';
import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/modules/extract/extract_page.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';

class HomePage extends StatefulWidget {
  final UserModel user;
  const HomePage({Key? key, required this.user}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = HomeControler();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(152),
        child: (Container(
          height: 152,
          color: AppColors.primary,
          child: Padding(
            padding: const EdgeInsets.only(top: 24, left: 10, right: 10),
            child: Center(
              child: ListTile(
                title: Text.rich(
                  TextSpan(
                      text: 'Olá, ',
                      style: TextStyles.titleRegular,
                      children: [
                        TextSpan(
                            text: widget.user.name,
                            style: TextStyles.titleBoldBackground),
                      ]),
                ),
                subtitle: Text('Mantenha suas contas em dia!',
                    style: TextStyles.captionShape),
                trailing: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10),
                    /*   image: const DecorationImage(
                        image: NetworkImage(
                            "https://lh3.googleusercontent.com/a-/AOh14GgxoT4uap7OwTMZrxnX9Ry_qaCnaO4nbq8r2HWxhLY=s96-c")), */
                    image: DecorationImage(
                      image: NetworkImage(widget.user.photoURL!),
                    ),
                  ),
                ),
              ),
            ),
          ),
        )),
      ),
      body: [
        MeusBoletosPage(key: UniqueKey()),
        ExtractPage(key: UniqueKey())
      ][controller.currentPage],
      bottomNavigationBar: SizedBox(
        height: 90,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
                onPressed: () {
                  controller.setPage(0);
                  setState(() {});
                },
                icon: Icon(Icons.home,
                    color: controller.currentPage == 0
                        ? AppColors.primary
                        : AppColors.body)),
            GestureDetector(
              onTap: () async {
                await Navigator.pushNamed(context, '/barcode_scanner');
                setState(() {});
              },
              child: Container(
                  height: 56,
                  width: 56,
                  decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(10)),
                  child: Icon(Icons.add_box_outlined,
                      color: AppColors.background)),
            ),
            IconButton(
                onPressed: () {
                  controller.setPage(1);
                  setState(() {});
                },
                icon: Icon(Icons.description_outlined,
                    color: controller.currentPage == 1
                        ? AppColors.primary
                        : AppColors.body)),
          ],
        ),
      ),
    );
  }
}
