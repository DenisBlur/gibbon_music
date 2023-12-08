import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gibbon_music/constants/app_consts.dart';
import 'package:gibbon_music/constants/style_consts.dart';
import 'package:gibbon_music/domain/models/data_model.dart';
import 'package:gibbon_music/main.dart';
import 'package:gibbon_music/updated_ui/screens/page_init.dart';
import 'package:gibbon_music/updated_ui/widgets/header.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:url_launcher/url_launcher.dart';

class PageAuth extends StatefulWidget {
  const PageAuth({Key? key}) : super(key: key);

  @override
  State<PageAuth> createState() => _PageAuthState();
}

class _PageAuthState extends State<PageAuth> {
  final DataModel dataModel = DataModel();
  PageController pageController = PageController();
  TextEditingController textEditingController = TextEditingController();
  bool errorAuth = false;
  final currentImage = AppConsts.authBgImagesLinks[Random().nextInt(AppConsts.authBgImagesLinks.length)];

  Future webInitialize() async {
    String localToken = await dataModel.readStringData(AppConsts.tokenKey);
    if (localToken.contains("null") && Platform.isWindows) {
    } else {
      initToken(localToken);
    }
  }

  void initToken(String token) async {
    await client.init(token: token).then(
      (value) {
        if (!value) {
          updateStatus(true);
          Future.delayed(const Duration(seconds: 1)).then((value) {
            setState(() {
              updateStatus(false);
            });
          });
        } else {
          dataModel.writeStringData(AppConsts.tokenKey, token);
          updateStatus(false);
          Navigator.pop(context);
          Navigator.push(
              context,
              FluentPageRoute(
                builder: (context) => PageInit(token: token),
              ));
        }
      },
    );
  }

  void updateStatus(bool er) {
    setState(() {
      errorAuth = er;
    });
  }

  @override
  void initState() {
    super.initState();
    webInitialize();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
        padding: const EdgeInsets.all(0),
        content: Stack(
          children: [
            FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: currentImage,
                fit: BoxFit.cover,
                height: AppConsts.pageSize(context).height,
                width: AppConsts.pageSize(context).width),
            ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  width: AppConsts.pageSize(context).width,
                  height: AppConsts.pageSize(context).height,
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(20, 20, 20, .4),
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Container(
                  width: 350,
                  color: const Color.fromRGBO(20, 20, 20, 1),
                  padding: const EdgeInsets.all(64),
                  height: AppConsts.pageSize(context).height,
                  child: tokenAuth(),
                ),
                Expanded(
                  child: PageView(
                    controller: pageController,
                    children: const [
                      Center(
                        child: UpdateWidget(
                          title: "RADIO UPDATE",
                          corrections: [
                            "Теперь музыка всегда играет только в высоком качестве",
                            "Исправлены ошибки",
                            "Обновлена главная страница",
                            "Обновлена страница авторизации",
                            "Обвнолены виджеты: Артист, Альбом, Плейлист",
                          ],
                          adding: [
                            "Радио",
                            "Выбор настроек для радио",
                            "Текст песен [BETA]",
                          ],
                          remove: [
                            "Темы",
                            'Страница "Настройки"',
                            "Боковое меню",
                            "Некоторые библиотеки",
                            "Получение токена через браузер внутри приложения"
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            const Header(menu: false),
          ],
        ));
  }

  Widget tokenAuth() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          "Авторизация",
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
        AppConsts.bigVSpacer,
        TextBox(
          controller: textEditingController,
          onSubmitted: (value) {
            initToken(value);
          },
          maxLines: 1,
          placeholder: "Ваш токен",
        ),
        AppConsts.smallVSpacer,
        Button(
            onPressed: () {
              initToken(textEditingController.text);
            },
            child: const Text("Войти")),
        AppConsts.bigVSpacer,
        Button(
            onPressed: () async {
              if (!await launchUrl(Uri.parse(AppConsts.tokenGetLink))) {
                throw Exception('Could not launch');
              }
            },
            style: ButtonStyle(
                backgroundColor: ButtonState.all(Colors.transparent),),
            child: const Text("как мне узнать токен?")),
      ],
    );
  }
}

class UpdateWidget extends StatelessWidget {
  const UpdateWidget(
      {Key? key, this.corrections = const ["Без изменений"], this.adding = const ["Без изменений"], this.remove = const ["Без изменений"], required this.title})
      : super(key: key);

  final String title;
  final List<String> corrections;
  final List<String> adding;
  final List<String> remove;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(20, 20, 20, .8),
        borderRadius: BorderRadius.circular(8),
      ),
      width: AppConsts.pageSize(context).width / 2,
      height: AppConsts.pageSize(context).height / 1.5,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: "https://cdn.dribbble.com/userupload/4484825/file/original-36fd81878bb930608eabf4da7c60f48d.png?resize=1024x1280",
                    width: AppConsts.pageSize(context).width,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        color: const Color.fromRGBO(20, 20, 20, .6),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                        child: Text(
                          title,
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            AppConsts.defaultVSpacer,
            const Text(
              "Исправления",
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            for (int i = 0; i < corrections.length; i++) Text("-${corrections[i]}", style: TextStyle(fontSize: 12, color: Colors.white.withOpacity(.6))),
            AppConsts.defaultVSpacer,
            const Text(
              "Добавлено",
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            for (int i = 0; i < adding.length; i++) Text("-${adding[i]}", style: TextStyle(fontSize: 12, color: Colors.white.withOpacity(.6))),
            AppConsts.defaultVSpacer,
            const Text(
              "Удалено",
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            for (int i = 0; i < remove.length; i++) Text("-${remove[i]}", style: TextStyle(fontSize: 12, color: Colors.white.withOpacity(.6))),
          ],
        ),
      ),
    );
  }
}
