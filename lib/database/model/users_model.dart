class UsersModel
{
  int? id ;
  String? name ;
  String? contact ;
  String? address ;
  String? pincode ;

  toMap()
  {
    var mapping = Map<String,dynamic>() ;

    mapping['id'] = id ;
    mapping['name'] = name ;
    mapping['contact'] = contact ;
    mapping['address'] = address ;
    mapping['pincode'] = pincode ;

    return mapping ;
  }
}