import 'package:bloc/bloc.dart';
import 'package:lop_app/modules/practice_view/domain/usecase/eval_code.dart';
import 'package:lop_app/modules/practice_view/presentation/states/practice_state.dart';

import '../domain/usecase/parse_code.dart';

class PracticeBloc extends Bloc<PracticeState, PracticeState> {
  final EvalCodeUsecase _usecase;
  final ParserCodeUsercase _parser;
  PracticeBloc(this._usecase, this._parser) : super(PracticeStart()) {
    on<PracticeState>((event, emit) async {
      if (event is PracticeRequestEvalCode) {
        //final result = _usecase.eval(event.code, []);
        //final response = result.fold((l) => PracticeFailed(""), (r) => r);
        final code = _parser.parsecode(event.code) as ParserResult;
        String current = code.handledCode;
        if (code.promptcount > 0) {
          emit(PracticeRequestInput(code.promptcount));
          return;
        } else {
          final result = _usecase.eval(current, []);
          final response = result.fold((l) => PracticeStart(), (r) => r);
          emit(response);
          return;
        }
      }
      if (event is PracticeRequestInput) {
        emit(PracticeRequestInput(event.count));
        return;
      }
      if (event is PracticeRequestedInput) {
        final result = _parser.parsecode(event.code) as ParserResult;
        String source = result.handledCode;
        for (var element in event.input) {
          source = source.replaceFirst("prompt()", "$element;");
        }
        final response =
            _usecase.eval(source, []).fold((l) => PracticeStart(), (r) => r);
        emit(response);
        return;
      }
      final result = PracticeLoading();
      emit(result);
    });
  }
}
