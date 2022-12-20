import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lop_app/core/themes/app_colors.dart';
import 'package:lop_app/modules/practice_view/presentation/practice_module.dart';
import 'package:lop_app/modules/practice_view/presentation/states/practice_state.dart';
import '../../../core/components/app_elevated_button.dart';
import 'practice_bloc.dart';

class PracticeView extends StatefulWidget {
  const PracticeView({super.key});

  @override
  State<PracticeView> createState() => _PracticeViewState();
}

class _PracticeViewState extends State<PracticeView> {
  final PracticeBloc bloc = PracticeModule().get<PracticeBloc>();
  final TextEditingController _controller = TextEditingController();
  final promps = [];
  bool isInput = false;
  @override
  void dispose() {
    super.dispose();
    bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(size.width, 48), child: const AppTopBar()),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 24,
              left: 24,
              bottom: 24,
              right: 24,
              child: ListView(
                children: [
                  Text(
                    "Questão 8",
                    style: GoogleFonts.workSans(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.black),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 24.0),
                    child: Text(
                      "faça um programa que receba dois valores e retorne a soma do quadrado deles",
                      style: GoogleFonts.workSans(
                          fontSize: 12, color: AppColors.black),
                    ),
                  ),
                  Container(
                    height: 336,
                    width: 375,
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                              color: AppColors.black.withOpacity(0.25),
                              blurRadius: 4,
                              blurStyle: BlurStyle.inner,
                              offset: const Offset(-1.5, -1.5)),
                          BoxShadow(
                              color: AppColors.black.withOpacity(0.25),
                              blurRadius: 4,
                              blurStyle: BlurStyle.inner,
                              offset: const Offset(1.5, 1.5)),
                        ]),
                    child: ListView(
                      children: [
                        TextFormField(
                          controller: _controller,
                          enabled: true,
                          maxLines: 18,
                          onChanged: (val) {},
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 24.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppElevatedButton(
                          borderColor: AppColors.primaryColor,
                          buttonColor: AppColors.white,
                          label: "Testar",
                          labelColor: AppColors.primaryColor,
                          onTap: () {
                            bloc.add(PracticeRequestEvalCode(_controller.text));
                          },
                        ),
                        AppElevatedButton(
                          buttonColor: AppColors.primaryColor,
                          borderColor: AppColors.white,
                          label: "Submeter",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            StreamBuilder(
              stream: bloc.stream,
              builder: (context, _) {
                final state = bloc.state;
                if (state is PracticeRequestInput) {
                  return AppInputBox(
                    cancelar: (val) {
                      promps.add(val);
                      final count = state.count - 1;
                      if (count > 0) {
                        bloc.add(PracticeRequestInput(count));
                      } else {
                        bloc.add(
                            PracticeRequestedInput(promps, _controller.text));
                      }
                    },
                    ok: (val) {
                      promps.add(val);
                      final count = state.count - 1;
                      if (count > 0) {
                        bloc.add(PracticeRequestInput(count));
                      } else {
                        bloc.add(
                            PracticeRequestedInput(promps, _controller.text));
                      }
                    },
                  );
                }
                if (state is PracticeSuccess) {
                  final msg = state.result;
                  return AppOutputBox(
                    outputmessage: msg,
                    ok: () {
                      bloc.add(PracticeCloseOutput());
                    },
                  );
                }
                return const Center();
              },
            )
          ],
        ),
      ),
    );
  }
}

class AppInputBox extends StatefulWidget {
  const AppInputBox({
    Key? key,
    required this.cancelar,
    required this.ok,
  }) : super(key: key);
  final void Function(String val) cancelar;
  final void Function(String val) ok;

  @override
  State<AppInputBox> createState() => _AppInputBoxState();
}

class _AppInputBoxState extends State<AppInputBox> {
  final ctrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 1,
      color: Colors.transparent,
      shadowColor: AppColors.primaryColor.withOpacity(0.25),
      child: Center(
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          margin: const EdgeInsets.symmetric(horizontal: 16),
          width: 328,
          height: 120,
          decoration: BoxDecoration(
              color: AppColors.white, borderRadius: BorderRadius.circular(8)),
          child: Column(
            children: [
              TextFormField(
                controller: ctrl,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppElevatedButton(
                      borderColor: AppColors.primaryColor,
                      buttonColor: AppColors.white,
                      label: "Cancelar",
                      labelColor: AppColors.primaryColor,
                      onTap: () => widget.cancelar("0"),
                    ),
                    AppElevatedButton(
                      buttonColor: AppColors.primaryColor,
                      borderColor: AppColors.white,
                      label: "Ok",
                      onTap: () => widget.ok(ctrl.text),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AppOutputBox extends StatelessWidget {
  const AppOutputBox({Key? key, this.ok, this.outputmessage = "None"})
      : super(key: key);
  final void Function()? ok;
  final String outputmessage;
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 1,
      color: Colors.transparent,
      shadowColor: AppColors.primaryColor.withOpacity(0.25),
      child: Center(
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          margin: const EdgeInsets.symmetric(horizontal: 16),
          width: 328,
          height: 120,
          decoration: BoxDecoration(
              color: AppColors.white, borderRadius: BorderRadius.circular(8)),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(outputmessage),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppElevatedButton(
                      buttonColor: AppColors.primaryColor,
                      borderColor: AppColors.white,
                      label: "Ok",
                      onTap: ok,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AppTopBar extends StatelessWidget {
  const AppTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: AppColors.white, boxShadow: [
        BoxShadow(
            color: AppColors.black.withOpacity(0.2),
            blurRadius: 4,
            offset: const Offset(0, 2))
      ]),
      child: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 2,
              bottom: 0,
              left: 12,
              child: Icon(
                Icons.keyboard_arrow_left,
                size: 40,
                color: AppColors.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
