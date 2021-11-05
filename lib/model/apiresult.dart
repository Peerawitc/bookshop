class ApiResult {

  final Map<String ,dynamic> data;

  ApiResult({
    required this.data,
  });

  factory ApiResult.fromJson(Map<String ,dynamic> json) {
    return ApiResult(
      data: json,
    );
  }
}