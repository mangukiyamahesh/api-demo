import 'package:api_demo/models/products_model.dart';
import 'package:api_demo/practice.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Practice(),
    );
  }
}

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentPage = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Api Demo"),
        actions: [
          Center(child: Text("Page $currentPage")),
          SizedBox(
            width: 20,
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 5,
            child: FutureBuilder(
                builder: (BuildContext context,
                    AsyncSnapshot<List<Products>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    //final product page
                    return Center(
                      child: Text("${snapshot.data?[1].title}"),
                    );
                  } else {
                    return CupertinoActivityIndicator();
                  }
                },
                future: giveMeSomeData()),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          currentPage = 1;
                        });
                      },
                      child: Text("1"),
                      style: ButtonStyle(
                          backgroundColor: currentPage == 1
                              ? MaterialStatePropertyAll<Color>(Colors.green)
                              : MaterialStatePropertyAll<Color>(Colors.blue))),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          currentPage = 2;
                        });
                      },
                      child: Text("2"),
                      style: ButtonStyle(
                          backgroundColor: currentPage == 2
                              ? MaterialStatePropertyAll<Color>(Colors.green)
                              : MaterialStatePropertyAll<Color>(Colors.blue))),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          currentPage = 3;
                        });
                      },
                      child: Text("3"),
                      style: ButtonStyle(
                          backgroundColor: currentPage == 3
                              ? MaterialStatePropertyAll<Color>(Colors.green)
                              : MaterialStatePropertyAll<Color>(Colors.blue))),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          currentPage = 4;
                        });
                      },
                      child: Text("4"),
                      style: ButtonStyle(
                          backgroundColor: currentPage == 4
                              ? MaterialStatePropertyAll<Color>(Colors.green)
                              : MaterialStatePropertyAll<Color>(Colors.blue))),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          currentPage = 5;
                        });
                      },
                      child: Text("5"),
                      style: ButtonStyle(
                          backgroundColor: currentPage == 5
                              ? MaterialStatePropertyAll<Color>(Colors.green)
                              : MaterialStatePropertyAll<Color>(Colors.blue))),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<List<Products>> giveMeSomeData() async {
    http.Response response =
        await http.get(Uri.parse('https://fakestoreapi.com/products'));

    List<Products> products = productsFromJson(response.body);
    return products;
  }
}
