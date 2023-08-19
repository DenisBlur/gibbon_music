import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';
import 'package:yam_api/enums.dart';

import '../../constants/app_consts.dart';
import '../../domain/models/playlist.dart';

class RadioWidget extends StatelessWidget {
  const RadioWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color waveColors = FluentTheme.of(context).accentColor;

    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            FluentTheme.of(context).cardColor,
            FluentTheme.of(context).cardColor.withOpacity(.1),
          ], begin: Alignment.topLeft, end: Alignment.bottomRight),
          borderRadius: BorderRadius.circular(8)),
      width: AppConsts.pageSize(context).width,
      height: 350,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: WaveWidget(
              config: CustomConfig(colors: [
                waveColors.withOpacity(0.1),
                waveColors.withOpacity(0.2),
                waveColors.withOpacity(0.4),
                waveColors.withOpacity(0.6),
                waveColors,
              ], durations: [
                9600,
                9700,
                9800,
                9900,
                10000
              ], heightPercentages: [
                0.2,
                0.3,
                0.4,
                0.5,
                0.6
              ]),
              size: const Size(double.infinity, double.infinity),
            ),
          ),
          Container(
            width: AppConsts.pageSize(context).width,
            height: 350,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Colors.black.withOpacity(.25),
                  Colors.black,
                ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                borderRadius: BorderRadius.circular(8)),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: AppConsts.pageSize(context).width,
              ),
              const Text(
                "МОЯ ВОЛНА",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              AppConsts.defaultVSpacer,
              Button(
                  onPressed: () async {
                    await context.read<NewPlaylist>().startRadio();
                  },
                  child: const Text("воспроизвести")),
              AppConsts.defaultVSpacer,
              SizedBox(
                width: 136 * (RadioDiversity.values.length - 1),
                height: 46,
                child: ListView.builder(
                    itemBuilder: (context, index) {
                      return RadioChangeButton(
                        voidCallback: () async {
                          await context.read<NewPlaylist>().updateRadio(radioDiversity: RadioDiversity.values[index]);
                        },
                        title: diversityTranslate[index],
                        selected: context.watch<NewPlaylist>().radioDiversity.index == index,
                      );
                    },
                    itemCount: RadioDiversity.values.length - 1,
                    scrollDirection: Axis.horizontal),
              ),
              AppConsts.defaultVSpacer,
              SizedBox(
                width: 136 * (RadioMoodEnergy.values.length - 1),
                height: 46,
                child: ListView.builder(
                    itemBuilder: (context, index) {
                      return RadioChangeButton(
                        voidCallback: () async {
                          await context.read<NewPlaylist>().updateRadio(radioMoodEnergy: RadioMoodEnergy.values[index]);
                        },
                        title: moodEnergyTranslate[index],
                        selected: context.watch<NewPlaylist>().radioMoodEnergy.index == index,
                      );
                    },
                    itemCount: RadioMoodEnergy.values.length - 1,
                    scrollDirection: Axis.horizontal),
              ),
              AppConsts.defaultVSpacer,
              SizedBox(
                width: 136 * (RadioLanguage.values.length - 1),
                height: 46,
                child: ListView.builder(
                    itemBuilder: (context, index) {
                      return RadioChangeButton(
                        voidCallback: () async {
                          await context.read<NewPlaylist>().updateRadio(radioLanguage: RadioLanguage.values[index]);
                        },
                        title: languageTranslate[index],
                        selected: context.watch<NewPlaylist>().radioLanguage.index == index,
                      );
                    },
                    itemCount: RadioLanguage.values.length - 1,
                    scrollDirection: Axis.horizontal),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class RadioChangeButton extends StatelessWidget {
  const RadioChangeButton({Key? key, required this.voidCallback, required this.title, this.selected = false}) : super(key: key);

  final VoidCallback voidCallback;
  final String title;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return HoverButton(
      onPressed: () => voidCallback(),
      builder: (p0, state) {
        return AnimatedContainer(
          width: 120,
          margin: const EdgeInsets.only(left: 8, right: 8),
          duration: AppConsts.slowAnimation,
          curve: AppConsts.defaultCurve,
          decoration: BoxDecoration(color: selected ? FluentTheme.of(context).accentColor : Color.fromRGBO(50, 50, 50, 1), borderRadius: BorderRadius.circular(24)),
          child: Center(child: Text(title)),
        );
      },
    );
  }
}
