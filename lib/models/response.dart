class Response {
  bool valido = false;
  String msg = '';

  Response.fromJson(Map<String, dynamic> json, {bool}) {
    valido = json['valido'];
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['valido'] = this.valido;
    data['msg'] = this.msg;

    return data;
  }
}
