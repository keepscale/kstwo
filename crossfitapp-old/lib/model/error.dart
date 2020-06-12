class ErrorMessage{
  String message;
  List<ErrorDetail> errors;

  
  static ErrorMessage fromJson(data) {
    ErrorMessage e = new ErrorMessage();
    e.message = data['message'];
    e.errors = (data['errors'] as List)??[].map(
                  (edetail) => ErrorDetail(edetail['message'], (edetail['reasons'] as List).map((_)=>_.toString()).toList())
                ).toList();
    return e;
  }

}

class ErrorDetail{
  final String message;
  final List<String> reasons;

  ErrorDetail(this.message, this.reasons);
}