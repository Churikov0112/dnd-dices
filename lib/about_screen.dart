import 'package:dnd_dices/main.dart';
import 'package:dnd_dices/main_drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AboutUsScreen extends StatefulWidget {
  final routeName = '/about';

  @override
  _AboutUsScreenState createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  @override
  void dispose() {
    isFirstTimeOnAboutPage = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        title: Text(
          'About us',
          style: TextStyle(
            color: Theme.of(context).accentColor,
          ),
        ),
      ),
      body: Center(
        child: Container(
          child: Column(
            children: [
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Card(
                  elevation: 10,
                  color: Theme.of(context).primaryColor,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Sheeeeeesh',
                          style: TextStyle(
                            fontSize: 25,
                            color: Theme.of(context).accentColor,
                          ),
                        ),
                        CupertinoSwitch(
                          value: isCheatActive,
                          onChanged: (newValue) {
                            setState(() {
                              isCheatActive = newValue;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              (!isCheatActive)
                  ? Container()
                  : Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Card(
                        elevation: 10,
                        color: Theme.of(context).primaryColor,
                        child: Container(
                          constraints: BoxConstraints(
                            minWidth: MediaQuery.of(context).size.width - 20,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              'Ага, вот и самый любопытный. Вряд ли информация о создателе этого приложения тебе о чем-то скажет, но не наградить тебя за твою любознательность я просто не мог. Теперь ты можешь активировать режим читера (+3 ко всем броскам кубика, но не больше максимума, чтобы тебя не спалили). Наслаждайся.',
                              style: TextStyle(
                                fontSize: 20,
                                color: Theme.of(context).accentColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
