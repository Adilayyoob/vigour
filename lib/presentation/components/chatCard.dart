// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:neumorphic_container/neumorphic_container.dart';
import 'package:vigour/presentation/components/fontLignt.dart';
import 'package:vigour/presentation/components/fontLigntHeader.dart';

class ChatCard extends StatelessWidget {
  final String userName;
  final String messageContent;
  final String userImageURL;
  const ChatCard(
      {required this.userName,
      required this.messageContent,
      required this.userImageURL});

  @override
  Widget build(BuildContext context) {
    return NeumorphicContainer(
      height: 152,
      width: 379,
      borderRadius: 20,
      primaryColor: Theme.of(context).primaryColor,
      child: Row(
        children: [
          const SizedBox(
            width: 15,
          ),
          Container(
            width: 3,
            height: 120,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Theme.of(context).primaryColorDark),
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  NeumorphicContainer(
                    width: 40,
                    height: 40,
                    borderRadius: 30,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Image.asset(
                        userImageURL,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  FontLightHeader(content: userName, contentSize: 18),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 320,
                height: 70,
                child: FontLight(
                  content: messageContent,
                  contentSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
