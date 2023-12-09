import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gibbon_music/constants/app_consts.dart';
import 'package:gibbon_music/domain/models/data_model.dart';
import 'package:gibbon_music/providers/auth_provider.dart';
import 'package:gibbon_music/updated_ui/screens/page_init.dart';
import 'package:gibbon_music/updated_ui/widgets/header.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

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

      return Scaffold(
          body: Stack(
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
          Center(
            child: Container(
              width: 350,
              height: 350,
              decoration: BoxDecoration(color: Theme.of(context).colorScheme.background.withOpacity(.85), borderRadius: BorderRadius.circular(16)),
              padding: const EdgeInsets.all(32),
              child: ap.waitBrowser
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : tokenAuth(ap, context),
            ),
          ),
          const Header(menu: false),
        ],
      ));
    });
  }

  Widget tokenAuth(AuthProvider ap, BuildContext context) {

    Future.delayed(const Duration(seconds: 5), () {
      if(ap.localToken != "null") {
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (context) => PageInit(token: ap.localToken!),));
      }
    },);

    return PageView(
      controller: ap.pageController,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Авторизация",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextField(
              controller: textEditingController,
              onSubmitted: (value) {
                ap.writeTelephone(value);
              },
              maxLines: 1,
              decoration: const InputDecoration(
                label: Text("Номер телефона"),
              ),
            ),
            if (ap.error)
              const Text(
                "Недопустимый формат номера",
                style: TextStyle(color: Colors.red),
              ),
            AppConsts.smallVSpacer,
            if (ap.loading) const LinearProgressIndicator(),
            FilledButton(
                onPressed: () async {
                  ap.writeTelephone(textEditingController.text);
                },
                child: const Text("Войти")),
            TextButton(
              onPressed: () {
                ap.anotherLogin();
              },
              child: const Text("QR код"),
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
            TextField(
              controller: textEditingController,
              onSubmitted: (value) {
                ap.writeTelephone(value);
              },
              maxLines: 1,
              decoration: const InputDecoration(
                label: Text("СМС код"),
              ),
            ),
            if (ap.loading) const LinearProgressIndicator(),
            AppConsts.smallHSpacer,
            if (ap.phoneCode)
              FilledButton(
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
                IconButton(
                  icon: const Icon(Icons.navigate_before_rounded, size: 24),
                  onPressed: () {
                    ap.restartAuth();
                  },
                ),
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
