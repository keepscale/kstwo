class ErrorMessage{
  String message;
  List<ErrorDetail> errors;

  
  static ErrorMessage fromJson(data) {
    ErrorMessage e = new ErrorMessage();
    e.message = data['message'];
    var errors = (data['errors'] as List)??[];
    e.errors = errors.map(
                  (edetail) => ErrorDetail(
                    message: edetail['message'], 
                    reasons: (edetail['reasons'] as List).map((_)=>_["message"].toString()).toList()
                  )
                ).toList();
    return e;
  }

}

class ErrorDetail{
  final String message;
  final List<String> reasons;

  ErrorDetail({this.message, this.reasons});
}