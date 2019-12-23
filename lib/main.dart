import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:flutter_remote_piano/blocs/remote_bloc.dart';
import 'package:flutter_remote_piano/common/settings.dart';
import 'package:flutter_remote_piano/widgets/connect_button.dart';
import 'package:flutter_remote_piano/widgets/piano.dart';

import 'package:flutter_remote_piano/platforms/others/grpc.dart'
    if (dart.library.io) 'package:flutter_remote_piano/platforms/mobile/grpc.dart'
    if (dart.library.html) 'package:flutter_remote_piano/platforms/web/grpc.dart';

import 'package:flutter_remote_piano/platforms/others/sound.dart'
    if (dart.library.io) 'package:flutter_remote_piano/platforms/mobile/sound.dart'
    if (dart.library.html) 'package:flutter_remote_piano/platforms/web/sound.dart';

Future<void> main() async {
  if (!kIsWeb) {
    WidgetsFlutterBinding.ensureInitialized();
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
    ]);
  }

  runApp(const App());
}

class App extends StatelessWidget {
  const App();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppSettings.appTitle,
      theme: ThemeData.dark(),
      home: MultiProvider(
        providers: [
          Provider<RemoteBloc>(
            create: (_) {
              final sound = Sound()..init();
              return RemoteBloc(
                grpc: Grpc(),
                basePitch: SoundBase.basePitch,
                numberOfKeys: SoundBase.whiteNum + SoundBase.blackNum,
              )..pitch.listen((pitch) => sound.play(pitch));
            },
            dispose: (_, bloc) => bloc.dispose(),
          ),
          ChangeNotifierProvider<HostController>(
            create: (_) => HostController(text: AppSettings.defaultHost),
          ),
          ChangeNotifierProvider<PortController>(
            create: (_) => PortController(text: AppSettings.defaultPort),
          ),
        ],
        child: const Piano(),
      ),
    );
  }
}
