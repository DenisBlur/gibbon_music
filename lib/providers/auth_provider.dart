import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gibbon_music/domain/models/data_model.dart';
import 'package:puppeteer/puppeteer.dart' as p;

class AuthProvider extends ChangeNotifier {
  p.Browser? browser;
  p.Page? authPage;

  PageController pageController = PageController();

  Uint8List? byteImage;

  bool error = false;
  bool phoneCode = false;
  bool loading = false;
  bool waitBrowser = false;

  String? localToken;

  AuthProvider() {
    launchBrowser();
  }

  animatePage(int page) {
    pageController.animateToPage(page, duration: const Duration(milliseconds: 650), curve: Curves.fastEaseInToSlowEaseOut);
  }

  ///Запуск браузера
  launchBrowser() async {
    localToken = await DataModel().readStringData("token");
    if (localToken == "null") {
      waitBrowser = true;
      notifyListeners();
      print("Start browser");

      browser = await p.puppeteer.launch(headless: false);
      authPage = await browser!.newPage();

      await authPage!
          .goto('https://oauth.yandex.ru/authorize?response_type=token&client_id=23cabbbdc6cd418abb4b39c32c41195d', wait: p.Until.networkIdle);

      print("Browser open");

      waitBrowser = false;
      notifyListeners();

      authPage!.onFrameNavigated.listen((event) {
        if (event.url.contains("#access_token=")) {
          String token = event.url.substring(event.url.indexOf("#access_token=") + 14, event.url.indexOf("&token_type=bearer"));

          print(token);
          print(event.url);

          DataModel().writeStringData("token", token);
          notifyListeners();

          closeBrowser();
        }
      });
    }
  }

  ///Закрывает браузер
  closeBrowser() async {
    await browser!.close();
  }

  ///Отправляет номер телефона
  writeTelephone(String value) async {
    error = false;
    loading = false;

    var input = await authPage!.$("#passp-field-phone");
    await input.click();

    var telephoneNumber = value.split("");
    for (var element in telephoneNumber) {
      await authPage!.keyboard.press(p.Key.control, text: element);
    }

    var button = await authPage!.$(".Button2.Button2_size_xxl.Button2_view_contrast-action.Button2_width_max.Button2_type_submit");
    await button.click();

    loading = true;
    notifyListeners();

    Future.delayed(
      const Duration(milliseconds: 650),
      () async {
        var errorWidget = await authPage!.evaluate('document.querySelector(".Textinput-Hint.Textinput-Hint_state_error")');
        if (errorWidget == null) {
          error = false;
          Future.delayed(
            const Duration(seconds: 2),
            () async {
              var check = await authPage!.waitForSelector('#passp-field-phoneCode');
              if (check != null) {
                animatePage(1);
                loading = false;
                phoneCode = true;
                notifyListeners();
              }
            },
          );
        } else {
          loading = false;
          error = true;
          notifyListeners();
        }
      },
    );
  }

  ///Отправляет код
  sendCode(String value) async {
    var input = await authPage!.$("#passp-field-phoneCode");
    await input.click();

    var code = value.split("");
    for (var element in code) {
      await authPage!.keyboard.press(p.Key.control, text: element);
    }

    Future.delayed(
      const Duration(seconds: 2),
      () async {
        if (browser != null) {
          var check = await authPage!.$(".Accounts-list");
          print("Choose Account");
          var accounts = await check.$$(".AccountsListItem-account.AccountsListItem-account_v2");
          var f = await accounts[0].jsonValue;
          print(f);
        }
      },
    );
  }

  anotherLogin() async {
    loading = true;
    notifyListeners();
    var button = await authPage!.$(".Button2.Button2_size_xxl.Button2_view_clear.Button2_width_max.UserEntryFlow__sign-in-with-yandex-btn");
    button.click(delay: const Duration(milliseconds: 150));
    Future.delayed(
      const Duration(seconds: 2),
      () => qrCode(),
    );
  }

  qrCode() async {
    var qrCode = await authPage!.$(".AuthSocialBlock-provider.AuthSocialBlock-provider_code_qr");
    qrCode.click(delay: const Duration(milliseconds: 150));

    Future.delayed(
      const Duration(seconds: 2),
      () async {
        var qrImage = await authPage!.$(".MagicField-qr");
        var image = await qrImage.screenshot(format: p.ScreenshotFormat.png);
        byteImage = Uint8List.fromList(image);
        animatePage(2);
        loading = false;
        notifyListeners();
      },
    );
  }

  void restartAuth() {
    animatePage(0);
    closeBrowser();
    launchBrowser();
  }
}
