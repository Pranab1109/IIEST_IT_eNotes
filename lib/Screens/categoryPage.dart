import 'package:FirebasePdf/Models/model.dart';
import 'package:FirebasePdf/Screens/firstPage.dart';
import 'package:FirebasePdf/Screens/thirdScreen.dart';
import 'package:FirebasePdf/databaseHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class CategoryPage extends StatefulWidget {
  CategoryPage({Key key}) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  // List<Category> categories = [Category(name: "cars", description: "cars"),];
  List<Category> items = [
    Category(name: "Sem 3", color: Color(0xffffd66b), list: [
      "Programming & DS",
      "Digital Logic & Circuit Design",
      "Discrete Mathematics and Graph Theory",
      "Signals, Systems & Circuits",
      "Mathematics III"
    ]),
    Category(name: "Sem 4", color: Color(0xffff9d72), list: [
      "Communication Systems",
      "Computer Organisation and Architecture",
      "Computer Graphics",
      "Formal language & Automata Theory",
      "Object Oriented System Design"
    ]),
    // Category(
    //     name: "Diagrams",
    //     color: Color(0xff949cdf),
    //     list: ["Anatomical positions planes and axis", "Limbs"]),
    // Category(name: "Question Bank", color: Color(0xffff8585), list: [
    //   "Anatomical positions planes and axis",
    //   "The bones of upper limbs"
    // ]),
  ];
  @override
  void initState() {
    super.initState();
    // print(categories);
  }

  Widget gridView() {
    return GridView.count(
      crossAxisCount: 2,
      children: List.generate(items.length, (index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ThirdScreen(items[index])),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: items[index].color,
              ),
              child: Center(child: Text(items[index].name)),
              height: 100,
              width: 100,
            ),
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1a1c20),
      appBar: AppBar(
        backgroundColor: Color(0xff1a1c20),
        title: Text(
          "IIEST e-Notes",
          style: TextStyle(fontSize: 26),
        ),
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color(0xffcceabb),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "Semester",
                  style: TextStyle(
                      fontSize: 18,
                      letterSpacing: 2.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff1a1c20)),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Expanded(
                child: StaggeredGridView.countBuilder(
              crossAxisCount: 2,
              itemCount: items.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ThirdScreen(items[index])),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black87,
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(5.0, 3.0),
                              color: items[index].color,
                              blurRadius: 8.0,
                            ),
                          ],
                          color: items[index].color,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                            topRight: Radius.circular(10),
                          )),
                      height: 200,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0, top: 20),
                        child: Text(
                          items[index].name,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                );
              },
              staggeredTileBuilder: (index) {
                return StaggeredTile.fit(1);
              },
            ))
          ],
        ),
      ),
    );
  }
}
