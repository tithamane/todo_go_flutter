///
//  Generated code. Do not modify.
//  source: proto/models.proto
//
// @dart = 2.7
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'models.pb.dart' as $0;
export 'models.pb.dart';

class TodoServiceClient extends $grpc.Client {
  static final _$getAll = $grpc.ClientMethod<$0.TodoFilter, $0.TodoList>(
      '/TodoService/GetAll',
      ($0.TodoFilter value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.TodoList.fromBuffer(value));
  static final _$get = $grpc.ClientMethod<$0.TodoParams, $0.Todo>(
      '/TodoService/Get',
      ($0.TodoParams value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Todo.fromBuffer(value));
  static final _$add = $grpc.ClientMethod<$0.Todo, $0.RequestResult>(
      '/TodoService/Add',
      ($0.Todo value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.RequestResult.fromBuffer(value));
  static final _$remove = $grpc.ClientMethod<$0.TodoParams, $0.RequestResult>(
      '/TodoService/Remove',
      ($0.TodoParams value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.RequestResult.fromBuffer(value));
  static final _$update = $grpc.ClientMethod<$0.Todo, $0.RequestResult>(
      '/TodoService/Update',
      ($0.Todo value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.RequestResult.fromBuffer(value));

  TodoServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions options,
      $core.Iterable<$grpc.ClientInterceptor> interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.TodoList> getAll($0.TodoFilter request,
      {$grpc.CallOptions options}) {
    return $createUnaryCall(_$getAll, request, options: options);
  }

  $grpc.ResponseFuture<$0.Todo> get($0.TodoParams request,
      {$grpc.CallOptions options}) {
    return $createUnaryCall(_$get, request, options: options);
  }

  $grpc.ResponseFuture<$0.RequestResult> add($0.Todo request,
      {$grpc.CallOptions options}) {
    return $createUnaryCall(_$add, request, options: options);
  }

  $grpc.ResponseFuture<$0.RequestResult> remove($0.TodoParams request,
      {$grpc.CallOptions options}) {
    return $createUnaryCall(_$remove, request, options: options);
  }

  $grpc.ResponseFuture<$0.RequestResult> update($0.Todo request,
      {$grpc.CallOptions options}) {
    return $createUnaryCall(_$update, request, options: options);
  }
}

abstract class TodoServiceBase extends $grpc.Service {
  $core.String get $name => 'TodoService';

  TodoServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.TodoFilter, $0.TodoList>(
        'GetAll',
        getAll_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.TodoFilter.fromBuffer(value),
        ($0.TodoList value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.TodoParams, $0.Todo>(
        'Get',
        get_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.TodoParams.fromBuffer(value),
        ($0.Todo value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Todo, $0.RequestResult>(
        'Add',
        add_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Todo.fromBuffer(value),
        ($0.RequestResult value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.TodoParams, $0.RequestResult>(
        'Remove',
        remove_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.TodoParams.fromBuffer(value),
        ($0.RequestResult value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Todo, $0.RequestResult>(
        'Update',
        update_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Todo.fromBuffer(value),
        ($0.RequestResult value) => value.writeToBuffer()));
  }

  $async.Future<$0.TodoList> getAll_Pre(
      $grpc.ServiceCall call, $async.Future<$0.TodoFilter> request) async {
    return getAll(call, await request);
  }

  $async.Future<$0.Todo> get_Pre(
      $grpc.ServiceCall call, $async.Future<$0.TodoParams> request) async {
    return get(call, await request);
  }

  $async.Future<$0.RequestResult> add_Pre(
      $grpc.ServiceCall call, $async.Future<$0.Todo> request) async {
    return add(call, await request);
  }

  $async.Future<$0.RequestResult> remove_Pre(
      $grpc.ServiceCall call, $async.Future<$0.TodoParams> request) async {
    return remove(call, await request);
  }

  $async.Future<$0.RequestResult> update_Pre(
      $grpc.ServiceCall call, $async.Future<$0.Todo> request) async {
    return update(call, await request);
  }

  $async.Future<$0.TodoList> getAll(
      $grpc.ServiceCall call, $0.TodoFilter request);
  $async.Future<$0.Todo> get($grpc.ServiceCall call, $0.TodoParams request);
  $async.Future<$0.RequestResult> add($grpc.ServiceCall call, $0.Todo request);
  $async.Future<$0.RequestResult> remove(
      $grpc.ServiceCall call, $0.TodoParams request);
  $async.Future<$0.RequestResult> update(
      $grpc.ServiceCall call, $0.Todo request);
}
