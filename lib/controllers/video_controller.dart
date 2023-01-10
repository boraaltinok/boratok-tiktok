import 'package:boratok/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../models/video.dart';

class VideoController extends GetxController {
  final Rx<List<Video>> _videoList =
      Rx<List<Video>>([]); //observable so it makes it real time

  List<Video> get videoList => _videoList.value;

  @override
  void onInit() {
    super.onInit();
    _videoList.bindStream(
        firestore.collection('videos').snapshots().map((QuerySnapshot query) {
      List<Video> retVal = [];
      for (var element in query.docs) {
        retVal.add(Video.fromSnap(element));
      }
      return retVal;
    }));
  }
  likeVideo(String id) async{
    DocumentSnapshot doc = await firestore.collection('videos').doc(id).get();
    var uid = authController.user.uid;

    //if user already liked the video remove the user's like(uid) from likes in the video
    //if user did not already liked the photo => add the (uid) to the likes array in the video
    if((doc.data()! as dynamic)['likes'].contains(uid)){
      await firestore.collection('videos').doc(id).update({
        'likes': FieldValue.arrayRemove([uid])
      });
    }else{
      await firestore.collection('videos').doc(id).update({
        'likes': FieldValue.arrayUnion([uid])
      });
    }
  }
}