import 'package:fluent_ui/fluent_ui.dart';
import 'package:gibbon_music/providers/audio_provider.dart';
import 'package:provider/provider.dart';

import '../../constants/app_consts.dart';
import '../../providers/ux_provider.dart';

class LyricWidget extends StatelessWidget {
  const LyricWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UxProvider uxProvider = context.watch();
    var backgroundColor = Color.fromRGBO(24, 24, 24, context.watch<UxProvider>().isFullscreen ? .8 : 1);

    return Consumer<AudioProvider>(builder: (context, audioProvider, child) {
      return AnimatedPositioned(
        left: context.watch<UxProvider>().isFullscreen ? 0 : AppConsts.pageSize(context).width / 2 - 450,
        right: context.watch<UxProvider>().isFullscreen ? 0 : AppConsts.pageSize(context).width / 2 - 450,
        top: context.watch<UxProvider>().isFullscreen ? 0 : (AppConsts.pageSize(context).height - AppConsts.playerHeight) - (uxProvider.isOpenLyric ? 450 : 0),
        bottom: context.watch<UxProvider>().isFullscreen ? 0 : AppConsts.playerHeight,
        duration: AppConsts.slowAnimation,
        curve: AppConsts.defaultCurve,
        child: Container(
          height: 450,
          width: 450,
          margin: EdgeInsets.only(right: context.watch<UxProvider>().isFullscreen ? 0 : 16, bottom: context.watch<UxProvider>().isFullscreen ? 0 : 32, top: context.watch<UxProvider>().isFullscreen ? 0 : AppConsts.pageSize(context).height / 6),
          decoration: BoxDecoration(color: backgroundColor, borderRadius: BorderRadius.circular(8)),
          child: audioProvider.lyric.lines != null
              ? ListView.builder(
                  itemBuilder: (context, index) {
                    var lines = audioProvider.lyric.lines;
                    int lastIndex = audioProvider.lyric.lines!.length - 1;

                    double endTimeMs = 0;

                    if (index != lastIndex) {
                      endTimeMs = double.parse(lines![index + 1].startTimeMs.toString());
                    } else {
                      endTimeMs = double.parse(lines![index].startTimeMs.toString()) * 2;
                    }

                    return Center(
                      child: LyricText(
                        index: index,
                        words: lines[index].words!,
                        startTimeMs: double.parse(
                          lines[index].startTimeMs!,
                        ),
                        endTimeMs: endTimeMs,
                        first: index == 0,
                        last: index == lastIndex,
                      ),
                    );
                  },
                  itemCount: audioProvider.lyric.lines!.length,
                )
              : const Text("Пока нет текста"),
        ),
      );
    });
  }
}

class LyricText extends StatelessWidget {
  const LyricText(
      {Key? key,
      required this.index,
      required this.words,
      required this.startTimeMs,
      required this.endTimeMs,
      required this.first,
      required this.last})
      : super(key: key);

  final int index;
  final String words;
  final double startTimeMs;
  final double endTimeMs;
  final bool first, last;

  @override
  Widget build(BuildContext context) {
    return Consumer<AudioProvider>(builder: (context, audioProvider, child) {
      return StreamBuilder(
          stream: audioProvider.onPositionChanged,
          initialData: const Duration(milliseconds: 0),
          builder: (context, snapshot) {
            Duration? data = snapshot.data as Duration?;
            double position = data!.inMilliseconds.toDouble();
            {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                case ConnectionState.active:
                  bool select = position > startTimeMs && position < endTimeMs;

                  if (position > startTimeMs && position < endTimeMs) {
                    Scrollable.ensureVisible(context, curve: AppConsts.defaultCurve, duration: AppConsts.slowAnimation, alignment: first ? 1: .5);
                  }

                  return Padding(
                    padding: EdgeInsets.only(top: first ? 350 : 8, bottom: last ? 350 : 8),
                    child: AnimatedDefaultTextStyle(
                      style: TextStyle(
                          fontSize: select ? context.watch<UxProvider>().isFullscreen ? 24 : 18 : context.watch<UxProvider>().isFullscreen ? 18 : 16,
                          fontWeight: select ? FontWeight.bold : FontWeight.normal,
                          color: FluentTheme.of(context).scaffoldBackgroundColor.withOpacity(select ? 1 : .4)),
                      duration: AppConsts.slowAnimation,
                      curve: AppConsts.defaultCurve,
                      textAlign: TextAlign.center,
                      child: Text(
                        words,
                      ),
                    ),
                  );
                case ConnectionState.none:
                case ConnectionState.done:
                default:
                  return const Text("None");
              }
            }
          });
    });
  }
}
