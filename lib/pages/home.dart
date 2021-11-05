import 'package:bookshop/model/apiresult.dart';
import 'package:bookshop/model/covid.dart';
import 'package:bookshop/service/api.dart';
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
        title: Text("Covid"),
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
                var covid = covidList;

                return Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  margin: EdgeInsets.all(8.0),
                  elevation: 5.0,
                  shadowColor: Colors.black.withOpacity(0.2),
                  child: InkWell(
                    onTap: () {},
                    child: Row(
                     children: [
                       Text(covid!.txn_date)
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
