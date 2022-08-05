// ignore_for_file: lines_longer_than_80_chars

class Country {
  Country({
    this.name,
    this.tld,
    this.cca2,
    this.cca3,
    this.independent,
    this.status,
    this.unMember,
    this.currencies,
    this.idd,
    this.capital,
    this.altSpellings,
    this.region,
    this.subregion,
    this.languages,
    this.translations,
    this.latlng,
    this.landlocked,
    this.borders,
    this.area,
    this.flag,
    this.maps,
    this.population,
    this.timezones,
    this.continents,
    this.flags,
    this.coatOfArms,
    this.startOfWeek,
  });

  Country.withError(String errorMessage) {
    error = errorMessage;
  }

  Country.fromJson(Map<String, dynamic> json) {
    name = (json['name'] as Map<String, dynamic>?) != null
        ? Name.fromJson(json['name'] as Map<String, dynamic>)
        : null;
    tld = (json['tld'] as List?)?.map((dynamic e) => e as String).toList();
    cca2 = json['cca2'] as String?;

    cca3 = json['cca3'] as String?;

    independent = json['independent'] as bool?;
    status = json['status'] as String?;
    unMember = json['unMember'] as bool?;
    currencies = (json['currencies'] as Map<String, dynamic>?) != null
        ? Currencies.fromJson(json['currencies'] as Map<String, dynamic>)
        : null;
    idd = (json['idd'] as Map<String, dynamic>?) != null
        ? Idd.fromJson(json['idd'] as Map<String, dynamic>)
        : null;
    capital =
        (json['capital'] as List?)?.map((dynamic e) => e as String).toList();
    altSpellings = (json['altSpellings'] as List?)
        ?.map((dynamic e) => e as String)
        .toList();
    region = json['region'] as String?;
    subregion = json['subregion'] as String?;
    languages = (json['languages'] as Map<String, dynamic>?) != null
        ? Languages.fromJson(json['languages'] as Map<String, dynamic>)
        : null;
    translations = (json['translations'] as Map<String, dynamic>?) != null
        ? Translations.fromJson(json['translations'] as Map<String, dynamic>)
        : null;
    latlng =
        (json['latlng'] as List?)?.map((dynamic e) => e as double).toList();
    landlocked = json['landlocked'] as bool?;
    borders =
        (json['borders'] as List?)?.map((dynamic e) => e as String).toList();
    area = json['area'] as double?;

    flag = json['flag'] as String?;
    maps = (json['maps'] as Map<String, dynamic>?) != null
        ? Maps.fromJson(json['maps'] as Map<String, dynamic>)
        : null;
    population = json['population'];
    timezones =
        (json['timezones'] as List?)?.map((dynamic e) => e as String).toList();
    continents =
        (json['continents'] as List?)?.map((dynamic e) => e as String).toList();
    flags = (json['flags'] as Map<String, dynamic>?) != null
        ? Flags.fromJson(json['flags'] as Map<String, dynamic>)
        : null;
    coatOfArms = (json['coatOfArms'] as Map<String, dynamic>?) != null
        ? CoatOfArms.fromJson(json['coatOfArms'] as Map<String, dynamic>)
        : null;
    startOfWeek = json['startOfWeek'] as String?;
  }
  Name? name;
  List<String>? tld;
  String? cca2;
  String? cca3;
  bool? independent;
  String? status;
  bool? unMember;
  Currencies? currencies;
  Idd? idd;
  List<String>? capital;
  List<String>? altSpellings;
  String? region;
  String? subregion;
  Languages? languages;
  Translations? translations;
  List<double>? latlng;
  bool? landlocked;
  List<String>? borders;
  double? area;
  String? flag;
  Maps? maps;
  dynamic population;
  List<String>? timezones;
  List<String>? continents;
  Flags? flags;
  CoatOfArms? coatOfArms;
  String? startOfWeek;
  String? error;

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json['name'] = name?.toJson();
    json['tld'] = tld;
    json['cca2'] = cca2;
    json['cca3'] = cca3;
    json['independent'] = independent;
    json['status'] = status;
    json['unMember'] = unMember;
    json['currencies'] = currencies?.toJson();
    json['idd'] = idd?.toJson();
    json['capital'] = capital;
    json['altSpellings'] = altSpellings;
    json['region'] = region;
    json['subregion'] = subregion;
    json['languages'] = languages?.toJson();
    json['translations'] = translations?.toJson();
    json['latlng'] = latlng;
    json['landlocked'] = landlocked;
    json['borders'] = borders;
    json['area'] = area;
    json['flag'] = flag;
    json['maps'] = maps?.toJson();
    json['population'] = population;
    json['timezones'] = timezones;
    json['continents'] = continents;
    json['flags'] = flags?.toJson();
    json['coatOfArms'] = coatOfArms?.toJson();
    json['startOfWeek'] = startOfWeek;
    return json;
  }
}

