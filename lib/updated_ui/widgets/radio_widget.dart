import 'package:audioplayers/audioplayers.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:gibbon_music/providers/audio_provider.dart';
import 'package:provider/provider.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';
import 'package:yam_api/enums.dart';
import 'package:flutter/material.dart' as m;

import '../../constants/app_consts.dart';
import '../../domain/models/playlist.dart';

class RadioWidget extends StatelessWidget {
  const RadioWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color waveColors = FluentTheme.of(context).accentColor;
    AudioProvider au = context.read();
    NewPlaylist playlistProvider = context.read();

    return Container(
      decoration: BoxDecoration(color: const Color.fromRGBO(20, 20, 20, 1), borderRadius: BorderRadius.circular(8)),
      width: AppConsts.pageSize(context).width,
      height: 650,
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
            height: 650,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Colors.black,
                  Colors.black.withOpacity(.25),
                  Colors.black,
                ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                borderRadius: BorderRadius.circular(8)),
          ),
          Container(
            width: AppConsts.pageSize(context).width,
            height: 650,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Colors.black,
                  Colors.black.withOpacity(.25),
                  Colors.black,
                ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
                borderRadius: BorderRadius.circular(8)),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: AppConsts.pageSize(context).width,
              ),
              AppConsts.defaultVSpacer,
              Button(
                  onPressed: () async {
                    if (playlistProvider.radio) {
                      if (au.playerState == PlayerState.playing) {
                        au.pause();
                      } else {
                        au.resume();
                      }
                    } else {
                      await playlistProvider.startRadio();
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: ButtonState.all(Colors.transparent),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(playlistProvider.radio ? context.watch<AudioProvider>().icon() : m.Icons.play_arrow, size: 28),
                      AppConsts.defaultHSpacer,
                      Text(
                        "МОЯ ВОЛНА".toUpperCase(),
                        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ],
                  )),
              AppConsts.defaultVSpacer,
              Text("ПО ХАРАКТЕРУ", style: TextStyle(fontWeight: FontWeight.bold, color: FluentTheme.of(context).cardColor.withOpacity(.6), fontSize: 12),),
              AppConsts.smallVSpacer,
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
              Text("ПОД НАСТРОЕНИЕ", style: TextStyle(fontWeight: FontWeight.bold, color: FluentTheme.of(context).cardColor.withOpacity(.6), fontSize: 12),),
              AppConsts.smallVSpacer,
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
              Text("ПО ЯЗЫКУ", style: TextStyle(fontWeight: FontWeight.bold, color: FluentTheme.of(context).cardColor.withOpacity(.6), fontSize: 12),),
              AppConsts.smallVSpacer,
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
        return AnimatedScale(
          scale: state.isPressing
              ? .8
              : state.isHovering
                  ? .9
                  : 1,
          duration: AppConsts.defaultAnimation,
          curve: AppConsts.defaultCurve,
          child: AnimatedContainer(
            width: 120,
            margin: const EdgeInsets.only(left: 8, right: 8),
            duration: AppConsts.slowAnimation,
            curve: AppConsts.defaultCurve,
            decoration: BoxDecoration(
                color: selected ? FluentTheme.of(context).accentColor : const Color.fromRGBO(50, 50, 50, 1), borderRadius: BorderRadius.circular(24)),
            child: Center(child: Text(title)),
          ),
        );
      },
    );
  }
}
