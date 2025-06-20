
class PartyContactDetails {
  dynamic id;
  dynamic partyId;
  dynamic deleted;
  dynamic name;
  String? department;
  String? designation;
  int? departmentId;
  int? designationId;
  dynamic email;
  dynamic primaryPhoneNumber;
  dynamic secondaryPhoneNumber;
  dynamic remarks;
  dynamic companyId;
  dynamic isPrimary;
  dynamic imp;

  PartyContactDetails({
    this.id,
    this.partyId,
    this.deleted,
    this.name,
    this.department,
    this.designation,
    this.departmentId,
    this.designationId,
    this.email,
    this.primaryPhoneNumber,
    this.secondaryPhoneNumber,
    this.remarks,
    this.companyId,
    this.isPrimary,
    this.imp,
  });

  PartyContactDetails.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        partyId = json['partyId'],
        deleted = json['deleted'],
        name = json['name'],
        department = json['department'] as String?,
        designation = json['designation'] as String?,
        departmentId = json['departmentId'] as int?,
        designationId = json['designationId'] as int?,
        email = json['email'],
        primaryPhoneNumber = json['primaryPhoneNumber'],
        secondaryPhoneNumber = json['secondaryPhoneNumber'],
        remarks = json['remarks'],
        companyId = json['companyId'],
        isPrimary = json['isPrimary'],
        imp = json['imp'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'partyId': partyId,
        'deleted': deleted,
        'name': name,
        'department': department,
        'designation': designation,
        'departmentId': departmentId,
        'designationId': designationId,
        'email': email,
        'primaryPhoneNumber': primaryPhoneNumber,
        'secondaryPhoneNumber': secondaryPhoneNumber,
        'remarks': remarks,
        'companyId': companyId,
        'isPrimary': isPrimary,
        'imp': imp
      };
}
