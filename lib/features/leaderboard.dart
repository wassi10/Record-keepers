import 'package:flutter/material.dart';
import 'package:flutter_new/theme.dart';

class LeaderBoard extends StatefulWidget {
  const LeaderBoard({Key? key}) : super(key: key);

  @override
  State<LeaderBoard> createState() => _LeaderBoardState();
}

class _LeaderBoardState extends State<LeaderBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // appBar: AppBar(
      //   backgroundColor: primaryColor,
      //   leading: Icon(Icons.arrow_back),
      //   actions: [
      //     IconButton(onPressed: (){}, icon: Icon(Icons.share)),
      //     IconButton(onPressed: (){}, icon: Icon(Icons.person_add)),
      //   ],
      //   title: Text(
      //     "Profile",
      //     style: TextStyle(fontSize: 28),
      //   ),
      //   centerTitle: true,
      //   elevation: 0.0,
      // ),
      body: SingleChildScrollView(

        child: Column(
          children: [
            //SizedBox(height: 40,),
            Container(
              padding: const EdgeInsets.only(top: 40),
              height: 330,
              decoration: const BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20))),
              child: Column(
                children: [
                  Stack(
                    children: [
                      const CircleAvatar(
                        backgroundImage: NetworkImage(
                            "https://images.unsplash.com/photo-1511367461989-f85a21fda167?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1331&q=80"),
                        radius: 50,
                      ),

                      Positioned(
                        bottom: 0.0,
                        right: 0.0,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(shape: BoxShape.circle,color: Colors.white),child: const Icon(Icons.edit, color: Colors.blueAccent,),),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Riya",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Divider(
                    thickness: 1,
                    indent: 20,
                    endIndent: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text(
                            "45",
                            style: TextStyle(
                                fontSize: 42,
                                fontWeight: FontWeight.w300,
                                color: Colors.white.withOpacity(0.9)),
                          ),
                          const Text("Level",
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                        ],
                      ),
                      Column(
                        children: [
                          Text("#335",
                              style: TextStyle(
                                  fontSize: 42,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white.withOpacity(0.9))),
                          const Text("Rank",
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Leader Board",
              style: TextStyle(fontSize: 20),
            ),
            Container(
              margin: const EdgeInsets.all(20),
              child: SizedBox(
                height: 200,
                child: ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Row(
                          children: const [
                            CircleAvatar(
                              backgroundImage: NetworkImage(
                                  "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80"),
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Text("Riya")
                          ],
                        ),
                        leading: Text("#${index + 1}", style: const TextStyle(fontWeight: FontWeight.bold),),
                        trailing: Text(
                          "Rs.${(200000 / (index + 1)).toString().substring(0, 5)}", style: const TextStyle(fontWeight: FontWeight.bold),),
                      );
                    },
                    separatorBuilder: (Context, index) => const Divider(thickness: 1,color: Colors.blue,indent: 10, endIndent: 10,),
                    itemCount: 12),
              ),
            )
          ],
        ),
      ),
    );
  }
}

