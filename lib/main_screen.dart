import 'dart:async';
import 'dart:math';
import 'package:dnd_dices/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//is light theme
var currentTheme = true;

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int result = 0;
  int preResult = 0;
  bool isFakeLoading = false;

  Future<void> randomize(int maxValue, int numberOfDices) async {
    setState(() {
      isFakeLoading = true;
    });
    await Future.delayed(
      Duration(milliseconds: 700),
      () {
        for (var i = 1; i <= numberOfDices; i++) {
          preResult += Random().nextInt(maxValue) + 1;
          print(preResult);
        }
        result = preResult;
        preResult = 0;
        setState(() {
          isFakeLoading = false;
        });
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
          result = 0;
        });
      },
    );
  }

  Widget returnDiceButton(int maxNumber, BuildContext context) {
    return InkWell(
      onTap: () {
        showHowManyDicesDialog(context, maxNumber);
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
            : result == 0
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

  Widget returnHowManyDicesButton(
    int number,
    int dice,
  ) {
    return InkWell(
      child: CircleAvatar(
        radius: 25,
        backgroundColor: Theme.of(context).accentColor,
        child: CircleAvatar(
          radius: 22,
          backgroundColor: (currentTheme == true)
              ? Colors.white
              : Theme.of(context).primaryColor,
          child: Center(
            child: Text(
              '$number',
              style: TextStyle(
                fontSize: 20,
                color: Theme.of(context).accentColor,
              ),
            ),
          ),
        ),
      ),
      onTap: () {
        Navigator.of(context).pop();
        randomize(dice, number);
      },
    );
  }

// диалог для изменения возраста
  void showHowManyDicesDialog(
    BuildContext context,
    int dice,
  ) {
    showModalBottomSheet<void>(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Padding(
            padding: const EdgeInsets.only(
              left: 15,
              right: 15,
              bottom: 49,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  // SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text(
                      'Сколько кубиков кинуть?',
                      style: TextStyle(
                        fontSize: 20,
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        returnHowManyDicesButton(1, dice),
                        returnHowManyDicesButton(2, dice),
                        returnHowManyDicesButton(3, dice),
                        returnHowManyDicesButton(4, dice),
                        returnHowManyDicesButton(5, dice),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        returnHowManyDicesButton(6, dice),
                        returnHowManyDicesButton(7, dice),
                        returnHowManyDicesButton(8, dice),
                        returnHowManyDicesButton(9, dice),
                        returnHowManyDicesButton(10, dice),
                      ],
                    ),
                  ),
                  SizedBox(height: 15)
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;

    return Scaffold(
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
                        returnDiceButton(4, context),
                        returnDiceButton(6, context),
                        returnDiceButton(8, context),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        returnDiceButton(10, context),
                        returnDiceButton(12, context),
                        returnDiceButton(100, context),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        returnChangeThemeButton(),
                        returnDiceButton(20, context),
                        returnDeleteButton(),
                      ],
                    ),
                    SizedBox(height: 10),
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
