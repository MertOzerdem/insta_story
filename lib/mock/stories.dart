import '../models/story.dart';
import '../models/user.dart';

const User user = User(
  name: 'John Doe',
  profileImg: 'https://wallpapercave.com/wp/AYWg3iu.jpg',
);

final List<Story> stories = [
  const Story(
    url:
        'https://images.unsplash.com/photo-1534103362078-d07e750bd0c4?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
    media: MediaType.img,
    duration: Duration(seconds: 3),
    user: user,
  ),
  const Story(
    url: 'https://media.giphy.com/media/moyzrwjUIkdNe/giphy.gif',
    media: MediaType.img,
    user: user,
    duration: Duration(seconds: 3),
  ),
  const Story(
    url:
        'https://static.videezy.com/system/resources/previews/000/005/529/original/Reaviling_Sjusj%C3%B8en_Ski_Senter.mp4',
    media: MediaType.video,
    duration: Duration(seconds: 15),
    user: user,
  ),
  const Story(
    url:
        'https://static.videezy.com/system/resources/previews/000/007/536/original/rockybeach.mp4',
    media: MediaType.video,
    duration: Duration(seconds: 3),
    user: user,
  ),
  const Story(
    url: 'https://media2.giphy.com/media/M8PxVICV5KlezP1pGE/giphy.gif',
    media: MediaType.img,
    duration: Duration(seconds: 8),
    user: user,
  ),
];