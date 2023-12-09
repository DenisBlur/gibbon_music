
import 'package:flutter/material.dart';
import 'package:gibbon_music/constants/app_consts.dart';
import 'package:gibbon_music/domain/models/data_model.dart';
import 'package:gibbon_music/main.dart';
import 'package:gibbon_music/providers/ux_provider.dart';
import 'package:gibbon_music/updated_ui/widgets/custom_scaffold.dart';
import 'package:provider/provider.dart';

class PageSetting extends StatelessWidget {
  const PageSetting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DataModel dataModel = DataModel();
    String accName = client.account.account!.displayName.toString();
    String accLogin = client.account.account!.login.toString();
    bool? hasPlus = client.account.plus!.hasPlus;
    return SafeArea(
        child: Scaffold(
            body: CustomScaffold(
              children: [
                AppConsts.smallVSpacer,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      accName,
                    ),
                    AppConsts.smallHSpacer,
                    hasPlus == true
                        ? Container(
                            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),),
                            child: const Text(
                              "PLUS",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          )
                        : const SizedBox(),
                  ],
                ),
                Text(
                  accLogin,
                ),
                AppConsts.defaultVSpacer,
                const Text(
                  "Персонализация",
                ),
                AppConsts.defaultVSpacer,
                const Row(
                  children: [
                    Text(
                      "Системная тема",
                    ),
                    AppConsts.defaultHSpacer,
                  ],
                ),
                AppConsts.defaultVSpacer,
                Consumer<UxProvider>(
                  builder: (context, ux, child) {
                    return Row(
                      children: [
                        const Text(
                          "Плавная прокрутка",
                        ),
                        AppConsts.fillSpacer,
                        Switch(
                          value: ux.smoothScroll,
                          onChanged: (value) {
                            if (!ux.smoothScroll) {
                              ux.changeSmoothScrollState();
                              dataModel.writeBoolData(AppConsts.smoothScrollKey, true);
                            } else {
                              ux.changeSmoothScrollState();
                              dataModel.writeBoolData(AppConsts.smoothScrollKey, false);
                            }
                          },
                        )
                      ],
                    );
                  },
                ),
                AppConsts.smallVSpacer,
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.warning_rounded),
                      AppConsts.smallHSpacer,
                      Text(
                          "Attention when smooth scrolling is enabled, your laptop's touchpad or touch screen will not work!"
                      ),
                    ],
                  )
                ),
                AppConsts.defaultVSpacer,
                const Text(
                  "Темы",
                ),
                AppConsts.smallVSpacer,
              ],
            )));
  }
}
