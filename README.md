# Remote Piano

A toy piano app made with Flutter as a gRPC example, with a unique feature to interact with remote devices.

![Screencast](doc/images/remote_piano.gif)

## Supported platforms

* Android
* iOS
* Web (limited)
    * `grpc-web` is used for Web instead of `grpc-dart`.
    * Sending notes is not supported due to the limited functionality of grpc-web.
    * Receiving notes does not start unless you send a request by tapping a key after connected to a server.
    * Tapping more keys cause an error printed in a browser console.
    * A gateway proxy is necessary between a server and clients. See below for instruction.

## Server

...

## Proxy for web

1. Copy `envoy.Dockerfile` and `envoy.yaml` from grpc-web's [helloworld](https://github.com/grpc/grpc-web/tree/master/net/grpc/gateway/examples/helloworld) example to your preferred directory.
2. In envoy.yaml, change `localhost` on the last line to `host.docker.internal` if you run Docker on Windows/Mac.
3. Change `greeter_service` (several places in the same file) to `piano_service`.
4. Run `docker build -t piano/envoy -f ./envoy.Dockerfile .` to build a Docker image.
5. Run `docker run -d -p 50051:8080 --name piano_server piano/envoy` to create a container and start it.
6. Run `dart path/to/server/directory/server.dart -p 9090` to start a server. Change the port number accordingly if a different one is written on the last line of your envoy.yaml.
