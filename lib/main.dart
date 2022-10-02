import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final List<String> tabs = ['Галерея', 'Мои фото'];

  Map<String, dynamic> data = {
    'Мои фото': [
      'https://images.unsplash.com/photo-1546587348-d12660c30c50?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8N3x8bmF0dXJhbHxlbnwwfHwwfHw%3D&w=1000&q=80',
      'https://upload.wikimedia.org/wikipedia/commons/c/c8/Altja_jõgi_Lahemaal.jpg',
      'https://img.freepik.com/free-photo/wide-angle-shot-single-tree-growing-clouded-sky-during-sunset-surrounded-by-grass_181624-22807.jpg?w=2000',
    ],
    'Галерея': [
      'https://wallpaperaccess.com/full/1131217.jpg',
      'https://images.pexels.com/photos/414102/pexels-photo-414102.jpeg?cs=srgb&dl=pexels-pixabay-414102.jpg&fm=jpg',
      'https://cdn-prod.medicalnewstoday.com/content/images/articles/325/325466/man-walking-dog.jpg',
    ]
  };

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Gallery'),
          bottom: TabBar(
              tabs: tabs
                  .map((String item) => Tab(
                        text: item,
                      ))
                  .toList()),
        ),
        body: TabBarView(
          children: tabs.map((name) {
            return ListView(
              key: PageStorageKey(name),
              children: <Widget>[
                ...data[name].map((value) => Card(
                      margin: const EdgeInsets.all(8),
                      child: Image.network(
                        value,
                        fit: BoxFit.cover,
                        height: 250,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          );
                        },
                      ),
                    ))
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