class Name {
  Name(
      {this.common,
      this.official,
      this.officialNativeName,
      this.commonNativeName});

  Name.fromJson(Map<String, dynamic> json) {
    common = json['common'] as String?;
    official = json['official'] as String?;
    officialNativeName = (json['nativeName'] as Map<String, dynamic>?) != null
        ? (json['nativeName'] as Map<String, dynamic>)
            .entries
            .first
            .value['official']
            .toString()
        : null;

    commonNativeName = (json['nativeName'] as Map<String, dynamic>?) != null
        ? (json['nativeName'] as Map<String, dynamic>)
            .entries
            .first
            .value['common']
            .toString()
        : null;
  }
  String? common;
  String? official;
  String? officialNativeName;
  String? commonNativeName;

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json['common'] = common;
    json['official'] = official;
    json['officialNativeName'] = officialNativeName;
    json['commonNativeName'] = commonNativeName;
    return json;
  }
}

class NativeName {
  NativeName({
    this.ara,
    this.fra,
  });

  NativeName.fromJson(Map<String, dynamic> json) {
    ara = (json['ara'] as Map<String, dynamic>?) != null
        ? Ara.fromJson(json['ara'] as Map<String, dynamic>)
        : null;
    fra = (json['fra'] as Map<String, dynamic>?) != null
        ? Fra.fromJson(json['fra'] as Map<String, dynamic>)
        : null;
  }
  Ara? ara;
  Fra? fra;

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json['ara'] = ara?.toJson();
    json['fra'] = fra?.toJson();
    return json;
  }
}

class Ara {
  Ara({
    this.official,
    this.common,
  });

  Ara.fromJson(Map<String, dynamic> json) {
    official = json['official'] as String?;
    common = json['common'] as String?;
  }
  String? official;
  String? common;

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json['official'] = official;
    json['common'] = common;
    return json;
  }
}

class Fra {
  Fra({
    this.official,
    this.common,
  });

  Fra.fromJson(Map<String, dynamic> json) {
    official = json['official'] as String?;
    common = json['common'] as String?;
  }
  String? official;
  String? common;

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json['official'] = official;
    json['common'] = common;
    return json;
  }
}

class Currencies {
  Currencies({
    this.lBP,
  });

  Currencies.fromJson(Map<String, dynamic> json) {
    lBP = (json['LBP'] as Map<String, dynamic>?) != null
        ? LBP.fromJson(json['LBP'] as Map<String, dynamic>)
        : null;
  }
  LBP? lBP;

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json['LBP'] = lBP?.toJson();
    return json;
  }
}

class LBP {
  LBP({
    this.name,
    this.symbol,
  });

  LBP.fromJson(Map<String, dynamic> json) {
    name = json['name'] as String?;
    symbol = json['symbol'] as String?;
  }
  String? name;
  String? symbol;

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json['name'] = name;
    json['symbol'] = symbol;
    return json;
  }
}

class Idd {
  Idd({
    this.root,
    this.suffixes,
  });

  Idd.fromJson(Map<String, dynamic> json) {
    root = json['root'] as String?;
    suffixes =
        (json['suffixes'] as List?)?.map((dynamic e) => e as String).toList();
  }
  String? root;
  List<String>? suffixes;

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json['root'] = root;
    json['suffixes'] = suffixes;
    return json;
  }
}

class Languages {
  Languages({
    this.ara,
    this.fra,
  });

  Languages.fromJson(Map<String, dynamic> json) {
    ara = json['ara'] as String?;
    fra = json['fra'] as String?;
  }
  String? ara;
  String? fra;

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json['ara'] = ara;
    json['fra'] = fra;
    return json;
  }
}

