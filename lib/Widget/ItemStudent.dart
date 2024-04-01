// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:fakeapp/module/models/collage_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orderez/model/Product.dart';

class ItemStudent extends StatelessWidget {
  final Product? collageModel;
  const ItemStudent({
    super.key,
    required this.collageModel,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
      child: Container(
        width: double.infinity,
        height: 70,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.blueGrey[200],
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 15, 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Text('test'),
                  // CachedNetworkImage(
                  //   width: 60,
                  //   height: 70,
                  //   fit: BoxFit.cover,
                  //   imageUrl: collageModel!.photo ??
                  //       // 'https://raw.githubusercontent.com/Flutterando/modular/master/flutter_modular.png',
                  //       "https://firebasestorage.googleapis.com/v0/b/fakeapp-cb082.appspot.com/o/student%2Fuploads%2F099a.jpg?alt=media&token=5f79a021-c300-4764-893a-b96529d3eda6",
                  //   placeholder: (context, url) =>
                  //       const CupertinoActivityIndicator(),
                  //   errorWidget: (context, url, error) => const SizedBox(
                  //     width: 50,
                  //     height: 50,
                  //     child: Icon(
                  //       Icons.warning,
                  //       color: Colors.yellow,
                  //     ),
                  //   ),
                  // ),
                
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    collageModel!.namaProduct ?? 'null',
                    // style: GoogleFonts.poppins(
                    //   fontSize: 16,
                    //   fontWeight: FontWeight.w600,
                    // ),
                  ),
                  Text(
                    collageModel!.namaProduct ?? 'null',
                    // style: GoogleFonts.poppins(
                    //   fontSize: 16,
                    //   fontWeight: FontWeight.w600,
                    // ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}