import 'package:education_app/core/res/media_res.dart';
import 'package:equatable/equatable.dart';

class OnBoardingEntity extends Equatable {
  const OnBoardingEntity({
    required this.image,
    required this.title,
    required this.description,
  });

  factory OnBoardingEntity.first() {
    return const OnBoardingEntity(
      image: MediaRes.casualReading,
      description: "This is the first online education platform designed by the world's top professors",
      title: 'Brand new curriculum',
    );
  }

  factory OnBoardingEntity.second() {
    return const OnBoardingEntity(
      image: MediaRes.casualLife,
      description: "This is the first online education platform designed by the world's top professors",
      title: 'Brand a fun atmosphere',
    );
  }

  factory OnBoardingEntity.third() {
    return const OnBoardingEntity(
      image: MediaRes.casualMeditationScience,
      description: "This is the first online education platform designed by the world's top professors",
      title: 'Easy to join the lesson',
    );
  }

  final String image;
  final String title;
  final String description;

  @override
  List<Object> get props => [image, title, description];
}
