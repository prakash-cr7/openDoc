import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:opendoc/widgets.dart';
import 'package:provider/provider.dart';

import 'dataProvider.dart';

class ConvoScreen extends StatefulWidget {
  ConvoScreen({this.chat});
  final chat;

  @override
  _ConvoScreenState createState() => _ConvoScreenState();
}

class _ConvoScreenState extends State<ConvoScreen> {
  final messageTextController = TextEditingController();
  var _fireStore = FirebaseFirestore.instance;
  bool verified;
  String messageText, email, docId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    verified =
        Provider.of<DataProvider>(context, listen: false).getVerification();
    email = Provider.of<DataProvider>(context, listen: false).getEmail();
    docId = widget.chat.documentID;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kAccentColorDark,
        title: verified
            ? Text(widget.chat.data()['patientName'])
            : Text(widget.chat.data()['doctorName']),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            StreamBuilder(
              stream: _fireStore
                  .collection('chat')
                  .doc(docId)
                  .collection('messages')
                  .orderBy('timeStamp', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                final messages = snapshot.data.documents;
                List<MessageBubble> messageWidget = [];
                for (var message in messages) {
                  final messageText = message.data()['text'];
                  final messageSender = message.data()['sender'];
                  final currentUser = email;
                  final messageTextWidget = MessageBubble(
                    text: messageText,
                    sender: messageSender,
                    isMe: currentUser == messageSender,
                  );
                  messageWidget.add(messageTextWidget);
                }
                return messageWidget.length == 0
                    ? Center(
                        child: Text(
                        widget.chat.data()['description'],
                        style: TextStyle(color: kAccentColorDark, fontSize: 18),
                      ))
                    : Expanded(
                        child: ListView(
                          reverse: true,
                          padding: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 10),
                          children: messageWidget,
                        ),
                      );
              },
            ),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      await _fireStore
                          .collection('chat')
                          .doc(docId)
                          .collection('messages')
                          .add({
                        'text': messageText,
                        'timeStamp': DateTime.now(),
                        'sender': email
                      });
                      messageTextController.clear();
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  MessageBubble({this.sender, this.text, this.isMe});
  final String text;
  final String sender;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            sender,
            style: TextStyle(fontSize: 12, color: Colors.black45),
          ),
          Material(
            elevation: 8,
            borderRadius: BorderRadius.only(
                topLeft: isMe ? Radius.circular(20) : Radius.circular(0),
                topRight: !isMe ? Radius.circular(20) : Radius.circular(0),
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20)),
            color: isMe ? kAccentColorDark : Colors.green[100],
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text(
                '$text',
                style: TextStyle(
                    color: isMe ? Colors.white : Colors.black87, fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
