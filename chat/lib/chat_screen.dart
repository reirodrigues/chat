import 'dart:io';
import 'package:chat/text_compose.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'chat_messenger.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isLoading = false;

  User? _currentUser;

  @override
  void initState() {
    super.initState();

    FirebaseAuth.instance.authStateChanges().listen((user) {
      setState(() {
        _currentUser = user;
      });
    });
  }

  Future<User?> getUser() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    if (_currentUser != null) return _currentUser;

    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();

      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken,
      );

      final UserCredential userCredential =
          await auth.signInWithCredential(credential);

      user = userCredential.user;
      return user;
    } catch (err) {
      print(err);

      return null;
    }
  }

  void _sendMessage({String? text, File? photo}) async {
    final User? user = await getUser();

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Não foi possivel fazer login, tente novamente!'),
          backgroundColor: Colors.red,
        ),
      );
    }

    Map<String, dynamic> data = {
      "uid": user!.uid,
      "senderName": user.displayName,
      "senderPhotoUrl": user.photoURL,
      "time": Timestamp.now(),
    };

    if (photo != null) {
      UploadTask task = FirebaseStorage.instance
          .ref()
          .child(user.uid + DateTime.now().millisecondsSinceEpoch.toString())
          .putFile(photo);

      setState(() {
        isLoading = true;
      });

      TaskSnapshot taskSnapshot = await task;
      String url = await taskSnapshot.ref.getDownloadURL();
      print(url);
      data['imgUrl'] = url;

      setState(() {
        isLoading = false;
      });
    }

    if (text != null) data['text'] = text;

    FirebaseFirestore.instance.collection('messages').doc().set(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: _currentUser != null ? false : true,
        title: Text(_currentUser != null
            ? 'Olá, ${_currentUser?.displayName}'
            : 'Chat App'),
        elevation: 0,
        actions: [
          _currentUser != null
              ? IconButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    _googleSignIn.signOut();
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Você saiu com sucesso!'),
                    ));
                  },
                  icon: const Icon(Icons.exit_to_app))
              : Container()
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('messages')
                  .orderBy('time')
                  .snapshots(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return const Center(child: CircularProgressIndicator());
                  default:
                    List<DocumentSnapshot> documents =
                        snapshot.data!.docs.reversed.toList();
                    return ListView.builder(
                      itemCount: documents.length,
                      reverse: true,
                      itemBuilder: ((context, index) {
                        return ChatMessenger(
                          documents[index].data() as Map<String, dynamic>,
                          true,
                          // documents[index].get('uid') == _currentUser?.uid,
                        );
                      }),
                    );
                }
              },
            ),
          ),
          isLoading ? const LinearProgressIndicator() : Container(),
          TextCompose(_sendMessage),
        ],
      ),
    );
  }
}
