import 'package:flutter/material.dart';
import 'package:prueba/src/models/citys.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SearchWidget extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;

  SearchWidget({Key key, this.parentScaffoldKey}) : super(key: key);
  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends StateMVC<SearchWidget> {

  Citys climainicial;
  List<Citys> nuevaList = [];
  var woeid= null;

  _SearchWidgetState() : super() {

  }


  void initState() {
    super.initState();
  }

  final TextEditingController _textController = TextEditingController();
  String get _text => _textController.text;





  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child:
        Scaffold(
          appBar: AppBar(
              title: const Text('searcher'),
            leading: new IconButton(
              icon: new Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('/Home');
              },
            ),

          ),
          body:
              Column (children: [
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: _textController,
                          decoration: const InputDecoration(
                            labelText: 'search site',
                            hintText: 'enter site name',
                          ),
                          onChanged: (_text) {
                            searchitem(_text);
                          },
                        ),
                      ),
                    ),
                    IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () =>  escogeritem(woeid),
                    )
                  ],
                ),
                nuevaList.length<=0 ? SizedBox():
                nuevaList.length>10 ?  ListView.builder(
                  itemCount: 10,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    Citys item = nuevaList[index];
                    return GestureDetector(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            children: [
                              Text("${item.title} - ${item.type}"),
                              SizedBox(height: 4,),
                            ],
                          ),
                        ),
                        onTap: () => {
                          setState(() {
                           _textController.text=item.title;
                           woeid=item.woeid;
                          }),
                        }
                    );
                  },
                ):
                ListView.builder(
                  itemCount: nuevaList.length,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    Citys item = nuevaList[index];
                    return GestureDetector(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            children: [
                              Text("${item.title} - ${item.type}"),
                              SizedBox(height: 4,),
                            ],
                          ),
                        ),
                        onTap: () => {
                          setState(() {
                            _textController.text="${item.title} - ${item.type}";
                            woeid=item.woeid;
                          }),
                        }
                    );
                  },
                ),

              ],),

        )
    );
  }

  Future<void> escogeritem(item) async{
    if (item!=null){
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('cityusado',"$item");
      Navigator.of(context).pushReplacementNamed('/Home');
    }
    else {
      Navigator.of(context).pushReplacementNamed('/Home');
    }

  }

  void searchitem(texto) async{
    List<Citys> itemsList = [];
    http.Response response = await http.get(Uri.parse('https://www.metaweather.com/api/location/search/?query='+texto));

    try {
      var body = json.decode(utf8.decode(response.bodyBytes));
      var list = body as List;
      itemsList = list.map((i) => Citys.fromJSON(i)).toList();
    }catch(e){

    }
    setState(() {
      nuevaList=itemsList;
    });
        }



}









