import 'package:flutter/material.dart';
import 'package:sqflite_database/database/repositories/user_repository.dart';
import 'package:sqflite_database/ui/screens/home_page.dart';

import '../../database/model/users_model.dart';
import '../widgets/round_button.dart';

class EditUser extends StatefulWidget {
  final UsersModel usersModel ;
  EditUser({Key? key, required this.usersModel}) : super(key: key);

  @override
  State<EditUser> createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {

  @override
  void initState() {
    nameController.text = widget.usersModel.name! ;
    contactController.text = widget.usersModel.contact! ;
    addressController.text = widget.usersModel.address! ;
    pincodeController.text = widget.usersModel.pincode! ;
    // TODO: implement initState
    super.initState();
  }

  final userRepository = UserRepository() ;

  final nameController = TextEditingController();

  final contactController = TextEditingController();

  final addressController = TextEditingController();

  final pincodeController = TextEditingController();

  final formKey = GlobalKey<FormState>() ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit User'),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: (){
          FocusScope.of(context).requestFocus(FocusNode()) ;
        },
        child: Form(
          key: formKey,
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Container(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  fixedHeight(),
                  nameTextField(),
                  fixedHeight(),
                  contactTextField(),
                  fixedHeight(),
                  addressTextField(),
                  fixedHeight(),
                  pincodeTextField(),
                  fixedHeight(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      RoundButton(onTap: () async
                      {
                        if(formKey.currentState!.validate())
                        {
                          var user = UsersModel() ;
                          user.id = widget.usersModel.id;
                          user.name = nameController.text ;
                          user.contact = contactController.text ;
                          user.address = addressController.text ;
                          user.pincode = pincodeController.text ;

                          await userRepository.updateUser(user) ;

                          // Navigator.pop(context) ;

                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) => HomePage())
                          ) ;
                        }
                      }, title: 'Update',),
                      RoundButton(onTap: ()
                      {
                        nameController.text = '' ;
                        contactController.text = '' ;
                        addressController.text = '' ;
                        pincodeController.text = '' ;

                      }, title: 'CLear',),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  TextFormField pincodeTextField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      controller: pincodeController,
      style: TextStyle(fontSize: 16),
      decoration: InputDecoration(
        hintText: 'Enter pincode',
        label: Text(
          'Pincode',
          style: TextStyle(color: Colors.grey[600]),
        ),
        focusedBorder:
        OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        enabledBorder:
        OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        errorBorder:
        OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      validator: (text) {
        if (text!.isEmpty) {
          return 'Enter pincode';
        }
        else if(text.length != 5)
        {
          return 'Pincode must be of 5 digit' ;
        }
        return null;
      },
    );
  }

  TextFormField addressTextField() {
    return TextFormField(
      controller: addressController,
      style: TextStyle(fontSize: 16),
      decoration: InputDecoration(
        hintText: 'Enter address',
        label: Text(
          'Address',
          style: TextStyle(color: Colors.grey[600]),
        ),
        focusedBorder:
        OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        enabledBorder:
        OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        errorBorder:
        OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      validator: (text) {
        if (text!.isEmpty) {
          return 'Enter address';
        }
        return null;
      },
    );
  }

  TextFormField contactTextField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      controller: contactController,
      style: TextStyle(fontSize: 16),
      decoration: InputDecoration(
        hintText: 'Enter contact',
        label: Text(
          'Contact',
          style: TextStyle(color: Colors.grey[600]),
        ),
        focusedBorder:
        OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        enabledBorder:
        OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        errorBorder:
        OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      validator: (text) {
        if (text!.isEmpty) {
          return 'Enter contact';
        }
        return null;
      },
    );
  }

  TextFormField nameTextField() {
    return TextFormField(
      controller: nameController,
      style: TextStyle(fontSize: 16),
      decoration: InputDecoration(
        hintText: 'Enter name',
        label: Text(
          'Name',
          style: TextStyle(color: Colors.grey[600]),
        ),
        focusedBorder:
        OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        enabledBorder:
        OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        errorBorder:
        OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      validator: (text) {
        if (text!.isEmpty) {
          return 'Enter name';
        }
        return null;
      },
    );
  }

  SizedBox fixedHeight() => SizedBox(
    height: 10,
  );
}


