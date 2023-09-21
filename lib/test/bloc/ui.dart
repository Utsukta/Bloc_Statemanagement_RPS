import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rpsbloc/test/bloc/test_bloc.dart';

class test extends StatefulWidget {
  const test({super.key});

  @override
  State<test> createState() => _testState();
}

class _testState extends State<test> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocConsumer<TestBloc, TestState>(
              listener: (context, state) {},
              builder: (context, state) {
                var testbloc = BlocProvider.of<TestBloc>(context);
                if (state is TestInitial) {
                  return IconButton(
                      onPressed: () {
                        testbloc
                            .add(Testbuttonevet(email: 'u1@mailinator.com'));
                      },
                      icon: const Icon(Icons.abc));
                }
                if (state is Testloading) {
                  const Text("loading");
                }
                if (state is TestSuccess) {
                  const Text("success");
                }

                return const Text(
                  "hello",
                  style: TextStyle(color: Colors.black),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
