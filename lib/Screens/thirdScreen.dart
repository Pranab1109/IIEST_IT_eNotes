import 'package:FirebasePdf/Models/model.dart';
import 'package:FirebasePdf/Screens/firstPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ThirdScreen extends StatefulWidget {
  Category category;
  ThirdScreen(this.category);
  @override
  _ThirdScreenState createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  Category items;
  @override
  void initState() {
    super.initState();
    items = widget.category;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff433d3c),
      appBar: AppBar(
        backgroundColor: Color(0xff433d3c),
        title: Text(
          "Budding MEDicos",
          style: TextStyle(fontSize: 26),
        ),
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Category",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xffd0e8f2)),
            ),
            SizedBox(
              height: 30,
            ),
            Expanded(
                child: StaggeredGridView.countBuilder(
              crossAxisCount: 2,
              itemCount: items.list.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FirstPage(items, index)),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          // border: Border.all(
                          //   color: Colors.white,
                          //   width: 2,
                          // ),
                          boxShadow: [
                            BoxShadow(
                              color: items.color,
                              blurRadius: 8.0,
                            ),
                          ],
                          color: items.color,
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
                          items.list[index],
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
