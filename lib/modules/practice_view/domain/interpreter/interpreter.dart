import 'package:dart_eval/dart_eval.dart';

abstract class Interpreter {
  dynamic evaluateCode(String code, dynamic args);
}

class InterpreterImpl implements Interpreter {
  @override
  evaluateCode(String code, dynamic args) {
    code = code.replaceAll("let", "var");

    String newcode = """dynamic program() { 
          $code ;
          }""";
    final result = eval(newcode, function: "program", args: args);
    return "$result";
  }
}
