import 'dart:developer';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_page_view_indicator/flutter_page_view_indicator.dart';
import 'package:machine/presentation/colors.dart';
import 'package:machine/presentation/fonts.dart';
import 'package:machine/presentation/shared/blur.dart';
import 'package:machine/presentation/widgets/triangle_painter.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/yandex.dart';
import 'package:octo_image/octo_image.dart';
import 'package:latlong2/latlong.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: MyCustomScrollBehavior(),
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late ScrollController _scrollController;
  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  int _currentIndex = 0;
  int _currentIndex2 = 0;
  bool _validate = false;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _numberController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _productController = TextEditingController();
  TextEditingController _vinController = TextEditingController();

  void sendMessage(TextEditingController _nameController,
      TextEditingController _emailController) async {
    final smtp = yandex("remm1e@yandex.ru", "nqwityycozcldjji");
    final message = Message()
      ..from = const Address("remm1e@yandex.ru", 'Test')
      ..recipients.add(_emailController.text)
      ..subject = "Ответ от нас"
      ..text = 'Спасибо за отклик, ${_nameController.text}';

    try {
      final sendReport = await send(message, smtp);
      log('message sended success $sendReport');
      _nameController.clear();
      _emailController.clear();
    } on MailerException catch (e) {
      log('message not send ${e.message}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        scrollBehavior: MyCustomScrollBehavior(),
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15))),
            title: MediaQuery.sizeOf(context).width > 900
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        'logo.jpg',
                        width: 120,
                        height: 200,
                      ),
                      GestureDetector(
                        onTap: () {
                          _scrollController.animateTo(
                            1200,
                            duration: Duration(seconds: 1),
                            curve: Curves.easeInOut,
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(10)),
                          child: Text("Каталог"),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          _scrollController.animateTo(
                            2200,
                            duration: Duration(seconds: 1),
                            curve: Curves.easeInOut,
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(10)),
                          child: Text("Оставьте заявку"),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          _scrollController.animateTo(
                            4000,
                            duration: Duration(seconds: 1),
                            curve: Curves.easeInOut,
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(10)),
                          child: Text("Контакты"),
                        ),
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        'logo.jpg',
                        width: 120,
                        height: 200,
                      ),
                      GestureDetector(
                        onTap: () {
                          _scrollController.animateTo(
                            1200,
                            duration: Duration(seconds: 1),
                            curve: Curves.easeInOut,
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(10)),
                          child: Icon(
                            Icons.list,
                            size: 30,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          _scrollController.animateTo(
                            2200,
                            duration: Duration(seconds: 1),
                            curve: Curves.easeInOut,
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(10)),
                          child: Icon(
                            Icons.send_to_mobile,
                            size: 30,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          _scrollController.animateTo(
                            4000,
                            duration: Duration(seconds: 1),
                            curve: Curves.easeInOut,
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(10)),
                          child: Icon(
                            Icons.call,
                            size: 30,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
            floating: true,
          ),
          SliverToBoxAdapter(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 1350,
                  child: Stack(
                    children: [
                      OctoImage(
                          fit: BoxFit.cover,
                          height: 1350,
                          placeholderBuilder: blurHashPlaceholderBuilder(
                              "LFD]rG^+M{M{0000xu-;~q~qWBD%"),
                          width: MediaQuery.of(context).size.width,
                          image: const CachedNetworkImageProvider(
                              "https://regionavto164.ru/wp-content/uploads/2021/04/w_f994e09b.jpg")),
                      Align(
                        alignment: Alignment.center,
                        child: ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: 2000),
                          child: Container(
                            margin: EdgeInsets.only(top: 420, left: 100),
                            child: Column(
                              children: [
                                Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'В ДЕТАЛЯХ',
                                      style: MyFonts.header,
                                    )),
                                Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'г. Саратов, ул. Астраханская 47',
                                      style: MyFonts.header2,
                                    )),
                                GestureDetector(
                                  onTap: () {
                                    _scrollController.animateTo(
                                      2200,
                                      duration: Duration(seconds: 1),
                                      curve: Curves.easeInOut,
                                    );
                                  },
                                  child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Container(
                                        margin: EdgeInsets.only(top: 30),
                                        decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        padding: EdgeInsets.all(16),
                                        child: Text(
                                          'ОТПРАВИТЬ ЗАЯВКУ',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 24),
                                        ),
                                      )),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: CustomPaint(
                          size: Size(double.infinity, 120),
                          painter: TrianglePainter(
                              color: MyColors.primary,
                              flipVertical: false,
                              flipHorizontal: false),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 1000,
                  width: double.infinity,
                  decoration: const BoxDecoration(color: MyColors.primary),
                  child: Padding(
                    padding: EdgeInsets.all(0),
                    child: Column(
                      children: [
                        Text(
                          "НАШ КАТАЛОГ",
                          style: MyFonts.catalog,
                        ),
                        Container(
                          width: 1000,
                          height: 800,
                          child: PageView(
                            onPageChanged: (page) {
                              setState(() {
                                _currentIndex2 = page;
                              });
                            },
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            children: [
                              Image.asset('catalog1.avif'),
                              Image.asset('catalog2.avif'),
                              Image.asset('catalog3.avif'),
                              Image.asset('catalog4.avif'),
                              Image.asset('catalog5.avif'),
                            ],
                          ),
                        ),
                        PageViewIndicator(
                          length: 5,
                          currentIndex: _currentIndex2,
                          currentSize: 10,
                          currentColor: Colors.white,
                          otherColor: Colors.black,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 1350,
                  child: Stack(
                    children: [
                      OctoImage(
                          fit: BoxFit.cover,
                          height: 1350,
                          width: MediaQuery.of(context).size.width,
                          placeholderBuilder: blurHashPlaceholderBuilder(
                              "LFD]rG^+M{M{0000xu-;~q~qWBD%"),
                          image: const CachedNetworkImageProvider(
                              "https://regionavto164.ru/wp-content/uploads/2021/04/w_f994e09b.jpg")),
                      Container(
                        padding: EdgeInsets.only(right: 50, left: 50, top: 300),
                        decoration: BoxDecoration(
                            color: Colors.black45.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          children: [
                            Icon(
                              Icons.car_crash_sharp,
                              size: 200,
                              color: Colors.white,
                            ),
                            Text(
                              "ОСТАВЬТЕ ЗАЯВКУ",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize:
                                    MediaQuery.sizeOf(context).width > 1000
                                        ? 40
                                        : 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Менеджер свяжется с вами в течении 15 минут.",
                              style: TextStyle(
                                color: Colors.white54,
                                fontSize:
                                    MediaQuery.sizeOf(context).width > 1000
                                        ? 24
                                        : 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "Ответит на все вопросы и поможет оформить заказ.",
                              style: TextStyle(
                                color: Colors.white54,
                                fontSize:
                                    MediaQuery.sizeOf(context).width > 1000
                                        ? 24
                                        : 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 40),
                              child: Container(
                                padding: EdgeInsets.all(20),
                                child: TextField(
                                  controller: _nameController,
                                  decoration: InputDecoration(
                                      errorText: _validate
                                          ? "Поле обязательно для заполнения."
                                          : null,
                                      filled: true,
                                      hintText: "Ваше имя*",
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Container(
                                padding: EdgeInsets.all(20),
                                child: TextField(
                                  controller: _numberController,
                                  decoration: InputDecoration(
                                      errorText: _validate
                                          ? "Поле обязательно для заполнения."
                                          : null,
                                      filled: true,
                                      hintText: "Ваш телефон*",
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Container(
                                padding: EdgeInsets.all(20),
                                child: TextField(
                                  controller: _emailController,
                                  decoration: InputDecoration(
                                      errorText: _validate
                                          ? "Поле обязательно для заполнения."
                                          : null,
                                      filled: true,
                                      hintText: "Ваша почта",
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Container(
                                padding: EdgeInsets.all(20),
                                child: TextField(
                                  controller: _vinController,
                                  decoration: InputDecoration(
                                      errorText: _validate
                                          ? "Поле обязательно для заполнения."
                                          : null,
                                      errorStyle: TextStyle(color: Colors.red),
                                      filled: true,
                                      hintText: "VIN-номер авто*",
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Container(
                                padding: EdgeInsets.all(20),
                                child: TextField(
                                  controller: _productController,
                                  decoration: InputDecoration(
                                      errorText: _validate
                                          ? "Поле обязательно для заполнения."
                                          : null,
                                      errorStyle: TextStyle(color: Colors.red),
                                      filled: true,
                                      hintText: "Запчасть*",
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                if (_nameController.text.isEmpty ||
                                    _numberController.text.isEmpty ||
                                    _emailController.text.isEmpty ||
                                    _productController.text.isEmpty) {
                                  _validate = true;
                                } else {
                                  sendMessage(
                                      _nameController, _emailController);
                                }
                              },
                              child: Text("ОТПРАВИТЬ"),
                              style: ButtonStyle(
                                  textStyle:
                                      MaterialStatePropertyAll<TextStyle>(
                                          TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  )),
                                  foregroundColor:
                                      MaterialStatePropertyAll<Color>(
                                          Colors.black),
                                  backgroundColor:
                                      MaterialStatePropertyAll<Color>(
                                          Colors.white)),
                            )
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: CustomPaint(
                          size: const Size(double.infinity, 120),
                          painter: TrianglePainter(
                              flipVertical: true,
                              flipHorizontal: true,
                              color: MyColors.primary),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 720,
                  child: Stack(
                    children: [
                      IgnorePointer(
                        child: FlutterMap(
                            options: MapOptions(
                                initialCenter: LatLng(
                                    51.532201, 46.005061),
                                initialZoom: 16.0),
                            children: [
                              TileLayer(
                                urlTemplate:
                                    "https://tile-c.openstreetmap.fr/hot/{z}/{x}/{y}.png",
                              ),
                              MarkerLayer(markers: [
                                Marker(
                                    point: LatLng(51.532201, 46.005061),
                                    child: Image.asset('marker.png', width: 200, height: 200,))
                              ])
                            ]),
                      ),
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "НАШЕ МЕСТОПОЛОЖЕНИЕ",
                            style:
                                MyFonts.catalog.copyWith(color: Colors.black),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                    decoration: const BoxDecoration(
                        color: Colors.grey,
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/sky.jpg'))),
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 50),
                        child: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 100),
                                child: Text(
                                  "Контакты магазина автозапчастей 'В ДЕТАЛЯХ'",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.map_outlined,
                                    color: Colors.white,
                                    size: 50,
                                  ),
                                  SizedBox(
                                    width: 100,
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "Адрес:",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 40,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "г. Саратов",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 40,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "ул. Астраханская 47",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 40,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20),
                                child: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width - 100,
                                    child: Divider(
                                      height: 2,
                                      color: Colors.white,
                                    )),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.timelapse,
                                    color: Colors.white,
                                    size: 50,
                                  ),
                                  SizedBox(
                                    width: 100,
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "Время работы:",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 40,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "Пн-вск: 9:00 - 21:00",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 40,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20),
                                child: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width - 100,
                                    child: Divider(
                                      height: 2,
                                      color: Colors.white,
                                    )),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.call,
                                    color: Colors.lightGreen,
                                    size: 50,
                                  ),
                                  SizedBox(
                                    width: 100,
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "Для связи:",
                                        style: TextStyle(
                                            color: Colors.lightGreen,
                                            fontSize: 40,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "+7 (987) 327-77-34",
                                        style: TextStyle(
                                            color: Colors.lightGreen,
                                            fontSize: 40,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "v.detalyah64@mail.ru",
                                        style: TextStyle(
                                            color: Colors.lightGreen,
                                            fontSize: 40,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "https://vk.com/v.detalah",
                                        style: TextStyle(
                                            color: Colors.lightGreen,
                                            fontSize: 40,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    )),
                Container(
                    color: MyColors.footerBackground,
                    padding: EdgeInsets.all(20),
                    child: MediaQuery.sizeOf(context).width > 1280
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: _buildfooter())
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: _buildfooter()))
              ],
            ),
          ),
        ],
      ),
    );
  }

  _buildfooter() {
    return [
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "О нас",
              style: TextStyle(color: Colors.white),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Container(
              width: 500,
              child: Text(
                "'Точность, надежность, процветание!' — это девиз нашей компании, которая специализируется на поставках запчастей для автомобилей иностранных марок. Мы обслуживаем как оптовых, так и розничных клиентов, предлагая широкий ассортимент продукции. Наличие собственного склада и розничного магазина гарантирует быстрое и комфортное обслуживание каждого клиента.",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Icon(
              Icons.ac_unit_outlined,
              color: Colors.white,
            ),
          )
        ],
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 500,
            height: 220,
            child: PageView(
              onPageChanged: (value) {
                setState(() {
                  _currentIndex = value;
                });
              },
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              children: [
                Column(children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20)),
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(20),
                    child: const Text(
                      'Как менеджер нашего магазина, я всегда готов помочь клиентам подобрать нужные запчасти, используя наш обширный каталог и экспертные знания.',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w700),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Icon(
                            Icons.access_alarm_sharp,
                            color: Colors.white,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Менеджер по продажам",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "В ДЕТАЛЯХ",
                              style: TextStyle(color: Colors.white30),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ]),
                Column(children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20)),
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(20),
                    child: const Text(
                      'Как консультант в розничном магазине, я всегда на связи, чтобы ответить на любые вопросы клиентов и помочь им с выбором, используя наш персонализированный подход к каждому покупателю.',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w700),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Icon(
                            Icons.access_alarm_sharp,
                            color: Colors.white,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Консультант",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "В ДЕТАЛЯХ",
                              style: TextStyle(color: Colors.white30),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ]),
              ],
            ),
          ),
          PageViewIndicator(
            length: 2,
            currentIndex: _currentIndex,
            currentSize: 10,
            currentColor: Colors.blue,
          ),
        ],
      )
    ];
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        // etc.
      };
}
