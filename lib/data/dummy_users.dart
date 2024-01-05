// import '../constants/app_images.dart';

// List<Map<String, dynamic>> dummyusers = [
//   {
//     'name': 'Progress Chuke',
//     'message': 'I am a Flutter Developer',
//     'time': '12:00 am',
//     'image': AppImages.progress,
//   },
//   {
//     'name': 'Jessica Pearson',
//     'message': 'I do not respond to threats!',
//     'time': '1:24 pm',
//     'image': '',
//   },
//   {
//     'name': 'Harvey Specter',
//     'message': 'You always have a choice',
//     'time': '1:30 am',
//     'image': AppImages.harvey,
//   },
//   {
//     'name': 'Louis Litt',
//     'message': 'You just got litt up!',
//     'time': '2:00am',
//     'image': '',
//   },
//   {
//     'name': 'Mike Ross',
//     'message': 'I can explain...',
//     'time': '6:00 pm',
//     'image': AppImages.mike,
//   },
// ];

import '../constants/app_images.dart';
import '../model/user.dart';

List<User> dummyusers = [
  User(
      userName: 'Progress Chuke',
      id: '1',
      message: 'I am a Flutter Developer',
      sent: '12:00 am',
      image: AppImages.progress),
  User(
      userName: 'Jessica Pearson',
      id: '2',
      message: 'I do not respond to threats!',
      sent: '1:24 am'),
  User(
      userName: 'Harvey Specter',
      id: '3',
      message: 'You always have a choice',
      sent: '1:30 am',
      image: AppImages.harvey),
  User(
      userName: 'Louis Litt',
      id: '4',
      message: 'You just got litt up!',
      sent: '2:00am'),
  User(
      userName: 'Mike Ross',
      id: '5',
      message: 'I can explain...',
      sent: '6:00 pm',
      image: AppImages.mike),
];
