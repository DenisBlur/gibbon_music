import 'package:fluent_ui/fluent_ui.dart';
import 'package:gibbon_music/constants/app_consts.dart';
import 'package:gibbon_music/constants/style_consts.dart';
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
        child: ScaffoldPage(
            padding: EdgeInsets.zero,
            content: CustomScaffold(
              children: [
                AppConsts.smallVSpacer,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      accName,
                      style: AppStyle.header1Style,
                    ),
                    AppConsts.smallHSpacer,
                    hasPlus == true
                        ? Container(
                            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                            decoration: BoxDecoration(
                                color: FluentTheme.of(context).cardColor,
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
                  style: AppStyle.subTrackHeaderStyle(context),
                ),
                AppConsts.defaultVSpacer,
                const Text(
                  "Персонализация",
                  style: AppStyle.header1Style,
                ),
                AppConsts.defaultVSpacer,
                Row(
                  children: [
                    Text(
                      "Системная тема",
                      style: AppStyle.prTitle(context),
                    ),
                    AppConsts.defaultHSpacer,
                  ],
                ),
                AppConsts.defaultVSpacer,
                Consumer<UxProvider>(
                  builder: (context, ux, child) {
                    return Row(
                      children: [
                        Text(
                          "Плавная прокрутка",
                          style: AppStyle.prTitle(context),
                        ),
                        AppConsts.fillSpacer,
                        ToggleSwitch(
                          checked: ux.smoothScroll,
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
                      Icon(FluentIcons.warning),
                      AppConsts.smallHSpacer,
                      Text(
                          "Attention when smooth scrolling is enabled, your laptop's touchpad or touch screen will not work!"
                      ),
                    ],
                  )
                ),
                AppConsts.defaultVSpacer,
                Text(
                  "Темы",
                  style: AppStyle.prTitle(context),
                ),
                AppConsts.smallVSpacer,
              ],
            )));
  }
}
