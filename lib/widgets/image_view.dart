import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:photo_view/photo_view.dart';
import 'package:s_riza_sewakamera/constants/theme.dart';

class ImageView extends StatelessWidget {
  final String img;

  ImageView({this.img});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: PhotoView(
        imageProvider: CachedNetworkImageProvider(img),
        loadingBuilder: (context, progress) => Center(
          child: Container(
            width: 20.0,
            height: 20.0,
            child: SpinKitCircle(color: primaryColor),
          ),
        ),
      ),
    );
  }
}
