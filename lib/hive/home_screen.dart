import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hive Database"),
        
      ),
    body: Column(
      children: [
    // FutureBuilder(
    //     future:Hive.openBox('name') ,
    //     builder:(context, snapshot){
    //  return Column(
    //    children: [
    //  ListTile(
    //    title:Text(snapshot.data!.get('Youtube').toString()),
    //
    //  ),
    //
    //
    //    ],
    //  );
    //     }),
        FutureBuilder(
            future:Hive.openBox('Anus') ,
            builder:(context, snapshot){
              return Column(
                children: [
                  ListTile(
                    title:Text(snapshot.data!.get('fName').toString()),
                    subtitle:Text(snapshot.data!.get('age').toString()),
                    trailing: IconButton(
                      //for edit
                      onPressed: (){
                        //for edit
                       snapshot.data?.put('fName', 'Liaqat Ali');
                       snapshot.data?.put('age', '24.-.');
                       // for delete
                     //  snapshot.data?.delete('fName');
                       setState(() {

                       });
                      },
                      icon:Icon(Icons.edit),
                    ),
                  ),


                ],
              );
            })
      ],
    ),
floatingActionButton: FloatingActionButton(
  onPressed: () async {
    var box= await Hive.openBox('Anus');
    var box2 = await Hive.openBox('name');
    box2.put('Youtube', 'Muhammas Anus Gul');
    box.put('fName', "Anus Gul");
    box.put('age', "22");
    box.put('details',{
      'fName': 'Anus Gul',
        'prof': 'Supreme Leader of Iran',
         'power': 'indefinite'

    });
    print(box.get('fName'));
    print(box.get('age'));
    print(box.get('details')['prof']);
  },
  child: Icon(Icons.add),
),
    );



  }
}
