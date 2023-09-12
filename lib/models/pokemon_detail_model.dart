import 'dart:convert';
import 'package:flutter/foundation.dart';

class PokemonDetail {
  final List<Abilities>? abilities;
  final int? baseExperience;
  final int? height;
  final int? id;
  final String? name;
  final List<PokemonStat>? stats;
  final List<PokemonType>? types;
  final int? weight;
  final PokemonSpecies? species;
  PokemonDetail({
    this.abilities,
    this.baseExperience,
    this.height,
    this.id,
    this.name,
    this.stats,
    this.types,
    this.weight,
    this.species,
  });

  PokemonDetail copyWith({
    List<Abilities>? abilities,
    int? baseExperience,
    int? height,
    int? id,
    String? name,
    List<PokemonStat>? stats,
    List<PokemonType>? types,
    int? weight,
    PokemonSpecies? species,
  }) {
    return PokemonDetail(
      abilities: abilities ?? this.abilities,
      baseExperience: baseExperience ?? this.baseExperience,
      height: height ?? this.height,
      id: id ?? this.id,
      name: name ?? this.name,
      stats: stats ?? this.stats,
      types: types ?? this.types,
      weight: weight ?? this.weight,
      species: species ?? this.species,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'abilities': abilities?.map((x) => x.toMap()).toList(),
      'base_experience': baseExperience,
      'height': height,
      'id': id,
      'name': name,
      'stats': stats?.map((x) => x.toMap()).toList(),
      'types': types?.map((x) => x.toMap()).toList(),
      'weight': weight,
      'species': species?.toMap(),
    };
  }

