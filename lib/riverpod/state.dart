import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zognest_website/features/home/models/blog.dart';

@immutable
class AppState extends Equatable {
  const AppState({
    required this.blogs,
  });

  final AsyncValue<List<Blog>> blogs;

  AppState copyWith({
    AsyncValue<List<Blog>>? blogs,
  }) {
    return AppState(
      blogs: blogs ?? this.blogs,
    );
  }

  @override
  List<Object?> get props => [
        blogs,
      ];
}
