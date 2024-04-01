// import 'package:fakeapp/module/controllers/collage_controller.dart';
// import 'package:fakeapp/module/views/collage_data.dart';
// import 'package:fakeapp/module/widgets/item_student.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orderez/Widget/ItemStudent.dart';
import 'package:orderez/koneksi/CollageController.dart';
import 'package:orderez/model/Product.dart';

class CollageList extends StatefulWidget {
  const CollageList({Key? key}) : super(key: key);

  @override
  State<CollageList> createState() => _CollageListState();
}

class _CollageListState extends State<CollageList> {
  final CollageController _collageController = CollageController();

  late Future<List<Product>> model;

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => _refreshCollages(context),
      color: Colors.white,
      backgroundColor: Colors.black,
      strokeWidth: 3,
      child: FutureBuilder<List<Product>>(
        future: model,
        builder: (context, snapshot) {
          // if (snapshot.connectionState == ConnectionState.waiting) {
          //   return const Center(
          //     child: CupertinoActivityIndicator(),
          //   );
          // }

          // if (snapshot.hasError) {
          //   return Padding(
          //     padding: const EdgeInsets.only(top: 20),
          //     child: Center(
          //       child: Text(
          //         "ERROR : ${snapshot.error}",
          //         style: const TextStyle(
          //           fontSize: 30,
          //           color: Colors.black,
          //         ),
          //       ),
          //     ),
          //   );
          // }

          if (snapshot.hasData) {
            List<Product> data = snapshot.data!;
            return SizedBox(
              height: 500,
              child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  Product student = data[index];
                  return InkWell(
                    onTap: () {
                      // Get.to(
                      //   CollageDataPage(
                      //     student: student.nim!,
                      //   ),
                      // );
                    },
                    child: ItemStudent(collageModel: student),
                  );
                },
              ),
            );
          }

          return const Center(
            child: Text(
              'null-------',
              style: TextStyle(
                fontSize: 30,
                color: Colors.black,
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _refreshCollages(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 1));
    _refreshData();
  }

  Future<void> _refreshData() async {
    model = _collageController.getAllStudent();
    setState(() {});
  }
}
