abstract class PracticeState {}

class PracticeSuccess implements PracticeState {
  final String result;
  PracticeSuccess(this.result);
}

class PracticeFailed implements PracticeState {
  final String msg;
  PracticeFailed(this.msg);
}

class PracticeLoading implements PracticeState {}

class PracticeRequestEvalCode implements PracticeState {
  final String code;
  PracticeRequestEvalCode(this.code);
}

class PracticeStart implements PracticeState {}

class PracticeRequestInput implements PracticeState {
  int count = 0;
  PracticeRequestInput(this.count);
}

class PracticeDisplayOutput implements PracticeState {}

class PracticeCloseOutput implements PracticeState {}

class PracticeRequestedInput implements PracticeState {
  final dynamic input;
  final String code;
  PracticeRequestedInput(this.input, this.code);
}

class ParserResult implements PracticeState {
  String handledCode;
  int promptcount;
  ParserResult(this.handledCode, this.promptcount);
}