class Translations {
  Translations({
    this.ara,
    this.ces,
    this.cym,
    this.deu,
    this.est,
    this.fin,
    this.fra,
    this.hrv,
    this.hun,
    this.ita,
    this.jpn,
    this.kor,
    this.nld,
    this.per,
    this.pol,
    this.por,
    this.rus,
    this.slk,
    this.spa,
    this.swe,
    this.urd,
    this.zho,
  });

  Translations.fromJson(Map<String, dynamic> json) {
    ara = (json['ara'] as Map<String, dynamic>?) != null
        ? Ara.fromJson(json['ara'] as Map<String, dynamic>)
        : null;
    ces = (json['ces'] as Map<String, dynamic>?) != null
        ? CountryNameTranslation.fromJson(json['ces'] as Map<String, dynamic>)
        : null;
    cym = (json['cym'] as Map<String, dynamic>?) != null
        ? CountryNameTranslation.fromJson(json['cym'] as Map<String, dynamic>)
        : null;
    deu = (json['deu'] as Map<String, dynamic>?) != null
        ? CountryNameTranslation.fromJson(json['deu'] as Map<String, dynamic>)
        : null;
    est = (json['est'] as Map<String, dynamic>?) != null
        ? CountryNameTranslation.fromJson(json['est'] as Map<String, dynamic>)
        : null;
    fin = (json['fin'] as Map<String, dynamic>?) != null
        ? CountryNameTranslation.fromJson(json['fin'] as Map<String, dynamic>)
        : null;
    fra = (json['fra'] as Map<String, dynamic>?) != null
        ? CountryNameTranslation.fromJson(json['fra'] as Map<String, dynamic>)
        : null;
    hrv = (json['hrv'] as Map<String, dynamic>?) != null
        ? CountryNameTranslation.fromJson(json['hrv'] as Map<String, dynamic>)
        : null;
    hun = (json['hun'] as Map<String, dynamic>?) != null
        ? CountryNameTranslation.fromJson(json['hun'] as Map<String, dynamic>)
        : null;
    ita = (json['ita'] as Map<String, dynamic>?) != null
        ? CountryNameTranslation.fromJson(json['ita'] as Map<String, dynamic>)
        : null;
    jpn = (json['jpn'] as Map<String, dynamic>?) != null
        ? CountryNameTranslation.fromJson(json['jpn'] as Map<String, dynamic>)
        : null;
    kor = (json['kor'] as Map<String, dynamic>?) != null
        ? CountryNameTranslation.fromJson(json['kor'] as Map<String, dynamic>)
        : null;
    nld = (json['nld'] as Map<String, dynamic>?) != null
        ? CountryNameTranslation.fromJson(json['nld'] as Map<String, dynamic>)
        : null;
    per = (json['per'] as Map<String, dynamic>?) != null
        ? CountryNameTranslation.fromJson(json['per'] as Map<String, dynamic>)
        : null;
    pol = (json['pol'] as Map<String, dynamic>?) != null
        ? CountryNameTranslation.fromJson(json['pol'] as Map<String, dynamic>)
        : null;
    por = (json['por'] as Map<String, dynamic>?) != null
        ? CountryNameTranslation.fromJson(json['por'] as Map<String, dynamic>)
        : null;
    rus = (json['rus'] as Map<String, dynamic>?) != null
        ? CountryNameTranslation.fromJson(json['rus'] as Map<String, dynamic>)
        : null;
    slk = (json['slk'] as Map<String, dynamic>?) != null
        ? CountryNameTranslation.fromJson(json['slk'] as Map<String, dynamic>)
        : null;
    spa = (json['spa'] as Map<String, dynamic>?) != null
        ? CountryNameTranslation.fromJson(json['spa'] as Map<String, dynamic>)
        : null;
    swe = (json['swe'] as Map<String, dynamic>?) != null
        ? CountryNameTranslation.fromJson(json['swe'] as Map<String, dynamic>)
        : null;
    urd = (json['urd'] as Map<String, dynamic>?) != null
        ? CountryNameTranslation.fromJson(json['urd'] as Map<String, dynamic>)
        : null;
    zho = (json['zho'] as Map<String, dynamic>?) != null
        ? CountryNameTranslation.fromJson(json['zho'] as Map<String, dynamic>)
        : null;
  }
  Ara? ara;
  CountryNameTranslation? ces;
  CountryNameTranslation? cym;
  CountryNameTranslation? deu;
  CountryNameTranslation? est;
  CountryNameTranslation? fin;
  CountryNameTranslation? fra;
  CountryNameTranslation? hrv;
  CountryNameTranslation? hun;
  CountryNameTranslation? ita;
  CountryNameTranslation? jpn;
  CountryNameTranslation? kor;
  CountryNameTranslation? nld;
  CountryNameTranslation? per;
  CountryNameTranslation? pol;
  CountryNameTranslation? por;
  CountryNameTranslation? rus;
  CountryNameTranslation? slk;
  CountryNameTranslation? spa;
  CountryNameTranslation? swe;
  CountryNameTranslation? urd;
  CountryNameTranslation? zho;

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json['ara'] = ara?.toJson();
    json['ces'] = ces?.toJson();
    json['cym'] = cym?.toJson();
    json['deu'] = deu?.toJson();
    json['est'] = est?.toJson();
    json['fin'] = fin?.toJson();
    json['fra'] = fra?.toJson();
    json['hrv'] = hrv?.toJson();
    json['hun'] = hun?.toJson();
    json['ita'] = ita?.toJson();
    json['jpn'] = jpn?.toJson();
    json['kor'] = kor?.toJson();
    json['nld'] = nld?.toJson();
    json['per'] = per?.toJson();
    json['pol'] = pol?.toJson();
    json['por'] = por?.toJson();
    json['rus'] = rus?.toJson();
    json['slk'] = slk?.toJson();
    json['spa'] = spa?.toJson();
    json['swe'] = swe?.toJson();
    json['urd'] = urd?.toJson();
    json['zho'] = zho?.toJson();
    return json;
  }
}

