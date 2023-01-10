import 'package:cloud_firestore/cloud_firestore.dart';

class Video {
  String username;
  String uid;
  String id;
  List likes;
  int commentCount;
  int sharedCount;
  String videoName;
  String caption;
  String videoUrl;
  String thumbnailUrl;
  String profilePhoto;

  Video({
    required this.username,
    required this.uid,
    required this.id,
    required this.likes,
    required this.commentCount,
    required this.sharedCount,
    required this.videoName,
    required this.caption,
    required this.videoUrl,
    required this.thumbnailUrl,
    required this.profilePhoto,
  });

  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "id": id,
        "likes": likes,
        "commentCount": commentCount,
        "sharedCount": sharedCount,
        "videoName": videoName,
        "caption": caption,
        "videoUrl": videoUrl,
        "thumbnailUrl": thumbnailUrl,
        "profilePhoto": profilePhoto,
      };

  static Video fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Video(
        username: snapshot['username'],
        uid: snapshot['uid'],
        id: snapshot['id'],
        likes: snapshot['likes'],
        commentCount: snapshot['commentCount'],
        sharedCount: snapshot['sharedCount'],
        videoName: snapshot['videoName'],
        caption: snapshot['caption'],
        videoUrl: snapshot['videoUrl'],
        thumbnailUrl: snapshot['thumbnailUrl'],
        profilePhoto: snapshot['profilePhoto']);
  }
}
