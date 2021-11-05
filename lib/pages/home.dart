import 'package:covidapp/model/apiresult.dart';
import 'package:covidapp/model/covid.dart';
import 'package:covidapp/service/api.dart';
import 'package:flutter/material.dart';

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
        title: Center(child: Text("Covid-19",)),

      ),
      body: FutureBuilder<Covid>(
        future: futureCovid,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasData) {
            var covidList = snapshot.data;
            return ListView.builder(
              padding: EdgeInsets.all(8.0),
              itemCount: 1,
              itemBuilder: (BuildContext context, int index) {
                var covid = covidList!;

                return Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  margin: EdgeInsets.all(8.0),
                  elevation: 5.0,
                  shadowColor: Colors.black.withOpacity(0.2),
                  child: InkWell(
                    onTap: () {},
                    child: Column(
                     children: [
                       Text("วันที่"+covid.txn_date.toString()),
                       Text("ผู้ป่วยใหม่"+covid.new_case.toString()),
                       Text("ผู้ป่วยสะสม"+covid.total_case.toString()),
                       Text("ผู้ป่วยที่ไม่ได้เดินทางจากต่างประเทศ"+covid.new_case_excludeabroad.toString()),
                       Text("ผู้ป่วยที่ไม่ได้เดินทางจากต่างประเทศรวมทั้งหมด"+covid.total_case_excludeabroad.toString()),
                       Text("เสียชีวิตวันนี้"+covid.new_death.toString()),
                       Text("เสียชีวิตรวม"+covid.total_death.toString()),
                       Text("รักษาหายวันนี้"+covid.new_recovered.toString()),
                       Text("รักษาหายรวม"+covid.total_recovered.toString()),
                       Text("เวลาที่อัพเดต"+covid.update_date.toString()),

                       

                     ],
                    ),
                  ),
                );
              },
            );
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
                          futureCovid =fetch();
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
    );
  }

  @override
  void initState(){
    super.initState();
    futureCovid = fetch();
  }
  late Future <Covid> futureCovid;
  Future <Covid> fetch() async{
    final ApiResult list = await Api().fetch("today-cases-all");
    final covid =  Covid.fromJson(list.data);
    return covid;
    
    
  }
}
