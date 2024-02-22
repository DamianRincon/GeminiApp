class MessageData {
  String _message;
  bool _isSender;

  MessageData(this._message, this._isSender);

  // ignore: unnecessary_getters_setters
  String get message => _message;

  set message(String value) {
    _message = value;
  }

  // ignore: unnecessary_getters_setters
  bool get isSender => _isSender;

  set isSender(bool value) {
    _isSender = value;
  }
}
