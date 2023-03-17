
import 'story_group.dart';

class User {
  final String name;
  final String profileImg;
  final List<StoryGroup> storyGroups;

  const User({
    required this.name,
    required this.profileImg,
    required this.storyGroups,
  });
}
