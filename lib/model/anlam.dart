

class Anlam {
  int? iId;
  String? maddeId;
  String? kac;
  String? kelimeNo;
  String? cesit;
  String? anlamGor;
  String? madde;
  String? cesitSay;
  String? anlamSay;
  String? taki;
  String? cogulMu;
  String? ozelMi;
  String? egikMi;
  String? lisanKodu;
  String? lisan;
  String? telaffuz;
  String? birlesikler;
  String? maddeDuz;
  List<AnlamlarListe>? anlamlarListe;
  List<Atasozu>? atasozu;

  Anlam({
    this.iId,
    this.maddeId,
    this.kac,
    this.kelimeNo,
    this.cesit,
    this.anlamGor,
    this.madde,
    this.cesitSay,
    this.anlamSay,
    this.taki,
    this.cogulMu,
    this.ozelMi,
    this.egikMi,
    this.lisanKodu,
    this.lisan,
    this.telaffuz,
    this.birlesikler,
    this.maddeDuz,
    this.anlamlarListe,
    this.atasozu,
  });

  factory Anlam.fromJson(Map<String, dynamic> json) {
    return Anlam(
      iId: json['id'],
      maddeId: json['maddeid'],
      kac: json['kac'],
      kelimeNo: json['kelimeno'],
      cesit: json['cesit'],
      anlamGor: json['anlamgor'],
      madde: json['madde'],
      cesitSay: json['cesitsay'],
      anlamSay: json['anlamsay'],
      taki: json['taki'],
      cogulMu: json['cogulmu'],
      ozelMi: json['ozelmi'],
      egikMi: json['egikmi'],
      lisanKodu: json['lisankodu'],
      lisan: json['lisan'],
      telaffuz: json['telaffuz'],
      birlesikler: json['birlesikler'],
      maddeDuz: json['maddeduz'],
      anlamlarListe: (json['anlamlarListe'] as List?)
          ?.map((e) => AnlamlarListe.fromJson(e))
          .toList(),
      atasozu:
          (json['atasozu'] as List?)?.map((e) => Atasozu.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': iId,
      'maddeid': maddeId,
      'kac': kac,
      'kelimeno': kelimeNo,
      'cesit': cesit,
      'anlamgor': anlamGor,
      'madde': madde,
      'cesitsay': cesitSay,
      'anlamsay': anlamSay,
      'taki': taki,
      'cogulmu': cogulMu,
      'ozelmi': ozelMi,
      'egikmi': egikMi,
      'lisankodu': lisanKodu,
      'lisan': lisan,
      'telaffuz': telaffuz,
      'birlesikler': birlesikler,
      'maddeduz': maddeDuz,
      'anlamlarListe': anlamlarListe?.map((e) => e.toJson()).toList(),
      'atasozu': atasozu?.map((e) => e.toJson()).toList(),
    };
  }
}

class AnlamlarListe {
  String? anlamId;
  String? maddeId;
  String? anlamSira;
  String? fiil;
  String? tipkes;
  String? anlam;
  String? gos;
  List<OzelliklerListe>? ozelliklerListe;
  List<OrneklerListe>? orneklerListe;

  AnlamlarListe({
    this.anlamId,
    this.maddeId,
    this.anlamSira,
    this.fiil,
    this.tipkes,
    this.anlam,
    this.gos,
    this.ozelliklerListe,
    this.orneklerListe,
  });

  factory AnlamlarListe.fromJson(Map<String, dynamic> json) {
    return AnlamlarListe(
      anlamId: json['anlamid'],
      maddeId: json['maddeid'],
      anlamSira: json['anlamsira'],
      fiil: json['fiil'],
      tipkes: json['tipkes'],
      anlam: json['anlam'],
      gos: json['gos'],
      ozelliklerListe: (json['ozelliklerListe'] as List?)
          ?.map((e) => OzelliklerListe.fromJson(e))
          .toList(),
      orneklerListe: (json['orneklerListe'] as List?)
          ?.map((e) => OrneklerListe.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'anlamid': anlamId,
      'maddeid': maddeId,
      'anlamsira': anlamSira,
      'fiil': fiil,
      'tipkes': tipkes,
      'anlam': anlam,
      'gos': gos,
      'ozelliklerListe': ozelliklerListe?.map((e) => e.toJson()).toList(),
      'orneklerListe': orneklerListe?.map((e) => e.toJson()).toList(),
    };
  }
}

class OzelliklerListe {
  String? ozellikId;
  String? tur;
  String? tamAdi;
  String? kisaAdi;
  String? ekno;

  OzelliklerListe({
    this.ozellikId,
    this.tur,
    this.tamAdi,
    this.kisaAdi,
    this.ekno,
  });

  factory OzelliklerListe.fromJson(Map<String, dynamic> json) {
    return OzelliklerListe(
      ozellikId: json['ozellikid'],
      tur: json['tur'],
      tamAdi: json['tamadi'],
      kisaAdi: json['kisaadi'],
      ekno: json['ekno'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ozellikid': ozellikId,
      'tur': tur,
      'tamadi': tamAdi,
      'kisaadi': kisaAdi,
      'ekno': ekno,
    };
  }
}

class OrneklerListe {
  String? ornekId;
  String? ornekSira;
  String? ornek;
  String? kac;
  List<Yazar>? yazar;

  OrneklerListe({
    this.ornekId,
    this.ornekSira,
    this.ornek,
    this.kac,
    this.yazar,
  });

  factory OrneklerListe.fromJson(Map<String, dynamic> json) {
    return OrneklerListe(
      ornekId: json['ornekid'],
      ornekSira: json['orneksira'],
      ornek: json['ornek'],
      kac: json['kac'],
      yazar: (json['yazar'] as List?)?.map((e) => Yazar.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ornekid': ornekId,
      'orneksira': ornekSira,
      'ornek': ornek,
      'kac': kac,
      'yazar': yazar?.map((e) => e.toJson()).toList(),
    };
  }
}

class Yazar {
  String? yazarId;
  String? tamAdi;
  String? kisaAdi;
  String? ekno;

  Yazar({
    this.yazarId,
    this.tamAdi,
    this.kisaAdi,
    this.ekno,
  });

  factory Yazar.fromJson(Map<String, dynamic> json) {
    return Yazar(
      yazarId: json['yazarid'],
      tamAdi: json['tamadi'],
      kisaAdi: json['kisaadi'],
      ekno: json['ekno'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'yazarid': yazarId,
      'tamadi': tamAdi,
      'kisaadi': kisaAdi,
      'ekno': ekno,
    };
  }
}

class Atasozu {
  String? maddeId;
  String? madde;
  String? ontaki;
  String? maddeDuz;

  Atasozu({
    this.maddeId,
    this.madde,
    this.ontaki,
    this.maddeDuz,
  });

  factory Atasozu.fromJson(Map<String, dynamic> json) {
    return Atasozu(
      maddeId: json['maddeid'],
      madde: json['madde'],
      ontaki: json['ontaki'],
      maddeDuz: json['maddeduz'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'maddeid': maddeId,
      'madde': madde,
      'ontaki': ontaki,
      'maddeduz': maddeDuz,
    };
  }
}

