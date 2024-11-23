// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$taskStreamHash() => r'6800f6146dd66d5eb72a6e45f0bfdb3b2444738c';

/// See also [taskStream].
@ProviderFor(taskStream)
final taskStreamProvider =
    AutoDisposeStreamProvider<List<Map<String, dynamic>>>.internal(
  taskStream,
  name: r'taskStreamProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$taskStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TaskStreamRef
    = AutoDisposeStreamProviderRef<List<Map<String, dynamic>>>;
String _$todoListHash() => r'5ae3555ae5da52f4b6d7e4cf3c3ecd433b47924e';

/// See also [TodoList].
@ProviderFor(TodoList)
final todoListProvider = AutoDisposeStreamNotifierProvider<TodoList,
    List<Map<String, dynamic>>>.internal(
  TodoList.new,
  name: r'todoListProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$todoListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$TodoList = AutoDisposeStreamNotifier<List<Map<String, dynamic>>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
