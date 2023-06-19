import 'package:api_calling/call_api.dart';
import 'package:api_calling/post.dart';
import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:shaky_animated_listview/widgets/animated_listview.dart';


void main()=>runApp(myApp());

class myApp extends StatelessWidget {
  const myApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const homepage();
  }

}


class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);

  @override
  State<homepage> createState() => _homepageState();
}



class _homepageState extends State<homepage> {
  List<Post>? posts;
  var isLoaded=false;

  @override
  void initState(){
    super.initState();
    getData();
  }

  getData() async {
    
    posts=await callApi().getPosts();
    if(posts !=null){
      setState(() {
        isLoaded=true;
      });
    }
  }

  bool _iconBool=false;
  final IconData _iconLight=Icons.wb_sunny ;
  final IconData _iconDark=Icons.nights_stay;

  final ThemeData _lightThem= ThemeData(
    brightness: Brightness.light
  );

  final ThemeData _DarkThem= ThemeData(
      brightness: Brightness.dark,

  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _iconBool ? _DarkThem : _lightThem,

      home: Scaffold(

        appBar: AppBar(
          title: const Center(child: Text('API Calling')),
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    _iconBool=!_iconBool;
                  });
                }, icon: Icon(_iconBool ? _iconDark : _iconLight),
            )


          ],
        ),
        body: Visibility(
          visible: isLoaded,
          replacement: const Center(
            child: CircularProgressIndicator(
              color: Colors.blue,
              backgroundColor: Colors.blueGrey,
              value: 0.60,
              strokeWidth: 6,
            ),
          ),
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: posts?.length,
              itemBuilder: (context, index)
              {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
               children: [
               Container(
                 height: 50,
                 width: 50,
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(15),
                   color: Colors.blueGrey,
                 ),
               ),
               const SizedBox(width: 16,),


                 Expanded(
                 child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text(posts![index].title ?? '',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blueAccent
                      ),
                    ),

                    Text(posts![index].body ?? '',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 16, color: Colors.grey
                    ),
                    ),
                  ],
              ),
                 ),
              ],
              ),
            );
          }),
        ),

      ),
    );
  }
}

