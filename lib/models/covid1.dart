class Covid1 {
  String txnDate ='';
  String province='';
  int newCase=0;
  int totalCase=0;
  int newCaseExcludeabroad=0;
  int totalCaseExcludeabroad=0;
  int newDeath=0;
  int totalDeath=0;
  String updateDate='';

  Covid1(
      {this.txnDate ='',
      this.province ='',
      this.newCase =0 ,
      this.totalCase =0,
      this.newCaseExcludeabroad =0,
      this.totalCaseExcludeabroad =0,
      this.newDeath=0,
      this.totalDeath=0,
      this.updateDate=''});

  Covid1.fromJson(Map<String, dynamic> json) {
    txnDate = json['txn_date'];
    province = json['province'];
    newCase = json['new_case'];
    totalCase = json['total_case'];
    newCaseExcludeabroad = json['new_case_excludeabroad'];
    totalCaseExcludeabroad = json['total_case_excludeabroad'];
    newDeath = json['new_death'];
    totalDeath = json['total_death'];
    updateDate = json['update_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['txn_date'] = this.txnDate;
    data['province'] = this.province;
    data['new_case'] = this.newCase;
    data['total_case'] = this.totalCase;
    data['new_case_excludeabroad'] = this.newCaseExcludeabroad;
    data['total_case_excludeabroad'] = this.totalCaseExcludeabroad;
    data['new_death'] = this.newDeath;
    data['total_death'] = this.totalDeath;
    data['update_date'] = this.updateDate;
    return data;
  }
}