import 'package:course_php/components/crud.dart';
import 'package:course_php/constant/linkAPI.dart';
import 'package:course_php/main.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with Crud {

  getNotes() async {
    var response = await postRequest(
      linkViewNote,
      {
        "id": sharedPref.getString("id"),
      },
    );
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, 'login');
                sharedPref.clear();
              },
              icon: const Icon(Icons.logout))
        ],
        title: const Text('home'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            FutureBuilder(
                future: getNotes(),
                builder: (context, AsyncSnapshot<Object?> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data['data'].length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Text(
                          "${snapshot.data['data'][index]["notes_title"]}",
                        );
                      },
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return const Center(
                    child: Text("loading..."),
                  );
                })
          ],
        ),
      ),
    );
  }
}
