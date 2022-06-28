import 'package:flutter/material.dart';
import '/../shared/themes/app_colors.dart';
import '/../shared/themes/app_images.dart';
import '/../shared/themes/app_text_styles.dart';

class SocialLoginButtonVisit extends StatelessWidget {
  final VoidCallback onTap;
  const SocialLoginButtonVisit({Key? key, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          color: AppColors.shape,
          borderRadius: BorderRadius.circular(5),
          border:
              const Border.fromBorderSide(BorderSide(color: AppColors.stroke)),
        ),
        child: Row(
          children: [
            Container(
              height: 56,
              decoration: const BoxDecoration(
                // ignore: unnecessary_const
                border: Border(right: BorderSide(color: AppColors.stroke)),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: Image.asset(AppImages.visit),
              ),
            ),
            Expanded(
              flex: 4,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'Entrar como Visitante',
                  style: TextStyles.buttonGrey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
