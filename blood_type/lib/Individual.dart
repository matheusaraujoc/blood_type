import 'package:blood_type/Genotype.dart';

class Individual {
  final String _name;
  final Genotype _genotype;

  Individual(String genotype, [String? name])
      : _genotype = Genotype(genotype),
        _name = name ?? _generateUniqueName();

  String get name => _name;

  Genotype get genotype => _genotype;

  @override
  String toString() => '$name(${genotype.bloodType})';

  static int _counter = 0;

  static String _generateUniqueName() {
    _counter++;
    return 'Indiv$_counter';
  }
}
