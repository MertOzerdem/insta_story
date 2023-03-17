import '../models/story.dart';
import '../models/story_group.dart';
import '../models/user.dart';

final User user = User(
  name: 'Jhon Doe',
  profileImg: 'https://wallpapercave.com/wp/AYWg3iu.jpg',
  storyGroups: [storyGroup1, storyGroup2, storyGroup3],
);

final StoryGroup storyGroup1 = StoryGroup(
  stories: [
    Story(
      url:
          'https://images.unsplash.com/photo-1534103362078-d07e750bd0c4?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
    ),
    Story(
      url: 'https://petapixel.com/assets/uploads/2022/08/fdfs11-800x533.jpg',
    ),
    Story(
      url:
          'https://static.videezy.com/system/resources/previews/000/005/529/original/Reaviling_Sjusj%C3%B8en_Ski_Senter.mp4',
    ),
    Story(
      url:
          'https://static.videezy.com/system/resources/previews/000/007/536/original/rockybeach.mp4',
    ),
    Story(
      url:
          'https://cdn.pixabay.com/photo/2012/08/27/14/19/mountains-55067__340.png',
    ),
  ],
);

final StoryGroup storyGroup2 = StoryGroup(
  stories: [
    Story(
      url:
          'https://static.videezy.com/system/resources/previews/000/005/529/original/Reaviling_Sjusj%C3%B8en_Ski_Senter.mp4',
    ),
    Story(
      url:
          'https://static.videezy.com/system/resources/previews/000/007/536/original/rockybeach.mp4',
    ),
  ],
);

final StoryGroup storyGroup3 = StoryGroup(
  stories: [
    Story(
      url:
          'https://images.unsplash.com/photo-1534103362078-d07e750bd0c4?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
    ),
    Story(
      url: 'https://petapixel.com/assets/uploads/2022/08/fdfs11-800x533.jpg',
    ),
    Story(
      url:
          'https://cdn.pixabay.com/photo/2012/08/27/14/19/mountains-55067__340.png',
    ),
  ],
);
