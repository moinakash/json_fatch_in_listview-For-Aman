import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:json_fatch_in_listview/constant.dart';

class ListScreen extends StatefulWidget {

  const ListScreen({Key? key}) : super(key: key);

  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {


  List AllDataList =[];

  @override
  void initState() {
    // TODO: implement initState
    getData(Constants.API_URL, Constants.MOBILE_NUMBER);

  }


  Future getData(String url,String mobile_num) async {

    var apiUrl = Uri.parse(url);
    var response = await http.get(apiUrl, headers: {
      'MOBILE_NUMBER': mobile_num });
    if (response.statusCode == 200) {

      log("Response- ${response.body.toString()}");


      setState(() {
        AllDataList = json.decode(response.body)['items'];
      });

    } else {
      print('error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AllDataList.isEmpty ? Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(top: 20),
          child: const CircularProgressIndicator()
      ):
      ListView.builder(
        itemCount: AllDataList.length,
          itemBuilder: (context,index){
            return Container(
              color: Colors.amberAccent,
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),

              child: Text(
                  "pk : ${AllDataList[index]["pk"]}"+"\n"+
                  "customer_id_fk : ${AllDataList[index]["customer_id_fk"]}"+"\n"+
                  "mobile_number : ${AllDataList[index]["mobile_number"]}"+"\n"+
                  "sell_person : ${AllDataList[index]["sell_person"]}"+"\n"+
                  "sell_date : ${AllDataList[index]["sell_date"]}"

              ),

             // child: Text("test"),

            );
          },

      ),
    );
  }
}