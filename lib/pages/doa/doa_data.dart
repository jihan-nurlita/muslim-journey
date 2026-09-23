/// doa_data.dart

class DoaModel {
  final String judul;
  final List<String> kategori; // Ubah String -> List<String>
  final String arab;
  final String latin;
  final String arti;

  /// TAMBAHAN
  final String keterangan;
  final String dalil;

  DoaModel({
    required this.judul,
    required this.kategori,
    required this.arab,
    required this.latin,
    required this.arti,
    required this.keterangan,
    required this.dalil,
  });
}

List<DoaModel> doaList = [
  DoaModel(
    judul: "Doa untuk Kedua Orang Tua",
    kategori: ["Doa-Doa"],
    arab:
        "اَللّٰهُمَّ اغْفِرْ لِيْ ذُنُوْبِيْ وَلِوَالِدَيَّ وَارْحَمْهُمَا كَمَا رَبَّيَانِيْ صَغِيْرًا",
    latin:
        "Allâhummaghfirlî dzunûbî wâlidayya warḫamhumâ kamâ rabbayânî shaghîrâ.",
    arti:
        "Tuhanku, ampunilah diriku dan kedua orang tuaku, sayangilah mereka sebagaimana mereka menyayangiku di waktu aku kecil.",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: "Doa Sebelum Tidur",
    kategori: ["Doa-Doa"],
    arab: "بِسْمِكَ اَللّٰهُمَّ أَحْيَا وَبِسْمِكَ أَمُوْتُ",
    latin: "bismika Allâhumma aḫyâ wa bismika amût(u)",
    arti:
        "Ya Allah, dengan Nama-Mu, aku hidup dan dengan nama-Mu pula aku mati.",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: "Doa Bangun Tidur",
    kategori: ["Doa-Doa"],
    arab:
        "اَلْحَمْدُ ِللّٰهِ الَّذِيْ أَحْيَانَا بَعْدَمَا أَمَاتَنَا وَإِلَيْهِ النُّشُوْرُ",
    latin: "Alḫamdulillâhil ladzî aḫyânâ ba‘da mâ amâtanâ wa ilaihin nusyûr(u)",
    arti:
        "Segala puji bagi Allah yang menghidupkanku kembali setelah mematikanku dan hanya kepada-Nya akan bangkit.",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: "Doa Masuk Kamar Mandi",
    kategori: ["Doa-Doa"],
    arab:
        "بِسْمِ اللهِ اَللّٰهُمَّ إِنِّيْ أَعُوْذُ بِكَ مِنَ الْخُبُثِ وَالْخَبَائِثِ",
    latin:
        "Bismillâhi allâhumma innî a‘ûdzu bika minal khubutsi wal khabâits(i)",
    arti:
        "Dengan nama Allah, ya Allah, aku berlindung kepada-Mu dari godaan setan laki-laki dan setan perempuan (sesuatu yang keji dan menjijikkan).",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: "Doa Keluar Kamar Mandi",
    kategori: ["Doa-Doa"],
    arab:
        "غُفْرَانَكَ الْحَمْدُ لِلّٰهِ الَّذِيْ أَذْهَبَ عَنِّيْ الْأَذَى وَعَافَانِيْ",
    latin: "Ghufrânaka alḫamdulillâhil-ladzî adzhaba ‘annil adzâ wa ‘âfânî",
    arti:
        "Dengan mengharap ampunan-Mu, segala puji bagi Allah yang telah menghilangkan penyakit dari tubuhku dan menyehatkan aku.",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: "Doa Bercermin",
    kategori: ["Doa-Doa"],
    arab: "اَلْحَمْدُ لِلّٰهِ كَمَا حَسَّنْتَ خَلْقِيْ فَحَسِّنْ خُلُقِيْ",
    latin: "Alḫamdulillâhi kamâ ḫassanta khalqî faḫassin khuluqî",
    arti:
        "Ya Allah, sebagaimana Engkau telah memperindah rupa lahiriahku, maka perindah pula akhlakku.",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: "Doa Memakai Pakaian",
    kategori: ["Doa-Doa"],
    arab:
        "بِسْمِ اللهِ اَللّٰهُمَّ إِنِّي أَسْأَلُكَ مِنْ خَيْرِهِ وَخَيْرِ مَا هُوَ لَهُ، وَأَعُوْذُ بِكَ مِنْ شَرِّهِ وَشَرِّ مَا هُوَ لَهُ",
    latin:
        "Bismillâhi Allâhumma innî as’aluka min khairihi wa khairi mâ huwa lahu, wa a‘ûdzubika min syarrihi wa syarri mâ huwa lahu",
    arti:
        "Dengan nama Allah Allâhumma innî as’aluka min khairihi wa khairi mâ huwa lahu, wa a‘ûdzubika min syarrihi wa syarri mâ huwa lahu",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: "Doa Melepas Pakaian",
    kategori: ["Doa-Doa"],
    arab: "بِسْمِ اللهِ الَّذِيْ لَا إِلٰهَ إِلَّا هُوَ",
    latin: "Bismillâhil ladzî lâilâha illâ huwa",
    arti: "Dengan nama Allah yang tiada tuhan selain Dia.",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: "Doa Memakai Pakaian Baru",
    kategori: ["Doa-Doa"],
    arab:
        "بِسْمِ اللهِ اَللّٰهُمَّ لَكَ الْحَمْدُ أَنْتَ كَسَوْتَنِيْهِ أَسْأَلُكَ خَيْرَهُ وَخَيْرَ مَا صُنِعَ لَهُ وأَعُوْذُ بِكَ مِنْ شَرِّهِ وَشَرِّ مَا صُنِعَ لَهُ",
    latin:
        "Bismillâhi Allâhumma lakal ḫamdu anta kasautanîhi, as-aluka khairahu wa khaira mâ shuni‘a lahû wa a‘ûdzu bika min syarrihi wa syarri mâ shuni‘a lahû",
    arti:
        "Dengan nama Allah Ya Allah bagi-Mu segala puji. Engkau telah memakaikannya untukku, aku memohon kepada-Mu kebaikannya dan kebaikan apa yang ia dijadikan untuknya, dan aku berlindung dari keburukannya dan keburukan apa yang ia dijadikan untuknya.",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: "Doa Sebelum Makan",
    kategori: ["Doa-Doa"],
    arab:
        "اَللّٰهُمَّ بَارِكْ لَنَا فِيْمَا رَزَقْتَنَا وَقِنَا عَذَابَ النَّارِ",
    latin: "Allâhumma bârik lanâ fîmâ razaqtanâ waqinâ ‘adzâban nâr(i)",
    arti:
        "Ya Allah, berkahilah apa yang telah Engkau anugerahkan kepada kami dan jagalah kami dari siksa neraka.",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: "Doa Sesudah Makan",
    kategori: ["Doa-Doa"],
    arab:
        "اَلْحَمْدُ لِلّٰهِ الَّذِيْ أَطْعَمَنَا وَسَقَــــانَا وَجَعَلَنَا مِنَ الْمُسْلِمِيْنَ",
    latin:
        "Alḫamdulillâhilladzî ath‘amanâ wa saqânâ wa ja‘alanâ minal muslimîn(a)",
    arti:
        "Segala puji bagi Allah yang telah memberi kami makan dan minum, serta menjadikan kami sebagai orang-orang yang berserah diri.",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: "Doa Keluar Rumah",
    kategori: ["Doa-Doa"],
    arab:
        "بِسْمِ اللهِ تَوَكَّلْتُ عَلَى اللهِ وَلَا حَوْلَ وَلَا قُوَّةَ إِلَّا بِاللهِ",
    latin:
        "Bismillâhi tawakkaltu ‘alallâhi wa lâ ḫaula wa lâ quwwata illâ billâh(i)",
    arti:
        "Dengan nama Allah, aku bertawakal kepada Allah. Tidak ada daya dan kekuatan kecuali dengan (pertolongan) Allah.",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: "Doa Masuk Rumah",
    kategori: ["Doa-Doa"],
    arab:
        "اللّٰهُمَّ إنِّي أَسْأَلُكَ خَيْرَ المَوْلِجِ وَخَيْرَ المَخْرَجِ، بِاسْمِ اللّٰهِ وَلَجْنَا، وَبِسْمِ اللّٰهِ خَرَجْنَا، وَعَلَى اللّٰهِ رَبِّنَا تَوَكَّلْنَا",
    latin:
        "Allahumma innii as-aluka khairal mauliji wa khairal makhraji, bismillahi wa lajnaa, wa bismillahi kharajnaa, wa 'alallahi rabbina tawakkalnaa.",
    arti:
        "Ya Allah, sesungguhnya aku memohon kepada-Mu kebaikan tempat masuk dan kebaikan tempat keluar. Dengan menyebut nama Allah kami masuk, dengan menyebut nama Allah kami keluar, dan hanya kepada Allah, Tuhan kami, kami bertawakal",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: "Doa Masuk Masjid",
    kategori: ["Doa-Doa"],
    arab:
        "اَللّٰهُمَّ اغْفِرْ لِيْ ذُنُوْبِيْ وَافْتَحْ لِيْ أَبْوَابَ رَحْمَتِكَ",
    latin: "Allâhummaghfir lî dzunûbî waftaḫ lî abwâba raḫmatik(a)",
    arti:
        "Ya Allah, ampuni segala dosaku dan bukalah bagiku segala pintu rahmat-Mu.",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: "Doa Keluar Masjid",
    kategori: ["Doa-Doa"],
    arab:
        "اَللّٰهُمَّ اغْفِرْ لِيْ ذُنُوْبِيْ وَافْتَحْ لِيْ أَبْوَابَ فَضْلِكَ",
    latin: "Allâhummaghfirlî dzunûbî waftaḫ lî abwâba fadl-lik(a)",
    arti:
        "Ya Allah, ampuni segala dosaku. Bukakanlah bagiku segala pintu anugerahmu-Mu.",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: "Doa saat Turun Hujan",
    kategori: ["Doa-Doa"],
    arab: "اَللّٰهُمَّ صَيِّبًا نَافِعًا",
    latin: "Allâhummâ shayyiban nâfi'an",
    arti: "Ya Allah, turunkanlah pada kami hujan yang bermanfaat.",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: "Doa setelah Hujan Reda",
    kategori: ["Doa-Doa"],
    arab: "مُطِرْنَا بِفَضْلِ اللهِ وَرَحْمَتِهِ",
    latin: "Muthirnâ bi fadhlillâhi wa raḫmatih.",
    arti: "Semoga kita dihujani dengan anugerah dan rahmat Allah.",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: "Doa Sebelum Belajar",
    kategori: ["Belajar"],
    arab:
        "اَللّٰهُمَّ ارْزُقْنَا فَهْمَ النَّبِيِّيْنَ وَحِفْظَ الْمُرْسَلِيْنَ وَإِلْهَامَ الْمَلَائِكَةِ الْمُقَرَّبِيْنَ، بِرَحْمَتِكَ يَا أَرْحَمَ الرَّاحِمِيْنَ",
    latin:
        "Allâhummarzuqnâ fahman nabiyyîna wa ḫifdhal mursalîna wa ilhâmal malâikatil muqarrabîn biraḫmatika yâ arḫamar râḫimîna",
    arti:
        "Ya Allah, anugerahilah kami pemahaman para nabi, hafalan para rasul, dan ilhamnya para malaikat yang dekat (dengan-Mu), sebab kasih sayang-Mu, wahai Dzat yang Maha pengasih",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: "Doa Sesudah Belajar",
    kategori: ["Belajar"],
    arab:
        "اَللّٰهُمَّ إِنِّيْ قَدِ اسْتَوْدَعْتُكَ مَا عَلَّمْتَنِيْهِ فَارْدُدْهُ إِلَيَّ عِنْدَ حَاجَتِيْ إِلَيْهِ وَ لَا تَنْسَنِيْهِ يَا رَبَّ الْعَالَـمِيْنَ",
    latin:
        "Allâhumma innî qad istauda‘tuka mâ ‘allamtanîhi fardud-hu ilayya ‘inda hâjatî ilaihi walâ tansanîhi yâ rabbal ‘âlamîn(a)",
    arti:
        "Ya Allah, sesungguhnya aku titipkan kepada-Mu apa yang telah Kauajarkan kepadaku, maka kembalikanlah ia kepadaku ketika aku membutuhkannya. Dan janganlah Kaubuat aku lupa padanya wahai Tuhan yang memelihara alam.",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: "Doa agar Tak Mudah Lupa",
    kategori: ["Belajar"],
    arab:
        "اللّٰهُمَّ اجْعَلْ نَفْسِيْ مُطْمَئِنَّةً، تُؤْمِنُ بِلِقَائِكَ، وَتَرْضَى بِقَضَائِكَ",
    latin:
        "Allâhumma ij’al nafsî muthmainnatan, tu’minu bi liqâika wa tardlâ bi qadlâika",
    arti:
        "Ya Allah, jadikan jiwa kami menjadi tenang, beriman akan adanya pertemuan dengan-Mu, dan rela atas qadha-Mu (ketentuan-Mu).",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: "Doa Mudah Hafal dan Memahami",
    kategori: ["Belajar"],
    arab:
        "يَا حَيُّ يَا قَيُّوْمُ يَا رَبَّ مُوْسَى وَهَارُوْنَ وَرَبَّ إِبْرَاهِيْمَ، وَيَا رَبَّ مُحَمَّدٍ صَلَّى اللهُ عَلَيْهِ وَسَلَّمَ عَلَيْهِمْ أَجْمَعِيْنَ، اَللّٰهُمَّ ارْزُقْنِيَ الْفَهْمَ وَالْعِلْمَ وَالْحِكْمَةَ وَالْعَقْلَ بِرَحْمَتِكَ يَا أَرْحَمَ الرَّاحِمِيْنَ\n\nفَفَهَّمْنٰهَا سُلَيْمٰنَۚ وَكُلًّا اٰتَيْنَا حُكْمًا وَّعِلْمًاۖ وَّسَخَّرْنَا مَعَ دَاوٗدَ الْجِبَالَ يُسَبِّحْنَ وَالطَّيْرَۗ وَكُنَّا فٰعِلِيْنَ",
    latin:
        "Yâ ḫayyu, yâ qayyûmu, yâ rabba Mûsâ wa Hârûn, wa rabba Ibrâhîm, wayâ rabba Muḫammadin shallallâhu ‘alayhi wa sallama ‘alayhim ajma‘în(a). Allâhummar-zuqniyal fahma wal ‘ilma wal ḫikmata wal ‘aqla bi raḫmatika yâ arḫamar râḫimîn(a)\n\nfa fahhamnâhâ sulaimân, wa kullan âtainâ ḫukmaw wa ‘ilmaw wa sakhkharnâ ma‘a dâwûdal-jibâla yusabbiḫna wath-thaîr, wa kunnâ fâ‘ilîn(a)",
    arti:
        "Wahai Zat yang hidup, wahai zat yang tegak, wahai Tuhan Musa, Harun, Tuhan Ibrahim, wahai Tuhan Muhammad SAW. Ya Allah, karuniakan aku pemahaman, ilmu, kebijaksanaan, dan akal, dengan rahmat-Mu wahai Zat yang Maha Pengasih.\n\nLalu, Kami memberi pemahaman kepada Sulaiman (tentang keputusan yang lebih tepat). Kepada masing-masing (Daud dan Sulaiman) Kami memberi hikmah dan ilmu. Kami menundukkan gunung-gunung dan burung-burung untuk bertasbih bersama Daud. Kamilah yang melakukannya.",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: "Doa Menjawab Soal Ujian",
    kategori: ["Belajar"],
    arab: "رَبِّ يَسِّرْ وَأَعِنْ وَلَا تُعَسِّرْ",
    latin: "Rabbi yassir wa a‘in wa lâ tu‘assir",
    arti: "Wahai Tuhanku, mudahkanlah. Bantulah [aku]. Jangan Kaupersulit.",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: "Doa Mohon Ilmu Bermanfaat",
    kategori: ["Belajar"],
    arab:
        "اَللّٰهُمَّ انْفَعْنِيْ بِمَا عَلَّمْتَنِيْ وَعَلِّمْنِيْ مَا يَنْفَعُنِيْ وَزِدْنِيْ عِلْمًا، اَلْحَمْدُ لِلّٰهِ عَلَى كُلِّ حَالٍ وَأَعُوذُ بِاللّٰهِ مِنْ حَالِ أَهْلِ النَّارِ",
    latin:
        "Allâhumma-nfa‘nî bimâ ‘allamtanî wa ‘allimnî mâ yanfa‘unî wa zidnî ‘ilman, alhamdu lillâhi alâ kulli ḫâlin wa a‘ûdzu billâhi min ḫâli ahlin nâr(i)",
    arti:
        "Ya Allah, berilah manfaat dengan apa yang telah Engkau ajarkan kepadaku. Ajarkan kepadaku sesuatu yang bermanfaat bagiku dan tambahkanlah kepadaku ilmu. Segala puji hanya milik Allah pada setiap keadaan dan aku berlindung kepada Allah dari perilaku ahli neraka.",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: "Mendoakan Guru",
    kategori: ["Belajar"],
    arab:
        "اَللّٰهُمَّ اغْفِرْ لِمَشَايِخِنَا وَلِمَنْ عَلَّمَنَا، وَارْحَمْهُمْ وَأَكْرِمْهُمْ بِرِضْوَانِكَ الْعَظِيْمِ، فِيْ مَقْعَدِ الصِّدْقِ عِنْدَكَ يَا أَرْحَمَ الرَّاحِمِيْنَ",
    latin:
        "Allâhumma-ghfir li masyâyikhinâ wa liman ‘allamanâ wa-rḫamhum wa akrimhum biridlwânikal ‘adhîm fî maq’adish shidqi ‘indaka yâ arḫamar râḫimîn(a)",
    arti:
        "Wahai Allah ampunilah guru-guru kami dan orang yang telah mengajar kami. Sayangilah mereka, muliakanlah mereka dengan keridhaan-Mu yang agung, di tempat yang disenangi di sisi-Mu, wahai Yang Maha Penyayang di antara penyayang.",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: "Doa Penutup Majelis",
    kategori: ["Belajar"],
    arab:
        "سُبْحَانَكَ اللّٰهُمَّ وبِحَمْدِكَ أَشْهَدُ أَنْ لَا إِلٰهَ إِلَّا أَنْتَ أَسْتَغْفِرُكَ وَأَتُوْبُ إِلَيْكَ",
    latin:
        "Subḫânakallâhumma wa biḫamdika asyhadu an-lâilâha illâ anta astaghfiruka wa atûbu ilaik(a)",
    arti:
        "Mahasuci Engkau, ya Allah. Segala sanjungan untuk-Mu. Aku bersaksi bahwa tiada tuhan melainkan Engkau. Aku memohon ampun dan bertaubat kepada-Mu.",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: "Doa Dijauhkan dari Maksiat",
    kategori: ["Doa-Doa"],
    arab:
        "اللّٰهُمَّ إِنَّا نَسْئَلُكَ التَّوْبَةَ وَدَوَامَهَا وَنَعُوْذُ بِكَ مِنَ الْمَعْصِيَةِ وَأَسْبَابِهَا وَذَكِّرْنَا بِالخَوْفِ مِنْكَ قَبْلَ هُجُوْمِ خَطَرَاتِهَا، وَاحْمِلْهُ عَلَى النَّجَاةِ مِنْهَا وَمِنَ التَّفَكُّرِ فِيْ طَرَائِقِهَا، وَامْحُ مِنْ قُلُوْبِنَا حَلَاوَةَ مَا اجْتَبَيْنَاهُ مِنْهَا، وَاسْتَبْدِلْهَا بِالكَرَاهَةِ لَهَا وَالطَّمَعِ لِمَا هُوَ بِضِدِّهَا",
    latin:
        "Allâhumma innâ nas’alukat taubata wa dawâmahâ, wa na‘ûdzu bika minal ma‘shiyati wa asbâbihâ, wa dzakkirnâ bil khaufi minka qabla hujûmi khatharâtihâ, waḫmilhu alan najâti minhâ wa minat tafakkuri fī tharâ’iqihâ, wamḫu min qulûbinâ ḫalâwata majtabainâhu minhâ, wastabdilhâ bil karâhati lahâ wat thama‘i li mâ huwa bi dhiddihâ.",
    arti:
        "Ya Allah, kepada-Mu kami meminta pertobatan dan kelanggengannya, kepada-Mu kami berlindung dari maksiat dan sebab-sebabnya, ingatkan kami agar takut kepada-Mu sebelum datang bersitan untuk melakukannya; doronglah ketakutan itu untuk menyelamatkan kami darinya dan dari memikirkan jalan-jalannya, hapuskan kelezatan maksiat yang kami pilih dari hati kami,  gantikan kenikmatan itu dengan rasa benci terhadapnya dan keinginan terhadap hal yang berlawanan dengannya.",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: "Doa agar Giat Beribadah",
    kategori: ["Doa-Doa"],
    arab:
        "اَللّٰهُمَّ وَفِّقْنَا لِطَاعَتِكَ وَأَتْمِمْ تَقْصِيْرَنَا وَتَقَبَّلْ مِنَّا إِنَّكَ أَنْتَ السَّمِيْعُ العَلِيْمُ وَصَلَّى اللهُ عَلَى سَيِّدِنَا مُحَمَّدٍ وَاٰلِهِ وَصَحْبِهِ وَسَلَّمَ وَالْحَمْدُ لِلّٰهِ رَبِّ الْعَالَمِيْنَ",
    latin:
        "Allâhumma waffiqnâ li thâ‘atika, wa atmim taqshîranâ, wa taqabbal minnâ, innaka antas samî‘ul ‘alîm. Wa shallallâhu ‘alâ sayyidinâ muḫammadin wa ‘âlihî wa shaḫbihî wa sallam. Walḫamdulillâhi rabbil ‘âlamîn.",
    arti:
        "Ya Allah, bimbinglah kami untuk melakukan ketaatan kepada-Mu, sempurnakanlah kekurangan kami, terimalah ibadah kami. Sungguh, Kau maha mendengar lagi mengetahui. Semoga Allah melimpahkan shalawat dan salam-Nya kepada Nabi Muhammad SAW, keluarga, dan para sahabatnya. Segala puji milik Allah pemelihara alam semesta.",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: "Doa Mohon Akhlak Mulia",
    kategori: ["Doa-Doa"],
    arab:
        "اَللّٰهُمَّ اهْدِنِيْ لِأَحْسَنِ الْأَخْلَاقِ لَا يَهْدِيْ لِأَحْسَنِهَا إِلَّا أَنْتَ، وَاصْرِفْ عَنِّيْ سَيِّئَهَا لَا يَصْرِفُ عَنِّيْ سَيِّئَهَا إِلَّا أَنْتَ",
    latin:
        "Allâhummahdinî li-aḫsanil akhlâq, lâ yahdii li-aḫsanihâ illâ anta, wash-rif ‘annî sayyi-ahâ, lâ yash-rifu ‘annî sayyi-ahâ illâ anta",
    arti:
        "Ya Allah, tunjukkanlah aku kepada akhlak yang baik. Tidak ada yang dapat menunjukkan kepadanya kecuali Engkau. Dan palingkanlah dariku akhlak yang buruk. Tidak ada yang dapat memalingkannya dariku kecuali Engkau.",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: "Doa Menghilangkan Malas",
    kategori: ["Doa-Doa"],
    arab:
        "اللّٰهُمَّ إِنِّيْ أَعُوْذُ بِكَ مِنَ الْكَسَلِ وَأَعُوْذُ بِكَ مِنَ الْجُبْنِ وَأَعُوْذُ بِكَ مِنَ الْهَرَمِ وَأَعُوذُ بِكَ مِنَ الْبُخْلِ",
    latin:
        "Allâhumma innî a‘ûdzubika minal kasali wa a‘ûdzubika minal jubni wa a‘ûdzubika minal harami wa a’ûdzubika minal bukhli ",
    arti:
        "Ya Allah sesungguhnya aku berlindung kepada-Mu dari rasa malas, dan aku berlindung kepada-Mu dari sikap pengecut, dan aku aku berlindung kepada-Mu dari pikun, dan aku berlindung kepada-Mu dari sifat pelit.",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: "Doa Meredam Rasa Marah",
    kategori: ["Doa-Doa"],
    arab:
        "اَللّٰهُمَّ اغْفِرْ لِيْ ذَنْبِيْ وَأَذْهِبْ غَيْظَ قَلْبِيْ وَأَجِرْنِيْ مِنَ الشَّيْطَانِ",
    latin:
        "Allâhummaghfirlî dzanbî, wa adzhib ghaizha qalbî, wa ajirnî minas syaithâni",
    arti:
        "Tuhanku, ampunilah dosaku, redamlah murka hatiku, dan lindungilah diriku dari pengaruh setan.",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: "Doa saat Dihinggapi Rasa Sombong",
    kategori: ["Doa-Doa"],
    arab:
        "اَللّٰهُمَّ أَحْيِنِيْ مِسْكِيْنًا وَأَمِتْنِيْ مِسْكِيْنًا وَاحْشُرْنِيْ فِيْ زُمْرَةِ الْمَسَاكِيْنِ",
    latin:
        "Allâhumma aḫyinî miskînan wa amitnî miskînan waḫsyurnî fî zumratil masâkîn",
    arti:
        "Ya Allah, hidupkanlah aku dalam keadaan miskin (tawadhu), matikanlah aku dalam keadaan miskin (tawadhu), dan kumpulkanlah aku bersama rombongan orang-orang miskin (tawadhu).' (HR Ibnu Majah dan lain-lain)",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: "Doa untuk Orang Iri atau Dengki",
    kategori: ["Doa-Doa"],
    arab:
        "اَللّٰهُمَّ اغْفِرْ لِحَاسِدِيْنَا فَإِنَّهُمْ لِمَا عِنْدَهُمْ مِنَ الضَّيْقِ لَا يَحْتَمِلُوْنَ رُؤْيَةَ النِّعَمِ الَّتِيْ عَلَيْنَا دُوْنَهُمْ، وَلَوِ اتَّسَعَتْ نُفُوْسُهُمْ لَمْ يَقَعُوْا فِي حَسَدِنَا",
    latin:
        "Allâḥummaghfir li hâsidînâ, fa innahum li mâ ‘indahum minadl dlaiqi lâ yaḫtamilûna ru’yatan ni‘amil latî ‘alainâ dûnahum. Wa law ittasa’at nufûsuhum lam yaq‘û fî hasadinâ",
    arti:
        "Ya Allah, ampunilah para pendengki kami karena mereka dalam kesempitan hatinya tidak kuat melihat nikmat-nikmat yang dianugerahkan pada kami, bukan pada mereka. Andai berhati lapang, mereka tentu takkan iri dengki kepada kami",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: "Doa Mohon Istiqamah",
    kategori: ["Doa-Doa"],
    arab:
        "رَبَّنَا لَا تُزِغْ قُلُوبَنَا بَعْدَ إِذْ هَدَيْتَنَا وَهَبْ لَنَا مِنْ لَدُنْكَ رَحْمَةً إِنَّكَ أَنْتَ الْوَهَّابُ",
    latin:
        "rabbanâ lâ tuzigh qulûbanâ ba‘da idz hadaitanâ wa hab lanâ min ladunka raḫmatan innaka antal wahhâb(u).",
    arti:
        "Wahai Tuhan kami, janganlah Engkau jadikan hati kami condong kepada kesesatan sesudah Engkau beri petunjuk kepada kami. Karuniakanlah kepada kami rahmat dari sisi-Mu. Sungguh Engkaulah Dzat yang Maha Pemberi karunia.",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: "Doa Mohon Umur Berkah",
    kategori: ["Doa-Doa"],
    arab:
        "اَللّٰهُمَّ اجْعَلِ الْحَيَاةَ زِيَادَةً لِيْ فِيْ كُلِّ خَيْرٍ وَالْمَوْتَ رَاحَةً لِيْ مِنْ كُلِّ شَرٍّ ",
    latin:
        "Allhâmma-j’al-ḫayâta ziyâdatan lî fî kulli khairin wal mauta râḫatan lî min kulli syarrin",
    arti:
        "Ya Allah, jadikanlah kehidupan ini sebagai nilai tambah bagiku dalam semua kebaikan, dan jadikanlah kematian sebagai peristirahatan bagiku dari segala kejahatan.",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: "Doa Husnul Khatimah",
    kategori: ["Doa-Doa"],
    arab:
        "اَللّٰهُمَّ أَكْرِمْ هٰذِهِ الْأُمَّةَ الْمُحَمَّدِيَّةَ بِجَمِيْلِ عَوَائِدِكَ فِي الدَّارَيْنِ إِكْرَامًا لِمَنْ جَعَلْتَهَا مِنْ أُمَّتِهِ صَلَّى اللهُ عَلَيْهِ وَسَلَّمَ",
    latin:
        "Allâhumma akrim hâdzihil ummatal muḫammadiyyata bi-jamîli ‘awâidika fid dâraini ikrâman liman ja'altahâ min ummatihi shallallâhu 'alaihi wa sallam ",
    arti:
        "Ya Allah, muliakanlah umat Nabi Muhammad dengan keindahan orang-orang yang kembali kepada-Mu di dunia dan akhirat, sebagai penghormatan-Mu kepada orang yang telah Engkau jadikan bagian dari umatnya ﷺ.",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: " Sholawat Jibril",
    kategori: ["Shalawat"],
    arab: "صَلَّى اللهُ عَلَى مُحَمَّدٍ",
    latin: "Shallallahu 'alaa Muhammad",
    arti: "Semoga Allah memberikan rahmat-Nya kepada Nabi Muhammad",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: "Sholawat Nabi",
    kategori: ["Shalawat"],
    arab: "اَللَّهُمَّ صَلِّ عَلَى سَيِّدِنَا مُحَمَّدٍ",
    latin:
        "Allahumma sholli ala sayyidina Muhammad wa ala ali sayyidina Muhammad.",
    arti:
        "Ya Allah, limpahkanlah rahmat kepada junjungan kami Nabi Muhammad dan kepada keluarga junjungan kami Nabi Muhammad.",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: "Shalawat Ibrahimiyah",
    kategori: ["Shalawat"],
    arab:
        "اَللّٰهُمَّ صَلِّ عَلٰى سَيِّدِنَا مُحَمَّدٍ وَعَلٰى اٰلِ سَيِّدِنَا مُحَمَّدٍ كَمَا صَلَّيْتَ عَلٰى سَيِّدِنَا إِبْرَاهِيْمَ وَعَلٰى اٰلِ سَيِّدِنَا إِبْرَاهِيْمَ وَ بَارِكْ عَلٰى سَيِّدِنَا مُحَمَّدٍ وَعَلٰى اٰلِ سَيِّدِنَا مُحَمَّدٍ كَمَا بَارَكْتَ عَلٰى سَيِّدِنَا إِبْرَاهِيْمَ وَعَلٰى اٰلِ سَيِّدِنَا إِبْرَاهِيْمَ فِي الْعَالَمِيْنَ إِنَّكَ حَمِيْدٌ مَجِيْدٌ",
    latin:
        "Allâhumma shalli ‘alâ sayyidinâ Muḫammad wa ‘alâ âli sayyidinâ Muḫammad kamâ shallaita ‘alâ sayyidinâ Ibrâhîm wa ‘alâ âli sayyidinâ Ibrâhîm. Wa bârik ‘alâ sayyidinâ Muḫammad wa ‘alâ âli sayyidinâ Muḫammad kamâ bârakta ‘alâ sayyidinâ Ibrâhim wa ‘alâ âli sayyidinâ Ibrâhîm. Fil ‘âlamîna innaka ḫamîdum majîd",
    arti:
        "Ya Allah, limpahkanlah rahmat kepada Nabi Muhammad dan kepada keluarga Nabi Muhammad, sebagaimana telah Engkau limpahkan rahmat kepada Nabi Ibrahim dan keluarga Nabi Ibrahim. Limpahkan pula keberkahan kepada Nabi Muhammad dan kepada keluarga Nabi Muhammad, sebagaimana telah Engkau limpahkan keberkahan kepada Nabi Ibrahim dan kepada keluarga Nabi Ibrahim. Sesungguhnya di alam semesta Engkau Maha Terpuji dan Mahaagung.",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: "Shalawat Munjiyat",
    kategori: ["Shalawat"],
    arab:
        "اَللّٰهُمَّ صَلِّ عَلَى سَيِّدِنَا مُحَمَّدٍ صَلَاةً تُنْجِيْنَا بِهَا مِنْ جَمِيْعِ الْأَهْوَالِ وَالْاٰفَاتِ وَتَقْضِيْ لَنَا بِهَا جَمِيعَ الْحَاجَاتِ وَتُطَهِّرُنَا بِهَا مِنْ جَمِيْعِ السَّيِّئَاتِ وَتَرْفَعُنَا بِهَا عِنْدَكَ أَعْلَى الدَّرَجَاتِ وَتُبَلِّغُنَا بِهَـــا أَقْصَى الْغَايَاتِ مِنْ جَمِيْعِ الْخَيْرَاتِ فِى الْحَيَاةِ وَبَعْدَ الْمَمَـــاتِ",
    latin:
        "Allâhumma shalli `ala sayyidinâ Muhammadin shalâtan tunjînâ bihâ min jamî`il-ahwâli wal-âfâti wa taqdî lanâ bihâ jamî’al-ḫâjâti wa tuthahhirunâ bihâ min jamî`is-sayyi’ati wa tarfa`unâ bihâ `indaka a`lad-darajâti wa tuballighunâ bihâ aqshal-ghâyâti min jamî`il-khairâti fil-ḫayâti wa ba`dal-mamât(i).",
    arti:
        "Ya Allah, limpahkanlah rahmat kepada junjungan kami Baginda Muhammad, yang dengan shalawat itu Engkau selamatkan kami dari semua keadaan yang menakutkan dan dari semua cobaan, Engkau penuhi semua kebutuhan kami, Engkau bersihkan kami dari segala kejelekan, Engkau angkat kami ke derajat paling tinggi, dan Engkau sampaikan kami kepada tujuan yang paling sempurna dari semua kebaikan, ketika hidup dan setelah mati.",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: "Shalawat Fatih",
    kategori: ["Shalawat"],
    arab:
        "اَللّٰهُمَّ صَلِّ عَلَى سَيِّدِنَا مُحَمَّدٍ ࣙالْفَاتِحِ لِمَا أُغْلِقَ، وَالْخَاتِمِ لِمَا سَبَقَ، نَاصِرِ الْحَقِّ بِالْحَقِّ، وَالْهَادِيْ إِلَى صِرَاطِكَ الْمُسْتَقِيْمِ، وَعَلَى اٰلِهِ وَصَحْبِهِ حَقَّ قَدْرِهِ وَمِقْدَارِهِ الْعَظِيْمِ",
    latin:
        "Allâhumma shalli ‘alâ sayyidinâ Muḫammadinil-fâtiḫi limâ ughliqa, wal-khâtimi limâ sabaqa, nâshiril-ḫaqqi bil-ḫaqqi wal-hâdî ila shirâthikal-mustaqîm(i), wa ‘alâ âlihi wa shaḫbihi ḫaqqa qadrihi wa miqdârihil ‘adhîm(i)",
    arti:
        "Ya Allah, limpahkanlah rahmat kepada junjungan kami, Nabi Muhammad ﷺ, pembuka segala yang terkunci, penutup kenabian yang telah lalu, pembela kebenaran dengan kebenaran, dan petunjuk kepada jalan-Mu yang lurus. Semoga Allah melimpahkan pula rahmat kepada keluarga dan para sahabatnya dengan hak derajat dan kedudukannya yang agung.",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: "Shalawat Adrikni",
    kategori: ["Shalawat"],
    arab:
        "اَللّٰهُمَّ صَلِّ عَلَى سَيِّدِنَا مُحَمَّدٍ قَدْ ضَاقَتْ حِيْلَتِي أَدْرِكْنِي يَا رَسُوْلَ اللّٰهِ",
    latin:
        "Allāhumma shalli ‘alā sayyidinā Muhammadin qad dhāqat hīlatī adriknī yā Rasūlallāh.",
    arti:
        "Ya Allah, limpahkanlah rahmat kepada junjungan kami, Nabi Muhammad SAW, sungguh telah sempit upayaku, tolonglah aku, wahai Rasulullah.",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: "Ayat 1000 Dinar",
    kategori: ["Shalawat"],
    arab:
        "وَمَنْ يَتَّقِ اللَّهَ يَجْعَلْ لَهُ مَخْرَجًا ﴿٢﴾ وَيَرْزُقْهُ مِنْ حَيْثُ لَا يَحْتَسِبُ ۚ وَمَنْ يَتَوَكَّلْ عَلَى اللَّهِ فَهُوَ حَسْبُهُ ۚ إِنَّ اللَّهَ بَالِغُ أَمْرِهِ ۚ قَدْ جَعَلَ اللَّهُ لِكُلِّ شَيْءٍ قَدْرًا ﴿٣﴾",
    latin:
        "Wa may yattaqillāha yaj'al lahū makhrajā. Wa yarzuq-hu min ḥaiṡu lā yaḥtasib, wa may yatawakkal 'alallāhi fa huwa ḥasbuh, innallāha bāligu amrih, qad ja'alallāhu likulli syai'in qadrā.",
    arti:
        "Barangsiapa bertakwa kepada Allah niscaya Dia akan membukakan jalan keluar baginya, dan Dia memberinya rezeki dari arah yang tidak disangka-sangkanya. Dan barangsiapa bertawakal kepada Allah, niscaya Allah akan mencukupkan (keperluan)nya. Sesungguhnya Allah melaksanakan urusan-Nya. Sungguh, Allah telah mengadakan ketentuan bagi setiap sesuatu.\n(QS. At-Talaq: 2-3).",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: "Shalawat Nabi Musa",
    kategori: ["Shalawat"],
    arab: "رَبِّ إِنِّي لِمَا أَنْزَلْتَ إِلَيَّ مِنْ خَيْرٍ فَقِيرٌ",
    latin: "Rabbi inni lima anzalta ilayya min khairin faqir",
    arti:
        "Ya Tuhanku sesungguhnya aku sangat memerlukan sesuatu kebaikan yang Engkau turunkan kepadaku.\n(QS. Al-Qasas ayat 24).",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: "Doa Nabi Yunus",
    kategori: ["Shalawat"],
    arab:
        "لَا إِلَهَ إِلَّا أَنْتَ سُبْحَانَكَ إِنِّي كُنْتُ مِنَ الظَّالِمِينَ",
    latin: "Laa ilaaha illaa anta subhaanaka inni kuntu minazh zhaalimiin",
    arti:
        "Bahwa tidak ada Tuhan selain Engkau. Maha Suci Engkau, sesungguhnya aku adalah termasuk orang-orang yang zalim.",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: "Istighfar",
    kategori: ["Dzikir Pagi", "Dzikir Petang"],
    arab: "أَسْتَغْفِرُ اللهَ وَأَتُوْبُ إِلَيْهِ",
    latin: "Astaghfirullāha wa atūbu ilaih.",
    arti: "Aku memohon ampun kepada Allah dan bertaubat kepada-Nya.",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: "Sayyidul Istighfar",
    kategori: ["Dzikir Pagi", "Dzikir Petang"],
    arab:
        "اللَّهُمَّ أَنْتَ رَبِّي لَا إِلَهَ إِلَّا أَنْتَ، خَلَقْتَنِي وَأَنَا عَبْدُكَ، وَأَنَا عَلَى عَهْدِكَ وَوَعْدِكَ مَا اسْتَطَعْتُ، أَعُوْذُ بِكَ مِنْ شَرِّ مَا صَنَعْتُ، أَبُوْءُ لَكَ بِنِعْمَتِكَ عَلَيَّ، وَأَبُوْءُ لَكَبِذَنْبِي فَاغْفِرْ لِي، فَإِنَّهُ لَا يَغْفِرُ الذُّنُوْبَ إِلَّا أَنْتَ",
    latin:
        "Allāhumma anta rabbī lā ilāha illā anta, khalaqtanī wa anā 'abduka, wa anā 'alā 'ahdika wa wa'dika mastatha'tu, a'ūdzu bika min syarri mā shana'tu, abū'u laka bini'matika 'alayya, wa abū'u laka bidzanbī faghfir lī, fa innahū lā yaghfirudz-dzunūba illā anta.",
    arti:
        "Ya Allah, Engkau adalah Tuhanku, tiada Tuhan selain Engkau. Engkau yang menciptakan aku dan aku adalah hamba-Mu. Aku memegang janji-Mu semampuku. Aku berlindung kepada-Mu dari keburukan yang kuperbuat. Aku mengakui nikmat-Mu kepadaku dan dosaku, maka ampunilah aku. Sesungguhnya tidak ada yang mengampuni dosa selain Engkau.",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: "Ayat Kursi",
    kategori: ["Dzikir Pagi", "Dzikir Petang"],
    arab:
        "اللَّهُ لَا إِلَهَ إِلَّا هُوَ الْحَيُّ الْقَيُّومُ لَا تَأْخُذُهُ سِنَةٌ وَلَا نَوْمٌ لَهُ مَا فِي السَّمَاوَاتِ وَمَا فِي الْأَرْضِ مَنْ ذَا الَّذِي يَشْفَعُ عِنْدَهُ إِلَّا بِإِذْنِهِ يَعْلَمُ مَا بَيْنَ أَيْدِيهِمْ وَمَا خَلْفَهُمْ وَلَا يُحِيطُونَ بِشَيْءٍ مِنْ عِلْمِهِ إِلَّا بِمَا شَاءَ وَسِعَ كُرْسِيُّهُ السَّمَاوَاتِ وَالْأَرْضَ وَلَا يَئُودُهُ حِفْظُهُمَا وَهُوَ الْعَلِيُّ الْعَظِيمُ",
    latin:
        "Allahu la ilaha illa huwal-hayyul-qayyum, la ta'khudzuhu sinatuw wa la naum, lahu ma fis-samawati wa ma fil-ardh, man dzalladzi yasyfa'u 'indahu illa bi'idznih, ya'lamu ma baina aidihim wa ma khalfahum, wa la yuhithuna bisyai'im min 'ilmihi illa bima sya', wasi'a kursiyyuhus-samawati wal-ardh, wa la ya'uduhu hifzhuhuma wa huwal-'aliyyul-'azhim.",
    arti:
        "Allah, tidak ada tuhan selain Dia. Yang Mahahidup, yang terus-menerus mengurus (makhluk-Nya). Tidak mengantuk dan tidak tidur. Milik-Nya apa yang ada di langit dan apa yang ada di bumi. Tidak ada yang dapat memberi syafaat di sisi-Nya tanpa izin-Nya. Dia mengetahui apa yang di hadapan mereka dan apa yang di belakang mereka. Dan mereka tidak mengetahui sesuatu pun dari ilmu-Nya melainkan apa yang Dia kehendaki. Kursi-Nya meliputi langit dan bumi. Dan Dia tidak merasa berat memelihara keduanya, dan Dia Mahatinggi, Mahagung.",
    dalil: "QS. Al-Baqarah: 255",
    keterangan: "",
  ),
  DoaModel(
    judul: "Surah Al-Ikhlas (3x)",
    kategori: ["Dzikir Pagi", "Dzikir Petang"],
    arab:
        "قُلْ هُوَ اللَّهُ أَحَدٌ ۝ اللَّهُ الصَّمَدُ ۝ لَمْ يَلِدْ وَلَمْ يُولَدْ ۝ وَلَمْ يَكُنْ لَهُ كُفُوًا أَحَدٌ",
    latin:
        "Qul huwallāhu aḥad. Allāhuṣ-ṣamad. Lam yalid wa lam yūlad. Wa lam yakul lahū kufuwan aḥad.",
    arti:
        "Katakanlah (Muhammad), 'Dialah Allah, Yang Maha Esa. Allah tempat meminta segala sesuatu. (Allah) tidak beranak dan tidak pula diperanakkan. Dan tidak ada sesuatu pun yang setara dengan Dia'.",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: "Surah Al-Falaq (3x)",
    kategori: ["Dzikir Pagi", "Dzikir Petang"],
    arab:
        "قُلْ أَعُوذُ بِرَبِّ الْفَلَقِ ۝ مِنْ شَرِّ مَا خَلَقَ ۝ وَمِنْ شَرِّ غَاسِقٍ إِذَا وَقَبَ ۝ وَمِنْ شَرِّ النَّفَّاثَاتِ فِي الْعُقَدِ ۝ وَمِنْ شَرِّ حَاسِدٍ إِذَا حَسَدَ",
    latin:
        "Qul a'ūżu birabbil-falaq. Min syarri mā khalaq. Wa min syarri ghāsiqin iżā waqab. Wa min syarrin-naffāṡāti fil-'uqad. Wa min syarri ḥāsidin iżā ḥasad.",
    arti:
        "Katakanlah, 'Aku berlindung kepada Tuhan yang menguasai subuh (fajar), dari kejahatan (makhluk yang) Dia ciptakan, dan dari kejahatan malam apabila telah gelap gulita, dan dari kejahatan (perempuan-perempuan) penyihir yang meniup pada buhul-buhul (talinya), dan dari kejahatan orang yang dengki apabila dia dengki'.",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: "Surah An-Naas (3x)",
    kategori: ["Dzikir Pagi", "Dzikir Petang"],
    arab:
        "قُلْ أَعُوذُ بِرَبِّ النَّاسِ ۝ مَلِكِ النَّاسِ ۝ إِلَٰهِ النَّاسِ ۝ مِنْ شَرِّ الْوَسْوَاسِ الْخَنَّاسِ ۝ الَّذِي يُوَسْوِسُ فِي صُدُورِ النَّاسِ ۝ مِنَ الْجِنَّةِ وَالنَّاسِ",
    latin:
        "Qul a'ūżu birabbin-nās. Malikin-nās. Ilāhin-nās. Min syarril-waswāsil-khannās. Allażī yuwaswisu fī ṣudūrin-nās. Minal-jinnati wan-nās.",
    arti:
        "Katakanlah, 'Aku berlindung kepada Tuhannya manusia, Raja manusia, Sembahan manusia, dari kejahatan (bisikan) setan yang bersembunyi, yang membisikkan (kejahatan) ke dalam dada manusia, dari (golongan) jin dan manusia.'",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: "Dzikir Perlindungan",
    kategori: ["Dzikir Pagi"],
    arab:
        "بِسْمِ اللهِ الَّذِي لَا يَضُرُّ مَعَ اسْمِهِ شَيْءٌ فِي الْأَرْضِ وَلَا فِي السَّمَاءِ وَهُوَ السَّمِيْعُ الْعَلِيْمُ",
    latin:
        "Bismillāhilladzī lā yadhurru ma'asmihi syai'un fil-ardhi wa lā fis-samā'i wa huwas-samī'ul-'alīm.",
    arti:
        "Dengan nama Allah, tidak ada sesuatu pun yang dapat membahayakan bersama nama-Nya, baik di bumi maupun di langit. Dia Maha Mendengar lagi Maha Mengetahui.",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: "Ridha kepada Allah",
    kategori: ["Dzikir Pagi"],
    arab:
        "رَضِيْتُ بِاللهِ رَبًّا، وَبِالْإِسْلَامِ دِيْنًا، وَبِمُحَمَّدٍ ﷺ نَبِيًّا",
    latin:
        "Radītu billāhi rabban, wa bil-islāmi dīnan, wa bi Muhammadin nabiyyā.",
    arti:
        "Aku ridha Allah sebagai Rabb-ku, Islam sebagai agamaku, dan Muhammad sebagai nabiku.",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: "Tauhid",
    kategori: ["Dzikir Pagi"],
    arab:
        "لَا إِلَهَ إِلَّا اللهُ وَحْدَهُ لَا شَرِيْكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ، وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيْرٌ",
    latin:
        "Lā ilāha illallāhu wahdahū lā syarīka lah, lahul-mulku wa lahul-hamdu, wa huwa 'alā kulli syai'in qadīr.",
    arti:
        "Tidak ada tuhan selain Allah, Yang Maha Esa, tidak ada sekutu bagi-Nya. Bagi-Nya kerajaan dan bagi-Nya segala pujian, dan Dia Mahakuasa atas segala sesuatu.",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: "Tasbih",
    kategori: ["Dzikir Pagi"],
    arab: "سُبْحَانَ اللهِ وَبِحَمْدِهِ",
    latin: "Subhānahullāhi wa bihamdih.",
    arti: "Maha Suci Allah dan dengan memuji-Nya.",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: "Shalawat",
    kategori: ["Dzikir Pagi", "Dzikir Petang"],
    arab: "اللَّهُمَّ صَلِّ وَسَلِّمْ عَلَى نَبِيِّنَا مُحَمَّدٍ",
    latin: "Allāhumma shalli wa sallim 'alā nabiyyinā Muhammad.",
    arti: "Ya Allah, berilah shalawat dan salam kepada Nabi kami Muhammad.",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: "Doa Kesehatan & Perlindungan",
    kategori: ["Dzikir Pagi"],
    arab:
        "اللَّهُمَّ إِنِّي أَسْأَلُكَ الْعَفْوَ وَالْعَافِيَةَ فِي الدُّنْيَا وَالْآخِرَةِ",
    latin: "Allāhumma innī as'alukal-'afwa wal-'āfiyata fid-dunyā wal-ākhirah.",
    arti: "Ya Allah, aku memohon ampunan dan keselamatan di dunia dan akhirat.",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: "Doa Penutup Pagi",
    kategori: ["Dzikir Pagi"],
    arab:
        "اللَّهُمَّ إِنِّي أَسْأَلُكَ خَيْرَ هَذَا الْيَوْمِ، فَتْحَهُ وَنَصْرَهُ وَنُوْرَهُ وَبَرَكَتَهُ وَهُدَاهُ، وَأَعُوْذُ بِكَ مِنْ شَرِّ مَا فِيْهِ وَشَرِّ مَا بَعْدَهُ",
    latin:
        "Allāhumma innī as'aluka khaira hādzal-yaum, fathahu wa nashrahu wa nūrahu wa barakatahu wa hudāh, wa a'ūdzu bika min syarri mā fīhi wa syarri mā ba'dah.",
    arti:
        "Ya Allah, aku memohon kebaikan hari ini: kemenangan, pertolongan, cahaya, keberkahan, dan petunjuknya. Aku berlindung kepada-Mu dari keburukan yang ada di dalamnya dan keburukan setelahnya.",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: "Dzikir Perlindungan",
    kategori: ["Dzikir Petang"],
    arab:
        "بِسْمِ اللهِ الَّذِي لَا يَضُرُّ مَعَ اسْمِهِ شَيْءٌ فِي الْأَرْضِ وَلَا فِي السَّمَاءِ وَهُوَ السَّمِيْعُ الْعَلِيْمُ",
    latin:
        "Bismillāhilladzī lā yadhurru ma'asmihi syai'un fil-ardhi wa lā fis-samā'i wa huwas-samī'ul-'alīm.",
    arti:
        "Dengan nama Allah, tidak ada sesuatu pun yang dapat membahayakan bersama nama-Nya, baik di bumi maupun di langit. Dia Maha Mendengar lagi Maha Mengetahui.",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: "Taubat & Harapan",
    kategori: ["Dzikir Petang"],
    arab:
        "رَبِّ اغْفِرْ لِي وَتُبْ عَلَيَّ إِنَّكَ أَنْتَ التَّوَّابُ الرَّحِيْمُ",
    latin: "Rabbighfir lī wa tub 'alayya innaka antat-tawwābur-rahīm.",
    arti:
        "Ya Rabb-ku, ampunilah aku dan terimalah taubatku. Sesungguhnya Engkau Maha Penerima Taubat lagi Maha Penyayang.",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: "Tasbih, Tahmid, Takbir",
    kategori: ["Dzikir Petang"],
    arab:
        "سُبْحَانَ اللَّهِ (33x)\nالْحَمْدُ لِلَّهِ (33x)\nاللَّهُ أَكْبَرُ (33x)",
    latin: "",
    arti: "",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: "Tabih",
    kategori: ["Dzikir Petang"],
    arab: "سُبْحَانَ اللهِ",
    latin: "Subḥānallāh",
    arti: "Maha Suci Allah",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: "Tahmid",
    kategori: ["Dzikir Petang"],
    arab: "الْحَمْدُ لِلَّهِ",
    latin: "Al-ḥamdulillāh",
    arti: "Segala puji bagi Allah.",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: "Takbir",
    kategori: ["Dzikir Petang"],
    arab: "اللهُ أَكْبَرُ",
    latin: "Allāhu akbar",
    arti: "Allah Maha Besar",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: "Doa Kebaikan Dunia Akhirat",
    kategori: ["Dzikir Petang"],
    arab:
        "اللَّهُمَّ إِنِّي أَسْأَلُكَ الْعَفْوَ وَالْعَافِيَةَ فِي الدُّنْيَا وَالْآخِرَةِ",
    latin: "Allāhumma innī as'alukal-'afwa wal-'āfiyata fid-dunyā wal-ākhirah.",
    arti: "Ya Allah, aku memohon ampunan dan keselamatan di dunia dan akhirat.",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: "Doa Penutup Petang",
    kategori: ["Dzikir Petang"],
    arab:
        "اللَّهُمَّ إِنِّي أَسْأَلُكَ خَيْرَ هَذِهِ اللَّيْلَةِ، فَتْحَهَا وَنَصْرَهَا وَنُوْرَهَا وَبَرَكَتَهَا وَهُدَاهَا، وَأَعُوْذُ بِكَ مِنْ شَرِّ مَا فِيْهَا وَشَرِّ مَا بَعْدَهَا",
    latin:
        "Allāhumma innī as'aluka khaira hādzihil-lailah, fathahā wa nashrahā wa nūrahā wa barakatahā wa hudāhā, wa a'ūdzu bika min syarri mā fīhā wa syarri mā ba'dahā.",
    arti:
        "Ya Allah, aku memohon kebaikan malam ini: kemenangan, pertolongan, cahaya, keberkahan, dan petunjuknya. Aku berlindung kepada-Mu dari keburukan yang ada di dalamnya dan keburukan setelahnya.",
    dalil: "",
    keterangan: "",
  ),
  // DoaModel(
  //   judul: "",
  //   kategori: ["Dzikir Petang"],
  //   arab: "",
  //   latin: "",
  //   arti: "",
  //   dalil: "",
  //   keterangan: "",
  // ),
];
