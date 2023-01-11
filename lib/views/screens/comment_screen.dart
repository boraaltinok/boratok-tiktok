import 'package:boratok/constants.dart';
import 'package:boratok/controllers/comment_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as tago;

class CommentScreen extends StatelessWidget {
  final String videoId;

  CommentScreen({Key? key, required this.videoId}) : super(key: key);

  final TextEditingController _commentController = TextEditingController();
  CommentController commentController = Get.put(CommentController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    commentController.updatePostId(videoId);

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: SizedBox(
            width: size.width,
            height: size.height,
            child: Column(
              children: [
                Expanded(child: Obx(() {
                  return ListView.builder(
                      itemCount: commentController.comments.length,
                      itemBuilder: (context, index) {
                        final comment = commentController.comments[index];
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.black,
                            backgroundImage: NetworkImage(comment.profilePhoto),
                          ),
                          title: Row(
                            children: [
                              Text(
                                '${comment.username}  ',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.red,
                                    fontWeight: FontWeight.w700),
                              ),
                              Text(
                                comment.comment,
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          subtitle: Row(
                            children: [
                              Text(tago.format(comment.datePublished.toDate()),
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.white)),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                '${comment.likes.length.toString()} likes',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
                              )
                            ],
                          ),
                          trailing: InkWell(
                              onTap: () {
                                commentController.likeComment(comment.id);
                              },
                              child: Icon(
                                Icons.favorite,
                                size: 25,
                                color: comment.likes
                                        .contains(authController.user.uid)
                                    ? Colors.red
                                    : Colors.white,
                              )),
                        );
                      });
                })),
                const Divider(),
                ListTile(
                  title: TextFormField(
                    controller: _commentController,
                    style: TextStyle(fontSize: 16, color: Colors.white),
                    decoration: const InputDecoration(
                        labelText: 'Comment',
                        labelStyle: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w700),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red))),
                  ),
                  trailing: TextButton(
                    onPressed: () {
                      commentController.postComment(_commentController.text);
                      _commentController.text = "";
                    },
                    child: const Text(
                      'Send',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
