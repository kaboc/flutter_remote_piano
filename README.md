# Remote Piano

A toy piano app made with Flutter as a gRPC example, with a unique feature to interact with remote devices.

![Screencast](doc/images/remote_piano.gif)

## Supported platforms

* Android
* iOS
* Web (limited)
    * `grpc-web` is used for web instead of `grpc-dart`.
    * Sending notes is not supported due to the limited functionality of grpc-web.
    * Receiving notes does not start unless you send a request by tapping a key after connected to a server.
    * Tapping more keys cause an error printed in a browser console.
    * A gateway proxy is necessary between a server and clients. See below for instruction.
        * See the README of [piano_server](https://github.com/kaboc/piano_server) for details.

[flutter_midi](https://pub.dev/packages/flutter_midi) and [Tone.js](https://tonejs.github.io/) are used for mobile and web respectively.

No sound font (.sf2) file is in this repository.
Search and get one, place it in `/assets/sf2/`, and then specify the file path in `pubspec.yaml`. 

## Server

A server is necessary if you use the remote operation feature of the app.
Its source code is on [another repository](https://github.com/kaboc/piano_server).
