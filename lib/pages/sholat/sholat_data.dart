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
    judul: "Doa Melihat Ada Air",
    kategori: ["Wudhu"],
    arab: "الْحَمْدُ لِلَّهِ الَّذِي جَعَلَ الْمَاءَ طَهُورًا",
    latin: "Alhamdulillāhilladhī ja'alal-mā'a ṭahūrā.",
    arti:
        "Segala puji bagi Allah yang telah menjadikan air ini suci dan menyucikan.",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: "Doa Niat Wudhu",
    kategori: ["Wudhu"],
    arab:
        "نَوَيْتُ الْوُضُوْءَ لِرَفْعِ الْحَدَثِ الْأَصْغَرِ فَرْضًا لِلّٰهِ تَعَالَى",
    latin: "Nawaitul wudlû-a li raf‘il ḫadatsil asghari fardlal lillâhi ta‘âlâ",
    arti:
        "Saya niat berwudhu untuk menghilangkan hadats kecil, fardhu karena Allah Ta‘la",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: "Doa Sebelum Wudhu",
    kategori: ["Wudhu"],
    arab:
        "أَعُوْذُ بِاللهِ مِنَ الشَّيْطَانِ الرَّجِيْمِ، بِسْمِ اللهِ الرَّحْمٰنِ الرَّحِيْمِ\n\nاَلْحَمْدُ لِلّٰهِ عَلَى الْإِسْلَامِ وَنِعْمَتِهِ، وَالْحَمْدُ لِلّٰهِ الَّذِيْ جَعَلَ الْمَاءَ طَهُورًا وَالْإِسْلَامَ نُورًا\n\nرَبِّ أَعُوْذُ بِكَ مِنْ هَمَزَاتِ الشَّيَاطِيْنِ وَأَعُوْذُ بِكَ رَبِّ أَنْ يَحْضُرُوْنَ\n\nأَشْهَدُ أَنْ لَاإِلٰهَ إِلَّا اللهُ وَأَشْهَدُ أَنَّ مُحَمَّدًا رَسُوْلُ اللهِ",
    latin:
        "A‘ûdzu billâhi minas syaithânir rajîm. Bismillâhir raḫmânir raḫîm\n\nAlḫamdulillâhi ‘alal Islâmi wa ni‘matihî. Walḫamdulillâhil ladzî ja‘alal mâ-a thahûran, wal islâma nûran\n\nRabbi a‘ûdzu bika min hamazâtisy syayâthîni, wa a‘ûdzu bika rabbi an yaḫdhurûn\n\nAsyhadu an lâ ilâha illallâhu, wa asyhadu anna Muhammadan rasûlullâhi",
    arti:
        "Aku berlindung kepada Allah dari gangguan setan yang terkutuk. Dengan menyebut nama Allah Yang Maha Pengasih lagi Maha Penyayang.\n\nSegala puji bagi Allah atas Islam dan nikmatnya. Segala puji bagi Allah yang menjadikan air itu suci dan Islam itu cahaya.\n\nTuhanku, aku berlindung kepada-Mu dari gangguan setan. Aku juga berlindung kepada-Mu wahai Tuhanku dari kepungan mereka, (QS al-Mukminun ayat 97-98).\n\nAku bersaksi, tiada tuhan selain Allah. Aku juga bersaksi bahwa Muhammad adalah utusan Allah.",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: "Doa Membasuh Telapak Tangan",
    kategori: ["Wudhu"],
    arab:
        "اللَّهُمَّ إِنِّي أَسْأَلُكَ الْيُمْنَ وَالْبَرَكَةَ وَأَعُوذُ بِكَ مِنَ الشُّؤْمِ وَالْهَلَكَةِ",
    latin:
        "Allāhumma innī as'alukal-yumna wal-barakata wa a'ūdhu bika minash-shu'mi wal-halakah.",
    arti:
        "Ya Allah, aku memohon kepada-Mu keberkahan dan keberuntungan, dan aku berlindung kepada-Mu dari kesialan dan kebinasaan.",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: "Doa saat Berkumur",
    kategori: ["Wudhu"],
    arab:
        "اللَّهُمَّ أَسْقِنِي مِنْ حَوْضِ نَبِيِّكَ مُحَمَّدٍ ﷺ كَأْسًا لَا أَظْمَأُ بَعْدَهُ أَبَدًا",
    latin:
        "Allāhummasqinī min ḥawḍi nabiyyika muḥammadin ṣallallāhu 'alaihi wa sallama ka'san lā aẓma'u ba'dahū abadā.",
    arti:
        "Ya Allah, berilah aku minuman dari telaga Nabi-Mu Muhammad dengan suatu cangkir yang membuatku tidak merasa haus lagi selamanya.",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: "Doa Saat Menghirup Air Ke Hidung",
    kategori: ["Wudhu"],
    arab: "اللَّهُمَّ أَرِحْنِي رَائِحَةَ الْجَنَّةِ وَأَنْتَ عَنِّي رَاضٍ",
    latin: "Allāhumma ariḥnī rā'iḥatal-jannati wa anta 'annī rāḍ.",
    arti:
        "Ya Allah, ciumkanlah kepadaku wewangian surga, sedangkan Engkau ridha kepadaku.",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: "Doa Saat Mengeluarkan Air Dari Hidung",
    kategori: ["Wudhu"],
    arab:
        "اللَّهُمَّ إِنِّي أَعُوذُ بِكَ مِنْ رَوَائِحِ النَّارِ وَسُوءِ الدَّارِ",
    latin: "Allāhumma innī a'ūdhu bika min rawā'iḥin-nāri wa sū'id-dār",
    arti:
        "Ya Allah, aku berlindung pada-Mu dari busuknya bau neraka, dan dari buruknya tempat kembali.",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: "Doa Membasuh Wajah",
    kategori: ["Wudhu"],
    arab:
        "اللَّهُمَّ بَيِّضْ وَجْهِي يَوْمَ تَبْيَضُّ وُجُوهٌ وَتَسْوَدُّ وُجُوهٌ",
    latin: "Allāhumma bayyiḍ wajhī yawma tabyaḍḍu wujūhun wa taswaddu wujūh.",
    arti:
        "Ya Allah, putihkanlah (bersihkanlah) wajahku pada hari ketika wajah-wajah menjadi putih dan wajah-wajah menjadi hitam.",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: "Doa Membasuh Tangan Kanan",
    kategori: ["Wudhu"],
    arab:
        "اللَّهُمَّ أَعْطِنِي كِتَابِي بِيَمِينِي وَحَاسِبْنِي حِسَابًا يَسِيرًا",
    latin: "Allâhumma a‘thinî kitâbî biyamînî, wa ḫâsibnî ḫisâban yasîran",
    arti:
        "Ya Allah, berikanlah kitab amalku (kelak di akhirat) pada tangan kananku, dan hisablah aku dengan hisab yang ringan.",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: "Doa Membasuh Tangan Kiri",
    kategori: ["Wudhu"],
    arab:
        "اللَّهُمَّ لَا تُعْطِنِي كِتَابِي بِشِمَالِي وَلَا مِنْ وَرَاءِ ظَهْرِي",
    latin: "Allāhumma lā tu'ṭinī kitābī bishimālī wa lā miw warā'i ẓahrī.",
    arti:
        "Ya Allah, janganlah Engkau berikan kitab catatan amalku dari sebelah kiri dan jangan pula dari belakang punggungku.",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: "Doa Mengusap Kepala",
    kategori: ["Wudhu"],
    arab: "اللَّهُمَّ حَرِّمْ شَعْرِي وَبَشَرِي عَلَى النَّارِ",
    latin: "Allāhumma ḥarrim sha'rī wa basharī 'alan-nār.",
    arti: "Ya Allah, haramkanlah rambutku dan kulitku dari siksaan api neraka.",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: "Doa Mengusap Telinga",
    kategori: ["Wudhu"],
    arab:
        "اللَّهُمَّ اجْعَلْنِي مِنَ الَّذِينَ يَسْتَمِعُونَ الْقَوْلَ فَيَتَّبِعُونَ أَحْسَنَهُ",
    latin:
        "Allâhumma-j‘alnî minalladzîna yastami‘ûnal qaula fayattabi‘ûna aḫsanahu",
    arti:
        "Ya Allah, jadikanlah aku termasuk orang-orang yang mendengarkan perkataan lalu mengikuti apa yang terbaik darinya.",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: "Doa Membasuh Kaki Kanan",
    kategori: ["Wudhu"],
    arab:
        "اللَّهُمَّ ثَبِّتْ قَدَمِي عَلَى الصِّرَاطِ الْمُسْتَقِيمِ مَعَ أَقْدَامِ عِبَادِكَ الصَّالِحِينَ",
    latin:
        "Allāhumma thabbit qadamī 'alaṣ-ṣirāṭil-mustaqīmi ma'a aqdāmi 'ibādikaṣ-ṣāliḥīn.",
    arti:
        "Ya Allah, teguhkanlah kakiku di atas titian siratal mustakim bersama kaki hamba-hamba-Mu yang saleh.",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: "Doa Membasuh Kaki Kiri",
    kategori: ["Wudhu"],
    arab:
        "اللَّهُمَّ إِنِّي أَعُوذُ بِكَ أَنْ تَزِلَّ قَدَمِي عَلَى الصِّرَاطِ فِي النَّارِ يَوْمَ تَزِلُّ أَقْدَامُ الْمُنَافِقِينَ وَالْمُشْرِكِينَ",
    latin:
        "Allāhumma innī a'ūdhu bika an tazilla qadamī 'alaṣ-ṣirāṭi fin-nāri yawma tazillu aqdāmul-munāfiqīna wal-mushrikīn.",
    arti:
        "Ya Allah, aku berlindung kepada-Mu agar kakiku tidak tergelincir dari titian sirat ke dalam neraka pada hari tergelincirnya kaki orang-orang munafik dan orang-orang musyrik.",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: "Doa setelah Wudhu",
    kategori: ["Wudhu"],
    arab:
        "أَشْهَدُ أَنْ لَاإِلٰهَ إِلَّااللهُ وَحْدَهُ لَاشَرِيْكَ لَهُ وَأَشْهَدُ أَنَّ مُحَمَّدًاعَبْدُهُ وَرَسُوْلُهُ. اَللّٰهُمَّ اجْعَلْنِيْ مِنَ التَّوَّابِيْنَ وَاجْعَلْنِيْ مِنَ الْمُتَطَهِّرِيْنَ",
    latin:
        "Asyhadu allâ ilâha illallâhu waḫdahû lâ syarîka lahu wa asyhadu anna muḫammadan ‘abduhû wa rasûluhû, allâhummaj'alnî minat tawwâbîna waj'alnî minal mutathahhirîn(a)",
    arti:
        "Aku bersaksi bahwa tidak ada Tuhan selain Allah Yang Maha Esa, tidak ada sekutu bagi-Nya, dan aku bersaksi bahwa Nabi Muhammad adalah hamba dan utusan Allah. Ya Allah, jadikanlah aku termasuk dalam golongan orang-orang yang bertobat dan jadikanlah aku termasuk dalam golongan orang-orang yang bersuci (shalih).",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: "Niat Sholat Subuh",
    kategori: ["Sholat"],
    arab:
        "أُصَلِّى فَرْضَ الصُّبْح رَكَعتَيْنِ مُسْتَقْبِلَ الْقِبْلَةِ أَدَاءً لله تَعَالَى",
    latin:
        "Usholli fardhol subhi rok'ataini mustaqbilal qiblati adaa an (sholat sendiri)/Ma'muuman (menjadi ma'mum)/Imaaman (menjadi imam) Lillaahi Ta'aalaa",
    arti:
        "Saya berniat sholat fardu zuhur empat rakaat menghadap kiblat karena Allah Ta'ala.",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: "Niat Sholat Dzuhur",
    kategori: ["Sholat"],
    arab:
        "اُصَلِّيْ فَرْضَ الظُّهْرِ أَرْبَعَ رَكَعاَتٍ مُسْتَقْبِلَ الْقِبْلَةِ أَدَاءً لله تَعَالَى",
    latin:
        "Usholli fardhol zuhri arba'a roka'aati mustaqbilal qiblati adaa an (sholat sendiri)/Ma'muuman (menjadi ma'mum)/Imaaman (menjadi imam) Lillaahi Ta'aalaa.",
    arti:
        "Saya berniat sholat fardu zuhur empat rakaat menghadap kiblat karena Allah Ta'ala.",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: "Niat Sholat Ashar",
    kategori: ["Sholat"],
    arab:
        "أُصَلِّى فَرْضَ العَصْرِأَرْبَعَ رَكَعاَتٍ مُسْتَقْبِلَ الْقِبْلَةِ أَدَاءً لله تَعَالَى",
    latin:
        "Usholli fardhol ashri arba'a roka'aati mustaqbilal qiblati adaa an (sholat sendiri)/Ma'muuman (menjadi ma'mum)/Imaaman (menjadi imam) Lillaahi Ta'ala. ",
    arti:
        "Saya berniat sholat fardu asar empat rakaat menghadap kiblat karena Allah Ta'ala.",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: "Niat Sholat Maghrib",
    kategori: ["Sholat"],
    arab:
        "أُصَلِّى فَرْضَ المَغْرِبِ ثَلاَثَ رَكَعاَتٍ مُسْتَقْبِلَ الْقِبْلَةِ أَدَاءً لله تَعَالَ",
    latin:
        "Usholli fardhol magribi tsalasa rok'aati mustaqbilal qiblati adaa an (sholat sendiri)/Ma'muuman (menjadi ma'mum)/Imaaman (menjadi imam) Lillaahi Ta'ala. ",
    arti:
        "Saya berniat sholat fardu magrib tiga rakaat menghadap kiblat karena Allah Ta'ala.",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: "Niat Sholat isya",
    kategori: ["Sholat"],
    arab:
        "أُصَلِّى فَرْضَ العِشَاء ِأَرْبَعَ رَكَعاَتٍ مُسْتَقْبِلَ الْقِبْلَةِ أَدَاءً لله تَعَالَى",
    latin:
        "Usholli fardhol 'Isya i arba'a roka'aati mustaqbilal qiblati adaa an (sholat sendiri)/Ma'muuman (menjadi ma'mum)/Imaaman (menjadi imam) Lillaahi Ta'aalaa.",
    arti:
        "Saya berniat sholat fardu isya empat rakaat menghadap kiblat karena Allah Ta'ala.",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: "Takbiratul Ihram",
    kategori: ["Sholat"],
    arab: "اللهُ أكْبَرُ",
    latin: "Allahu Akbar",
    arti: "Allah Maha Besar",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: "Doa Iftitah",
    kategori: ["Sholat"],
    arab:
        "اَللّٰهُ أَكْبَرُ كَبِيْرًا وَّالْحَمْدُ لِلّٰهِ كَثِيْرًا وَّسُبْحَانَ اللّٰهِ بُكْرَةً وَّأَصِيْلًا، إِنِّيْ وَجَّهْتُ وَجْهِيَ لِلَّذِيْ فَطَرَ السَّمٰوَاتِ وَالْأَرْضَ حَنِيْفًا مُّسْلِمًا وَّمَا أَنَا مِنَ الْمُشْرِكِيْنَ، إِنَّ صَلَاتِيْ وَنُسُكِيْ وَمَحْيَايَ وَمَمَاتِيْ لِلّٰهِ رَبِّ الْعَالَمِيْنَ، لَا شَرِيْكَ لَهُ وَبِذٰلِكَ أُمِرْتُ وَأَنَا مِنَ الْمُسْلِمِيْنَ",
    latin:
        "Allaahu akbar Kabiroo Walhamdulillaahi Katsiiraa, Wa Subhaanallaahi Bukratan Wa’ashiilaa, Innii Wajjahtu Wajhiya Lilladzii Fatharas Samaawaati Wal Ardha Haniifan Musliman Wamaa Anaa Minal Musyrikiin. Inna Shalaatii Wa Nusukii Wa Mahyaaya Wa Mamaatii Lillaahi Rabbil ‘Aalamiina. Laa Syariikalahu Wa Bidzaalika Umirtu Wa Ana Minal Muslimiin.",
    arti:
        "Allah Mahabesar, Mahasempurna kebesaran-Nya. Segala puji bagi Allah, pujian yang sebanyak-banyaknya. Mahasuci Allah sepanjang pagi dan petang. Kuhadapkan wajahku kepada Dzat yang telah menciptakan langit dan bumi dengan penuh ketulusan dan kepasrahan dan aku bukanlah termasuk orang-orang yang musyrik. Sesungguhnya shalatku, ibadahku, hidupku, dan matiku semuanya untuk Allah, penguasa alam semesta. Tidak ada sekutu bagi-Nya dan dengan demikianlah aku diperintahkan dan aku termasuk orang-orang Islam.",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: "Membaca Al- Fatihah",
    kategori: ["Sholat"],
    arab:
        "بِسْمِ اللّٰهِ الرَّحْمٰنِ الرَّحِيْمِ\nاَلْحَمْدُ لِلّٰهِ رَبِّ الْعٰلَمِيْنَۙ\nالرَّحْمٰنِ الرَّحِيْمِۙ \nمٰلِكِ يَوْمِ الدِّيْنِۗ \nاِيَّاكَ نَعْبُدُ وَاِيَّاكَ نَسْتَعِيْنُۗ\nاِهْدِنَا الصِّرَاطَ الْمُسْتَقِيْمَ ۙ\nصِرَاطَ الَّذِيْنَ اَنْعَمْتَ عَلَيْهِمْ ەۙ غَيْرِ الْمَغْضُوْبِ عَلَيْهِمْ وَلَا الضَّاۤلِّيْنَ",
    latin:
        "Bismillahirrahmaanirrahiim. Alhamdu lillahi rabbil 'aalamiin. Arrahmaanirrahiim. Maaliki yaumiddiin. Iyyaaka na'budu waiyyaaka nasta'iin. Ihdinash shirraathal musthaqiim. Shiraathal ladziina an'amta 'alaihim. Ghairil maghduubi 'alaihim waladl-dlaalliin.",
    arti:
        "Dengan nama Allah yang maha pengasih dan penyayang. Segala puji bagi Allah, Tuhan seru sekalian alam. Yang maha pengasih dan penyayang. Yang menguasai hari kemudian. Pada-Mu lah aku mengabdi dan kepada-Mu lah aku meminta pertologan. Tunjukilah kami ke jalan yang lurus. Bagaikan jalannya orang-orang yang telah Engkau beri ni'mat. Bukan jalan mereka yang pernah Engkau murkai, atau jalannya orang-orang yang sesat.",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: "Membaca Surat Pendek",
    kategori: ["Sholat"],
    arab: "",
    latin: "",
    arti:
        "Disunahkan membaca surat setelah membaca Al-Fatihah, contohny:\n\n • Surat An-Nas\n • Surat Al-Falaq\n • Surat Al-Ikhlas\n • Surat Al-Lahab\n • Surat An-Nasr\n • Surat Al-Kafirun\n • Surat Al-Kautsar\n • Surat Al-Ma'un\n • Surat Al Quraisy\n • Surat Al-Fiil\n • Surat Al-Humazah\n • Surat Al-Ashr\n • Surat At-Takatsur",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: "Ruku",
    kategori: ["Sholat"],
    arab: "سُبْحَانَ رَبِّيَ الْعَظِيْمِ وَبِحَمْدِهِ ×٣",
    latin: "Subhaana rabbiyal 'adzhiimi wabihamdihi (3 kali)",
    arti: "Maha Suci Rabbku yang maha Agung dan maha terpuji.",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: "I’tidal (berdiri setelah ruku’) ",
    kategori: ["Sholat"],
    arab:
        "سَمِعَ اللَّهُ لِمَنْ حَمِدَهُ.\nرَبَّنَا لَكَ الْحَمْدُ مِلْءُ السَّمَاوَاتِ وَمِلْءُ الْأَرْضِ وَمِلْءُ مَا شِئْتَ مِنْ شَيْءٍ بَعْدُ",
    latin:
        "Sami'allaahu liman hamidah.\nRabbanaaa lakal hamdu mil-ussamaawaati wa mil-ul-ardhi wa mil-u maa syik-ta min syai-im ba’du. ",
    arti:
        "Allah Mendengar orang memuji-Nya.\n Ya Allah Tuhan kami, bagi-Mu segala puji, sepenuh langit dan bumi dan sepenuh apa saja yang Engkau kehendaki sesudah itu.",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: "Qunut (Sholat Subuh)",
    kategori: ["Sholat"],
    arab:
        "اَللّٰهُمَّ اهْدِنِيْ فِيْمَنْ هَدَيْتَ، وَعَافِنِيْ فِيْمَنْ عَافَيْتَ، وَتَوَلَّنِيْ فِيْمَنْ تَوَلَّيْتَ، وَبَارِكْ لِيْ فِيْمَا أَعْطَيْتَ، وَقِنِيْ شَرَّمَا قَضَيْتَ، فَإِ نَّكَ تَقْضِيْ وَلَا يُقْضَى عَلَيْكَ وَإِنَّهُ لَا يَذِلُّ مَنْ وَالَيْتَ، وَلَا يَعِزُّ مَنْ عَادَيْتَ، تَبَارَكْتَ رَبَّنَا وَتَعَالَيْتَ، فَلَكَ الْحَمْدُ عَلَى مَا قَضَيْتَ، أَسْتَغْفِرُكَ وَأَتُوْبُ إِلَيْكَ، وَصَلَّى اللهُ عَلَى سَيِّدِنَا مُحَمَّدٍ ࣙالنَّبِيِّ الْأُمِّيِّ وَعَلَى اٰلِهِ وَصَحْبِهِ وَبَارَكَ وَسَلَّمَ",
    latin:
        "Allahummahdinî fî man hadait, wa ‘âfinî fî man ‘âfait, wa tawallanî fî man tawallait, wa bâriklî fî mâ a‘thait, wa qinî syarra mâ qadhait, fa innaka taqdhî wa lâ yuqdhâ ‘alaik, wa innahû lâ yazillu man wâlait, wa lâ ya‘izzu man ‘âdait, tabârakta rabbanâ wa ta‘âlait, fa lakal ḫamdu a’lâ mâ qadhait, astaghfiruka wa atûbu ilaik, wa shallallâhu ‘alâ sayyidinâ muḫammadi-nin-nabiyyil ummiyyi wa ‘alâ âlihî wa shaḫbihî wa bâraka wa sallam.",
    arti:
        "Ya Allah tunjukanlah aku sebagaimana mereka yang telah Engkau beri petunjuk. Berilah kesehatan kepadaku sebagaimana mereka yang telah Engkau berikan kesehatan. Peliharalah aku sebagaimana orang-orang yang telah Engkau lindungi. Berikanlah keberkahan kepadaku pada apa yang telah Engkau berikan. Selamatkanlah aku dari bahaya kejahatan yang telah Engkau tentukan. Engkaulah yang menghukum dan bukan dihukum. Tidak hina orang yang Engkau jadikan pemimpin. Tidak mulia orang yang Engkau musuhi. Maha Suci Engkau wahai Tuhan kami dan Maha Tinggi Engkau. Bagi-Mu segala pujian di atas apa yang Engkau tentukan. Aku memohon ampun kepada-Mu dan bertaubat kepada-Mu. Semoga Allah mencurahkan rahmat, keselamatan, dan berkah atas junjungan kami Nabi Muhammad SAW, keluarga, dan para sahabatnya.",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: "Sujud",
    kategori: ["Sholat"],
    arab: "سُبْحَانَ رَبِّيَ الْأَعْلَى وَبِحَمْدِهِ ×٣",
    latin: "Subhaana rabbiyal a'laa wabihamdihi (3 kali)",
    arti:
        "Mahasuci Rabbku Yang Mahatinggi dan pujian untuk-Nya (HR. Abu Daud).",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: "Duduk di antara dua sujud",
    kategori: ["Sholat"],
    arab:
        "رب اغْفِرلي وَارْحَمْنِى واجبرني وَارْفَعْنِي وَارْزُقْنِى وَاهْدِنِى وَعَافِنِى وَاعْفُ عَنِّى",
    latin:
        "Rabighfirlii, Warhamnii, Wajburnii, Warfa’ni, Warzuqnii, Wahdini, Wa’aafinii, Wa’fuannii ",
    arti:
        "Ya Allah, ampunilah dosaku, rahmatilah aku, perbaikilah aku, berikanlah aku rezeki dan angkatlah derajatku.",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: "Duduk Tasyahud (Tahiyat Awal)",
    kategori: ["Sholat"],
    arab:
        "التَّحِيَّاتُ الْمُبَارَكَاتُ الصَّلَوَاتُ الطَّيِّبَاتُ لِلّٰهِ، السَّلَامُ عَلَيْكَ أيُّهَا النَّبِيُّ وَرَحْمَةُ اللّٰهِ وَبَرَكَاتُهُ، السَّلَامُ عَلَيْنَا وَعَلَى عِبَادِ اللّٰهِ الصَّالِحِيْنَ، أشْهَدُ أَنْ لَّا إِلٰهَ إِلَّا اللّٰهُ، وَأَشْهَدُ أَنَّ مُحَمَّدًا رَّسُولُ اللّٰهِ اَللّٰهُمَّ صَلِّ عَلَى سَيِّدِنَا مُحَمَّدٍ وَّعَلَى اٰلِ سَيِّدِنَا مُحَمَّدٍ",
    latin:
        "Attahiyyaatul mubaarakaatush sholawaatuth thayyibaatu lillaah. Assalaamu 'alaika ayyuhan nabiyyu wa rahmatullahi wabarakaatuh. Assalaaamu'alainaa wa 'alaa 'ibaadillaahish shaalihiin. Asyhadu allaa ilaaha illallah wa asyhadu anna Muhammadar rasuulullah. Allahumma shalli 'alaa sayyidinaa Muhammad.",
    arti:
        "Segala kehormatan, keberkahan, rahmat dan kebaikan adalah milik Allah. Semoga keselamatan, rahmat Allah dan berkah-Nya (tetap tercurahkan) atas mu, wahai Nabi (Muhammad). Semoga keselamatan (tetap terlimpahkan) atas kami dan atas hamba-hamba Allah yang saleh. Aku bersaksi bahwa tidak ada Tuhan selain Allah dan aku bersaksi bahwa Muhammad adalah utusan Allah.",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: "Duduk Tasyahud (Tahiyat Akhir)",
    kategori: ["Sholat"],
    arab:
        " كَمَا صَلَّيْتَ عَلَى سَيِّدِنَا إِبْرَاهِيْمَ وَعَلَى اٰلِ سَيِّدِنَا إِبْرَاهِيْمَ وَبَارِكْ عَلَى سَيِّدِنَا مُحَمَّدٍ وَّعَلَى اٰلِ سَيِّدِنَا مُحَمَّدٍ كَمَا بَارَكْتَ عَلَى سَيّدِنَا إِبْرَاهِيْمَ وَعَلَى اٰلِ سَيِّدِنَا إِبْرَاهِيْمَ فِي الْعَالَمِيْنَ إنَّكَ حَمِيْدٌ مَّجِيْدٌ اَللّٰهُمَّ إِنِّيْ أَعُوْذُ بِكَ مِنْ عَذَابِ الْقَبْرِ، وَمِنْ عَذَابِ النَّارِ، وَمِنْ فِتْنَةِ الْمـحْيَا وَالْمَمَاتِ وَمِنْ فِتْنَةِ الْمَسِيْحِ الدَّجَّالِ",
    latin:
        "kamâ shallaitâ ‘alâ sayyidinâ ibrâhîm wa ‘alâ âli sayyidinâ ibrâhîm wa bârik ‘alâ sayyidinâ muḫammad wa ‘alâ âli sayyidinâ muḫammad kamâ bârakta ‘alâ sayyidinâ ibrâhîm wa ‘alâ âli sayyidinâ ibrâhîm. Fil ‘âlamîna innaka ḫamîdum majîd Allahummâ innî ‘aûdzubika min ‘adzâbil qabri wa min ‘adzâbin nâr wa min fitnatil maḫya wal mamati wa min fitnatil masîḫid dajjal",
    arti:
        "Ya Allah, limpahkanlah rahmat kepada junjungan kami Nabi Muhammad dan kepada keluarga junjungan kami Nabi Muhammad, sebagaimana pernah Engkau beri rahmat kepada junjungan kami Nabi Ibrahim dan kepada keluarga junjungan kami Nabi Ibrahim. Dan limpahilah berkah kepada kepada junjungan kami Nabi Muhammad dan kepada keluarga junjungan kami Nabi Muhammad, sebagaimana Engkau pernah beri berkah kepada junjungan kami Nabi Ibrahim dan kepada keluarga junjungan kami Nabi Ibrahim. Di seluruh alam semesta Engkaulah Yang Terpuji dan Mahamulia.Ya Allah. Aku berlindung dari siksa kubur, dan siksa api neraka dan aku berlindung dari fitnah hidup dan mati dan saya berlindung dari fitnah keburukan Dajjal.",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: "Salam",
    kategori: ["Sholat"],
    arab: "السَّلاَمُ عَلَيْكُمْ وَرَحْمَةُ اللهِ",
    latin: "Assalaamu alaikum wa rahmatullah",
    arti: "Semoga keselamatan dan rahmat Allah dilimpahkan kepadamu.",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: "Doa Sujud Tilawah",
    kategori: ["Sholat"],
    arab:
        "سَجَدَ وَجْهِيَ لِلَّذِيْ خَلَقَهُ وَصَوَّرَهُ، وَشَقَّ سَمْعَهُ وَبَصَرَهُ، بِحَوْلِهِ وَقُوَّتِهِ فَتَبَارَكَ اللهُ أَحْسَنُ الْخَالِقِيْنَ",
    latin:
        "Sajada wajhiya lil ladzî khalaqahu wa shawwarahu wa syaqqa sam‘ahu wa basharahu bi ḫaulihi wa quwwatihi fa tabârakallâhu aḫsanul khâliqîna",
    arti:
        "Diriku bersujud kepada Dzat yang menciptakan dan membentuknya, membuka pendengaran dan penglihatannya dengan daya dan kekuatan-Nya. Mahasuci Allah, sebaik-baik pencipta.",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: "Doa Sujud Sahwi",
    kategori: ["Sholat"],
    arab: "سُبْحَانَ مَنْ لَا يَسْهُوْ وَلَا يَنَامُ",
    latin: "Subḫâna man lâ yashû wa lâ yanâmu",
    arti: "Mahasuci Dzat yang tidak pernah lupa dan tidak tidur",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: "Doa Beres Sholat",
    kategori: ["Sholat", "Doa-Doa"],
    arab:
        "بِسْمِ اللهِ الرَّحْمٰنِ الرَّحِيْمِ. الْحَمْدُ لِلّٰهِ رَبِّ الْعَالَمِيْنَ حَمْدًا يُّوَافِيْ نِعَمَهُ وَ يُكَافِئُ مَزِيْدَهُ يَا رَبَّنَا لَكَ الْحَمْدُ كَمَا يَنْبَغِيْ لِجَلَالِ وَجْهِكَ وَعَظِيْمِ سُلْطَانِكَ. اللّٰهُمَّ صَلِّ وسَلِّمْ عَلَى سَيِّدِنَا مُحَمَّدٍ وَ آلِ سَيِّدِنَا مُحَمَّدٍ اَللّٰهُمَّ صَلِّ وَسَلِّمْ عَلٰى سَيِّدِنَا مُحَمَّدٍ صَلَاةً تُنْجِيْنَا بِهَا مِنْ جَمِيْعِ الْأَهْوَالِ وَالْآفَاتِ وَتَقْضِيْ لَنَا بِهَا مِنْ جَمِيعِ الْحَاجَاتِ وَتُطَهِّرُنَا بِهَا مِنْ جَمِيْعِ السَيِّئَاتِ وَتَرْفَعُنَا بِهَا عِنْدَكَ أَعْلَى الدَّرَجَاتِ وَتُبَلِّغُنَا بِهَا أَقْصَى الْغَايَاتِ مِنْ جَمِيْعِ الْخَيْرَاتِ فِي الْحَيَاةِ وَبَعْدَ الْمَمَاتِ",
    latin:
        "Bismillâhir-rahmânir-rahîm(i). Al-ḫamdulillâhi rabbil-`âlamîn(a), ḫamdan yuwâfî ni`amahu wa yukâfi’u mazîdahu yâ rabbanâ lakal-ḫamdu kamâ yanbaghî lijalâli wajhika wa `adhimi sulthânik(a). Allâhumma shalli wa sallim `ala sayyidinâ Muḫammadin wa âlihi sayyidinâ Muḫammad(in). Allâhumma shalli wa sallim `ala sayyidinâ Muḫammadin shalâtan tunjînâ bihâ min jamî`il-ahwâli wal-âfâti wa taqdî lanâ bihâ min jamî’il-ḫâjâti wa tuthahhirunâ bihâ min jamî`is-sayyi’ati wa tarfa`unâ bihâ `indaka a`lad-darajâti wa tuballighunâ bihâ aqshal-ghâyâti min jamî`il-khairâti fil-ḫayâti wa ba`dal-mamât(i).",
    arti:
        "Dengan nama Allah yang Maha Pengasih lagi Maha Penyayang. Segala puji bagi Allah, Tuhan semesta alam, dengan pujian yang sesuai dengan nikmatnya dan memungkinkan ditambah nikmatnya. Wahai Tuhan kami, hanya bagi-Mu segala puji, sebagaimana yang patut bagi keagungan-Mu dan kebesaran kekuasaan-Mu. Ya Allah, limpahkanlah rahmat kepada junjungan kami Baginda Muhammad, yang dengan shalawat itu Engkau selamatkan kami dari semua keadaan yang menakutkan dan dari semua cobaan, Engkau penuhi semua kebutuhan kami, Engkau bersihkan kami dari segala kejelekan, Engkau angkat kami ke derajat paling tinggi, dan Engkau sampaikan kami kepada tujuan yang paling sempurna dari semua kebaikan, ketika hidup dan setelah mati.",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: "Doa Beres Sholat",
    kategori: ["Sholat", "Doa-Doa"],
    arab:
        "اَللهُمَّ اِنَّا نَسْئَلُكَ سَلاَمَةً فِى الدِّيْنِ وَعَافِيَةً فِى الْجَسَدِ وَزِيَادَةً فِى الْعِلْمِ وَبَرَكَةً فِى الرِّزْقِ وَتَوْبَةً قَبْلَ الْمَوْتِ وَرَحْمَةً عِنْدَ الْمَوْتِ وَمَغْفِرَةً بَعْدَ الْمَوْتِ اَللهُمَّ هَوِّنْ عَلَيْنَا فِىْ سَكَرَاتِ الْمَوْتِ وَالنَّجَاةَ مِنَ النَّارِ وَالْعَفْوَ عِنْدَ الْحِسَابِ رَبَّنَا لَا تُزِغْ قُلُوبَنَا بَعْدَ إِذْ هَدَيْتَنَا وَهَبْ لَنَا مِن لَّدُنكَ رَحْمَةً ۚ إِنَّكَ أَنتَ ٱلْوَهَّابُ رَبَّنَا آتِنَا فِي الدُّنْيَا حَسَنَةً وَفِي الْآخِرَةِ حَسَنَةً وَقِنَا عَذَابَ النَّار وصلى الله على سيدنا محمد وعلى اله وصحبه وسلم والحمد لله رب العالمين",
    latin:
        "Allāhumma innā nas’aluka salāmatan fid-dīni wa ‘āfiyatan fil-jasadi wa ziyādatan fil-‘ilmi wa barakatan fir-rizqi wa taubatan qablal-mauti wa raḥmatan ‘indal-mauti wa maghfiratan ba‘dal-mauti. Allāhumma hawwin ‘alainā fī sakarātil-mauti wan-najāta minan-nāri wal-‘afwa ‘indal-ḥisābi. Rabbanā lā tuzigh qulūbanā ba‘da idz hadaitanā wa hab lanā mil-ladunka raḥmah, innaka antal-Wahhāb. Rabbanā ātinā fid-dunyā ḥasanatan wa fil-ākhirati ḥasanatan wa qinā ‘adzāban-nār. Wa ṣallallāhu ‘alā sayyidinā Muḥammadin wa ‘alā ālihi wa ṣaḥbihi wa sallam, wal-ḥamdulillāhi rabbil-‘ālamīn.",
    arti:
        "Ya Allah, sesungguhnya kami memohon kepada-Mu keselamatan dalam agama, kesehatan dalam tubuh, tambahan ilmu, keberkahan dalam rezeki, taubat sebelum kematian, rahmat ketika kematian, dan ampunan setelah kematian. Ya Allah, mudahkanlah kami dalam menghadapi sakaratul maut, selamatkanlah kami dari api neraka, dan berilah ampunan ketika hisab. Ya Tuhan kami, janganlah Engkau palingkan hati kami setelah Engkau memberi petunjuk kepada kami, dan karuniakanlah kepada kami rahmat dari sisi-Mu. Sesungguhnya Engkaulah Maha Pemberi. Ya Tuhan kami, berilah kami kebaikan di dunia dan kebaikan di akhirat serta lindungilah kami dari azab neraka. Semoga Allah melimpahkan rahmat dan keselamatan kepada junjungan kami Nabi Muhammad, keluarga dan para sahabatnya. Segala puji bagi Allah, Tuhan seluruh alam.",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: "Istighfar Kanjeng Rosul",
    kategori: ["Wudhu", "Doa-Doa"],
    arab:
        "اَللّٰهُمَّ اغْفِرْ لِيْ خَطِيْئَتِيْ وَجَهْلِيْ، وَإِسْرَافِيْ فِيْ أَمْرِيْ، وَمَا أَنْتَ أَعْلَمُ بِهِ مِنِّيْ، اَللّٰهُمَّ اغْفِرْ لِيْ جِدِّيْ وَهَزْلِيْ؛ وَخَطَئِيْ وَعَمْدِيْ؛ وَكُلُّ ذٰلِكَ عِنْدِيْ، اَللّٰهُمَّ اغْفِرْ لِيْ مَا قَدَّمْتُ وَمَا أَخَّرْتُ، وَمَا أَسْرَرْتُ وَمَا أَعْلَنْتُ، وَمَا أَنْتَ أَعْلَمُ بِهِ مِنِّيْ، أَنْتَ الْمُقَدِّمُ، وَأَنْتَ الْمُؤَخِّرُ لَا إِلٰهَ إِلَّا أَنْتَ وَلَا حَوْلَ وَلَا قُوَّةَ إِلَّا بِاللهِ",
    latin:
        "Allāhummaghfir lī khaṭī’atī wa jahlī, wa isrāfī fī amrī, wa mā anta a‘lamu bihī minnī. Allāhummaghfir lī jiddī wa hazlī, wa khaṭa’ī wa ‘amdī, wa kullu dzālika ‘indī. Allāhummaghfir lī mā qaddamtu wa mā akhkhartu, wa mā asrartu wa mā a‘lantu, wa mā anta a‘lamu bihī minnī. Antal-muqaddimu wa antal-mu’akhkhiru, lā ilāha illā anta, wa lā ḥaula wa lā quwwata illā billāh.",
    arti:
        "Ya Allah, ampunilah kesalahanku, kebodohanku, sikap berlebih-lebihanku dalam urusanku, dan segala sesuatu yang lebih Engkau ketahui daripada aku. Ya Allah, ampunilah kesungguhanku dan kelucuanku, kesalahanku dan kesengajaanku, dan semua itu ada padaku. Ya Allah, ampunilah apa yang telah aku lakukan dan apa yang akan aku lakukan, apa yang aku sembunyikan dan apa yang aku nyatakan, serta apa yang lebih Engkau ketahui daripada aku. Engkaulah Yang Mendahulukan dan Engkaulah Yang Mengakhirkan. Tidak ada Tuhan selain Engkau. Tidak ada daya dan kekuatan kecuali dengan pertolongan Allah.",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: "Doa Masuk Surga & Dijauhkan dari Panas Api Neraka",
    kategori: ["Wudhu", "Doa-Doa"],
    arab:
        "اللَّهُمَّ إِنِّي أَسْأَلُكَ الْجَنَّةَ، وَأَعُوذُ بِكَ مِنَ النَّارِ",
    latin: "Allāhumma innī as'alukal-jannah, wa a'ūdzu bika minan-nār.",
    arti:
        "Ya Allah, sesungguhnya aku memohon surga kepada-Mu dan aku berlindung kepada-Mu dari api neraka.",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: "Doa Pengugur Dosa",
    kategori: ["Wudhu", "Doa-Doa"],
    arab: "اللَّهُمَّ إِنَّكَ عَفُوٌّ كَرِيمٌ تُحِبُّ الْعَفْوَ فَاعْفُ عَنِّي",
    latin: "Allāhumma innaka 'afuwwun karīmun tuhibbul-'afwa fa'fu 'annī.",
    arti:
        "Ya Allah, sesungguhnya Engkau Maha Pengampun lagi Maha Mulia, Engkau menyukai ampunan, maka ampunilah aku.",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: "Doa Sapu Jagat",
    kategori: ["Wudhu", "Doa-Doa"],
    arab:
        "رَبَّنَا آتِنَا فِي الدُّنْيَا حَسَنَةً وَفِي الْآخِرَةِ حَسَنَةً وَقِنَا عَذَابَ النَّارِ",
    latin:
        "Rabbanā ātinā fid-dunyā hasanatan wa fil-ākhirati hasanatan wa qinā 'adzāban-nār.",
    arti:
        "Ya Tuhan kami, berilah kami kebaikan di dunia dan kebaikan di akhirat, dan lindungilah kami dari azab neraka.",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: "Doa Nabi Musa",
    kategori: ["Wudhu", "Doa-Doa"],
    arab: "رَبِّ إِنِّي لِمَا أَنْزَلْتَ إِلَيَّ مِنْ خَيْرٍ فَقِيرٌ",
    latin: "Rabbi innī limā anzalta ilayya min khairin faqīr.",
    arti:
        "Ya Tuhanku, sesungguhnya aku sangat memerlukan sesuatu kebaikan (rezeki) yang Engkau turunkan kepadaku.",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: "Doa Minta Kesehatan, Keberlimpahan Harta, dan Kecukupan",
    kategori: ["Wudhu", "Doa-Doa"],
    arab:
        "اللَّهُمَّ اغْفِرْ لِي، وَارْحَمْنِي، وَاهْدِنِي، وَعَافِنِي، وَارْزُقْنِي",
    latin: "Allāhummaghfir lī, warhamnī, wahdinī, wa 'āfinī, warzuqnī.",
    arti:
        "Ya Allah, ampunilah aku, rahmatilah aku, berilah aku petunjuk, berilah aku kesehatan/keselamatan, dan berilah aku rezeki.",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul:
        "Pelindung dari Kecemasan, Stres, Ketakutan, dan Pelancar Hadapi Masalah",
    kategori: ["Wudhu", "Doa-Doa"],
    arab:
        "حَسْبِيَ اللَّهُ لَا إِلٰهَ إِلَّا هُوَ ۖ عَلَيْهِ تَوَكَّلْتُ ۖ وَهُوَ رَبُّ الْعَرْشِ الْعَظِيمِ",
    latin:
        "Hasbiyallāhu lā ilāha illā huwa, 'alaihi tawakkaltu, wa huwa Rabbul-'Arsyil-'Azhīm.",
    arti:
        "Cukuplah Allah bagiku; tidak ada tuhan selain Dia. Hanya kepada-Nya aku bertawakal, dan Dia adalah Tuhan yang memiliki 'Arsy yang agung.",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: "Sholawat Munjiat",
    kategori: [" Sholawat"],
    arab:
        "اَللّٰهُمَّ صَلِّ عَلَى سَيِّدِنَا مُحَمَّدٍ صَلاَةً تُنْجِيْنَا بِهَا مِنْ جَمِيْعِ الْأَهْوَالِ وَالْاٰفَاتِ وَتَقْضِيْ لَنَا بِهَا جَمِيعَ الْحَاجَاتِ وَتُطَهِّرُنَا بِهَا مِنْ جَمِيْعِ السَيِّئَاتِ وَتَرْفَعُنَا بِهَا عِنْدَكَ أَعْلَى الدَّرَجَاتِ وَتُبَلِّغُنَا بِهَـــا أَقْصَى الْغَايَاتِ مِنْ جَمِيْعِ الْخَيْرَاتِ فِى الْحَيَاةِ وَبَعْدَ الْمَمَـــاتِ",
    latin: "",
    arti:
        "Ya Allah limpahkanlah rahmat kepada junjungan kami Nabi Muhammad, yang dengan shalawat itu, Engkau akan menyelamatkan kami dari semua keadaan yang menakutkan dan dari semua cobaan; dengan shalawat itu, Engkau akan mengabulkan hajat kami; dengan shalawat itu, Engkau akan menyucikan kami dari segala keburukan; dengan shalawat itu, Engkau akan mengangkat kami ke derajat paling tinggi; dengan shalawat itu pula, Engkau akan menyampaikan kami kepada tujuan yang paling sempurna dalam semua kebaikan, ketika hidup dan setelah mati.",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: "Niat Shalat Sunnah Taubat",
    kategori: ["Sholat", "Doa-Doa"],
    arab: "أُصَلِّي سُنَّةَ التَّوْبَةِ رَكْعَتَيْنِ لِلَّهِ تَعَالَى",
    latin: "Ushallī sunnatat-taubati rak‘ataini lillāhi ta‘ālā.",
    arti: "Aku berniat shalat sunnah Taubat dua rakaat karena Allah Ta‘ālā.",
    dalil: "",
    keterangan:
        "Dikerjakan dua rakaat sebagai bentuk taubat kepada Allah Ta‘ālā.",
  ),
  DoaModel(
    judul: "Niat Shalat Sunnah Hajat",
    kategori: ["Sholat", "Doa-Doa"],
    arab: "أُصَلِّي سُنَّةَ الْحَاجَةِ رَكْعَتَيْنِ لِلَّهِ تَعَالَى",
    latin: "Ushallī sunnatal-ḥājati rak‘ataini lillāhi ta‘ālā.",
    arti: "Aku berniat shalat sunnah Hajat dua rakaat karena Allah Ta‘ālā.",
    dalil: "",
    keterangan:
        "Dikerjakan dua rakaat kemudian dilanjutkan dengan berdoa memohon hajat kepada Allah Ta‘ālā.",
  ),
  DoaModel(
    judul: "Niat Shalat Sunnah Tasbih",
    kategori: ["Sholat", "Doa-Doa"],
    arab: "أُصَلِّي سُنَّةَ التَّسْبِيحِ أَرْبَعَ رَكَعَاتٍ لِلَّهِ تَعَالَى",
    latin: "Ushallī sunnatat-tasbīḥi arba‘a raka‘ātin lillāhi ta‘ālā.",
    arti: "Aku berniat shalat sunnah Tasbih empat rakaat karena Allah Ta‘ālā.",
    dalil: "",
    keterangan: "Shalat Tasbih dikerjakan empat rakaat.",
  ),
  DoaModel(
    judul: "Niat Shalat Tahajud",
    kategori: ["Sholat", "Doa-Doa"],
    arab: "أُصَلِّي سُنَّةَ التَّهَجُّدِ رَكْعَتَيْنِ لِلَّهِ تَعَالَى",
    latin: "Ushallī sunnatat-tahajjudi rak'ataini lillāhi ta'ālā.",
    arti: "Aku berniat shalat sunnah Tahajud dua rakaat karena Allah Ta'ala.",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: "Doa Ba'da Shalat Tahajud",
    kategori: ["Sholat", "Doa-Doa"],
    arab:
        "لَكَ الْحَمْدُ وَمِنْكَ الْفَرَجُ وَإِلَيْكَ الْمُشْتَكَى وَأَنْتَ الْمُسْتَعَانُ، وَلاَ حَوْلَ وَلاَ قُوَّةَ إِلاَّ بِاللَّهِ الْعَلِيِّ الْعَظِيمِ.\n"
        "(Buka kedua telapak tangan)\n"
        "اللَّهُمَّ إِنَّا نَسْأَلُكَ رِزْقًا وَاسِعًا وَشِفَاءً مِنْ كُلِّ دَاءٍ بِرَحْمَتِكَ يَا أَرْحَمَ الرَّاحِمِينَ.\n\n"
        "اللَّهُمَّ أَنْتَ قَيُّومُ السَّمَاوَاتِ وَالأَرْضِ وَمَنْ فِيهِنَّ وَلَكَ الْحَمْدُ، "
        "أَنْتَ مَلِكُ السَّمَاوَاتِ وَالأَرْضِ وَمَنْ فِيهِنَّ وَلَكَ الْحَمْدُ، "
        "أَنْتَ نُورُ السَّمَاوَاتِ وَالأَرْضِ وَمَنْ فِيهِنَّ وَلَكَ الْحَمْدُ، "
        "أَنْتَ الْحَقُّ وَوَعْدُكَ الْحَقُّ وَلِقَاؤُكَ الْحَقُّ، وَقَوْلُكَ الْحَقُّ، "
        "وَالْجَنَّةُ حَقٌّ، وَالنَّارُ حَقٌّ، وَالنَّبِيُّونَ حَقٌّ، وَمُحَمَّدٌ ﷺ حَقٌّ، وَالسَّاعَةُ حَقٌّ.\n\n"
        "اللَّهُمَّ لَكَ أَسْلَمْتُ، وَبِكَ آمَنْتُ، وَعَلَيْكَ تَوَكَّلْتُ، وَإِلَيْكَ أَنَبْتُ، "
        "وَبِكَ خَاصَمْتُ، وَإِلَيْكَ حَاكَمْتُ، فَاغْفِرْ لِي مَا قَدَّمْتُ وَمَا أَخَّرْتُ، "
        "وَمَا أَسْرَرْتُ وَمَا أَعْلَنْتُ، وَمَا أَنْتَ أَعْلَمُ بِهِ مِنِّي، "
        "أَنْتَ الْمُقَدِّمُ وَأَنْتَ الْمُؤَخِّرُ لاَ إِلَهَ إِلاَّ أَنْتَ، "
        "وَلاَ حَوْلَ وَلاَ قُوَّةَ إِلاَّ بِاللَّهِ الْعَلِيِّ الْعَظِيمِ",
    latin:
        "Lakal-hamdu wa minkal-faraju wa ilaikal-mushtakā wa antal-musta'ānu, "
        "wa lā haula wa lā quwwata illā billāhil-'aliyyil-'azhīm.\n"
        "(Buka kedua telapak tangan)\n"
        "Allāhumma innā nas'aluka rizqan wāsi'an wa syifā'an min kulli dā'in "
        "birahmatika yā arhamar-rāhimīn.\n\n"
        "Allāhumma anta qayyūmus-samāwāti wal-ardhi wa man fīhinna wa lakal-hamdu, "
        "anta malikus-samāwāti wal-ardhi wa man fīhinna wa lakal-hamdu, "
        "anta nūrus-samāwāti wal-ardhi wa man fīhinna wa lakal-hamdu, "
        "antal-haqqu wa wa'dukal-haqqu wa liqā'ukal-haqqu, wa qaulukal-haqqu, "
        "wal-jannatu haqqun, wan-nāru haqqun, wan-nabiyyūna haqqun, "
        "wa Muhammadun ﷺ haqqun, was-sā'atu haqqun.\n\n"
        "Allāhumma laka aslamtu, wa bika āmantu, wa 'alaika tawakkaltu, "
        "wa ilaika anabtu, wa bika khāshamtu, wa ilaika hākamtu, "
        "faghfir lī mā qaddamtu wa mā akhkhartu, wa mā asrartu wa mā a'lantu, "
        "wa mā anta a'lamu bihī minnī, antal-muqaddimu wa antal-mu'akhkhiru "
        "lā ilāha illā anta, wa lā haula wa lā quwwata illā billāhil-'aliyyil-'azhīm.",
    arti:
        "Bagi-Mu segala puji, dari-Mu kelapangan/jalan keluar, kepada-Mu tempat mengadu, "
        "dan Engkaulah tempat memohon pertolongan. Tidak ada daya dan kekuatan melainkan "
        "dengan pertolongan Allah Yang Mahatinggi lagi Mahaagung.\n\n"
        "(Buka kedua telapak tangan)\n\n"
        "Ya Allah, sesungguhnya kami memohon kepada-Mu rezeki yang luas dan kesembuhan "
        "dari segala penyakit dengan rahmat-Mu, wahai Yang Maha Penyayang di antara penyayang.\n\n"
        "Ya Allah, Engkaulah Pengatur langit dan bumi serta apa yang ada di dalamnya, "
        "bagi-Mu segala puji. Engkaulah Penguasa langit dan bumi serta apa yang ada di dalamnya, "
        "bagi-Mu segala puji. Engkaulah Cahaya langit dan bumi serta apa yang ada di dalamnya, "
        "bagi-Mu segala puji. Engkaulah Yang Mahabenar, janji-Mu benar, pertemuan dengan-Mu benar, "
        "firman-Mu benar, surga itu benar, neraka itu benar, para nabi itu benar, "
        "Nabi Muhammad ﷺ itu benar, dan hari kiamat itu benar.\n\n"
        "Ya Allah, hanya kepada-Mu aku berserah diri, kepada-Mu aku beriman, "
        "kepada-Mu aku bertawakal, kepada-Mu aku kembali, karena-Mu aku berdebat, "
        "dan kepada-Mu aku memutuskan hukum. Maka ampunilah dosaku yang telah lalu dan yang akan datang, "
        "yang kusembunyikan dan yang kunyatakan, serta apa yang Engkau lebih mengetahuinya daripadaku. "
        "Engkaulah Yang Mendahulukan dan Engkaulah Yang Mengakhirkan, tidak ada tuhan selain Engkau, "
        "dan tidak ada daya serta kekuatan melainkan dengan pertolongan Allah Yang Mahatinggi lagi Mahaagung.",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: "Doa Diberikan Rizki (Dibaca Ba'da Tahajud)",
    kategori: ["Sholat", "Doa-Doa"],
    arab:
        "اللَّهُمَّ ارْزُقْنَا رِزْقًا كَثِيرًا حَلاَلاً طَيِّبًا مُبَارَكًا فِيهِ مِنْ غَيْرِ ضَيْرٍ وَلاَ قُوَّةٍ وَلاَ تَعَبٍ وَلاَ مَشَقَّةٍ مِنَّا.\n\n"
        "[اللَّهُ لَطِيفٌ بِعِبَادِهِ يَرْزُقُ مَنْ يَشَاءُ وَهُوَ الْقَوِيُّ الْعَزِيزُ ×٢١]\n\n"
        "[يَا فَتَّاحُ يَا رَزَّاقُ ×١٠٠]",
    latin:
        "Allāhummar-zuqnā rizqan katsīran ḥalālan ṭayyiban mubārakan fīhi min ghairi ḍairin wa lā quwwatin wa lā ta'abin wa lā masyaqqatin minnā.\n\n"
        "[Allāhu laṭīfun bi'ibādihī yarzuqu may yasyā'u wa huwal-qawiyyul-'azīz ×21]\n\n"
        "[Yā Fattāḥu yā Razzāq ×100]",
    arti:
        "Ya Allah, berilah kami rezeki yang banyak, halal, baik, serta diberkahi di dalamnya tanpa ada kesulitan, tanpa kekuatan (usaha keras yang berat), tanpa rasa lelah, dan tanpa kesusahan dari kami.\n\n"
        "[Allah Maha Lembut kepada hamba-hamba-Nya; Dia memberi rezeki kepada siapa yang Dia kehendaki, dan Dia Mahakuat lagi Mahaperkasa ×21]\n\n"
        "[Wahai Yang Maha Pembuka, wahai Yang Maha Pemberi Rezeki ×100]",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: "Niat Shalat Istikharah",
    kategori: ["Sholat", "Doa-Doa"],
    arab: "أُصَلِّي سُنَّةَ الاِسْتِخَارَةِ رَكْعَتَيْنِ لِلَّهِ تَعَالَى\n\n"
        "Bacaan Rakaat Pertama:\n"
        "وَوَرَبُّكَ يَخْلُقُ مَا يَشَاءُ وَيَخْتَارُ مَا كَانَ لَهُمُ الْخِيَرَةُ سُبْحَانَ اللَّهِ وَتَعَالَى عَمَّا يُشْرِكُونَ\n\n"
        "Bacaan Rakaat Kedua:\n"
        "وَمَا كَانَ لِمُؤْمِنٍ وَلاَ مُؤْمِنَةٍ إِذَا قَضَى اللَّهُ وَرَسُولُهُ أَمْرًا أَنْ يَكُونَ لَهُمُ الْخِيَرَةُ مِنْ أَمْرِهِمْ وَمَنْ يَعْصِ اللَّهَ وَرَسُولَهُ فَقَدْ ضَلَّ ضَلاَلاً مُبِينًا",
    latin: "Ushallī sunnatal-istikhārati rak'ataini lillāhi ta'ālā.\n\n"
        "Bacaan Rakaat Pertama:\n"
        "Wa rabbuka yakhluqu mā yasyā'u wa yakhtāru, mā kāna lahumul-khiyaratu subḥānallāhi wa ta'ālā 'ammā yusyrikūn.\n\n"
        "Bacaan Rakaat Kedua:\n"
        "Wa mā kāna limu'miniw wa lā mu'minatin iżā qaḍallāhu wa rasūluhū amran ay yakūna lahumul-khiyaratu min amrihim, wa may ya'ṣillāha wa rasūlahū faqad ḍalla ḍalālam mubīnā.",
    arti:
        "Aku berniat shalat sunnah Istikharah dua rakaat karena Allah Ta'ala.\n\n"
        "Bacaan Rakaat Pertama:\n"
        "Dan Tuhanmu menciptakan apa yang Dia kehendaki dan memilih-Nya. Tidak ada pilihan bagi mereka. Maha Suci Allah dan Mahatinggi Dia dari apa yang mereka persekutukan.\n\n"
        "Bacaan Rakaat Kedua:\n"
        "Dan tidaklah pantas bagi laki-laki yang mukmin dan tidak pula bagi perempuan yang mukmin, apabila Allah dan Rasul-Nya telah menetapkan suatu ketetapan, akan ada bagi mereka pilihan yang lain tentang urusan mereka. Dan barangsiapa mendurhakai Allah dan Rasul-Nya maka sungguh dia telah sesat, sesat yang nyata.",
    dalil: "QS. Al-Qashash: 68; QS. Al-Ahzab: 36",
    keterangan:
        "Setelah membaca Al-Fatihah pada rakaat pertama, dapat membaca ayat dari QS. Al-Qashash: 68 atau Surah Al-Kafirun. "
        "Pada rakaat kedua, dapat membaca ayat dari QS. Al-Ahzab: 36.",
  ),
  DoaModel(
    judul: "Doa Shalat Istikharah",
    kategori: ["Sholat", "Doa-Doa"],
    arab:
        "اللَّهُمَّ يَا حَبِيبَ كُلِّ حَبِيبٍ، يَا مُغِيثَ كُلِّ مُغِيثٍ، يَا كَافِي يَا مُكَافِي، يَا مَنْ هُوَ لِجَمِيعِ الْخَلْقِ كَافٍ. إِكْشِفْ لِي مَا هُوَ فِي نَفْسِي مُخْفِي بِحَقِّ الْقَلَمِ وَاللَّوْحِ الْمَحْفُوظِ وَالْعَرْشِ وَالْكُرْسِيِّ وَبِحَقِّ مُحَمَّدٍ صَلَّى اللَّهُ عَلَيْهِ وَسَلَّمَ.\n\n"
        "اللَّهُمَّ إِنْ كُنْتَ تَعْلَمُ أَنَّ هَذَا الأَمْرَ (.....) خَيْرٌ لِي فِي دِينِي وَدُنْيَايَ وَمَعَاشِي وَعَاقِبَةِ أَمْرِي عَاجِلِهِ وَآجِلِهِ فَأَرِنِي بَيَاضًا أَوْ خَضِرًا أَوْ مَاءً جَارِيًا.\n\n"
        "اللَّهُمَّ إِنْ كُنْتَ تَعْلَمُ أَنَّ هَذَا الأَمْرَ (.....) شَرٌّ لِي فِي دِينِي وَدُنْيَايَ وَمَعَاشِي وَعَاقِبَةِ أَمْرِي عَاجِلِهِ وَآجِلِهِ فَأَرِنِي سَوَادًا أَوْ دُخَانًا، إِنَّكَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ.\n\n"
        "وَصَلَّى اللَّهُ عَلَى سَيِّدِنَا مُحَمَّدٍ وَعَلَى آلِهِ وَصَحْبِهِ وَسَلَّمَ.",
    latin:
        "Allāhumma yā habība kulli habīb, yā mughītsa kulli mughīts, yā kāfī yā mukāfī, yā man huwa lijamī'il-khalqi kāf. Iksyif lī mā huwa fī nafsī mukhfī bihaqqil-qalami wal-lauhil-mahfūzhi wal-'arsyi wal-kursiyyi wa bihaqqi Muhammadin shallallāhu 'alaihi wa sallam.\n\n"
        "Allāhumma in kun ta'lamu anna hādzal-amra (.....) khairun lī fī dīnī wa dunyāya wa ma'āsyī wa 'āqibati amrī 'ājilihī wa ājilihī fa-arinī bayādhan au khadhiran au mā'an jāriyā.\n\n"
        "Allāhumma in kun ta'lamu anna hādzal-amra (.....) syarrun lī fī dīnī wa dunyāya wa ma'āsyī wa 'āqibati amrī 'ājilihī wa ājilihī fa-arinī sawādan au dukhānā, innaka 'alā kulli syai'in qadīr.\n\n"
        "Wa shallallāhu 'alā sayyidinā Muhammadin wa 'alā ālihī wa shahbihī wa sallam.",
    arti:
        "Ya Allah, wahai Kekasih dari setiap kekasih, wahai Penolong dari setiap yang memohon pertolongan, wahai Yang Maha Mencukupi, wahai Yang Maha Membalas, wahai Dzat yang mencukupi bagi seluruh makhluk. Singkapkanlah bagiku apa yang tersembunyi di dalam diriku demi kebenaran Pena (Qalam), Lauh Mahfuzh, Arsy, Kursi, dan demi kebenaran Nabi Muhammad ﷺ.\n\n"
        "Ya Allah, jika Engkau mengetahui bahwa urusan ini (.....) baik bagiku dalam agamaku, duniaku, penghidupanku, serta kesudahan urusanku baik jangka pendek maupun jangka panjang, maka perlihatkanlah padaku tanda warna putih, hijau, atau air yang mengalir.\n\n"
        "Ya Allah, jika Engkau mengetahui bahwa urusan ini (.....) buruk bagiku dalam agamaku, duniaku, penghidupanku, serta kesudahan urusanku baik jangka pendek maupun jangka panjang, maka perlihatkanlah padaku tanda warna hitam atau asap. Sesungguhnya Engkau Mahakuasa atas segala sesuatu.\n\n"
        "Semoga shalawat dan salam Allah tercurah kepada junjungan kami Nabi Muhammad beserta keluarga dan sahabatnya.",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: "Niat Shalat Sunnah Qabliyah Subuh",
    kategori: ["Sholat"],
    arab: "أُصَلِّي سُنَّةَ الْفَجْرِ رَكْعَتَيْنِ لِلَّهِ تَعَالَى",
    latin: "Ushallī sunnatal-fajri rak‘ataini lillāhi ta‘ālā.",
    arti: "Aku berniat shalat sunnah Fajar dua rakaat karena Allah Ta‘ālā.",
    dalil: "",
    keterangan: "Dikerjakan dua rakaat sebelum shalat Subuh.",
  ),
  DoaModel(
    judul: "Niat Shalat Sunnah Dhuha",
    kategori: ["Sholat", "Doa-Doa"],
    arab: "أُصَلِّي سُنَّةَ الضُّحَى رَكْعَتَيْنِ لِلَّهِ تَعَالَى",
    latin: "Ushallī sunnataḍ-ḍuḥā rak‘ataini lillāhi ta‘ālā.",
    arti: "Aku berniat shalat sunnah Dhuha dua rakaat karena Allah Ta‘ālā.",
    dalil: "",
    keterangan:
        "Shalat Dhuha dikerjakan pada waktu Dhuha dan dapat dikerjakan minimal dua rakaat.",
  ),
  DoaModel(
    judul: "Doa Shalat Dhuha",
    kategori: ["Sholat", "Doa-Doa"],
    arab:
        "اللَّهُمَّ إِنَّ الضُّحَاءَ ضُحَاؤُكَ، وَالْبَهَاءَ بَهَاؤُكَ، وَالْجَمَالَ جَمَالُكَ، وَالْقُوَّةَ قُوَّتُكَ، وَالْقُدْرَةَ قُدْرَتُكَ، وَالْعِصْمَةَ عِصْمَتُكَ.\n\n"
        "اللَّهُمَّ إِنْ كَانَ رِزْقِي فِي السَّمَاءِ فَأَنْزِلْهُ، وَإِنْ كَانَ فِي الأَرْضِ فَأَخْرِجْهُ، وَإِنْ كَانَ مُعَسَّرًا فَيَسِّرْهُ، وَإِنْ كَانَ حَرَامًا فَطَهِّرْهُ، وَإِنْ كَانَ بَعِيدًا فَقَرِّبْهُ، بِحَقِّ ضُحَائِكَ وَبَهَائِكَ وَجَمَالِكَ وَقُوَّتِكَ وَقُدْرَتِكَ آتِنِي مَا آتَيْتَ عِبَادَكَ الصَّالِحِينَ.",
    latin:
        "Allāhumma innadh-dhuhā'a dhuhā'uka, wal-bahā'a bahā'uka, wal-jamāla jamāluka, wal-quwwata quwwatuka, wal-qudrata qudratuka, wal-'ishmata 'ishmatuka.\n\n"
        "Allāhumma in kāna rizqī fis-samā'i fa-anzilhu, wa in kāna fil-arḍi fa-akhrijhu, wa in kāna mu'assaran fa-yassirhu, wa in kāna ḥarāman fa-ṭahhirhu, wa in kāna ba'īdan fa-qarribhu, bihaqqi ḍuhā'ika wa bahā'ika wa jamālika wa quwwatika wa qudratika ātinī mā ātaita 'ibādakaṣ-ṣāliḥīn.",
    arti:
        "Ya Allah, sesungguhnya waktu Dhuha itu adalah waktu Dhuha-Mu, keagungan itu adalah keagungan-Mu, keindahan itu adalah keindahan-Mu, kekuatan itu adalah kekuatan-Mu, kekuasaan itu adalah kekuasaan-Mu, dan perlindungan itu adalah perlindungan-Mu.\n\n"
        "Ya Allah, jika rezekiku masih berada di atas langit maka turunkanlah, jika ada di dalam bumi maka keluarkanlah, jika sukar maka mudahkanlah, jika haram maka sucikanlah, dan jika jauh maka dekatkanlah. Dengan hak Dhuha-Mu, keagungan-Mu, keindahan-Mu, kekuatan-Mu, dan kekuasaan-Mu, berikanlah kepadaku apa yang telah Engkau berikan kepada hamba-hamba-Mu yang shalih.",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul:
        "Doa Nyuhunkeun Pangriksa (Wirid Ba'da Shalat Dhuha) / Hijib Al-Isyroq",
    kategori: ["Sholat", "Doa-Doa"],
    arab:
        "بِسْمِ اللَّهِ أَشْرَقَتْ نُورُ اللَّهِ، وَظَهَرَ كَلاَمُ اللَّهِ، وَثَبَتَ أَمْرُ اللَّهِ، وَنَفَذَ حُكْمُ اللَّهِ، وَتَوَكَّلْتُ عَلَى اللَّهِ، مَا شَاءَ اللَّهُ لاَ حَوْلَ وَلاَ قُوَّةَ إِلاَّ بِاللَّهِ. تَحَصَّنْتُ بِخَفِيِّ لُطْفِ اللَّهِ، وَبِلُطْفِ صُنْعِ اللَّهِ، وَبِعَظِيمِ ذِكْرِ اللَّهِ، وَبِجَمِيلِ سِتْرِ اللَّهِ، وَبِقُوَّةِ سُلْطَانِ اللَّهِ، دَخَلْتُ فِي كَنَفِ اللَّهِ، وَاسْتَجَرْتُ بِرَسُولِ اللَّهِ ﷺ، تَبَرَّأْتُ مِنْ حَوْلِي وَقُوَّتِي وَاسْتَعَنْتُ بِحَوْلِ اللَّهِ وَقُوَّتِهِ. اللَّهُمَّ اسْتُرْ لِي وَاحْفَظْنِي فِي دِينِي وَدُنْيَايَ وَأَهْلِي وَمَالِي وَوَلَدِي وَأَصْحَابِي وَأَحْبَابِي وَمَشَايِخِي، بِسِتْرِكَ الَّذِي سَتَرْتَ بِهِ ذَاتَكَ، فَلاَ عَيْنٌ تَرَاكَ وَلاَ يَدٌ تَصِلُ إِلَيْكَ، [يَا أَرْحَمَ الرَّاحِمِينَ أِحْجُبْنِي عَنِ الْقَوْمِ الظَّالِمِينَ ×٣].\n\n"
        "بِقُدْرَتِكَ يَا قَوِيُّ يَا مَتِينُ وَبِكَ نَسْتَعِينُ. اللَّهُمَّ يَا سَابِقَ الْفَوْتِ وَيَا سَامِعَ الصَّوْتِ وَيَا كَاسِيَ الْعِظَامِ لَحْمًا بَعْدَ الْمَوْتِ، أَغِثْنِي وَأَجِرْنِي مِنْ خِزْيِ الدُّنْيَا وَعَذَابِ الآخِرَةِ بِرَحْمَتِكَ يَا أَرْحَمَ الرَّاحِمِينَ.",
    latin:
        "Bismillāhi asyraqat nūrullāh, wa zhahara kalāmullāh, wa tsabata amrullāh, wa nafadza hukmullāh, wa tawakkaltu 'alallāh, mā syā'allāhu lā haula wa lā quwwata illā billāh. Tahassantu bikhafiyyi lutfillāh, wa bilutfi shun'illāh, wa bi'azhīmi dzikrillāh, wa bijamīli sitrillāh, wa biquwwati sulthānillāh, dakhaltu fī kanafillāh, wastajartu birasūlillāhi ﷺ, tabarra'tu min haulī wa quwwatī wastā'antu bihaulillāhi wa quwwatih. Allāhummas-tur lī wahfazhnī fī dīnī wa dunyāya wa ahlī wa mālī wa waladī wa ash-hābī wa ahbābī wa masyāyikhī, bisitrikalladzī satarta bihī dzātaka, falā 'ainun tarāka wa lā yadun tashilu ilaika, [yā arhamar-rāhimīn ihjubnī 'anil-qaumidh-dhālimīn ×3].\n\n"
        "Biqudratika yā qawiyyu yā matīnu wa bika nasta'īn. Allāhumma yā sābiqal-fauti wa yā sāmi'ash-shauti wa yā kāsiyal-'izhāmi laḥman ba'dal-maut, aghitsnī wa ajirnī min khizyid-dunyā wa 'adzābil-ākhirati birahmatika yā arhamar-rāḥimīn.",
    arti:
        "Dengan nama Allah, telah memancar cahaya Allah, tampak jelas firman Allah, tetaplah urusan Allah, dan terlaksanalah hukum Allah. Aku bertawakal kepada Allah; apa yang dikehendaki Allah pasti terjadi, tidak ada daya dan kekuatan melainkan dengan pertolongan Allah. Aku membentengi diri dengan kelembutan Allah yang tersembunyi, dengan keindahan ciptaan Allah, dengan keagungan zikir Allah, dengan indahnya perlindungan Allah, dan dengan kekuatan kekuasaan Allah. Aku masuk ke dalam naungan Allah dan memohon perlindungan kepada Rasulullah ﷺ. Aku lepas dari daya dan kekuatanku sendiri, dan aku memohon pertolongan dengan daya serta kekuatan Allah. Ya Allah, tutuplah aibku dan peliharalah aku dalam agamaku, duniaku, keluargaku, hartaku, anak-anakku, sahabat-sahabatku, orang-orang yang kucintai, serta guru-guruku, dengan perlindungan-Mu yang Engkau gunakan untuk menutupi Dzat-Mu, sehingga tidak ada mata yang dapat melihat-Mu dan tidak ada tangan yang dapat menggapai-Mu. [Wahai Yang Maha Penyayang di antara penyayang, lindungilah/bentengilah aku dari kaum yang zalim ×3].\n\n"
        "Dengan kekuasaan-Mu wahai Yang Maha Kuat lagi Maha Kokoh, dan hanya kepada-Mu kami memohon pertolongan. Ya Allah, wahai Yang Mendahului segala luput, wahai Yang Maha Mendengar suara, wahai Yang Membungkus tulang-belulang dengan daging setelah kematian, tolonglah aku dan selamatkanlah aku dari kehinaan dunia dan azab akhirat dengan rahmat-Mu, wahai Yang Maha Penyayang di antara penyayang.",
    dalil: "",
    keterangan: "Dibaca sebagai wirid setelah Shalat Dhuha.",
  ),
  DoaModel(
    judul: "Niat Shalat Sunnah Qabliyah Zuhur",
    kategori: ["Sholat"],
    arab:
        "أُصَلِّي سُنَّةَ الظُّهْرِ قَبْلِيَّةً رَكْعَتَيْنِ لِلَّهِ تَعَالَى",
    latin: "Ushallī sunnataẓ-ẓuhri qabliyyatan rak‘ataini lillāhi ta‘ālā.",
    arti:
        "Aku berniat shalat sunnah qabliyah Zuhur dua rakaat karena Allah Ta‘ālā.",
    dalil: "",
    keterangan:
        "Dikerjakan sebelum shalat Zuhur. Dapat dikerjakan dua atau empat rakaat.",
  ),
  DoaModel(
    judul: "Niat Shalat Sunnah Ba'diyah Zuhur",
    kategori: ["Sholat"],
    arab:
        "أُصَلِّي سُنَّةَ الظُّهْرِ بَعْدِيَّةً رَكْعَتَيْنِ لِلَّهِ تَعَالَى",
    latin: "Ushallī sunnataẓ-ẓuhri ba‘diyyatan rak‘ataini lillāhi ta‘ālā.",
    arti:
        "Aku berniat shalat sunnah ba'diyah Zuhur dua rakaat karena Allah Ta‘ālā.",
    dalil: "",
    keterangan: "Dikerjakan setelah shalat Zuhur sebanyak dua rakaat.",
  ),
  DoaModel(
    judul: "Niat Shalat Sunnah Qabliyah Ashar",
    kategori: ["Sholat"],
    arab:
        "أُصَلِّي سُنَّةَ الْعَصْرِ قَبْلِيَّةً رَكْعَتَيْنِ لِلَّهِ تَعَالَى",
    latin: "Ushallī sunnatal-‘aṣri qabliyyatan rak‘ataini lillāhi ta‘ālā.",
    arti:
        "Aku berniat shalat sunnah qabliyah Ashar dua rakaat karena Allah Ta‘ālā.",
    dalil: "",
    keterangan:
        "Dikerjakan sebelum shalat Ashar. Dapat dikerjakan dua atau empat rakaat.",
  ),
  DoaModel(
    judul: "Niat Shalat Sunnah Ba'diyah Maghrib",
    kategori: ["Sholat"],
    arab:
        "أُصَلِّي سُنَّةَ الْمَغْرِبِ بَعْدِيَّةً رَكْعَتَيْنِ لِلَّهِ تَعَالَى",
    latin: "Ushallī sunnatal-maghribi ba‘diyyatan rak‘ataini lillāhi ta‘ālā.",
    arti:
        "Aku berniat shalat sunnah ba'diyah Maghrib dua rakaat karena Allah Ta‘ālā.",
    dalil: "",
    keterangan: "Dikerjakan setelah shalat Maghrib sebanyak dua rakaat.",
  ),
  DoaModel(
    judul: "Niat Shalat Sunnah Awwabin",
    kategori: ["Sholat"],
    arab:
        "نَوَيْتُ صَلَاةَ سُنَّةِ الْأَوَّابِينَ رَكْعَتَيْنِ لِلَّهِ تَعَالَى",
    latin: "Nawaitu ṣalāta sunnatil-awwābīna rak‘ataini lillāhi ta‘ālā.",
    arti: "Aku niat shalat sunnah Awwabin dua rakaat karena Allah Ta‘ālā.",
    dalil: "",
    keterangan: "Shalat sunnah Awwabin dikerjakan setelah shalat Maghrib.",
  ),
  DoaModel(
    judul: "Niat Shalat Sunnah Ba'diyah Isya",
    kategori: ["Sholat"],
    arab:
        "أُصَلِّي سُنَّةَ الْعِشَاءِ بَعْدِيَّةً رَكْعَتَيْنِ لِلَّهِ تَعَالَى",
    latin: "Ushallī sunnatal-‘isyā’i ba‘diyyatan rak‘ataini lillāhi ta‘ālā.",
    arti:
        "Aku berniat shalat sunnah ba'diyah Isya dua rakaat karena Allah Ta‘ālā.",
    dalil: "",
    keterangan: "Dikerjakan setelah shalat Isya sebanyak dua rakaat.",
  ),
  DoaModel(
    judul: "Niat Shalat Sunnah Witir",
    kategori: ["Sholat"],
    arab: "أُصَلِّي سُنَّةَ الْوِتْرِ رَكْعَةً لِلَّهِ تَعَالَى",
    latin: "Ushallī sunnatal-witri rak‘atan lillāhi ta‘ālā.",
    arti: "Aku berniat shalat sunnah Witir satu rakaat karena Allah Ta‘ālā.",
    dalil: "",
    keterangan:
        "Shalat Witir dikerjakan dengan jumlah rakaat ganjil. Niat disesuaikan dengan jumlah rakaat yang dikerjakan.",
  ),
  DoaModel(
    judul: "Niat Shalat Istisqa",
    kategori: ["Sholat", "Doa-Doa"],
    arab:
        "أُصَلِّي سُنَّةَ الاِسْتِسْقَاءِ رَكْعَتَيْنِ مُسْتَقْبِلَ الْكَعْبَةِ لِلَّهِ تَعَالَى\n\n"
        "Bacaan Istighfar:\n"
        "أَسْتَغْفِرُ اللَّهَ الْعَظِيمَ الَّذِي لاَ إِلَهَ إِلاَّ هُوَ الْحَيُّ الْقَيُّومُ وَأَتُوبُ إِلَيْهِ\n\n"
        "Istighfar Khutbah:\n"
        "أَسْتَغْفِرُ اللَّهَ الْعَظِيمَ إِنَّكَ كُنْتَ غَفَّارًا فَأَرْسِلِ السَّمَاءَ عَلَيْنَا مِدْرَارًا، وَأَمْدِدْنَا بِأَمْوَالٍ وَبَنِينَ وَاجْعَلْ لَنَا جَنَّاتٍ وَاجْعَلْ لَنَا أَنْهَارًا",
    latin:
        "Ushallī sunnatal-istisqā'i rak'ataini mustaqbilal-ka'bati lillāhi ta'ālā.\n\n"
        "Bacaan Istighfar:\n"
        "Astaghfirullāhal-'azhīmalladzī lā ilāha illā huwal-hayyul-qayyūmu wa atūbu ilaih.\n\n"
        "Istighfar Khutbah:\n"
        "Astaghfirullāhal-'azhīma innaka kunta ghaffāran, fa-arsilis-samā'a 'alainā midrāran, wa amdidnā bi-amwāliw wa banīna waj'al lanā jannātiw waj'al lanā anhāran.",
    arti:
        "Aku berniat shalat sunnah Istisqa dua rakaat menghadap Ka'bah karena Allah Ta'ala.\n\n"
        "Bacaan Istighfar:\n"
        "Aku memohon ampun kepada Allah Yang Maha Agung, tidak ada tuhan selain Dia Yang Maha Hidup lagi terus-menerus mengurus makhluk-Nya, dan aku bertobat kepada-Nya.\n\n"
        "Istighfar Khutbah:\n"
        "Aku memohon ampun kepada Allah Yang Maha Agung, sesungguhnya Engkau Maha Pengampun, maka turunkanlah hujan dari langit kepada kami dengan lebat, dan perbanyaklah harta serta anak-anak kami, dan jadikanlah untuk kami kebun-kebun serta jadikanlah untuk kami sungai-sungai.",
    dalil: "",
    keterangan:
        "Setelah doa iftitah, sebelum membaca Al-Fatihah pada rakaat pertama membaca istighfar 7 kali. "
        "Pada rakaat kedua membaca istighfar 5 kali. Bacaan selanjutnya seperti shalat biasa.\n\n"
        "Setelah shalat dilanjutkan dengan khutbah seperti khutbah hari raya. "
        "Bacaan takbir 9 kali pada khutbah pertama dan 7 kali pada khutbah kedua diganti dengan istighfar.",
  ),
  DoaModel(
    judul: "Niat Shalat Gerhana Matahari (Kusuf)",
    kategori: ["Sholat", "Doa-Doa"],
    arab:
        "أُصَلِّي سُنَّةَ الْكُسُوفِ الشَّمْسِ رَكْعَتَيْنِ مُسْتَقْبِلَ الْكَعْبَةِ لِلَّهِ تَعَالَى",
    latin:
        "Ushallī sunnatal-kusūfisy-syamsi rak'ataini mustaqbilal-ka'bati lillāhi ta'ālā.",
    arti:
        "Aku berniat shalat sunnah gerhana matahari dua rakaat menghadap Ka'bah karena Allah Ta'ala.",
    dalil: "",
    keterangan:
        "Setiap rakaat membaca Al-Fatihah dua kali, melakukan rukuk dua kali, kemudian sujud. "
        "Setelah rukuk pertama, berdiri i'tidal kemudian membaca Al-Fatihah lagi dan melakukan rukuk kedua, setelah itu sujud. "
        "Setelah shalat dilanjutkan dengan khutbah.",
  ),
  DoaModel(
    judul: "Niat Shalat Gerhana Bulan (Khusuf)",
    kategori: ["Sholat", "Doa-Doa"],
    arab:
        "أُصَلِّي سُنَّةَ الْخُسُوفِ الْقَمَرِ رَكْعَتَيْنِ مُسْتَقْبِلَ الْكَعْبَةِ لِلَّهِ تَعَالَى",
    latin:
        "Ushallī sunnatal-khusūfil-qamari rak'ataini mustaqbilal-ka'bati lillāhi ta'ālā.",
    arti:
        "Aku berniat shalat sunnah gerhana bulan dua rakaat menghadap Ka'bah karena Allah Ta'ala.",
    dalil: "",
    keterangan: "Cara shalat sama seperti shalat gerhana matahari. "
        "Setiap rakaat membaca Al-Fatihah dua kali, melakukan rukuk dua kali, kemudian sujud. "
        "Setelah rukuk pertama, berdiri i'tidal kemudian membaca Al-Fatihah lagi dan melakukan rukuk kedua, setelah itu sujud. "
        "Setelah shalat dilanjutkan dengan khutbah.\n\n"
        "Bacaan surat yang digunakan: rakaat pertama setelah Al-Fatihah membaca Surah Asy-Syams, "
        "dan rakaat kedua setelah Al-Fatihah membaca Surah Ad-Duha.",
  ),
  DoaModel(
    judul: "Niat Sholat Awwabin",
    kategori: ["Sholat", "Doa-Doa"],
    arab:
        "نَوَيْتُ صَلَاةَ سُنَّةِ الْأَوَّابِينَ رَكْعَتَيْنِ لِلّٰهِ تَعَالَى",
    latin: "Nawaitu ṣalāta sunnatil-awwābīna rak‘ataini lillāhi ta‘ālā.",
    arti: "Aku niat shalat sunnah Awwabin dua rakaat karena Allah Ta‘ālā.",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: "Niat Qosor Sholat Dzuhur",
    kategori: ["Sholat"],
    arab:
        "أُصَلِّي فَرْضَ الظُّهْرِ رَكْعَتَيْنِ قَصْرًا مُسْتَقْبِلَ الْقِبْلَةِ أَدَاءً لِلَّهِ تَعَالَى",
    latin:
        "Ushallī fardhazh-zhuhri rak‘ataini qashran mustaqbilal-qiblati adā’an lillāhi ta‘ālā.",
    arti:
        "Aku niat shalat fardu Dzuhur dua rakaat dengan qashar, menghadap kiblat, karena Allah Ta'ala.",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: "Niat Qosor Sholat Ashar",
    kategori: ["Sholat"],
    arab:
        "أُصَلِّي فَرْضَ الْعَصْرِ رَكْعَتَيْنِ قَصْرًا مُسْتَقْبِلَ الْقِبْلَةِ أَدَاءً لِلَّهِ تَعَالَى",
    latin:
        "Ushallī fardhal-‘ashri rak‘ataini qashran mustaqbilal-qiblati adā’an lillāhi ta‘ālā.",
    arti:
        "Aku niat shalat fardu Asar dua rakaat dengan qashar, menghadap kiblat, karena Allah Ta'ala.",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: "Niat Jama Taqdim Sholat Dzuhur",
    kategori: ["Sholat"],
    arab:
        "أُصَلِّي فَرْضَ الظُّهْرِ أَرْبَعَ رَكَعَاتٍ مَجْمُوعًا بِالْعَصْرِ جَمْعَ تَقْدِيمًا مُسْتَقْبِلَ الْقِبْلَةِ لِلَّهِ تَعَالَى",
    latin:
        "Ushallī fardhazh-zhuhri arba‘a raka‘ātin majmū‘an bil-‘ashri jam‘a taqdīmin mustaqbilal-qiblati lillāhi ta‘ālā.",
    arti:
        "Aku niat shalat fardu Zuhur empat rakaat, dijamak dengan Asar secara jamak taqdim, menghadap kiblat, karena Allah Ta'ala.",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: "Niat Jama Taqdim Sholat Ashar",
    kategori: ["Sholat"],
    arab:
        "أُصَلِّي فَرْضَ الْعَصْرِ أَرْبَعَ رَكَعَاتٍ مَجْمُوعًا إِلَيْهِ الظُّهْرُ جَمْعَ تَقْدِيمًا مُسْتَقْبِلَ الْقِبْلَةِ لِلَّهِ تَعَالَى",
    latin:
        "Ushallī fardhal-‘ashri arba‘a raka‘ātin majmū‘an ilaihi zh-zhuhru jam‘a taqdīmin mustaqbilal-qiblati lillāhi ta‘ālā.",
    arti:
        "Aku niat shalat fardu Asar empat rakaat, dijamak dengan Zuhur secara jamak taqdim, menghadap kiblat, karena Allah Ta'ala.",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: "Niat Jama Taqdim Sholat Maghrib",
    kategori: ["Sholat"],
    arab:
        "أُصَلِّي فَرْضَ الْمَغْرِبِ ثَلَاثَ رَكَعَاتٍ مَجْمُوعًا بِالْعِشَاءِ جَمْعَ تَقْدِيمًا مُسْتَقْبِلَ الْقِبْلَةِ لِلَّهِ تَعَالَى",
    latin:
        "Ushallī fardhal-maghribi tsalātsa raka‘ātin majmū‘an bil-‘isyā’i jam‘a taqdīmin mustaqbilal-qiblati lillāhi ta‘ālā.",
    arti:
        "Aku niat shalat fardu Maghrib tiga rakaat, dijamak dengan Isya secara jamak taqdim, menghadap kiblat, karena Allah Ta'ala.",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: "Niat Jama Taqdim Sholat Isya",
    kategori: ["Sholat"],
    arab:
        "أُصَلِّي فَرْضَ الْعِشَاءِ أَرْبَعَ رَكَعَاتٍ مَجْمُوعًا إِلَيْهِ الْمَغْرِبُ جَمْعَ تَقْدِيمًا مُسْتَقْبِلَ الْقِبْلَةِ لِلَّهِ تَعَالَى",
    latin:
        "Ushallī fardhal-‘isyā’i arba‘a raka‘ātin majmū‘an ilaihil-maghribu jam‘a taqdīmin mustaqbilal-qiblati lillāhi ta‘ālā.",
    arti:
        "Aku niat shalat fardu Isya empat rakaat, dijamak dengan Maghrib secara jamak taqdim, menghadap kiblat, karena Allah Ta'ala.",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: "Niat Jama Takhir sholat Dzuhur Ke Sholat Ashar",
    kategori: ["Sholat"],
    arab: "نَوَيْتُ تَأْخِيرَ الظُّهْرِ إِلَى الْعَصْرِ",
    latin: "Nawaitu ta’khīrazh-zhuhri ilal-‘ashri.",
    arti: "Aku berniat mengakhirkan shalat Zuhur ke waktu Asar.",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: "Niat Jama Takhir Sholat Maghrib Ke Sholat Isya",
    kategori: ["Sholat"],
    arab: "نَوَيْتُ تَأْخِيرَ الْمَغْرِبِ إِلَى الْعِشَاءِ",
    latin: "Nawaitu ta’khīral-maghribi ilal-‘isyā’i.",
    arti: "Aku berniat mengakhirkan shalat Maghrib ke waktu Isya.",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: "Niat Jama Takhir Sholat dzuhur",
    kategori: ["Sholat"],
    arab:
        "أُصَلِّي فَرْضَ الظُّهْرِ أَرْبَعَ رَكَعَاتٍ مَجْمُوعًا إِلَيْهِ الْعَصْرِ جَمْعَ تَأْخِيرٍ مُسْتَقْبِلَ الْقِبْلَةِ لِلَّهِ تَعَالَى",
    latin:
        "Ushallī fardhazh-zhuhri arba‘a raka‘ātin majmū‘an ilaihil-‘ashri jam‘a ta’khīrin mustaqbilal-qiblati lillāhi ta‘ālā.",
    arti:
        "Aku niat shalat fardu Zuhur empat rakaat, dijamak dengan Asar secara jamak takhir, menghadap kiblat, karena Allah Ta'ala.",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: "Niat Jama Takhir Sholat Ashar",
    kategori: ["Sholat"],
    arab:
        "أُصَلِّي فَرْضَ الْعَصْرِ أَرْبَعَ رَكَعَاتٍ مَجْمُوعًا بِالظُّهْرِ جَمْعَ تَأْخِيرٍ مُسْتَقْبِلَ الْقِبْلَةِ لِلَّهِ تَعَالَى",
    latin:
        "Ushallī fardhal-‘ashri arba‘a raka‘ātin majmū‘an bizh-zhuhri jam‘a ta’khīrin mustaqbilal-qiblati lillāhi ta‘ālā.",
    arti:
        "Aku niat shalat fardu Asar empat rakaat, dijamak dengan Zuhur secara jamak takhir, menghadap kiblat, karena Allah Ta'ala.",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: "Niat Jama Takhir Sholat Maghrib",
    kategori: ["Sholat"],
    arab:
        "أُصَلِّي فَرْضَ الْمَغْرِبِ ثَلَاثَ رَكَعَاتٍ مَجْمُوعًا إِلَيْهِ الْعِشَاءِ جَمْعَ تَأْخِيرٍ مُسْتَقْبِلَ الْقِبْلَةِ لِلَّهِ تَعَالَى",
    latin:
        "Ushallī fardhal-maghribi tsalātsa raka‘ātin majmū‘an ilaihil-‘isyā’u jam‘a ta’khīrin mustaqbilal-qiblati lillāhi ta‘ālā.",
    arti:
        "Aku niat shalat fardu Maghrib tiga rakaat, dijamak dengan Isya secara jamak takhir, menghadap kiblat, karena Allah Ta'ala.",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: "Niat Jama Takhir Sholat Isya",
    kategori: ["Sholat"],
    arab:
        "أُصَلِّي فَرْضَ الْعِشَاءِ أَرْبَعَ رَكَعَاتٍ مَجْمُوعًا بِالْمَغْرِبِ جَمْعَ تَأْخِيرٍ مُسْتَقْبِلَ الْقِبْلَةِ لِلَّهِ تَعَالَى",
    latin:
        "Ushallī fardhal-‘isyā’i arba‘a raka‘ātin majmū‘an bil-maghribi jam‘a ta’khīrin mustaqbilal-qiblati lillāhi ta‘ālā.",
    arti:
        "Aku niat shalat fardu Isya empat rakaat, dijamak dengan Maghrib secara jamak takhir, menghadap kiblat, karena Allah Ta'ala.",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: "Niat Jama Taqdim Qosor Dzuhur",
    kategori: ["Sholat"],
    arab:
        "أُصَلِّي فَرْضَ الظُّهْرِ مَجْمُوعًا بِالْعَصْرِ جَمْعَ تَقْدِيمٍ مَقْصُورًا رَكْعَتَيْنِ مُسْتَقْبِلَ الْقِبْلَةِ لِلَّهِ تَعَالَى",
    latin:
        "Ushallī fardhazh-zhuhri majmū‘an bil-‘ashri jam‘a taqdīmin maqṣūran raka‘ataini mustaqbilal-qiblati lillāhi ta‘ālā.",
    arti:
        "Aku niat shalat fardu Zuhur yang dijamak dengan Asar secara jamak taqdim dan diqashar menjadi dua rakaat, menghadap kiblat, karena Allah Ta'ala.",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: "Niat Jama Taqdim Qosor Ashar",
    kategori: ["Sholat"],
    arab:
        "أُصَلِّي فَرْضَ الْعَصْرِ مَجْمُوعًا إِلَيْهِ الظُّهْرُ جَمْعَ تَقْدِيمٍ مَقْصُورًا رَكْعَتَيْنِ مُسْتَقْبِلَ الْقِبْلَةِ لِلَّهِ تَعَالَى",
    latin:
        "Ushallī fardhal-‘ashri majmū‘an ilaihi zh-zhuhru jam‘a taqdīmin maqṣūran raka‘ataini mustaqbilal-qiblati lillāhi ta‘ālā.",
    arti:
        "Aku niat shalat fardu Asar yang dijamak dengan Zuhur secara jamak taqdim dan diqashar menjadi dua rakaat, menghadap kiblat, karena Allah Ta'ala.",
    dalil: "",
    keterangan: "",
  ),
  DoaModel(
    judul: "Niat Jama Taqdim Qosor Isya",
    kategori: ["Sholat"],
    arab:
        "أُصَلِّي فَرْضَ الْعِشَاءِ مَجْمُوعًا بِالْمَغْرِبِ جَمْعَ تَأْخِيرٍ مَقْصُورًا رَكْعَتَيْنِ مُسْتَقْبِلَ الْقِبْلَةِ لِلَّهِ تَعَالَى",
    latin:
        "Ushallī fardhal-‘isyā’i majmū‘an bil-maghribi jam‘a ta’khīrin maqṣūran raka‘ataini mustaqbilal-qiblati lillāhi ta‘ālā.",
    arti:
        "Aku niat shalat fardu Isya yang dijamak dengan Maghrib secara jamak takhir dan diqashar menjadi dua rakaat, menghadap kiblat, karena Allah Ta'ala.",
    dalil: "",
    keterangan: "",
  ),
  // DoaModel(
  //   judul: "",
  //   kategori: ["Wudhu"],
  //   arab: "",
  //   latin: "",
  //   arti: "",
  //   dalil: "",
  //   keterangan: "",
  // ),
];
