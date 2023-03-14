import 'package:equatable/equatable.dart';

import './user.dart';

enum MediaType { img, video }

class Story extends Equatable{
  final String url;
  final MediaType media;
  final Duration duration;
  final User user;

  const Story({
    required this.url,
    required this.media,
    required this.duration,
    required this.user,
  });
  
  @override
  List<Object?> get props => [
    url,
    media,
    duration,
    user
  ];
}
