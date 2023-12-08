import 'dart:math';
import 'dart:ui';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:gibbon_music/constants/app_consts.dart';
import 'package:gibbon_music/domain/models/data_model.dart';
import 'package:gibbon_music/providers/auth_provider.dart';
import 'package:gibbon_music/updated_ui/widgets/header.dart';
import 'package:flutter/material.dart' as m;
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class PageAuth extends StatelessWidget {
  PageAuth({Key? key}) : super(key: key);

  final DataModel dataModel = DataModel();
  PageController pageController = PageController();
  TextEditingController textEditingController = TextEditingController();
  final currentImage = AppConsts.authBgImagesLinks[Random().nextInt(AppConsts.authBgImagesLinks.length)];

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, ap, child) {
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
                    child: ap.waitBrowser
                        ? const Center(
                            child: ProgressRing(),
                          )
                        : tokenAuth(ap),
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
                              "Исправлены ошибки при получении треков",
                              "Оптимизирована работа с сетью"
                            ],
                            adding: [
                              "Радио",
                              "Выбор настроек для радио",
                              "Текст песен [BETA]",
                              "Дополнительные отправки на сервер (для рекомендаций)"
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
    });
  }

  Widget tokenAuth(AuthProvider ap) {
    return PageView(
      controller: ap.pageController,
      children: [
        Column(
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
                ap.writeTelephone(value);
              },
              maxLines: 1,
              placeholder: "Номер телефона",
            ),
            AppConsts.smallVSpacer,
            if (ap.error)
              Text(
                "Недопустимый формат номера",
                style: TextStyle(color: Colors.red),
              ),
            AppConsts.smallVSpacer,
            if (ap.loading) const ProgressBar(),
            Button(
                onPressed: () async {
                  ap.writeTelephone(textEditingController.text);
                },
                child: const Text("Войти")),
            Button(
              onPressed: () {
                ap.anotherLogin();
              },
              child: const Text("Войти с помощью QR кода"),
            ),
            AppConsts.bigVSpacer,
            Button(
              onPressed: () async {
                if (!await launchUrl(Uri.parse(AppConsts.tokenGetLink))) {
                  throw Exception('Could not launch');
                }
              },
              style: ButtonStyle(
                backgroundColor: ButtonState.all(Colors.transparent),
              ),
              child: const Text("как мне узнать токен?"),
            ),
          ],
        ),
        Column(
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
                ap.sendCode(value);
              },
              maxLines: 1,
              placeholder: "СМС Код",
            ),
            if (ap.loading) const ProgressBar(),
            AppConsts.smallHSpacer,
            if (ap.phoneCode)
              Button(
                  onPressed: () async {
                    ap.sendCode(textEditingController.text);
                  },
                  child: const Text("Отправить")),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                IconButton(icon: const Icon(m.Icons.navigate_before_rounded, size: 24), onPressed: () {
                  ap.restartAuth();
                },),
                AppConsts.smallHSpacer,
                const Text(
                  "QR Code",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            AppConsts.bigHSpacer,
            if (ap.byteImage != null) Image.memory(ap.byteImage!),
          ],
        )
      ],
    );
  }
}

class UpdateWidget extends StatelessWidget {
  const UpdateWidget(
      {Key? key,
      this.corrections = const ["Без изменений"],
      this.adding = const ["Без изменений"],
      this.remove = const ["Без изменений"],
      required this.title})
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
            for (int i = 0; i < corrections.length; i++)
              Text("-${corrections[i]}", style: TextStyle(fontSize: 12, color: Colors.white.withOpacity(.6))),
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
