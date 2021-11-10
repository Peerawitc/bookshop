import 'package:covidapp/model/apiresult.dart';
import 'package:covidapp/model/covid.dart';
import 'package:covidapp/service/api.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class covidHome extends StatefulWidget {
  const covidHome({Key? key}) : super(key: key);

  @override
  _covidHomeState createState() => _covidHomeState();
}

class _covidHomeState extends State<covidHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          "Covid-19",
        )),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg2.jpg"),
            fit: BoxFit.fill,
          ),
        ),
        child: FutureBuilder<Covid>(
          future: futureCovid,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.hasData) {
              Covid covid = snapshot.data as Covid;
              List<Map<String, dynamic>> covidList = [
                {
                  "title": "วันที่",
                  "content": covid.txn_date.toString(),
                  "image": "assets/images/bg1.jpg",
                  "color": Colors.lightBlueAccent
                },
                {
                  "title": "ผู้ป่วยใหม่",
                  "content": covid.new_case.toString(),
                  "image": "assets/images/bg1.jpg",
                  "color": Colors.redAccent
                },
                {
                  "title": "ผู้ป่วยสะสม",
                  "content": covid.total_case.toString(),
                  "image": "assets/images/bg1.jpg",
                  "color": Colors.red
                },
                {
                  "title": "ผู้ป่วยในประเทศ",
                  "content": covid.new_case_excludeabroad.toString(),
                  "image": "assets/images/bg1.jpg",
                  "color": Colors.red
                },
                {
                  "title": "ผู้ป่วยในประเทศ\nทั้งหมด",
                  "content": covid.total_case_excludeabroad.toString(),
                  "image": "assets/images/bg1.jpg",
                  "color": Colors.red
                },
                {
                  "title": "เสียชีวิตวันนี้",
                  "content": covid.new_death.toString(),
                  "image": "assets/images/bg1.jpg",
                  "color": Colors.grey
                },
                {
                  "title": "เสียชีวิตรวม",
                  "content": covid.total_death.toString(),
                  "image": "assets/images/bg1.jpg",
                  "color": Colors.grey
                },
                {
                  "title": "รักษาหายวันนี้",
                  "content": covid.new_recovered.toString(),
                  "image": "assets/images/bg1.jpg",
                  "color": Colors.greenAccent
                },
                {
                  "title": "รักษาหายรวม",
                  "content": covid.total_recovered.toString(),
                  "image": "assets/images/bg1.jpg",
                  "color": Colors.green
                },
                {
                  "title": "เวลาที่อัพเดต",
                  "content": covid.update_date.toString(),
                  "image": "assets/images/bg1.jpg",
                  "color": Colors.green
                },
              ];
              return ListView(
                  padding: EdgeInsets.all(8.0),
                  children: [
                    for(int i =0;i<covidList.length;i+=2)
                    buildRow([covidList[i],covidList[i+1]])]);
            }

            if (snapshot.hasError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('ผิดพลาด: ${snapshot.error}'),
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            futureCovid = fetch();
                          });
                        },
                        child: Text('ลองใหม่')),
                  ],
                ),
              );
            }

            return SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Row buildRow(List<Map<String, dynamic>> covidList) {
    return Row(
      children: [
        for (int i = 0; i < covidList.length; i++)
          Expanded(
            child: Card(
              child: Container(
                width: 220.0,
                height: 250.0,
                // decoration: BoxDecoration(image: DecorationImage(
                //   image: AssetImage("${covidList[i]['image']}",),fit : BoxFit.cover
                // )),
                color: covidList[i]["color"],
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        covidList[i]['title'],
                        style: GoogleFonts.prompt(
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        covidList[i]['content'],
                        style: GoogleFonts.prompt(
                          fontSize: 30,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    futureCovid = fetch();
  }

  late Future<Covid> futureCovid;

  Future<Covid> fetch() async {
    final ApiResult list = await Api().fetch("today-cases-all");
    final covid = Covid.fromJson(list.data);
    return covid;
  }
}
