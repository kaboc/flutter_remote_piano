///
//  Generated code. Do not modify.
//  source: piano.proto
//
// @dart = 2.3
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'piano.pb.dart' as $0;
export 'piano.pb.dart';

class PianoClient extends $grpc.Client {
  static final _$connect = $grpc.ClientMethod<$0.Note, $0.Note>(
      '/piano.Piano/Connect',
      ($0.Note value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Note.fromBuffer(value));

  PianoClient($grpc.ClientChannel channel,
      {$grpc.CallOptions options,
      $core.Iterable<$grpc.ClientInterceptor> interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseStream<$0.Note> connect($async.Stream<$0.Note> request,
      {$grpc.CallOptions options}) {
    return $createStreamingCall(_$connect, request, options: options);
  }
}

abstract class PianoServiceBase extends $grpc.Service {
  $core.String get $name => 'piano.Piano';

  PianoServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.Note, $0.Note>(
        'Connect',
        connect,
        true,
        true,
        ($core.List<$core.int> value) => $0.Note.fromBuffer(value),
        ($0.Note value) => value.writeToBuffer()));
  }

  $async.Stream<$0.Note> connect(
      $grpc.ServiceCall call, $async.Stream<$0.Note> request);
}
