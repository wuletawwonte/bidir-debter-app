
class Tenant  {
  int id;
  int tenanteeId;
  String itemType;
  String tenantType;
  String itemDetails;
  int itemQuantity;
  int deadline;


  Tenant(this.id, this.tenanteeId, this.tenantType, this.itemType, this.itemDetails, this.itemQuantity, this.deadline);
  
  Map<String, dynamic> toMap() {
    var map = <String, dynamic> {
      'tenant_id': id,
      'tenantee_id': tenanteeId,
      'item_type': itemType,
      'tenant_type': tenantType,
      'item_details': itemDetails,
      'item_quantity' : itemQuantity,
      'deadline': deadline
    };

    return map;
  }

  Tenant.fromMap(Map<String, dynamic> map) {
    id = map['tenant_id'];
    tenanteeId = map['tenantee_id'];
    itemType = map['item_type'];
    tenantType = map['tenant_type'];
    itemDetails = map['item_details'];
    itemQuantity = map['item_quantity'];
    deadline = map['deadline'];
  }

}