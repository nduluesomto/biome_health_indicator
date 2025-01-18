import 'package:biome_activity_test/di.dart';
import 'package:biome_activity_test/domain/usecases/health_usecase.dart';
import 'package:biome_activity_test/presentation/blocs/steps_tracker_cubit/step_tracker_cubit.dart';
import 'package:biome_activity_test/presentation/widgets/steps_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          shape: Border(
              bottom: BorderSide(
                  color: Colors.grey.shade600.withOpacity(0.4), width: 1)),
          backgroundColor: Colors.transparent,
          title: const Text('Индикаторы',
              style: TextStyle(color: Colors.white, fontSize: 19)),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration:  BoxDecoration(
              gradient: RadialGradient(
                  center: Alignment.topRight,
                  radius: 0.8,
                  colors: [
                    Colors.blueGrey.shade600,
                Colors.grey.shade800
                // Color(0xBF032D3D),
                //Color(0xFF005B96),
              ])),
          child: BlocProvider(
              create: (context) =>
                  StepTrackerCubit(locator<FetchStepData>())..loadHealthData(),
              child: BlocBuilder<StepTrackerCubit, StepTrackerState>(
                builder: (context, state) {
                  if (state is StepTrackerLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is StepTrackerLoaded) {
                    return SingleChildScrollView(
                      child: SafeArea(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: StepWidgetContent(
                                  steps: state.steps,
                                  calories: state.calories,
                                  distance: state.distance,
                                )),
                          ],
                        ),
                      ),
                    );
                  } else if (state is StepTrackerError) {
                    return Center(child: Text(state.message));
                  }
                  return const Center(child: Text('Welcome to Biome'));
                },
              )),
        ));
  }
}
