class MenuModel {
  final int? id;
  final int? menuOrder;
  final String? name;
  final dynamic imagePath;
  final List<Activities>? activities;
  final int? menuLevel;

  MenuModel({
    this.id,
    this.menuOrder,
    this.name,
    this.imagePath,
    this.activities,
    this.menuLevel,
  });

  MenuModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        menuOrder = json['menuOrder'] as int?,
        name = json['name'] as String?,
        imagePath = json['imagePath'],
        activities = (json['activities'] as List?)?.map((dynamic e) => Activities.fromJson(e as Map<String, dynamic>)).toList(),
        menuLevel = json['menuLevel'] as int?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'menuOrder': menuOrder,
        'name': name,
        'imagePath': imagePath,
        'activities': activities?.map((e) => e.toJson()).toList(),
        'menuLevel': menuLevel
      };
}

class Activities {
  final int? id;
  final String? name;
  final dynamic pageUrl;
  final dynamic urlParams;
  final String? imagePath;
  final dynamic description;
  final String? deleted;
  final int? activityOrder;
  final SubMenu? subMenu;
  final List<ActivityRoleBindings>? activityRoleBindings;

  Activities({
    this.id,
    this.name,
    this.pageUrl,
    this.urlParams,
    this.imagePath,
    this.description,
    this.deleted,
    this.activityOrder,
    this.subMenu,
    this.activityRoleBindings,
  });

  Activities.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'] as String?,
        pageUrl = json['pageUrl'],
        urlParams = json['urlParams'],
        imagePath = json['imagePath'] as String?,
        description = json['description'],
        deleted = json['deleted'] as String?,
        activityOrder = json['activityOrder'] as int?,
        subMenu = (json['subMenu'] as Map<String, dynamic>?) != null ? SubMenu.fromJson(json['subMenu'] as Map<String, dynamic>) : null,
        activityRoleBindings =
            (json['activityRoleBindings'] as List?)?.map((dynamic e) => ActivityRoleBindings.fromJson(e as Map<String, dynamic>)).toList();

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'pageUrl': pageUrl,
        'urlParams': urlParams,
        'imagePath': imagePath,
        'description': description,
        'deleted': deleted,
        'activityOrder': activityOrder,
        'subMenu': subMenu?.toJson(),
        'activityRoleBindings': activityRoleBindings?.map((e) => e.toJson()).toList()
      };
}

class SubMenu {
  final int? id;
  final int? menuOrder;
  final String? name;
  final String? imagePath;
  final List<ActivitiesSubMenu>? activities;
  final int? menuLevel;

  SubMenu({
    this.id,
    this.menuOrder,
    this.name,
    this.imagePath,
    this.activities,
    this.menuLevel,
  });

  SubMenu.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        menuOrder = json['menuOrder'] as int?,
        name = json['name'] as String?,
        imagePath = json['imagePath'] as String?,
        activities = (json['activities'] as List?)?.map((dynamic e) => ActivitiesSubMenu.fromJson(e as Map<String, dynamic>)).toList(),
        menuLevel = json['menuLevel'] as int?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'menuOrder': menuOrder,
        'name': name,
        'imagePath': imagePath,
        'activities': activities?.map((e) => e.toJson()).toList(),
        'menuLevel': menuLevel
      };
}

class ActivitiesSubMenu {
  final int? id;
  final String? name;
  final String? pageUrl;
  final String? urlParams;
  final dynamic imagePath;
  final dynamic description;
  final String? deleted;
  final int? activityOrder;
  final dynamic subMenu;
  final List<ActivityRoleBindings>? activityRoleBindings;

  ActivitiesSubMenu({
    this.id,
    this.name,
    this.pageUrl,
    this.urlParams,
    this.imagePath,
    this.description,
    this.deleted,
    this.activityOrder,
    this.subMenu,
    this.activityRoleBindings,
  });

  ActivitiesSubMenu.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'] as String?,
        pageUrl = json['pageUrl'] as String?,
        urlParams = json['urlParams'] as String?,
        imagePath = json['imagePath'],
        description = json['description'],
        deleted = json['deleted'] as String?,
        activityOrder = json['activityOrder'] as int?,
        subMenu = json['subMenu'],
        activityRoleBindings =
            (json['activityRoleBindings'] as List?)?.map((dynamic e) => ActivityRoleBindings.fromJson(e as Map<String, dynamic>)).toList();

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'pageUrl': pageUrl,
        'urlParams': urlParams,
        'imagePath': imagePath,
        'description': description,
        'deleted': deleted,
        'activityOrder': activityOrder,
        'subMenu': subMenu,
        'activityRoleBindings': activityRoleBindings?.map((e) => e.toJson()).toList()
      };
}

class ActivityRoleBindings {
  final int? id;
  final int? activityId;
  final int? roleId;
  final dynamic userId;
  final String? deleted;
  final dynamic companyId;
  final int? permissionToCreate;
  final int? permissionToUpdate;
  final int? permissionToDelete;
  final int? permissionToCancel;
  final int? permissionToApprove;
  final int? permissionToPrint;
  final dynamic permissionToEmail;

  ActivityRoleBindings({
    this.id,
    this.activityId,
    this.roleId,
    this.userId,
    this.deleted,
    this.companyId,
    this.permissionToCreate,
    this.permissionToUpdate,
    this.permissionToDelete,
    this.permissionToCancel,
    this.permissionToApprove,
    this.permissionToPrint,
    this.permissionToEmail,
  });

  ActivityRoleBindings.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        activityId = json['activityId'] as int?,
        roleId = json['roleId'] as int?,
        userId = json['userId'],
        deleted = json['deleted'] as String?,
        companyId = json['companyId'],
        permissionToCreate = json['permissionToCreate'] as int?,
        permissionToUpdate = json['permissionToUpdate'] as int?,
        permissionToDelete = json['permissionToDelete'] as int?,
        permissionToCancel = json['permissionToCancel'] as int?,
        permissionToApprove = json['permissionToApprove'] as int?,
        permissionToPrint = json['permissionToPrint'] as int?,
        permissionToEmail = json['permissionToEmail'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'activityId': activityId,
        'roleId': roleId,
        'userId': userId,
        'deleted': deleted,
        'companyId': companyId,
        'permissionToCreate': permissionToCreate,
        'permissionToUpdate': permissionToUpdate,
        'permissionToDelete': permissionToDelete,
        'permissionToCancel': permissionToCancel,
        'permissionToApprove': permissionToApprove,
        'permissionToPrint': permissionToPrint,
        'permissionToEmail': permissionToEmail
      };
}

