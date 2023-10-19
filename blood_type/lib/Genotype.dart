class Genotype {
  final String _genotype;

  Genotype(this._genotype) {
  final List<String> validGenotypes = ["AA", "Ai", "BB", "Bi", "AB", "ii"];
  if (!validGenotypes.contains(_genotype)) {
    throw Exception("Genotype '$_genotype' não é válido. Os valores válidos são: ${validGenotypes.join(', ')}");
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
  return alleles.where((allele) => allele == 'i').map((allele) {
    if (allele == 'i') return 'B';
    return 'A';
  }).toList();
}

  List<String> offsprings(Genotype other) {
    final List<String> alleles1 = alleles;
    final List<String> alleles2 = other.alleles;
    final List<String> result = [];

    for (final allele1 in alleles1) {
      for (final allele2 in alleles2) {
        result.add((allele1 + allele2));
        result.add((allele2 + allele1));
      }
    }

    return result.toSet().toList();
  }

  bool compatible(Genotype other) {
    final List<String> agglutinogens1 = agglutinogens;
    final List<String> agglutinins1 = agglutinins;
    final List<String> agglutinogens2 = other.agglutinogens;
    final List<String> agglutinins2 = other.agglutinins;

    return agglutinogens1.every((agglutinogen) => agglutinins2.contains(agglutinogen)) &&
        agglutinogens2.every((agglutinogen) => agglutinins1.contains(agglutinogen));
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
