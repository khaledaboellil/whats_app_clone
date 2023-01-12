import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageView extends StatelessWidget {

  String title ;
  String Image;
  ImageView(this.title,this.Image);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(title,style: TextStyle(color: Colors.white),),
      ),
      backgroundColor: Colors.black,
      body: Center(child: InteractiveViewer(
        clipBehavior: Clip.none,
        child: Container(
          width: double.infinity,
          height: 400,
          child: CachedNetworkImage(
            imageUrl: Image,
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
            errorWidget: (context, url, error) => Icon(Icons.error),
            width: 180,
            height: 180,
            fit: BoxFit.cover,
          ),
        ),
      ),),
    );
  }
}
