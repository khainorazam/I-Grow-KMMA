import 'package:flutter/material.dart';

Widget feedBox(String avatarUrl, String userName, String date,
    String contentText, String contentImg) {
  if (contentImg != "") {
    return Column(
      children: [
        PhysicalModel(
          color: Colors.transparent,
          shadowColor: Colors.green,
          elevation: 20,
          child: Container(
            margin: EdgeInsets.only(bottom: 20.0),
            width: 360,
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                AvatarandUsername(avatarUrl, userName, date),
                SizedBox(
                  height: 10,
                ),
                Text(
                  contentText,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 200,
                      child: FittedBox(
                        fit: BoxFit.fill,
                        child: Image.network(contentImg),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                LikeandDislike()
              ],
            ),
          ),
        ),
      ],
    );
  } else {
    return Column(
      children: [
        PhysicalModel(
          color: Colors.transparent,
          shadowColor: Colors.green,
          elevation: 20,
          child: Container(
            margin: EdgeInsets.only(bottom: 20.0),
            width: 360,
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                AvatarandUsername(avatarUrl, userName, date),
                SizedBox(
                  height: 10,
                ),
                Text(
                  contentText,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                LikeandDislike()
              ],
            ),
          ),
        ),
      ],
    );
  }
}

Widget AvatarandUsername(String avatarUrl, String userName, String date) {
  return Row(
    children: <Widget>[
      FittedBox(
        fit: BoxFit.contain,
        child: CircleAvatar(backgroundImage: NetworkImage(avatarUrl)),
      ),
      SizedBox(
        width: 8,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(userName,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Text(
            date,
            style: TextStyle(color: Colors.grey[600]),
          )
        ],
      )
    ],
  );
}

Widget LikeandDislike() {
  return Container(
    width: double.infinity,
    height: 40,
    decoration: BoxDecoration(
        border: Border(
            top: BorderSide(
              color: Colors.grey.shade500,
            ),
            bottom: BorderSide(
              color: Colors.grey.shade500,
            ))),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Row(
          children: [
            IconButton(
              iconSize: 20,
              onPressed: () {},
              icon: Icon(Icons.thumb_up_outlined, color: Colors.grey[500]
                  //_likeStatus ? Colors.green[700] : Colors.grey[500],
                  ),
              tooltip: "Like this post",
            ),
            Text(
              "Like",
              style: TextStyle(fontSize: 14, color: Colors.grey[500]
                  //_likeStatus ? Colors.green[700]: Colors.grey[500]
                  ),
            )
          ],
        ),
        Row(
          children: [
            IconButton(
              iconSize: 20,
              onPressed: () {},
              icon: Icon(Icons.thumb_down_outlined, color: Colors.grey[500]
                  //_likeStatus ? Colors.green[700] : Colors.grey[500],
                  ),
              tooltip: "Like this post",
            ),
            Text(
              "Dislike",
              style: TextStyle(fontSize: 14, color: Colors.grey[500]
                  //_likeStatus ? Colors.green[700]: Colors.grey[500]
                  ),
            )
          ],
        ),
      ],
    ),
  );
}
