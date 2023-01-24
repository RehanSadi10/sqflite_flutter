import 'package:flutter/material.dart';
import 'package:sqflite_database/database/repositories/user_repository.dart';
import 'package:sqflite_database/ui/screens/edit_user.dart';

import '../../database/model/users_model.dart';
import 'add_user.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<UsersModel>? userModel ;
  UserRepository userRepository = UserRepository();

  @override
  void initState() {
    getAllUserDetail() ;
    // TODO: implement initState
    super.initState();
  }

  getAllUserDetail() async
  {
    userModel = <UsersModel>[] ;
    final data = await userRepository.realAllUsers('users');

    data.forEach((var user){
      setState(() {
        final list = UsersModel() ;
        list.id = user['id'] ;
        list.name = user['name'] ;
        list.contact = user['contact'] ;
        list.address = user['address'] ;
        list.pincode = user['pincode'] ;

        userModel!.add(list) ;
      });
    });
  }

  _showSuccessSnacBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  _deleteFromDialog(BuildContext context,id)
  {
    return showDialog(context: context, builder: (param){
      return AlertDialog(
        title: Text(
          'Are you sure to delete',
          style: TextStyle(
            fontSize: 20,
            color: Colors.black
          ),
        ),
        actions: [
          TextButton(
              onPressed: (){
                Navigator.pop(context) ;
              },
              child: Text(
                'Close',
              ),
          ),
          TextButton(
            onPressed: ()async{
              final result = await userRepository.deleteUser(id) ;
              if(result != null)
              {
                setState(() {
                  Navigator.pop(context) ;
                });

                getAllUserDetail() ;
                _showSuccessSnacBar('Successfully delete the user') ;
              }
            },
            child: Text(
              'Delete',
            ),
          ),
        ],
      ) ;
    }) ;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{return false ;},
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'Sqflite Database',
          ),
          centerTitle: true,
        ),
        body: GestureDetector(
          onTap: (){
            FocusScope.of(context).requestFocus(FocusNode()) ;
          },
          child: Container(
            padding: EdgeInsets.all(8),
            child: ListView.builder(
              itemCount: userModel!.length,
              shrinkWrap: true,
                itemBuilder: (context,index)
                {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 5),
                    child: Container(
                      padding: EdgeInsets.all(8),
                      width: double.infinity,
                      height: 120,
                      decoration: BoxDecoration(
                          color: Colors.grey[200], borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              textWidget('Id : ${userModel![index].id??''}'),
                              textWidget('Name : ${userModel![index].name??''}'),
                              textWidget('Contact : ${userModel![index].contact??''}'),
                              textWidget('Address : ${userModel![index].address??''}'),
                              textWidget('Pincode : ${userModel![index].pincode}'),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                onPressed: (){
                                  Navigator.of(context).push(
                                    MaterialPageRoute(builder: (context) => EditUser(usersModel: userModel![index],))
                                  ).then((value) {
                                    if(value != null)
                                    {
                                      getAllUserDetail() ;
                                      _showSuccessSnacBar('successfully edit the user') ;
                                    }
                                  }) ;
                                },
                                icon: Icon(
                                  Icons.edit,
                                  color: Colors.grey[700],
                                ),
                              ),
                              IconButton(
                                onPressed: (){
                                  _deleteFromDialog(context, userModel![index].id) ;
                                },
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ) ;
                }
            ),
          ),
        ),

        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () {
                userRepository.deleteAllUser() ;
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => HomePage()),
                ) ;
              },
              child: Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 10,),
            FloatingActionButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => AddUser()))
                    .then((data) {
                  if (data != null) {
                    getAllUserDetail() ;
                    _showSuccessSnacBar('User detail added successfully');
                  }
                });
              },
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 10,),
          ],
        ),
      ),
    );
  }

  Text textWidget(String title) {
    return Text(
      title,
      style: TextStyle(fontSize: 16, color: Colors.grey[800]),
    );
  }
}
