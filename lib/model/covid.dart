class Covid{
  final String txn_date;
  final int new_case;
  final int total_case;
  final int new_case_excludeabroad;
  final int total_case_excludeabroad;
  final int new_death;
  final int new_recovered;
  final int total_recovered;
  final String update_date;
  Covid({
    required this.txn_date,
    required this.new_case,
    required this.total_case,
    required this.new_case_excludeabroad,
    required this.total_case_excludeabroad,
    required this.new_death,
    required this.new_recovered,
    required this.total_recovered,
    required this.update_date,
  });

  factory Covid.fromJson( Map<String ,dynamic> json) {
    return Covid(
      txn_date: json['txn_date'],
      new_case: json['new_case'],
      total_case: json['total_case'],
      new_case_excludeabroad: json['new_case_excludeabroad'],
      total_case_excludeabroad: json['total_case_excludeabroad'],
      new_death: json['new_death'],
      new_recovered: json['new_recovered'],
      total_recovered: json['total_recovered'],
      update_date: json['update_date'],
    );
  }



}