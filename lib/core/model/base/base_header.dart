class Header {
  final String key;
  final String value;

  Header(this.key, this.value);

  Map<String, String> toJson() {
    final Map<String, String> data = new Map<String, String>();
    data['key'] = this.key;
    data['value'] = this.value;
    return data;
  }
}
