import 'package:demo_social_network/controller/remote_service.dart';
import 'package:flutter/material.dart';

import '../model/comment.dart';
// import 'package:flutter_application_1/moldel/post.dart';
// import 'package:flutter_application_1/moldel/comment.dart';
// import 'package:flutter_application_1/servies/remote_service.dart';

class Homepage extends StatefulWidget {
  Homepage({this.id, super.key});
  int? id;
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final newCmtControllor = TextEditingController();
  final oldCmtControllor = TextEditingController();
  Comment comment = Comment();
  List<Comment> comments = [];
  var isLoaded = true;
  var flagPostOrPut = false;

  @override
  void initState() {
    super.initState();

    // fetch data from API
    getData();
  }

  void updateData() {}

  getData() async {
    comments = await RemoteService().getComment(widget.id ?? 0) ?? [];
    if (comments != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  Future<void> updatData() async {
    List<Comment> updateList =
        await RemoteService().getComment(widget.id ?? 0) ?? [];
    setState(() {
      comments = updateList;
    });
  }

  @override
  Widget build(BuildContext context) {
    // final arg = ModalRoute.of(context)?.settings.arguments;
    // final arg =

    return Scaffold(
      appBar: AppBar(
        title: const Text("Commets "),
      ),
      body: Visibility(
        visible: isLoaded,
        child: ListView.builder(
          itemCount: comments?.length,
          itemBuilder: ((context, index) {
            return Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.grey[300],
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                // if (args.isNotEmpty) {
                                //   newCmtControllor.text = args[1];
                                // }
                                setState(() {
                                  newCmtControllor.text =
                                      comments![index].body ?? '';
                                  comment = comments[index];
                                  flagPostOrPut = true;
                                });
                                print(flagPostOrPut);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    Text(
                                      comments?[index].name ?? "",
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      comments?[index].body ?? '',
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      // style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),)
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Text("Time"),
                                TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      "Thích",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )),
                                TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      "Phản hồi",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
              ],
            );
          }),
        ),
        replacement: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          height: kToolbarHeight,
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          padding: const EdgeInsets.only(left: 16, right: 8),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQs2P8p8_JPq5zu3mRzDWmM5tQb7zfqlslmMw&usqp=CAU",
                ),
                radius: 18,
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 8),
                child: TextField(
                  controller: newCmtControllor,
                  decoration: InputDecoration(
                    hintText: "Comment here!",
                    border: InputBorder.none,
                  ),
                ),
              )),
              InkWell(
                onTap: () async {
                  print('flagPostOrPut1 = $flagPostOrPut');
                  // print("123");

                  // await RemoteService().postComment(comment);
                  // if (flagPostOrPut == true) {
                  // comment.id = 1000;
                  // comment.postId = widget.id;
                  // comment.name = "a";
                  // comment.email = "quyet123@gmail.com";
                  // comment.body = newCmtControllor.text;
                  // await RemoteService().updateComment(comment);
                  //   flagPostOrPut = false;
                  //   print(comment.toJsonPut());
                  // }
                  // print('flagPostOrPut2 = $flagPostOrPut');
                  // else {
                  comment.id = 1000;
                  comment.postId = widget.id;
                  comment.name = "a";
                  comment.email = "quyet123@gmail.com";
                  comment.body = newCmtControllor.text;
                  await RemoteService().postComment(comment);
                  updatData();
                  // }
                  // print('new cmt = ${newCmtControllor.text.isEmpty}');
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 8,
                  ),
                  child: Icon(
                    Icons.send,
                    size: 35,
                    color: Colors.blue,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