  factory PokemonDetail.fromMap(Map<String, dynamic> map) {
    return PokemonDetail(
      abilities: map['abilities'] != null
          ? List<Abilities>.from(
              map['abilities']?.map((x) => Abilities.fromMap(x)))
          : null,
      baseExperience: map['base_experience'],
      height: map['height'],
      id: map['id'],
      name: map['name'],
      stats: map['stats'] != null
          ? List<PokemonStat>.from(
              map['stats']?.map((x) => PokemonStat.fromMap(x)))
          : null,
      types: map['types'] != null
          ? List<PokemonType>.from(
              map['types']?.map((x) => PokemonType.fromMap(x)))
          : null,
      weight: map['weight'],
      species: map['species'] != null
          ? PokemonSpecies.fromMap(map['species'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PokemonDetail.fromJson(String source) =>
      PokemonDetail.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PokemonDetail(abilities: $abilities, baseExperience: $baseExperience, height: $height, id: $id, name: $name, stats: $stats, types: $types, weight: $weight, species: $species)';
  }

  @override
  bool operator ==(covariant PokemonDetail other) {
    if (identical(this, other)) return true;

    return listEquals(other.abilities, abilities) &&
        other.baseExperience == baseExperience &&
        other.height == height &&
        other.id == id &&
        other.name == name &&
        listEquals(other.stats, stats) &&
        listEquals(other.types, types) &&
        other.weight == weight &&
        other.species == species;
  }

  @override
  int get hashCode {
    return abilities.hashCode ^
        baseExperience.hashCode ^
        height.hashCode ^
        id.hashCode ^
        name.hashCode ^
        stats.hashCode ^
        types.hashCode ^
        weight.hashCode ^
        species.hashCode;
  }
}

class Abilities {
  final Ability ability;
  final bool isHidden;
  final int slot;
  Abilities({
    required this.ability,
    required this.isHidden,
    required this.slot,
  });

  Abilities copyWith({
    Ability? ability,
    bool? isHidden,
    int? slot,
  }) {
    return Abilities(
      ability: ability ?? this.ability,
      isHidden: isHidden ?? this.isHidden,
      slot: slot ?? this.slot,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'ability': ability.toMap(),
      'is_hidden': isHidden,
      'slot': slot,
    };
  }

  factory Abilities.fromMap(Map<String, dynamic> map) {
    return Abilities(
      ability: Ability.fromMap(map['ability']),
      isHidden: map['is_hidden'] as bool,
      slot: map['slot'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Abilities.fromJson(String source) =>
      Abilities.fromMap(json.decode(source));

  @override
  String toString() =>
      'Abilities(ability: $ability, isHidden: $isHidden, slot: $slot)';

  @override
  bool operator ==(covariant Abilities other) {
    if (identical(this, other)) return true;

    return other.ability == ability &&
        other.isHidden == isHidden &&
        other.slot == slot;
  }

  @override
  int get hashCode => ability.hashCode ^ isHidden.hashCode ^ slot.hashCode;
}

class Ability {
  final String name;
  final String url;
  Ability({
    required this.name,
    required this.url,
  });

  Ability copyWith({
    String? name,
    String? url,
  }) {
    return Ability(
      name: name ?? this.name,
      url: url ?? this.url,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'url': url,
    };
  }

  factory Ability.fromMap(Map<String, dynamic> map) {
    return Ability(
      name: map['name'],
      url: map['url'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Ability.fromJson(String source) =>
      Ability.fromMap(json.decode(source));

  @override
  String toString() => 'Ability(name: $name, url: $url)';

  @override
  bool operator ==(covariant Ability other) {
    if (identical(this, other)) return true;

    return other.name == name && other.url == url;
  }

  @override
  int get hashCode => name.hashCode ^ url.hashCode;
}

class PokemonStat {
  final int baseStat;
  final int effort;
  final Stat stat;
  PokemonStat({
    required this.baseStat,
    required this.effort,
    required this.stat,
  });

  PokemonStat copyWith({
    int? baseStat,
    int? effort,
    Stat? stat,
  }) {
    return PokemonStat(
      baseStat: baseStat ?? this.baseStat,
      effort: effort ?? this.effort,
      stat: stat ?? this.stat,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'base_stat': baseStat,
      'effort': effort,
      'stat': stat.toMap(),
    };
  }

  factory PokemonStat.fromMap(Map<String, dynamic> map) {
    return PokemonStat(
      baseStat: map['base_stat'],
      effort: map['effort'],
      stat: Stat.fromMap(map['stat']),
    );
  }

  String toJson() => json.encode(toMap());

  factory PokemonStat.fromJson(String source) =>
      PokemonStat.fromMap(json.decode(source));

  @override
  String toString() =>
      'Stat(baseStat: $baseStat, effort: $effort, stat: $stat)';

  @override
  bool operator ==(covariant PokemonStat other) {
    if (identical(this, other)) return true;

    return other.baseStat == baseStat &&
        other.effort == effort &&
        other.stat == stat;
  }

  @override
  int get hashCode => baseStat.hashCode ^ effort.hashCode ^ stat.hashCode;
}

class Stat {
  final String name;
  final String url;
  Stat({
    required this.name,
    required this.url,
  });

  Stat copyWith({
    String? name,
    String? url,
  }) {
    return Stat(
      name: name ?? this.name,
      url: url ?? this.url,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'url': url,
    };
  }

  factory Stat.fromMap(Map<String, dynamic> map) {
    return Stat(
      name: map['name'],
      url: map['url'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Stat.fromJson(String source) => Stat.fromMap(json.decode(source));

  @override
  String toString() => 'Stat(name: $name, url: $url)';

  @override
  bool operator ==(covariant Stat other) {
    if (identical(this, other)) return true;

    return other.name == name && other.url == url;
  }

  @override
  int get hashCode => name.hashCode ^ url.hashCode;
}

class PokemonType {
  final int slot;
  final Type type;
  PokemonType({
    required this.slot,
    required this.type,
  });

  PokemonType copyWith({
    int? slot,
    Type? type,
  }) {
    return PokemonType(
      slot: slot ?? this.slot,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'slot': slot,
      'type': type.toMap(),
    };
  }

  factory PokemonType.fromMap(Map<String, dynamic> map) {
    return PokemonType(
      slot: map['slot'],
      type: Type.fromMap(map['type']),
    );
  }

  String toJson() => json.encode(toMap());

  factory PokemonType.fromJson(String source) =>
      PokemonType.fromMap(json.decode(source));

  @override
  String toString() => 'Type(slot: $slot, type: $type)';

  @override
  bool operator ==(covariant PokemonType other) {
    if (identical(this, other)) return true;

    return other.slot == slot && other.type == type;
  }

  @override
  int get hashCode => slot.hashCode ^ type.hashCode;
}

class Type {
  final String name;
  final String url;
  Type({
    required this.name,
    required this.url,
  });

  Type copyWith({
    String? name,
    String? url,
  }) {
    return Type(
      name: name ?? this.name,
      url: url ?? this.url,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'url': url,
    };
  }

  factory Type.fromMap(Map<String, dynamic> map) {
    return Type(
      name: map['name'],
      url: map['url'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Type.fromJson(String source) => Type.fromMap(json.decode(source));

  @override
  String toString() => 'Type(name: $name, url: $url)';

  @override
  bool operator ==(covariant Type other) {
    if (identical(this, other)) return true;

    return other.name == name && other.url == url;
  }

  @override
  int get hashCode => name.hashCode ^ url.hashCode;
}

class PokemonSpecies {
  final String name;
  final String url;
  bool isFavorite;
  PokemonSpecies({
    required this.name,
    required this.url,
    this.isFavorite = false,
  });

  PokemonSpecies copyWith({
    String? name,
    String? url,
  }) {
    return PokemonSpecies(
      name: name ?? this.name,
      url: url ?? this.url,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'url': url,
    };
  }

  factory PokemonSpecies.fromMap(Map<String, dynamic> map) {
    return PokemonSpecies(
      name: map['name'],
      url: map['url'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PokemonSpecies.fromJson(String source) =>
      PokemonSpecies.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'PokemonSpecies(name: $name, url: $url)';

  @override
  bool operator ==(covariant PokemonSpecies other) {
    if (identical(this, other)) return true;

    return other.name == name && other.url == url;
  }

  @override
  int get hashCode => name.hashCode ^ url.hashCode;
}
