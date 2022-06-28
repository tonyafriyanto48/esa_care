class logindao {
  String? token;
  String? message;
  bool? status;

  logindao({this.token, this.message, this.status});

  logindao.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['message'] = this.message;
    data['status'] = this.status;
    return data;
  }
}
