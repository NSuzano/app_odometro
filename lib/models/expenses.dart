import 'package:app_odometro/models/categories.dart';
import 'package:app_odometro/models/user.dart';

class Expenses {
  int? id;
  String? type;
  String? externalCode;
  String? transactionCode;
  String? description;
  String? grossAmount;
  String? netAmount;
  String? status;
  String? dueDate;
  String? paymentDate;
  String? cancellationDate;
  String? clearanceDate;
  int? branchId;
  int? groupTaxaId;
  int? categoryId;
  String? centerOfCost;
  String? project;
  int? userId;
  String? createdAt;
  String? updatedAt;
  User? user;
  Categories? category;

  Expenses(
      {this.id,
      this.type,
      this.externalCode,
      this.transactionCode,
      this.description,
      this.grossAmount,
      this.netAmount,
      this.status,
      this.dueDate,
      this.paymentDate,
      this.cancellationDate,
      this.clearanceDate,
      this.branchId,
      this.groupTaxaId,
      this.categoryId,
      this.centerOfCost,
      this.project,
      this.userId,
      this.createdAt,
      this.updatedAt,
      this.user,
      this.category});

  Expenses.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'] ?? "";
    externalCode = json['external_code'] ?? "";
    transactionCode = json['transaction_code'] ?? "";
    description = json['description'] ?? "";
    grossAmount = json['gross_amount'] ?? "";
    netAmount = json['net_amount'] ?? "";
    status = json['status'] ?? "";
    dueDate = json['due_date'] ?? "";
    paymentDate = json['payment_date'] ?? "";
    cancellationDate = json['cancellation_date'] ?? "";
    clearanceDate = json['clearance_date'] ?? "";
    branchId = json['branch_id'] ?? "";
    groupTaxaId = json['group_taxa_id'] ?? "";
    categoryId = json['category_id'] ?? "";
    centerOfCost = json['center_of_cost'] ?? "";
    project = json['project'] ?? "";
    userId = json['user_id'] ?? "";
    createdAt = json['created_at'];
    updatedAt = json['updated_ at'];
    user = json['user'] != null ? User.fromJsonAlt(json['user']) : null;
    category = json['category'] != null
        ? Categories.fromJsonAlt(json['category'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    data['external_code'] = externalCode;
    data['transaction_code'] = transactionCode;
    data['description'] = description;
    data['gross_amount'] = grossAmount;
    data['net_amount'] = netAmount;
    data['status'] = status;
    data['due_date'] = dueDate;
    data['payment_date'] = paymentDate;
    data['cancellation_date'] = cancellationDate;
    data['clearance_date'] = clearanceDate;
    data['branch_id'] = branchId;
    data['group_taxa_id'] = groupTaxaId;
    data['category_id'] = categoryId;
    data['center_of_cost'] = centerOfCost;
    data['project'] = project;
    data['user_id'] = userId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (category != null) {
      data['category'] = category!.toJson();
    }
    return data;
  }
}
