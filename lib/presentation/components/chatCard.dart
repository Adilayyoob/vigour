// Each message card in community chat.
// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:neumorphic_container/neumorphic_container.dart';
import 'package:vigour/presentation/components/fontLight.dart';
import 'package:vigour/presentation/components/fontLightHeader.dart';

class ChatCard extends StatelessWidget {
  final String userName;
  final String messageContent;
  final Image userImageURL;
  final String publishedDate;
  const ChatCard(
      {required this.userName,
      required this.messageContent,
      required this.userImageURL,
      required this.publishedDate});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10, top: 10),
          child: FontLight(content: publishedDate, contentSize: 14),
        ),
        NeumorphicContainer(
          borderRadius: 20,
          primaryColor: Theme.of(context).primaryColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
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
              Expanded(
                child: SizedBox(
                  height: 140,
                  child: ListView(
                    primary: false,
                    padding: EdgeInsets.only(top: 0, bottom: 10),
                    children: [
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
                                  child: userImageURL,
                                ),
                              ),
                              const SizedBox(
                                width: 30,
                              ),
                              FontLightHeader(
                                  content: userName, contentSize: 18),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            child: FontLight(
                              content: messageContent,
                              contentSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