class CountryNameTranslation {
  CountryNameTranslation({
    this.official,
    this.common,
  });

  CountryNameTranslation.fromJson(Map<String, dynamic> json) {
    official = json['official'] as String?;
    common = json['common'] as String?;
  }
  String? official;
  String? common;

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json['official'] = official;
    json['common'] = common;
    return json;
  }
}

class Eng {
  Eng({
    this.f,
    this.m,
  });

  Eng.fromJson(Map<String, dynamic> json) {
    f = json['f'] as String?;
    m = json['m'] as String?;
  }
  String? f;
  String? m;

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json['f'] = f;
    json['m'] = m;
    return json;
  }
}

class Maps {
  Maps({
    this.googleMaps,
    this.openStreetMaps,
  });

  Maps.fromJson(Map<String, dynamic> json) {
    googleMaps = json['googleMaps'] as String?;
    openStreetMaps = json['openStreetMaps'] as String?;
  }
  String? googleMaps;
  String? openStreetMaps;

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json['googleMaps'] = googleMaps;
    json['openStreetMaps'] = openStreetMaps;
    return json;
  }
}

class Flags {
  Flags({
    this.png,
    this.svg,
  });

  Flags.fromJson(Map<String, dynamic> json) {
    png = json['png'] as String?;
    svg = json['svg'] as String?;
  }
  String? png;
  String? svg;

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json['png'] = png;
    json['svg'] = svg;
    return json;
  }
}

class CoatOfArms {
  CoatOfArms({
    this.png,
    this.svg,
  });

  CoatOfArms.fromJson(Map<String, dynamic> json) {
    png = json['png'] as String?;
    svg = json['svg'] as String?;
  }
  String? png;
  String? svg;

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json['png'] = png;
    json['svg'] = svg;
    return json;
  }
}

class CapitalInfo {
  CapitalInfo({
    this.latlng,
  });

  CapitalInfo.fromJson(Map<String, dynamic> json) {
    latlng =
        (json['latlng'] as List?)?.map((dynamic e) => e as double).toList();
  }
  List<double>? latlng;

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json['latlng'] = latlng;
    return json;
  }
}

class PostalCode {
  PostalCode({
    this.format,
    this.regex,
  });

  PostalCode.fromJson(Map<String, dynamic> json) {
    format = json['format'] as String?;
    regex = json['regex'] as String?;
  }
  String? format;
  String? regex;

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json['format'] = format;
    json['regex'] = regex;
    return json;
  }
}
