import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod2/data/count_data.dart';
import 'package:flutter_riverpod2/provider.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    print("MyHomePage rebuild");
    return Scaffold(
      appBar: AppBar(title: Text(ref.watch(titleProvider))),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(ref.watch(messageProvider)),
            Text(
              ref.watch(countDataProvider).count.toString(),
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              FloatingActionButton(
                  onPressed: () {
                    CountData countData =
                        ref.read(countDataProvider.notifier).state;
                    ref.read(countDataProvider.notifier).state =
                        countData.copyWith(
                      count: countData.count + 1,
                      countUp: countData.countUp + 1,
                    );
                  },
                  child: const Icon(CupertinoIcons.plus)),
              FloatingActionButton(
                onPressed: () {
                  CountData countData =
                      ref.read(countDataProvider.notifier).state;
                  ref.read(countDataProvider.notifier).state =
                      countData.copyWith(
                    count: countData.count - 1,
                    countDown: countData.countDown + 1,
                  );
                },
                child: const Icon(CupertinoIcons.minus),
              )
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              Text(ref.watch(countDataProvider).countUp.toString()),
              Text(ref.watch(countDataProvider).countDown.toString()),
            ])
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(countDataProvider.notifier).state = const CountData(
            count: 0,
            countUp: 0,
            countDown: 0,
          );
        },
        tooltip: 'Increment',
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
