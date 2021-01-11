///
//  Generated code. Do not modify.
//  source: proto/models.proto
//
// @dart = 2.7
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:async' as $async;

import 'package:protobuf/protobuf.dart' as $pb;

import 'dart:core' as $core;
import 'models.pb.dart' as $0;
import 'models.pbjson.dart';

export 'models.pb.dart';

abstract class TodoServiceBase extends $pb.GeneratedService {
  $async.Future<$0.TodoList> getAll($pb.ServerContext ctx, $0.TodoFilter request);
  $async.Future<$0.Todo> get($pb.ServerContext ctx, $0.TodoParams request);
  $async.Future<$0.RequestResult> add($pb.ServerContext ctx, $0.Todo request);
  $async.Future<$0.RequestResult> remove($pb.ServerContext ctx, $0.TodoParams request);
  $async.Future<$0.RequestResult> update($pb.ServerContext ctx, $0.Todo request);

  $pb.GeneratedMessage createRequest($core.String method) {
    switch (method) {
      case 'GetAll': return $0.TodoFilter();
      case 'Get': return $0.TodoParams();
      case 'Add': return $0.Todo();
      case 'Remove': return $0.TodoParams();
      case 'Update': return $0.Todo();
      default: throw $core.ArgumentError('Unknown method: $method');
    }
  }

  $async.Future<$pb.GeneratedMessage> handleCall($pb.ServerContext ctx, $core.String method, $pb.GeneratedMessage request) {
    switch (method) {
      case 'GetAll': return this.getAll(ctx, request);
      case 'Get': return this.get(ctx, request);
      case 'Add': return this.add(ctx, request);
      case 'Remove': return this.remove(ctx, request);
      case 'Update': return this.update(ctx, request);
      default: throw $core.ArgumentError('Unknown method: $method');
    }
  }

  $core.Map<$core.String, $core.dynamic> get $json => TodoServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>> get $messageJson => TodoServiceBase$messageJson;
}

