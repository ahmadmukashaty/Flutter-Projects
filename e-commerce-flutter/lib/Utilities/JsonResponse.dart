class JsonResponse {
  int status;
  String msg;
  dynamic result;

  JsonResponse({this.status, this.msg, this.result});

  Map toJson() => {
        'status': status,
        'msg': msg,
        'result': result,
      };
}
