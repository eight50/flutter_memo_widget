import 'package:flutter/material.dart';

class DefaultConstructor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ListView(
          children: [
            _menuItem("メニュー1", Icon(Icons.settings)),
            _menuItem("メニュー2", Icon(Icons.map)),
            _menuItem("メニュー3", Icon(Icons.room)),
            _menuItem("メニュー4", Icon(Icons.local_shipping)),
            _menuItem("メニュー5", Icon(Icons.airplanemode_active)),
          ]
        ),
      ),
    );
  }

  Widget _menuItem(String title, Icon icon) {
    return Container(
      decoration: new BoxDecoration(
        border: new Border(bottom: BorderSide(width: 1.0, color: Colors.grey))
      ),
      child: ListTile(
        leading: icon,
        title: Text(
          title,
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.0
          ),
        ),
        onTap: () {
          print("onTap called.");
        },
        onLongPress: () {
          print("onLongPress called.");
        },
      ),
    );
  }
}

class ListViewBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var list = ["メッセージ", "メッセージ", "メッセージ", "メッセージ", "メッセージ",];
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: Text('ListView'),
            ),
            body: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                if (index >= list.length) {
                  list.addAll(["メッセージ","メッセージ","メッセージ","メッセージ",]);
                }
                return _messageItem(list[index]);
              },
            )
        )
    );
  }

  Widget _messageItem(String title) {
    return Container(
      decoration: new BoxDecoration(
          border: new Border(bottom: BorderSide(width: 1.0, color: Colors.grey))
      ),
      child:ListTile(
        title: Text(
          title,
          style: TextStyle(
              color:Colors.black,
              fontSize: 18.0
          ),
        ),
        onTap: () {
          print("onTap called.");
        }, // タップ
        onLongPress: () {
          print("onLongTap called.");
        }, // 長押し
      ),
    );
  }
}

class ListViewSeparated extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var list = ["メッセージ", "メッセージ", "メッセージ", "メッセージ", "メッセージ","メッセージ","メッセージ","メッセージ",];
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: Text('ListView'),
            ),
            body: ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                return _messageItem(list[index]);
              },
              separatorBuilder: (BuildContext context, int index) {
                return separatorItem();
              },
              itemCount: list.length,
            )
        )
    );
  }
  Widget separatorItem() {
    return Container(
      height: 10,
      color: Colors.orange,
    );
  }

  Widget _messageItem(String title) {
    return Container(
      decoration: new BoxDecoration(
          border: new Border(bottom: BorderSide(width: 1.0, color: Colors.grey))
      ),
      child:ListTile(
        title: Text(
          title,
          style: TextStyle(
              color:Colors.black,
              fontSize: 18.0
          ),
        ),
        onTap: () {
          print("onTap called.");
        }, // タップ
        onLongPress: () {
          print("onLongTap called.");
        }, // 長押し
      ),
    );
  }
}

class ListViewScrollDirection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var list = ["0","1","2","3","4","5","6","7","8","9"];
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: Text('ListView'),
            ),
            body: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                if (index >= list.length) {
                  list.addAll(["0","1","2","3","4","5","6","7","8","9",]);
                }
                return _messageItem(list[index]);
              },
            )
        )
    );
  }

  Widget _messageItem(String title) {
    return Container(
        width: 100,
        decoration: new BoxDecoration(
            border: new Border(right: BorderSide(width: 1.0, color: Colors.grey))
        ),
        child:Center(
          child:Text(
            title,
            style: TextStyle(
                color:Colors.black,
                fontSize: 20.0
            ),
          ),
        )
    );
  }
}
