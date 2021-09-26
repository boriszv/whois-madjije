const hardcodedDomains = [
  '.rs',
  '.срб',
  '.ru',
  '.рф',
  '.mk',
  '.мкд',
  '.org',
  '.орг',
  '.ком',
  '.uk',
  '.se',
  '.io',
  '.gov',

  ".com",
  ".net",
  ".biz",
  ".info",
  ".ac",
  ".academy",
  ".accountant",
  ".accountants",
  ".actor",
  ".adult",
  ".ae",
  ".ae.org",
  ".ag",
  ".agency",
  ".ai",
  ".airforce",
  ".al",
  ".alsace",
  ".am",
  ".amsterdam",
  ".apartments",
  ".archi",
  ".army",
  ".art",
  ".associates",
  ".at",
  ".auction",
  ".ba",
  ".band",
  ".bar",
  ".barcelona",
  ".bargains",
  ".bayern",
  ".be",
  ".beer",
  ".berlin",
  ".best",
  ".bet",
  ".bid",
  ".bike",
  ".bingo",
  ".bio",
  ".black",
  ".blog",
  ".blue",
  ".boutique",
  ".br.com",
  ".brussels",
  ".build",
  ".builders",
  ".business",
  ".buzz",
  ".bz",
  ".bzh",
  ".cab",
  ".cafe",
  ".camera",
  ".camp",
  ".capetown",
  ".capital",
  ".cards",
  ".care",
  ".careers",
  ".casa",
  ".cash",
  ".casino",
  ".catering",
  ".cc",
  ".center",
  ".ceo",
  ".ch",
  ".chat",
  ".cheap",
  ".christmas",
  ".church",
  ".city",
  ".cl",
  ".claims",
  ".cleaning",
  ".click",
  ".clinic",
  ".clothing",
  ".cloud",
  ".club",
  ".cm",
  ".cn",
  ".cn.com",
  ".co",
  ".co.at",
  ".co.nl",
  ".co.no",
  ".co.uk",
  ".co.za",
  ".coach",
  ".codes",
  ".coffee",
  ".college",
  ".cologne",
  ".com.br",
  ".com.cn",
  ".com.gr",
  ".com.hr",
  ".com.mx",
  ".com.pe",
  ".com.pl",
  ".com.pt",
  ".com.ua",
  ".community",
  ".company",
  ".computer",
  ".condos",
  ".construction",
  ".consulting",
  ".contractors",
  ".cooking",
  ".cool",
  ".country",
  ".coupons",
  ".courses",
  ".credit",
  ".creditcard",
  ".cricket",
  ".cruises",
  ".cx",
  ".cymru",
  ".cz",
  ".dance",
  ".date",
  ".dating",
  ".de",
  ".de.com",
  ".deals",
  ".degree",
  ".delivery",
  ".democrat",
  ".dental",
  ".desi",
  ".design",
  ".dev",
  ".diamonds",
  ".digital",
  ".direct",
  ".directory",
  ".discount",
  ".dk",
  ".dog",
  ".domains",
  ".download",
  ".durban",
  ".earth",
  ".education",
  ".email",
  ".energy",
  ".engineer",
  ".engineering",
  ".enterprises",
  ".es",
  ".estate",
  ".eu",
  ".eu.com",
  ".events",
  ".exchange",
  ".expert",
  ".exposed",
  ".express",
  ".fail",
  ".faith",
  ".family",
  ".fans",
  ".farm",
  ".fashion",
  ".fi",
  ".film",
  ".finance",
  ".financial",
  ".fish",
  ".fishing",
  ".fit",
  ".fitness",
  ".flights",
  ".florist",
  ".fm",
  ".football",
  ".forsale",
  ".foundation",
  ".fr",
  ".frl",
  ".fun",
  ".fund",
  ".furniture",
  ".futbol",
  ".fyi",
  ".gallery",
  ".game",
  ".games",
  ".garden",
  ".gb.net",
  ".gift",
  ".gifts",
  ".gives",
  ".glass",
  ".global",
  ".gmbh",
  ".gold",
  ".golf",
  ".gr",
  ".graphics",
  ".gratis",
  ".green",
  ".gripe",
  ".group",
  ".gs",
  ".guide",
  ".guru",
  ".hamburg",
  ".haus",
  ".healthcare",
  ".help",
  ".hn",
  ".hockey",
  ".holdings",
  ".holiday",
  ".horse",
  ".hospital",
  ".host",
  ".house",
  ".how",
  ".ht",
  ".hu",
  ".im",
  ".immo",
  ".immobilien",
  ".in",
  ".industries",
  ".ink",
  ".institute",
  ".insure",
  ".international",
  ".investments",
  ".irish",
  ".is",
  ".ist",
  ".istanbul",
  ".it",
  ".jetzt",
  ".jewelry",
  ".joburg",
  ".jp",
  ".jpn.com",
  ".kaufen",
  ".kim",
  ".kitchen",
  ".kiwi",
  ".koeln",
  ".la",
  ".land",
  ".lc",
  ".lease",
  ".legal",
  ".lgbt",
  ".li",
  ".life",
  ".lighting",
  ".limited",
  ".limo",
  ".link",
  ".live",
  ".loan",
  ".loans",
  ".lol",
  ".london",
  ".love",
  ".ltd",
  ".ltda",
  ".lu",
  ".maison",
  ".management",
  ".market",
  ".marketing",
  ".mba",
  ".me",
  ".media",
  ".melbourne",
  ".memorial",
  ".men",
  ".menu",
  ".miami",
  ".mn",
  ".mobi",
  ".moda",
  ".mom",
  ".money",
  ".mortgage",
  ".movie",
  ".ms",
  ".mu",
  ".mx",
  ".nagoya",
  ".name",
  ".navy",
  ".network",
  ".news",
  ".ngo",
  ".ninja",
  ".nl",
  ".nrw",
  ".nu",
  ".nyc",
  ".one",
  ".online",
  ".or.at",
  ".org.uk",
  ".paris",
  ".partners",
  ".parts",
  ".party",
  ".pe",
  ".pet",
  ".photo",
  ".photography",
  ".photos",
  ".physio",
  ".pics",
  ".pictures",
  ".pink",
  ".pizza",
  ".pl",
  ".place",
  ".plumbing",
  ".plus",
  ".poker",
  ".porn",
  ".press",
  ".pro",
  ".productions",
  ".promo",
  ".properties",
  ".pt",
  ".pub",
  ".pw",
  ".quebec",
  ".racing",
  ".recipes",
  ".red",
  ".rehab",
  ".reise",
  ".reisen",
  ".rent",
  ".rentals",
  ".repair",
  ".report",
  ".rest",
  ".restaurant",
  ".review",
  ".reviews",
  ".rip",
  ".ro",
  ".rocks",
  ".rodeo",
  ".ru.com",
  ".ruhr",
  ".run",
  ".sa.com",
  ".saarland",
  ".sale",
  ".salon",
  ".sarl",
  ".sc",
  ".school",
  ".schule",
  ".science",
  ".scot",
  ".se.net",
  ".services",
  ".sex",
  ".sexy",
  ".sh",
  ".shoes",
  ".shop",
  ".show",
  ".si",
  ".singles",
  ".site",
  ".sk",
  ".ski",
  ".soccer",
  ".social",
  ".software",
  ".solar",
  ".solutions",
  ".soy",
  ".space",
  ".st",
  ".store",
  ".stream",
  ".studio",
  ".study",
  ".style",
  ".sucks",
  ".supplies",
  ".supply",
  ".support",
  ".surf",
  ".surgery",
  ".sydney",
  ".systems",
  ".tattoo",
  ".tax",
  ".taxi",
  ".team",
  ".tech",
  ".technology",
  ".tennis",
  ".theater",
  ".tienda",
  ".tips",
  ".tires",
  ".tirol",
  ".tk",
  ".to",
  ".today",
  ".tokyo",
  ".tools",
  ".top",
  ".tours",
  ".town",
  ".toys",
  ".trade",
  ".training",
  ".tv",
  ".tw",
  ".uk.com",
  ".uk.net",
  ".university",
  ".uno",
  ".us",
  ".us.com",
  ".vacations",
  ".vc",
  ".vegas",
  ".ventures",
  ".vet",
  ".viajes",
  ".video",
  ".villas",
  ".vin",
  ".vip",
  ".vision",
  ".vodka",
  ".vote",
  ".voyage",
  ".wales",
  ".watch",
  ".webcam",
  ".website",
  ".wedding",
  ".wien",
  ".wiki",
  ".win",
  ".wine",
  ".work",
  ".works",
  ".world",
  ".ws",
  ".wtf",
  ".xxx",
  ".xyz",
  ".yoga",
  ".yokohama",
  ".za.com",
  ".zone",
];