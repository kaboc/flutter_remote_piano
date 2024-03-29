import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import 'package:flutter_remote_piano/common/l10n.dart';
import 'package:flutter_remote_piano/blocs/remote_bloc.dart';
import 'package:flutter_remote_piano/common/settings.dart';
import 'package:flutter_remote_piano/widgets/connection_button.dart';
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
    return MultiProvider(
      providers: [
        Provider<Sound>(
          create: (_) => Sound()..init(),
        ),
        Provider<RemoteBloc>(
          create: (context) {
            final sound = context.read<Sound>();
            return RemoteBloc(
              grpc: Grpc(),
              basePitch: SoundBase.basePitch,
              numberOfKeys: SoundBase.whiteNum + SoundBase.blackNum,
            )..pitch.listen(sound.play);
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
      child: MaterialApp(
        onGenerateTitle: (context) => l(context).appTitle,
        theme: ThemeData.from(
          colorScheme: const ColorScheme.dark(
            primary: Colors.lightGreen,
          ),
        ),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const Piano(),
      ),
    );
  }
}
