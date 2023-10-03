// ignore_for_file: public_member_api_docs, sort_constructors_first
class ProcessAndPermisstion {
  static ProcessModelPermission1 trips = ProcessModelPermission1(
      id: 1, permissons: PermissonsModel1(add: 1, edite: 2, delete: 3));
  static ProcessModelPermission1 service = ProcessModelPermission1(
      id: 2, permissons: PermissonsModel1(add: 4, delete: 5, edite: 6));
  static ProcessModelPermission1 serviceProvider = ProcessModelPermission1(
      id: 3, permissons: PermissonsModel1(add: 7, delete: 8, edite: 9));
  static ProcessModelPermission2 report = ProcessModelPermission2(
      id: 4,
      permissons: PermissonsModel2(
        view: 13,
        add: 14,
      ));
  static ProcessModelPermission3 userManagement = ProcessModelPermission3(
      id: 5,
      permissons: PermissonsModel3(add: 15, edite: 16, view: 17, delete: 18));
  static ProcessModelPermission4 customerRequest = ProcessModelPermission4(
      id: 6, permissons: PermissonsModel4(view: 19, add: 20, respons: 21));
}

class ProcessModelPermission1 {
  int id;
  PermissonsModel1 permissons;
  ProcessModelPermission1({
    required this.id,
    required this.permissons,
  });
}

class PermissonsModel1 {
  int add;
  int edite;
  int delete;
  PermissonsModel1({
    required this.add,
    required this.edite,
    required this.delete,
  });
}

class ProcessModelPermission2 {
  int id;
  PermissonsModel2 permissons;
  ProcessModelPermission2({
    required this.id,
    required this.permissons,
  });
}

class PermissonsModel2 {
  int add;
  int view;

  PermissonsModel2({
    required this.add,
    required this.view,
  });
}

class ProcessModelPermission3 {
  int id;
  PermissonsModel3 permissons;
  ProcessModelPermission3({
    required this.id,
    required this.permissons,
  });
}

class PermissonsModel3 {
  int add;
  int edite;
  int delete;
  int view;
  PermissonsModel3({
    required this.add,
    required this.edite,
    required this.delete,
    required this.view,
  });
}

class ProcessModelPermission4 {
  int id;
  PermissonsModel4 permissons;
  ProcessModelPermission4({
    required this.id,
    required this.permissons,
  });
}

class PermissonsModel4 {
  int add;
  int respons;
  int view;
  PermissonsModel4({
    required this.add,
    required this.respons,
    required this.view,
  });
}
