import 'package:adviser/application/adviser/adviser_bloc.dart';
import 'package:adviser/presentation/adviser/widgets/advice_field.dart';
import 'package:adviser/presentation/adviser/widgets/custom_button.dart';
import 'package:adviser/presentation/adviser/widgets/error_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdviserPage extends StatelessWidget {
  const AdviserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Adviser",
          style: themeData.textTheme.headline1,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: BlocBuilder<AdviserBloc, AdviserState>(
                  bloc: BlocProvider.of<AdviserBloc>(context)
                    ..add(AdviceRequestedEvent()), // Add initial state here.
                  /*buildWhen: (previousState, currentState) =>
                      previousState != currentState,*/ // Build only when a certain value changes.
                  builder: ((context, state) {
                    if (state is AdviserInitial) {
                      return Text(
                        "Your advice is waiting for you.",
                        style: themeData.textTheme.bodyText1,
                      );
                    } else if (state is AdviserStateLoading) {
                      return CircularProgressIndicator(
                        color: themeData.colorScheme.secondary,
                      );
                    } else if (state is AdviserStateLoaded) {
                      return AdviceField(
                        advice: state.advice,
                      );
                    } else if (state is AdviserStateError) {
                      return ErrorMessage(
                        message: state.message,
                      );
                    }
                    return Container();
                  }),
                ),
              ),
            ),
            const SizedBox(
              height: 200,
              child: Center(
                child: CustomButton(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
