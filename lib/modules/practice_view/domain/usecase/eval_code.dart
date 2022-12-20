import 'package:lop_app/modules/practice_view/domain/interpreter/interpreter.dart';

import '../../../../core/err/failure.dart';
import '../../../../core/result_adaptative/either_adaptative.dart';
import '../../presentation/states/practice_state.dart';

abstract class EvalCodeUsecase {
  Either<Failure, PracticeState> eval(String code, dynamic args);
}

class EvalCodeUseCaseImpl implements EvalCodeUsecase {
  final Interpreter impl;

  EvalCodeUseCaseImpl(this.impl);
  @override
  Either<Failure, PracticeState> eval(String code, dynamic args) {
    try {
      final result = impl.evaluateCode(code, args);
      return Right(PracticeSuccess(result));
    } catch (e) {
      return Left(FailedToEvalCode());
    }
  }
}
