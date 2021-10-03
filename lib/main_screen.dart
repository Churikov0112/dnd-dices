import 'dart:async';
import 'dart:math';
import 'package:dnd_dices/main.dart';
import 'package:dnd_dices/main_drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//is light theme
var currentTheme = true;

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final int minNumber = 1;
  int result;
  bool isFakeLoading = false;

  //сердце нашего приложения
  Future<void> randomize(int maxNumber) async {
    int preResult = Random().nextInt(maxNumber) + 1;
    // метод рандом от нуля до maxNumber-1, так что прибавляем единицу к результату
    setState(() {
      isFakeLoading = true;
    });
    await Future.delayed(
      Duration(milliseconds: 700),
      () {
        if (isCheatActive == true) {
          //проверка, чтобы число + чит не было больше max
          if (preResult + 3 < maxNumber) {
            result = preResult + 3;
          } else {
            result = maxNumber;
          }
        } else {
          result = preResult;
        }

        setState(() {
          isFakeLoading = false;
        });
        // Return number
        return result;
      },
    );
  }

  Widget returnDeleteButton() {
    return IconButton(
      iconSize: 40,
      icon: Icon(
        Icons.delete,
        size: 40,
        color: Theme.of(context).accentColor,
      ),
      onPressed: () {
        setState(() {
          result = null;
        });
      },
    );
  }

  Widget returnDiceButton(int maxNumber) {
    return InkWell(
      onTap: () {
        randomize(maxNumber);
      },
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Container(
          constraints: BoxConstraints(
            minWidth: MediaQuery.of(context).size.width * 0.3,
            minHeight: MediaQuery.of(context).size.width * 0.3,
          ),
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            border: Border.all(
              color: Theme.of(context).accentColor,
              width: maxNumber == 20 ? 3 : 3,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: Center(
              child: Text(
            '$maxNumber',
            style: TextStyle(
              fontSize: 28,
              color: Theme.of(context).accentColor,
            ),
          )),
          width: 20,
          height: 20,
        ),
      ),
    );
  }

  Widget returnHublot(Size deviceSize) {
    return Container(
      width: deviceSize.width,
      height: deviceSize.height * 0.27,
      //color: Colors.red,
      child: Center(
        child: isFakeLoading
            ? CircularProgressIndicator(
                color: Theme.of(context).accentColor,
              )
            : result == null
                ? currentTheme
                    ? Image.asset(
                        'lib/assets/dice.png',
                        width: 100,
                      )
                    : Image.asset(
                        'lib/assets/dice_dark.png',
                        width: 100,
                      )
                : Text(
                    '$result',
                    style: TextStyle(
                      fontSize: 48,
                      color: Theme.of(context).accentColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
      ),
    );
  }

  Widget returnChangeThemeButton() {
    return Padding(
      padding: const EdgeInsets.only(right: 4),
      child: InkWell(
        child: CircleAvatar(
          radius: 25,
          backgroundColor: Theme.of(context).accentColor,
          child: CircleAvatar(
            radius: 22,
            backgroundColor: (currentTheme == true)
                ? Colors.white
                : Theme.of(context).primaryColor,
          ),
        ),
        onTap: () {
          isLightTheme.add(!currentTheme);
          currentTheme = !currentTheme;
          //returnThemePicker(context);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        //elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          'Your favorite dices',
          style: TextStyle(
            color: Theme.of(context).accentColor,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(child: Container()),
          returnHublot(deviceSize),
          Expanded(child: Container()),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Container(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        returnDiceButton(4),
                        returnDiceButton(6),
                        returnDiceButton(8),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        returnDiceButton(10),
                        returnDiceButton(12),
                        returnDiceButton(100),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        returnChangeThemeButton(),
                        returnDiceButton(20),
                        returnDeleteButton(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
