import 'package:lop_app/modules/practice_view/domain/interpreter/interpreter.dart';
import 'package:lop_app/modules/practice_view/domain/usecase/eval_code.dart';
import 'package:lop_app/modules/practice_view/domain/usecase/parse_code.dart';

import 'practice_bloc.dart';

class PracticeModule {
  final _bloc =
      PracticeBloc(EvalCodeUseCaseImpl(InterpreterImpl()), ParserCodeImpl());
  dynamic get<T>() {
    if (PracticeBloc == PracticeBloc) {
      return _bloc;
    }
  }
}
