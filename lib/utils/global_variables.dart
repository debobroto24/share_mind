import 'package:flutter/material.dart';
import 'package:instragram_flutter/screens/add_post_screen.dart';
import 'package:instragram_flutter/screens/feed_screen.dart';

const webScreenSize = 600;

const homeScreenItems = [
  // ignore: unnecessary_const
  const FeedScreen(),
  Text("search"),
  AddPostScreen(),
  Text("favorite"),
  Text("person"),
];
