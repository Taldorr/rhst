import 'package:rhst/profiles/models/dog.dart';
import 'package:rhst/profiles/models/human.dart';

class Dogteam {
  const Dogteam({
    required this.human,
    required this.dogs,
    this.id,
  });

  final Human human;

  final List<Dog> dogs;

  final String? id;
}
