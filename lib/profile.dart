import 'package:blug_club/data.dart';
import 'package:blug_club/home.dart';
import 'package:flutter/material.dart';

import 'gen/assets.gen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final posts = AppDatabase.posts;
    final themeData = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: themeData.colorScheme.background.withOpacity(0),
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_horiz_rounded),
            onPressed: () {},
          ),
          const SizedBox(
            width: 16,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Stack(
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(32, 0, 32, 64),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: themeData.colorScheme.surface,
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 10,
                          color:
                              themeData.colorScheme.onBackground.withOpacity(0.2))
                    ]),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Row(
                          children: [
                            ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Assets.img.stories.story8
                                    .image(width: 84, height: 84)),
                            const SizedBox(
                              width: 16,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('@Jovidan'),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Text('Jovi Daniel',
                                      style: themeData.textTheme.bodyLarge!
                                          .copyWith(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 15)),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text('ux designer',
                                      style: themeData.textTheme.bodyLarge!.apply(
                                          color: themeData.colorScheme.primary))
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(32, 0, 32, 0),
                        child: Text(
                          'About me',
                          style: themeData.textTheme.titleLarge,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(32, 4, 32, 32),
                        child: Text(
                          'Madison Blackstone is a director of user experience design, with experience managing global teams.',
                          style: themeData.textTheme.bodyLarge!
                              .copyWith(fontWeight: FontWeight.w200),
                        ),
                      ),
                      const SizedBox(
                        height: 32,
                      )
                    ]),
              ),
              Positioned(
                  bottom: 32,
                  right: 96,
                  left: 96,
                  child: Container(
                    height: 32,
                    decoration: BoxDecoration(color: Colors.blue, boxShadow: [
                      BoxShadow(
                          blurRadius: 30,
                          color:
                              themeData.colorScheme.onBackground.withOpacity(0.8))
                    ]),
                  )),
              Positioned(
                  bottom: 32,
                  left: 64,
                  right: 64,
                  child: Container(
                    height: 68,
                    decoration: BoxDecoration(
                        color: themeData.colorScheme.primary,
                        borderRadius: BorderRadius.circular(12)),
                    child: Row(children: [
                      Expanded(
                          flex: 1,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: const Color(0xff2151cd)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '52',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: themeData.colorScheme.onPrimary),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  'Post',
                                  style: themeData.textTheme.bodyLarge!.copyWith(
                                      fontWeight: FontWeight.w200,
                                      color: themeData.colorScheme.onPrimary),
                                )
                              ],
                            ),
                          )),
                      Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '250',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: themeData.colorScheme.onPrimary),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                'Folowing',
                                style: themeData.textTheme.bodyLarge!.copyWith(
                                    fontWeight: FontWeight.w200,
                                    color: themeData.colorScheme.onPrimary),
                              )
                            ],
                          )),
                      Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '4.5K',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: themeData.colorScheme.onPrimary),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                'Folwers',
                                style: themeData.textTheme.bodyLarge!.copyWith(
                                    fontWeight: FontWeight.w200,
                                    color: themeData.colorScheme.onPrimary),
                              )
                            ],
                          ))
                    ]),
                  ))
            ],
          ),
          Container(
            decoration: BoxDecoration(
              color: themeData.colorScheme.surface,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(32), topRight: Radius.circular(32))),
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                Expanded(child: Text('My Posts',style: themeData.textTheme.titleLarge,)),
                IconButton(onPressed: (){}, icon: Assets.img.icons.grid.svg()),
                 IconButton(onPressed: (){}, icon: Assets.img.icons.table.svg())
              ],),
            ),
              for(int i = 0 ;i<posts.length;i++)
              PostItem(post: posts[i])
          ]),)
        ]),
      ),
    );
  }
}
