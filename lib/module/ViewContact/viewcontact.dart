import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:whats_app/models/Registermodel.dart';
import 'package:whats_app/module/ImageView/ImageView.dart';
import 'package:whats_app/shared/companents/companents.dart';
import 'package:whats_app/shared/companents/constans.dart';

class ViewContact extends StatelessWidget {
  RegisterModel model ;
  ViewContact(this.model);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              delegate: WhatsappAppbar(MediaQuery.of(context).size.width,model),
              pinned: true,
            ),
            SliverToBoxAdapter(
              child: Column(
                children:[PhoneAndName(model), ProfileIconButtons()],
              ),
            ),
            const WhatsappProfileBody()
          ],
        ),
      ),
    );
  }
}

class WhatsappAppbar extends SliverPersistentHeaderDelegate {
  double screenWidth;
  Tween<double>? profilePicTranslateTween;
  RegisterModel model ;
  WhatsappAppbar(this.screenWidth,this.model) {
    profilePicTranslateTween =
        Tween<double>(begin: screenWidth / 2 - 45 - 40 + 15, end: 40.0);
  }
  static final appBarColorTween = ColorTween(
      begin: Colors.white, end: green);

  static final appbarIconColorTween =
  ColorTween(begin: Colors.grey[800], end: Colors.white);

  static final phoneNumberTranslateTween = Tween<double>(begin: 20.0, end: 0.0);

  static final phoneNumberFontSizeTween = Tween<double>(begin: 20.0, end: 16.0);

  static final profileImageRadiusTween = Tween<double>(begin: 3.5, end: 1.0);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final relativeScroll = min(shrinkOffset, 45) / 45;
    final relativeScroll70px = min(shrinkOffset, 70) / 70;

    return Container(
      color: appBarColorTween.transform(relativeScroll),
      child: Stack(
        children: [
          Stack(
            children: [
              Positioned(
                left: 0,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back, size: 25),
                  color: appbarIconColorTween.transform(relativeScroll),
                ),
              ),
              Positioned(
                right: 0,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.more_vert, size: 25),
                  color: appbarIconColorTween.transform(relativeScroll),
                ),
              ),
              Positioned(
                  top: 15,
                  left: 90,
                  child: displayPhoneNumber(relativeScroll70px)),
              Positioned(
                  top: 5,
                  left: profilePicTranslateTween!.transform(relativeScroll70px),
                  child: displayProfilePicture(relativeScroll70px,context)),
            ],
          ),
        ],
      ),
    );
  }

  Widget displayProfilePicture(double relativeFullScrollOffset,context) {
    return Transform(
      transform: Matrix4.identity()
        ..scale(
          profileImageRadiusTween.transform(relativeFullScrollOffset),
        ),
      child:  InkWell(
        onTap: (){
          navigateTo(context, ImageView('${model.name}', '${model.profileImage}')) ;
        },
        child: CircleAvatar(
          //backgroundImage: NetworkImage('${model.profileImage}'),
          child: ClipOval(
            child: CachedNetworkImage(
              imageUrl: "${model.profileImage}",
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
              errorWidget: (context, url, error) => Icon(Icons.error),
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),

          ),
        ),
      ),
    );
  }

  Widget displayPhoneNumber(double relativeFullScrollOffset) {
    if (relativeFullScrollOffset >= 0.8) {
      return Transform(
        transform: Matrix4.identity()
          ..translate(
            0.0,
            phoneNumberTranslateTween
                .transform((relativeFullScrollOffset - 0.8) * 5),
          ),
        child: Text(
          "${model.name}",
          style: TextStyle(
            fontSize: phoneNumberFontSizeTween
                .transform((relativeFullScrollOffset - 0.8) * 5),
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    }

    return const SizedBox.shrink();
  }

  @override
  double get maxExtent => 120;

  @override
  double get minExtent => 50;

  @override
  bool shouldRebuild(WhatsappAppbar oldDelegate) {
    return true;
  }
}

class WhatsappProfileBody extends StatelessWidget {
  const WhatsappProfileBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
        delegate: SliverChildListDelegate(const [
          SizedBox(height: 20),
          ListTile(
            title: Text("Custom Notifications"),
            leading: Icon(Icons.notification_add),
          ),
          ListTile(
            title: Text("Disappearing messages"),
            leading: Icon(Icons.message),
          ),
          ListTile(
            title: Text("Mute Notifications"),
            leading: Icon(Icons.mic_off),
          ),
          ListTile(
            title: Text("Media visibility"),
            leading: Icon(Icons.save),
          ),
          // to fill up the rest of the space to enable scrolling
          SizedBox(
            height: 550,
          ),
        ]));
  }
}

class ProfileIconButtons extends StatelessWidget {
  const ProfileIconButtons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            Icon(
              Icons.call,
              size: 30,
              color: green,
            ),
            SizedBox(height: 5),
            Text(
              "Call",
              style: TextStyle(
                fontSize: 18,
                color:green,
              ),
            )
          ],
        ),
        const SizedBox(width: 20),
        Column(
          children:  [
            Icon(
              Icons.video_call,
              size: 30,
              color: green,
            ),
            SizedBox(height: 5),
            Text(
              "Video",
              style: TextStyle(
                fontSize: 18,
                color: green,
              ),
            )
          ],
        ),
        const SizedBox(width: 20),
        Column(
          children:  [
            Icon(
              Icons.save,
              size: 30,
              color: green,
            ),
            SizedBox(height: 5),
            Text(
              "Save",
              style: TextStyle(
                fontSize: 18,
                color: green,
              ),
            )
          ],
        ),
        const SizedBox(width: 20),
        Column(
          children: [
            Icon(
              Icons.search,
              size: 30,
              color:green,
            ),
            SizedBox(height: 5),
            Text(
              "Search",
              style: TextStyle(
                fontSize: 18,
                color:green,
              ),
            )
          ],
        ),
      ],
    );
  }
}

class PhoneAndName extends StatelessWidget {
  RegisterModel model ;
  PhoneAndName(this.model);

  @override
  Widget build(BuildContext context) {
    return Column(
      children:  [
        SizedBox(height: 35),
        Text(
          '${model.name}',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Text(
          "${model.phoneNumber}",
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        SizedBox(height: 30),
      ],
    );
  }
}



