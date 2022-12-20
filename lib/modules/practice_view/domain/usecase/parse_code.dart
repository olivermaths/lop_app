import 'package:lop_app/modules/practice_view/presentation/states/practice_state.dart';

abstract class ParserCodeUsercase {
  PracticeState parsecode(String code);
}

class ParserCodeImpl implements ParserCodeUsercase {
  @override
  PracticeState parsecode(String code) {
    code = insertCollon(code);
    code = replaceLetForvar(code);
    int count = parsePrompt(code.split(' '));
    return ParserResult(code, count);
  }

  String insertCollon(String code) {
    final val = code;
    final d = val.split('\n');
    final l = [];
    for (var x in d) {
      if ((x.contains("let")) && !x.contains("(")) {
        l.add("$x;");
      } else if ((x.contains("=")) && !x.contains(";") && x.contains("\n")) {
        l.add("$x;");
      } else {
        l.add(x);
      }
    }
    return l.join();
  }

  String replaceLetForvar(String code) {
    return code.replaceAll("let", "var");
  }

  int parsePrompt(List<String> code) {
    print(code);
    int count = 0;
    bool isFor = false;
    for (String token in code) {
      if (token.contains("{")) {
        isFor = true;
      }

      if (token.contains("prompt()") && !token.contains("{") && !isFor) {
        count++;
      }
      if (token.contains("}")) {
        isFor = false;
      }
    }

    return count;
  }

  List<int> handleFor(List<String> code) {
    List<int> types = [];
    bool find = false;
    String num = "";

    for (var str in code) {
      for (var c in str.split('')) {
        if (find) {
          if (c == ';') {
            find = false;
            continue;
          }
          num += c;
        }
        if (c == '<') {
          find = true;
        }
      }
      types.add(int.parse(num));
      num = "";
    }
    return types;
  }
}
