class Covid {
  String txnDate = '';
  int newCase = 0;
  int totalCase = 0;
  int newCaseExcludeabroad = 0;
  int totalCaseExcludeabroad = 0;
  int newDeath = 0;
  int totalDeath = 0;
  int newRecovered = 0;
  int totalRecovered = 0;
  String updateDate = '';

  Covid(
      {this.txnDate = '',
      this.newCase = 0,
      this.totalCase = 0,
      this.newCaseExcludeabroad = 0,
      this.totalCaseExcludeabroad = 0,
      this.newDeath = 0,
      this.totalDeath = 0,
      this.newRecovered = 0,
      this.totalRecovered = 0,
      this.updateDate = ''});

  Covid.fromJson(Map<String, dynamic> json) {
    txnDate = json['txn_date'];
    newCase = json['new_case'];
    totalCase = json['total_case'];
    newCaseExcludeabroad = json['new_case_excludeabroad'];
    totalCaseExcludeabroad = json['total_case_excludeabroad'];
    newDeath = json['new_death'];
    totalDeath = json['total_death'];
    newRecovered = json['new_recovered'];
    totalRecovered = json['total_recovered'];
    updateDate = json['update_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['txn_date'] = this.txnDate;
    data['new_case'] = this.newCase;
    data['total_case'] = this.totalCase;
    data['new_case_excludeabroad'] = this.newCaseExcludeabroad;
    data['total_case_excludeabroad'] = this.totalCaseExcludeabroad;
    data['new_death'] = this.newDeath;
    data['total_death'] = this.totalDeath;
    data['new_recovered'] = this.newRecovered;
    data['total_recovered'] = this.totalRecovered;
    data['update_date'] = this.updateDate;
    return data;
  }
}
