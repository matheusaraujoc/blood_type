class Genotype {
  final String _genotype;

  Genotype(this._genotype) {
    final List<String> validGenotypes = ["AA", "Ai", "BB", "Bi", "AB", "ii"];
    if (!validGenotypes.contains(_genotype)) {
      throw Exception(
          "Genotype '$_genotype' não é válido. Os valores válidos são: ${validGenotypes.join(', ')}");
    }
  }

  String get bloodType {
    if (_genotype == 'AA' || _genotype == 'Ai') {
      return 'A';
    } else if (_genotype == 'BB' || _genotype == 'Bi') {
      return 'B';
    } else if (_genotype == 'AB') {
      return 'AB';
    } else {
      return 'O';
    }
  }

  List<String> get alleles {
    return _genotype.split('').toSet().toList();
  }

  List<String> get agglutinogens {
    return alleles.where((allele) => allele == 'A' || allele == 'B').toList();
  }

  List<String> get agglutinins {
    var tempResult = agglutinogens;
    var result = <String>[];

    if (tempResult.length == 1) {
      switch (tempResult[0]) {
        case 'A':
          result.add('B');
          break;
        case 'B':
          result.add('A');
          break;
      }
    } else if (tempResult.length == 0) {
      result.addAll(['A', 'B']);
    }
    return result;
  }

  List<String> offsprings(Genotype other) {
    final List<String> alleles1 = alleles;
    final List<String> alleles2 = other.alleles;
    List<String> crossing = [];
    final List<String> result = [];
    for (final allele1 in alleles1) {
      for (final allele2 in alleles2) {
        crossing.add((allele1 + allele2));
        crossing.add((allele2 + allele1));
      }
    }
    crossing.forEach((element) {
      if (element == 'Ai' ||
          element == 'Bi' ||
          element == 'AB' ||
          element == 'ii' ||
          element == 'AA' ||
          element == 'BB') {
        if (!result.contains(element)) {
          result.add(element);
        }
      }
    });
    return result;
  }

  bool compatible(Genotype other) {
    bool result;
    if (bloodType == 'A' &&
        (other.bloodType == 'A' || other.bloodType == 'AB')) {
      result = true;
    } else if (bloodType == 'B' &&
        (other.bloodType == 'B' || other.bloodType == 'AB')) {
      result = true;
    } else if (bloodType == 'AB' && other.bloodType == 'AB') {
      result = true;
    } else if (bloodType == 'O') {
      result = true;
    } else {
      result = false;
    }
    return result;
  }

  @override
  String toString() {
    return _genotype;
  }

  static bool _isValidGenotype(String genotype) {
    final validGenotypes = ['AA', 'Ai', 'BB', 'Bi', 'AB', 'ii'];
    return validGenotypes.contains(genotype);
  }
}
