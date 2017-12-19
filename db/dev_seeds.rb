require 'database_cleaner'
DatabaseCleaner.clean_with :truncation
@logger = Logger.new(STDOUT)
@logger.formatter = proc { |_severity, _datetime, _progname, msg| msg }

def section(section_title)
  @logger.info section_title
  yield
  log(' ✅')
end

def log(msg)
  @logger.info "#{msg}\n"
end

section "Creating Settings" do
  Setting.create(key: 'official_level_1_name', value: 'Empleados públicos')
  Setting.create(key: 'official_level_2_name', value: 'Gerente Regional')
  Setting.create(key: 'official_level_3_name', value: 'Gerente General')
  Setting.create(key: 'official_level_4_name', value: 'Consejeros Regionales')
  Setting.create(key: 'official_level_5_name', value: 'Gobernador')
  Setting.create(key: 'max_ratio_anon_votes_on_debates', value: '50')
  Setting.create(key: 'max_votes_for_debate_edit', value: '1000')
  Setting.create(key: 'max_votes_for_proposal_edit', value: '1000')
  Setting.create(key: 'proposal_code_prefix', value: 'LIB')
  Setting.create(key: 'votes_for_proposal_success', value: '100')
  Setting.create(key: 'months_to_archive_proposals', value: '12')
  Setting.create(key: 'comments_body_max_length', value: '1000')

  Setting.create(key: 'twitter_handle', value: '@GRLaLibertad')
  Setting.create(key: 'twitter_hashtag', value: '#DecideLaLibertad')
  Setting.create(key: 'facebook_handle', value: 'GRLaLibertad')
  Setting.create(key: 'youtube_handle', value: 'channel/UC0IcCo7kPbktO-rply0HtJQ')
  Setting.create(key: 'telegram_handle', value: '')
  Setting.create(key: 'instagram_handle', value: 'grlalibertad')
  Setting.create(key: 'blog_url', value: '')
  Setting.create(key: 'url', value: 'http://decidelalibertad.pe/')
  Setting.create(key: 'org_name', value: 'Decide La Libertad')
  Setting.create(key: 'place_name', value: 'Trujillo')
  Setting.create(key: 'feature.debates', value: "true")
  Setting.create(key: 'feature.proposals', value: "true")
  Setting.create(key: 'feature.polls', value: "true")
  Setting.create(key: 'feature.spending_proposals', value: nil)
  Setting.create(key: 'feature.spending_proposal_features.voting_allowed', value: nil)
  Setting.create(key: 'feature.budgets', value: "true")
  Setting.create(key: 'feature.twitter_login', value: "")
  Setting.create(key: 'feature.facebook_login', value: "")
  Setting.create(key: 'feature.google_login', value: "")
  Setting.create(key: 'feature.signature_sheets', value: "true")
  Setting.create(key: 'feature.legislation', value: "true")
  Setting.create(key: 'feature.user.recommendations', value: "true")
  Setting.create(key: 'feature.community', value: "true")
  Setting.create(key: 'feature.map', value: "true")
  Setting.create(key: 'feature.allow_images', value: "true")
  Setting.create(key: 'feature.public_stats', value: "true")
  Setting.create(key: 'per_page_code_head', value: "")
  Setting.create(key: 'per_page_code_body', value: "")
  Setting.create(key: 'comments_body_max_length', value: '1000')
  Setting.create(key: 'mailer_from_name', value: 'Decide La Libertad')
  Setting.create(key: 'mailer_from_address', value: 'decide@regionlalibertad.gob.pe')
  Setting.create(key: 'meta_description', value: 'Citizen Participation and Open Government Application')
  Setting.create(key: 'meta_keywords', value: 'citizen participation, open government')
  Setting.create(key: 'verification_offices_url', value: 'http://oficinas-atencion-ciudadano.url/')
  Setting.create(key: 'min_age_to_participate', value: '18')
  Setting.create(key: 'proposal_improvement_path', value: nil)
  Setting.create(key: 'map_latitude', value: -8.112595421768354)
  Setting.create(key: 'map_longitude', value: -79.02875661849977)
  Setting.create(key: 'map_zoom', value: 12)
  Setting.create(key: 'related_contents_report_threshold', value: 2)
end

section "Creating Geozones" do
  geo = Geozone.create(name: "Trujillo", html_map_coordinates: "172,205,174,206,179,206,180,209,181,212,184,213,187,215,186,221,175,226,171,228,169,231,161,232,159,235,160,245,158,248,150,254,143,256,140,252,138,249,135,246,133,239,132,234,118,220,114,219,108,214,106,213,101,202,99,201,90,193,87,192,90,186,95,184,98,180,99,182,103,183,106,187,114,188,115,186,118,185,122,183,124,175,127,173,133,172,138,170,140,168,142,161,146,160,153,154,158,154,160,154,160,158,162,160,161,165,161,168,164,169,168,171,169,175,173,177,176,179,170,186,169,191,173,196")
  Geozone.create(name: "Víctor Larco", geozone_id: geo.id)
  Geozone.create(name: "El Porvenir", geozone_id: geo.id)
  Geozone.create(name: "La Esperanza", geozone_id: geo.id)
  Geozone.create(name: "Huanchaco", geozone_id: geo.id)
  Geozone.create(name: "Florencia de Mora", geozone_id: geo.id)
  Geozone.create(name: "Laredo", geozone_id: geo.id)
  Geozone.create(name: "Moche", geozone_id: geo.id)
  Geozone.create(name: "Salaverry", geozone_id: geo.id)
  Geozone.create(name: "Simbal", geozone_id: geo.id)
  Geozone.create(name: "Poroto", geozone_id: geo.id)
  Geozone.create(name: "Trujillo", geozone_id: geo.id)
  geo = Geozone.create(name: "Santiago de Chuco", html_map_coordinates: "298,229,301,228,311,227,312,223,312,220,314,215,316,209,319,201,324,201,329,204,334,201,340,203,344,204,348,203,352,201,357,200,364,199,362,196,362,191,361,185,359,185,356,183,354,181,350,180,348,183,341,189,337,190,332,186,329,185,324,186,320,188,313,186,308,185,305,189,298,184,297,180,296,177,294,173,290,173,287,174,285,175,285,178,282,178,279,179,276,178,272,177,270,175,267,175,265,172,261,171,259,170,257,168,254,167,252,168,249,168,245,169,243,173,239,177,232,180,228,187,230,189,232,192,235,191,238,194,241,197,244,198,247,200,247,208,245,212,244,215,247,219,248,222,250,227,247,231,244,233,242,233,240,237,236,240,234,241,232,240,229,241,228,244,226,248,225,251,225,254,226,257,229,261,231,264,231,268,234,269,237,270,240,274,243,279,245,280,249,284,251,288,253,292,254,295,258,298,258,301,260,304,263,300,266,297,267,292,265,289,269,285,272,280,274,277,276,274,275,268,278,266,277,260,278,255,281,253,282,248,283,245,284,243,286,240,288,236,293,235,296,233")
  Geozone.create(name: "Santa Cruz de Chuca", geozone_id: geo.id)
  Geozone.create(name: "Quiruvilca", geozone_id: geo.id)
  Geozone.create(name: "Cachicadán", geozone_id: geo.id)
  Geozone.create(name: "Angasmarca", geozone_id: geo.id)
  Geozone.create(name: "Sitabamba", geozone_id: geo.id)
  Geozone.create(name: "Mollepata", geozone_id: geo.id)
  Geozone.create(name: "Mollebamba", geozone_id: geo.id)
  Geozone.create(name: "Santiago de Chuco", geozone_id: geo.id)
  geo = Geozone.create(name: "Virú", html_map_coordinates: "143,256,148,254,156,250,159,246,160,243,161,237,159,235,161,232,167,232,170,230,174,227,185,222,189,226,194,230,195,236,197,240,198,244,205,246,212,248,216,250,224,251,225,256,229,261,231,268,237,271,241,276,243,279,245,279,249,283,251,289,253,294,258,299,259,304,253,306,246,308,240,309,235,311,232,313,231,317,227,318,224,319,219,320,219,322,215,324,212,326,208,327,206,333,203,335,199,338,198,343,199,347,199,353,198,357,196,360,191,360,190,358,188,352,186,349,184,347,181,343,179,339,176,336,174,335,173,331,171,329,168,326,168,318,171,316,171,309,171,303,170,299,167,295,165,290,162,290,160,287,160,285,153,281,152,279,149,277,145,275,143,275,141,273,140,271,139,269,138,265,142,262,143,259")
  Geozone.create(name: "Chao", geozone_id: geo.id)
  Geozone.create(name: "Guadalupito", geozone_id: geo.id)
  Geozone.create(name: "Virú", geozone_id: geo.id)
  geo = Geozone.create(name: "Sánchez Carrión", html_map_coordinates: "305,189,306,187,308,184,312,186,317,188,321,187,325,185,332,186,335,189,340,189,348,183,350,180,354,182,357,184,361,185,363,183,363,180,364,163,363,161,363,159,361,152,360,148,358,146,359,130,357,127,356,125,354,122,354,119,352,117,350,116,350,113,349,110,347,106,345,102,344,100,345,96,341,97,337,99,331,100,327,102,323,103,323,106,321,109,322,112,319,116,315,116,313,118,312,121,311,124,309,125,309,128,305,128,304,131,299,131,296,133,287,133,285,134,282,132,280,129,276,130,274,133,271,137,266,140,264,141,261,141,260,139,259,143,257,144,254,145,253,148,251,152,255,159,255,167,258,171,261,169,263,172,267,175,271,175,275,178,279,179,282,177,284,177,285,175,288,172,291,172,294,173,296,177,297,180,298,183")
  Geozone.create(name: "Huamachuco", geozone_id: geo.id)
  Geozone.create(name: "Chugay", geozone_id: geo.id)
  Geozone.create(name: "Marcabal", geozone_id: geo.id)
  Geozone.create(name: "Sanagorán", geozone_id: geo.id)
  Geozone.create(name: "Sartimbamba", geozone_id: geo.id)
  Geozone.create(name: "Sarín", geozone_id: geo.id)
  Geozone.create(name: "Cochorco", geozone_id: geo.id)
  Geozone.create(name: "Curgos", geozone_id: geo.id)
  geo = Geozone.create(name: "Pataz", html_map_coordinates: "413,199,426,200,431,196,432,193,447,192,451,194,455,194,462,192,466,194,471,195,475,196,478,199,481,202,483,205,488,210,492,212,494,214,494,217,495,220,494,222,495,225,498,228,498,231,499,235,496,237,494,242,494,246,491,248,488,253,484,256,480,255,476,256,474,255,467,256,464,257,459,263,455,265,453,265,452,268,449,268,447,270,446,273,430,274,427,277,425,281,422,284,419,282,417,280,414,278,411,278,409,276,406,273,405,270,404,266,402,263,400,262,400,257,398,254,397,250,396,247,393,244,392,241,390,238,385,236,384,233,379,232,376,230,376,225,375,220,373,220,370,219,370,215,366,213,366,211,366,207,366,201,364,199,362,197,361,186,363,182,364,179,364,163,363,161,363,157,361,153,360,148,359,146,359,131,356,127,356,124,354,122,354,120,353,117,351,116,350,114,353,115,355,116,359,118,364,120,366,122,371,127,374,129,384,129,388,133,392,135,396,135,392,142,389,145,385,146,388,148,394,153,405,155,407,157,407,162,405,164,407,169,409,171,414,173,415,176,414,179,412,181,413,187")
  Geozone.create(name: "Parcoy", geozone_id: geo.id)
  Geozone.create(name: "Tayabamba", geozone_id: geo.id)
  Geozone.create(name: "Chilia", geozone_id: geo.id)
  Geozone.create(name: "Pataz", geozone_id: geo.id)
  Geozone.create(name: "Huancaspata", geozone_id: geo.id)
  Geozone.create(name: "Huayo", geozone_id: geo.id)
  Geozone.create(name: "Buldibuyo", geozone_id: geo.id)
  Geozone.create(name: "Urpay", geozone_id: geo.id)
  Geozone.create(name: "Taurija", geozone_id: geo.id)
  Geozone.create(name: "Santiago de Challas", geozone_id: geo.id)
  Geozone.create(name: "Huaylillas", geozone_id: geo.id)
  Geozone.create(name: "Ongón", geozone_id: geo.id)
  Geozone.create(name: "Pías", geozone_id: geo.id)
  geo = Geozone.create(name: "Pacasmayo", html_map_coordinates: "43,129,46,127,50,125,57,115,63,116,66,117,69,113,70,104,74,103,78,97,79,92,83,89,85,88,86,85,88,84,88,81,85,79,81,80,78,81,70,75,68,76,65,75,61,74,59,72,55,71,48,65,46,62,45,59,38,53,36,56,33,61,31,59,25,60,24,62,19,66,16,66,14,67,20,83,16,84,16,88,18,92,19,96,24,103,25,106,28,108,30,110,37,121,37,123")
  Geozone.create(name: "Guadalupe", geozone_id: geo.id)
  Geozone.create(name: "Pacasmayo", geozone_id: geo.id)
  Geozone.create(name: "San Pedro de Lloc", geozone_id: geo.id)
  Geozone.create(name: "San José", geozone_id: geo.id)
  Geozone.create(name: "Jequetepeque", geozone_id: geo.id)
  geo = Geozone.create(name: "Otuzco", html_map_coordinates: "176,179,169,191,173,196,172,199,172,205,179,206,181,206,185,207,194,202,206,205,208,201,208,196,211,192,219,189,228,187,232,181,245,170,253,168,255,166,255,160,251,153,253,148,253,145,251,144,250,142,250,138,242,135,236,132,231,126,222,127,219,125,213,124,211,128,208,130,202,133,199,134,194,132,188,130,182,133,177,134,172,138,166,141,159,137,149,129,142,127,137,132,138,139,140,144,145,149,149,149,153,152,159,153,160,157,162,160,162,164,161,168,165,169,169,170,169,176")
  Geozone.create(name: "Usquil", geozone_id: geo.id)
  Geozone.create(name: "Otuzco", geozone_id: geo.id)
  Geozone.create(name: "Agallpampa", geozone_id: geo.id)
  Geozone.create(name: "Sinsicap", geozone_id: geo.id)
  Geozone.create(name: "Salpo", geozone_id: geo.id)
  Geozone.create(name: "Huaranchal", geozone_id: geo.id)
  Geozone.create(name: "Mache", geozone_id: geo.id)
  Geozone.create(name: "Charat", geozone_id: geo.id)
  Geozone.create(name: "La Cuesta", geozone_id: geo.id)
  Geozone.create(name: "Paranday", geozone_id: geo.id)
  geo = Geozone.create(name: "Julcán", html_map_coordinates: "207,204,208,200,208,197,211,193,216,190,222,188,227,187,230,190,232,191,234,191,243,198,245,198,247,201,247,208,245,211,244,215,247,218,248,223,249,228,245,233,242,233,240,238,236,241,232,240,229,241,225,251,216,250,212,248,205,246,198,245,197,240,195,234,194,229,185,221,186,219,186,214,183,213,180,211,180,208,179,206,181,205,183,206,185,206,189,205,191,202,195,202,199,203,203,205")
  Geozone.create(name: "Julcán", geozone_id: geo.id)
  Geozone.create(name: "Carabamba", geozone_id: geo.id)
  Geozone.create(name: "Calamarca", geozone_id: geo.id)
  Geozone.create(name: "Huaso", geozone_id: geo.id)
  geo = Geozone.create(name: "Gran Chimú", html_map_coordinates: "166,141,163,142,157,136,152,131,148,129,143,127,141,127,141,125,139,123,134,124,131,122,131,119,128,118,128,112,129,110,129,107,131,104,142,94,146,89,149,89,151,86,152,84,154,82,158,83,160,82,164,82,176,83,179,82,182,83,188,89,188,100,186,102,188,105,191,107,193,109,201,108,209,110,215,104,218,100,222,97,229,97,231,99,239,98,240,104,238,107,238,114,236,117,233,118,232,122,230,126,223,128,219,125,213,124,211,128,207,132,200,135,194,132,191,129,187,130,182,134,177,134,175,137,171,137,170,139")
  Geozone.create(name: "Cascas", geozone_id: geo.id)
  Geozone.create(name: "Marmot", geozone_id: geo.id)
  Geozone.create(name: "Sayapullo", geozone_id: geo.id)
  Geozone.create(name: "Lucma", geozone_id: geo.id)
  geo = Geozone.create(name: "Chepén", html_map_coordinates: "14,67,10,63,10,60,4,55,4,52,1,50,0,46,14,32,15,28,28,16,30,9,34,9,36,10,42,6,46,7,50,9,54,12,59,17,63,20,63,27,66,31,67,35,69,38,68,41,71,43,71,46,75,49,73,54,72,64,60,72,51,68,47,64,45,58,38,53,36,56,32,61,30,59,25,58,24,62,18,66")
  Geozone.create(name: "Chepén", geozone_id: geo.id)
  Geozone.create(name: "Pacanga", geozone_id: geo.id)
  Geozone.create(name: "Pueblo Nuevo", geozone_id: geo.id)
  geo = Geozone.create(name: "Bolívar", html_map_coordinates: "363,76,365,78,364,81,366,83,366,85,367,87,368,90,370,93,374,93,376,96,378,98,380,101,381,103,384,103,384,107,383,110,384,112,385,115,388,116,390,118,392,118,391,120,388,123,386,123,384,126,384,128,373,128,370,127,368,124,366,122,364,119,360,118,357,116,354,116,352,114,350,114,350,111,347,107,346,104,344,101,344,97,344,93,343,91,343,89,340,86,339,83,336,83,332,79,331,76,329,73,329,69,329,66,326,63,326,58,323,55,323,53,320,52,317,48,316,41,312,40,310,38,310,35,309,33,309,30,307,27,307,25,306,21,304,19,302,17,302,15,298,11,298,9,298,6,307,7,311,10,315,11,318,12,322,12,326,11,328,9,332,8,335,9,337,9,336,7,336,5,338,1,341,0,343,2,345,3,343,5,343,8,341,11,343,15,343,18,344,20,346,22,348,23,348,31,352,35,354,35,358,36,361,38,363,40,363,42,365,44,367,47,367,50,362,58,363,61,363,66,364,68,364,73")
  Geozone.create(name: "Bolívar", geozone_id: geo.id)
  Geozone.create(name: "Bambamarca", geozone_id: geo.id)
  Geozone.create(name: "Uchumarca", geozone_id: geo.id)
  Geozone.create(name: "Longotea", geozone_id: geo.id)
  Geozone.create(name: "Condormarca", geozone_id: geo.id)
  Geozone.create(name: "Ucuncha", geozone_id: geo.id)
  geo = Geozone.create(name: "Ascope", html_map_coordinates: "120,128,130,128,134,124,140,124,142,127,138,132,137,137,142,148,147,150,150,150,154,153,147,160,143,160,142,166,140,168,133,172,126,173,124,176,122,182,116,186,114,188,106,188,103,183,100,183,98,181,95,184,91,186,87,191,79,186,74,183,70,176,64,173,58,163,58,160,56,160,50,152,48,148,42,143,45,137,43,133,43,129,45,127,50,125,52,121,56,116,60,115,66,117,69,112,70,104,73,104,76,100,78,96,79,91,85,88,87,83,90,83,95,88,99,90,108,90,111,88,113,88,112,92,108,101,115,114,116,119")
  Geozone.create(name: "Casa Grande", geozone_id: geo.id)
  Geozone.create(name: "Paiján", geozone_id: geo.id)
  Geozone.create(name: "Santiago de Cao", geozone_id: geo.id)
  Geozone.create(name: "Chicama", geozone_id: geo.id)
  Geozone.create(name: "Chocope", geozone_id: geo.id)
  Geozone.create(name: "Rázuri", geozone_id: geo.id)
  Geozone.create(name: "Ascope", geozone_id: geo.id)
  Geozone.create(name: "Magdalena de Cao", geozone_id: geo.id)
  #Geozone.create(name: "Existent District", census_code: "01")
  #('A'..'Z').each { |i| Geozone.create(name: "District #{i}", external_code: i.ord, census_code: i.ord) }
end

section "Creating Users" do
  def create_user(email, username = Faker::Name.name)
    pwd = '12345678'
    User.create!(
      username:               username,
      email:                  email,
      password:               pwd,
      password_confirmation:  pwd,
      confirmed_at:           Time.current,
      terms_of_service:       "1",
      gender:                 ['Male', 'Female'].sample,
      date_of_birth:          rand((Time.current - 80.years)..(Time.current - 16.years)),
      public_activity:        (rand(1..100) > 30)
    )
  end

  def unique_document_number
    @document_number ||= 12345678
    @document_number += 1
    "#{@document_number}#{[*'A'..'Z'].sample}"
  end

  admin = create_user('decide@regionlalibertad.gob.pe', 'Admin')
  admin.create_administrator
  admin.update(residence_verified_at: Time.current, confirmed_phone: Faker::PhoneNumber.phone_number, document_type: "1",
               verified_at: Time.current, document_number: unique_document_number)
=begin
  moderator = create_user('mod@consul.dev', 'mod')
  moderator.create_moderator
  manager = create_user('manager@consul.dev', 'manager')
  manager.create_manager
  valuator = create_user('valuator@consul.dev', 'valuator')
  valuator.create_valuator
  valuator.update(residence_verified_at: Time.current, confirmed_phone: Faker::PhoneNumber.phone_number, document_type: "1",
                  verified_at: Time.current, document_number: unique_document_number)
  poll_officer = create_user('poll_officer@consul.dev', 'Paul O. Fisher')
  poll_officer.create_poll_officer
  poll_officer.update(residence_verified_at: Time.current, confirmed_phone: Faker::PhoneNumber.phone_number, document_type: "1",
                      verified_at: Time.current, document_number: unique_document_number)
  poll_officer2 = create_user('poll_officer2@consul.dev', 'Pauline M. Espinosa')
  poll_officer2.create_poll_officer
  poll_officer2.update(residence_verified_at: Time.current, confirmed_phone: Faker::PhoneNumber.phone_number, document_type: "1",
                       verified_at: Time.current, document_number: unique_document_number)
  create_user('unverified@consul.dev', 'unverified')
  level_2 = create_user('leveltwo@consul.dev', 'level 2')
  level_2.update(residence_verified_at: Time.current, confirmed_phone: Faker::PhoneNumber.phone_number,
                 document_number: unique_document_number, document_type: "1")
  verified = create_user('verified@consul.dev', 'verified')
  verified.update(residence_verified_at: Time.current, confirmed_phone: Faker::PhoneNumber.phone_number, document_type: "1",
                  verified_at: Time.current, document_number: unique_document_number)
  (1..10).each do |i|
    org_name = Faker::Company.name
    org_user = create_user("org#{i}@consul.dev", org_name)
    org_responsible_name = Faker::Name.name
    org = org_user.create_organization(name: org_name, responsible_name: org_responsible_name)
    verified = [true, false].sample
    if verified
      org.verify
    else
      org.reject
    end
  end
  (1..5).each do |i|
    official = create_user("official#{i}@consul.dev")
    official.update(official_level: i, official_position: "Official position #{i}")
  end
  (1..100).each do |i|
    user = create_user("user#{i}@consul.dev")
    level = [1, 2, 3].sample
    if level >= 2
      user.update(residence_verified_at: Time.current, confirmed_phone: Faker::PhoneNumber.phone_number,
                  document_number: unique_document_number, document_type: "1", geozone: Geozone.all.sample)
    end
    if level == 3
      user.update(verified_at: Time.current, document_number: unique_document_number)
    end
  end
=end
end

section "Creating Tags Categories" do
  ActsAsTaggableOn::Tag.category.create!(name: "Seguridad Ciudadana")
  ActsAsTaggableOn::Tag.category.create!(name: "Salud")
  ActsAsTaggableOn::Tag.category.create!(name: "Educación")
  ActsAsTaggableOn::Tag.category.create!(name: "Gestión de riesgo y desastre")
  ActsAsTaggableOn::Tag.category.create!(name: "Trabajo y Promoción del Empleo")
  ActsAsTaggableOn::Tag.category.create!(name: "Infraestructura vial")
  ActsAsTaggableOn::Tag.category.create!(name: "Energía urbana y rural")
  ActsAsTaggableOn::Tag.category.create!(name: "Agropecuaria")
  ActsAsTaggableOn::Tag.category.create!(name: "Turismo y artesanía")
  ActsAsTaggableOn::Tag.category.create!(name: "Diversidad biológica")
  ActsAsTaggableOn::Tag.category.create!(name: "Participación Ciudadana")
  ActsAsTaggableOn::Tag.category.create!(name: "Protección Social")
  ActsAsTaggableOn::Tag.category.create!(name: "Cultura e Interculturalidad")
  ActsAsTaggableOn::Tag.category.create!(name: "Participación Política y Ciudadana")
end
=begin
section "Creating Debates" do
  tags = Faker::Lorem.words(25)
  30.times do
    author = User.all.sample
    description = "<p>#{Faker::Lorem.paragraphs.join('</p><p>')}</p>"
    debate = Debate.create!(author: author,
                            title: Faker::Lorem.sentence(3).truncate(60),
                            created_at: rand((Time.current - 1.week)..Time.current),
                            description: description,
                            tag_list: tags.sample(3).join(','),
                            geozone: Geozone.all.sample,
                            terms_of_service: "1")
  end
  tags = ActsAsTaggableOn::Tag.where(kind: 'category')
  30.times do
    author = User.all.sample
    description = "<p>#{Faker::Lorem.paragraphs.join('</p><p>')}</p>"
    debate = Debate.create!(author: author,
                            title: Faker::Lorem.sentence(3).truncate(60),
                            created_at: rand((Time.current - 1.week)..Time.current),
                            description: description,
                            tag_list: tags.sample(3).join(','),
                            geozone: Geozone.all.sample,
                            terms_of_service: "1")
  end
end
section "Creating Proposals" do
  tags = Faker::Lorem.words(25)
  30.times do
    author = User.all.sample
    description = "<p>#{Faker::Lorem.paragraphs.join('</p><p>')}</p>"
    proposal = Proposal.create!(author: author,
                                title: Faker::Lorem.sentence(3).truncate(60),
                                question: Faker::Lorem.sentence(3) + "?",
                                summary: Faker::Lorem.sentence(3),
                                responsible_name: Faker::Name.name,
                                external_url: Faker::Internet.url,
                                description: description,
                                created_at: rand((Time.current - 1.week)..Time.current),
                                tag_list: tags.sample(3).join(','),
                                geozone: Geozone.all.sample,
                                terms_of_service: "1")
  end
end
section "Creating Archived Proposals" do
  tags = Faker::Lorem.words(25)
  5.times do
    author = User.all.sample
    description = "<p>#{Faker::Lorem.paragraphs.join('</p><p>')}</p>"
    proposal = Proposal.create!(author: author,
                                title: Faker::Lorem.sentence(3).truncate(60),
                                question: Faker::Lorem.sentence(3) + "?",
                                summary: Faker::Lorem.sentence(3),
                                responsible_name: Faker::Name.name,
                                external_url: Faker::Internet.url,
                                description: description,
                                tag_list: tags.sample(3).join(','),
                                geozone: Geozone.all.sample,
                                terms_of_service: "1",
                                created_at: Setting["months_to_archive_proposals"].to_i.months.ago)
  end
end
section "Creating Successful Proposals" do
  tags = Faker::Lorem.words(25)
  10.times do
    author = User.all.sample
    description = "<p>#{Faker::Lorem.paragraphs.join('</p><p>')}</p>"
    proposal = Proposal.create!(author: author,
                                title: Faker::Lorem.sentence(3).truncate(60),
                                question: Faker::Lorem.sentence(3) + "?",
                                summary: Faker::Lorem.sentence(3),
                                responsible_name: Faker::Name.name,
                                external_url: Faker::Internet.url,
                                description: description,
                                created_at: rand((Time.current - 1.week)..Time.current),
                                tag_list: tags.sample(3).join(','),
                                geozone: Geozone.all.sample,
                                terms_of_service: "1",
                                cached_votes_up: Setting["votes_for_proposal_success"])
  end
  tags = ActsAsTaggableOn::Tag.where(kind: 'category')
  30.times do
    author = User.all.sample
    description = "<p>#{Faker::Lorem.paragraphs.join('</p><p>')}</p>"
    proposal = Proposal.create!(author: author,
                                title: Faker::Lorem.sentence(3).truncate(60),
                                question: Faker::Lorem.sentence(3) + "?",
                                summary: Faker::Lorem.sentence(3),
                                responsible_name: Faker::Name.name,
                                external_url: Faker::Internet.url,
                                description: description,
                                created_at: rand((Time.current - 1.week)..Time.current),
                                tag_list: tags.sample(3).join(','),
                                geozone: Geozone.all.sample,
                                terms_of_service: "1")
  end
end
section "Commenting Debates" do
  100.times do
    author = User.all.sample
    debate = Debate.all.sample
    Comment.create!(user: author,
                    created_at: rand(debate.created_at..Time.current),
                    commentable: debate,
                    body: Faker::Lorem.sentence)
  end
end
section "Commenting Proposals" do
  100.times do
    author = User.all.sample
    proposal = Proposal.all.sample
    Comment.create!(user: author,
                    created_at: rand(proposal.created_at..Time.current),
                    commentable: proposal,
                    body: Faker::Lorem.sentence)
  end
end
section "Commenting Comments" do
  200.times do
    author = User.all.sample
    parent = Comment.all.sample
    Comment.create!(user: author,
                    created_at: rand(parent.created_at..Time.current),
                    commentable_id: parent.commentable_id,
                    commentable_type: parent.commentable_type,
                    body: Faker::Lorem.sentence,
                    parent: parent)
  end
end
section "Voting Debates, Proposals & Comments" do
  not_org_users = User.where(['users.id NOT IN(?)', User.organizations.pluck(:id)])
  100.times do
    voter  = not_org_users.level_two_or_three_verified.all.sample
    vote   = [true, false].sample
    debate = Debate.all.sample
    debate.vote_by(voter: voter, vote: vote)
  end
  100.times do
    voter  = not_org_users.all.sample
    vote   = [true, false].sample
    comment = Comment.all.sample
    comment.vote_by(voter: voter, vote: vote)
  end
  100.times do
    voter = not_org_users.level_two_or_three_verified.all.sample
    proposal = Proposal.all.sample
    proposal.vote_by(voter: voter, vote: true)
  end
end
section "Flagging Debates & Comments" do
  40.times do
    debate = Debate.all.sample
    flagger = User.where(["users.id <> ?", debate.author_id]).all.sample
    Flag.flag(flagger, debate)
  end
  40.times do
    comment = Comment.all.sample
    flagger = User.where(["users.id <> ?", comment.user_id]).all.sample
    Flag.flag(flagger, comment)
  end
  40.times do
    proposal = Proposal.all.sample
    flagger = User.where(["users.id <> ?", proposal.author_id]).all.sample
    Flag.flag(flagger, proposal)
  end
end
section "Creating Spending Proposals" do
  tags = Faker::Lorem.words(10)
  60.times do
    geozone = Geozone.all.sample
    author = User.all.sample
    description = "<p>#{Faker::Lorem.paragraphs.join('</p><p>')}</p>"
    feasible_explanation = "<p>#{Faker::Lorem.paragraphs.join('</p><p>')}</p>"
    valuation_finished = [true, false].sample
    feasible = [true, false].sample
    spending_proposal = SpendingProposal.create!(author: author,
                                                 title: Faker::Lorem.sentence(3).truncate(60),
                                                 external_url: Faker::Internet.url,
                                                 description: description,
                                                 created_at: rand((Time.current - 1.week)..Time.current),
                                                 geozone: [geozone, nil].sample,
                                                 feasible: feasible,
                                                 feasible_explanation: feasible_explanation,
                                                 valuation_finished: valuation_finished,
                                                 tag_list: tags.sample(3).join(','),
                                                 price: rand(1000000),
                                                 terms_of_service: "1")
  end
end
section "Creating Valuation Assignments" do
  (1..17).to_a.sample.times do
    SpendingProposal.all.sample.valuators << Valuator.first
  end
end
section "Creating Budgets" do
  Budget::PHASES.each_with_index do |phase, i|
    descriptions = Hash[Budget::PHASES.map do |p|
      ["description_#{p}",
       "<p>#{Faker::Lorem.paragraphs(2).join('</p><p>')}</p>"]
    end]
    budget = Budget.create!(
      descriptions.merge(
        name: (Date.current - 10 + i).to_s,
        currency_symbol: "€",
        phase: phase
      )
    )
    (1..([1, 2, 3].sample)).each do |k|
      group = budget.groups.create!(name: "#{Faker::StarWars.planet} #{k}")
      geozones = Geozone.reorder("RANDOM()").limit([2, 5, 6, 7].sample)
      geozones.each do |geozone|
        group.headings << group.headings.create!(name: "#{geozone.name} #{k}",
                                                 price: rand(1..100) * 100000,
                                                 population: rand(1..50) * 10000)
      end
    end
  end
end
section "Creating Investments" do
  tags = Faker::Lorem.words(10)
  100.times do
    heading = Budget::Heading.all.sample
    investment = Budget::Investment.create!(
      author: User.all.sample,
      heading: heading,
      group: heading.group,
      budget: heading.group.budget,
      title: Faker::Lorem.sentence(3).truncate(60),
      external_url: Faker::Internet.url,
      description: "<p>#{Faker::Lorem.paragraphs.join('</p><p>')}</p>",
      created_at: rand((Time.current - 1.week)..Time.current),
      feasibility: %w{undecided unfeasible feasible feasible feasible feasible}.sample,
      unfeasibility_explanation: Faker::Lorem.paragraph,
      valuation_finished: [false, true].sample,
      tag_list: tags.sample(3).join(','),
      price: rand(1..100) * 100000,
      terms_of_service: "1"
    )
  end
end
section "Balloting Investments" do
  Budget.balloting.last.investments.each do |investment|
    investment.update(selected: true, feasibility: "feasible")
  end
end
section "Winner Investments" do
  budget = Budget.where(phase: "finished").last
  100.times do
    heading = budget.headings.all.sample
    investment = Budget::Investment.create!(
      author: User.all.sample,
      heading: heading,
      group: heading.group,
      budget: heading.group.budget,
      title: Faker::Lorem.sentence(3).truncate(60),
      external_url: Faker::Internet.url,
      description: "<p>#{Faker::Lorem.paragraphs.join('</p><p>')}</p>",
      created_at: rand((Time.current - 1.week)..Time.current),
      feasibility: "feasible",
      valuation_finished: true,
      selected: true,
      price: rand(10000..heading.price),
      terms_of_service: "1"
    )
  end
  budget.headings.each do |heading|
    Budget::Result.new(budget, heading).calculate_winners
  end
end
section "Creating Valuation Assignments" do
  (1..50).to_a.sample.times do
    Budget::Investment.all.sample.valuators << Valuator.first
  end
end
section "Ignoring flags in Debates, comments & proposals" do
  Debate.flagged.reorder("RANDOM()").limit(10).each(&:ignore_flag)
  Comment.flagged.reorder("RANDOM()").limit(30).each(&:ignore_flag)
  Proposal.flagged.reorder("RANDOM()").limit(10).each(&:ignore_flag)
end
section "Hiding debates, comments & proposals" do
  Comment.with_hidden.flagged.reorder("RANDOM()").limit(30).each(&:hide)
  Debate.with_hidden.flagged.reorder("RANDOM()").limit(5).each(&:hide)
  Proposal.with_hidden.flagged.reorder("RANDOM()").limit(10).each(&:hide)
end
section "Confirming hiding in debates, comments & proposals" do
  Comment.only_hidden.flagged.reorder("RANDOM()").limit(10).each(&:confirm_hide)
  Debate.only_hidden.flagged.reorder("RANDOM()").limit(5).each(&:confirm_hide)
  Proposal.only_hidden.flagged.reorder("RANDOM()").limit(5).each(&:confirm_hide)
end
section "Creating banners" do
  Proposal.last(3).each do |proposal|
    title = Faker::Lorem.sentence(word_count = 3)
    description = Faker::Lorem.sentence(word_count = 12)
    banner = Banner.create!(title: title,
                            description: description,
                            style: ["banner-style banner-style-one", "banner-style banner-style-two",
                                    "banner-style banner-style-three"].sample,
                            image: ["banner-img banner-img-one", "banner-img banner-img-two",
                                    "banner-img banner-img-three"].sample,
                            target_url: Rails.application.routes.url_helpers.proposal_path(proposal),
                            post_started_at: rand((Time.current - 1.week)..(Time.current - 1.day)),
                            post_ended_at:   rand((Time.current - 1.day)..(Time.current + 1.week)),
                            created_at: rand((Time.current - 1.week)..Time.current))
  end
end
section "Creating proposal notifications" do
  100.times do |i|
    ProposalNotification.create!(title: "Proposal notification title #{i}",
                                 body: "Proposal notification body #{i}",
                                 author: User.all.sample,
                                 proposal: Proposal.all.sample)
  end
end
section "Creating polls" do
  Poll.create(name: "Current Poll",
              # TODO: Uncomment when Poll get slugs
              # slug: "current-poll",
              starts_at: 7.days.ago,
              ends_at:   7.days.from_now,
              geozone_restricted: false)
  Poll.create(name: "Current Poll Geozone Restricted",
              # TODO: Uncomment when Poll get slugs
              # slug: "current-poll-geozone-restricted",
              starts_at: 5.days.ago,
              ends_at:   5.days.from_now,
              geozone_restricted: true,
              geozones: Geozone.reorder("RANDOM()").limit(3))
  Poll.create(name: "Incoming Poll",
              # TODO: Uncomment when Poll get slugs
              # slug: "incoming-poll",
              starts_at: 1.month.from_now,
              ends_at:   2.months.from_now)
  Poll.create(name: "Recounting Poll",
              # TODO: Uncomment when Poll get slugs
              # slug: "recounting-poll",
              starts_at: 15.days.ago,
              ends_at:   2.days.ago)
  Poll.create(name: "Expired Poll without Stats & Results",
              # TODO: Uncomment when Poll get slugs
              # slug: "expired-poll-without-stats-and-results",
              starts_at: 2.months.ago,
              ends_at:   1.month.ago)
  Poll.create(name: "Expired Poll with Stats & Results",
              # TODO: Uncomment when Poll get slugs
              # slug: "expired-poll-with-stats-and-results",
              starts_at: 2.months.ago,
              ends_at:   1.month.ago,
              results_enabled: true,
              stats_enabled: true)
end
section "Creating Poll Questions & Answers" do
  Poll.all.each do |poll|
    (1..4).to_a.sample.times do
      question = Poll::Question.create!(author: User.all.sample,
                                        title: Faker::Lorem.sentence(3).truncate(60) + '?',
                                        poll: poll)
      Faker::Lorem.words((2..4).to_a.sample).each do |answer|
        Poll::Question::Answer.create!(question: question,
                                       title: answer.capitalize,
                                       description: "<p>#{Faker::Lorem.paragraphs.join('</p><p>')}</p>")
      end
    end
  end
end
section "Creating Poll Booths & BoothAssignments" do
  20.times do |i|
    Poll::Booth.create(name: "Booth #{i}", location: Faker::Address.street_address, polls: [Poll.all.sample])
  end
end
section "Creating Poll Shifts for Poll Officers" do
  Poll.all.each do |poll|
    Poll::BoothAssignment.where(poll: poll).each do |booth_assignment|
      Poll::Officer.all.each do |poll_officer|
        {
          vote_collection: (poll.starts_at.to_datetime..poll.ends_at.to_datetime),
          recount_scrutiny: (poll.ends_at.to_datetime..poll.ends_at.to_datetime + Poll::RECOUNT_DURATION)
        }.each do |task_name, task_dates|
          task_dates.each do |shift_date|
            Poll::Shift.create(booth: booth_assignment.booth,
                               officer: poll_officer,
                               date: shift_date,
                               officer_name: poll_officer.name,
                               officer_email: poll_officer.email,
                               task: task_name)
          end
        end
      end
    end
  end
end
section "Creating Communities" do
  Proposal.all.each { |proposal| proposal.update(community: Community.create) }
  Budget::Investment.all.each { |investment| investment.update(community: Community.create) }
end

section "Creating Communities Topics" do
  Community.all.each do |community|
    Topic.create(community: community, author: User.all.sample,
                 title: Faker::Lorem.sentence(3).truncate(60), description: Faker::Lorem.sentence)
  end
end
section "Commenting Polls" do
  30.times do
    author = User.all.sample
    poll = Poll.all.sample
    Comment.create!(user: author,
                    created_at: rand(poll.created_at..Time.current),
                    commentable: poll,
                    body: Faker::Lorem.sentence)
  end
end
section "Commenting Community Topics" do
  30.times do
    author = User.all.sample
    topic = Topic.all.sample
    Comment.create!(user: author,
                    created_at: rand(topic.created_at..Time.current),
                    commentable: topic,
                    body: Faker::Lorem.sentence)
  end
end
section "Creating Poll Voters" do
  def vote_poll_on_booth(user, poll)
    Poll::Voter.create!(document_type: user.document_type,
                        document_number: user.document_number,
                        user: user,
                        poll: poll,
                        origin: 'booth',
                        officer: Poll::Officer.all.sample)
  end
  def vote_poll_on_web(user, poll)
    randomly_answer_questions(poll, user)
    Poll::Voter.create!(document_type: user.document_type,
                        document_number: user.document_number,
                        user: user,
                        poll: poll,
                        origin: 'web',
                        token: SecureRandom.hex(32))
  end
  def randomly_answer_questions(poll, user)
    poll.questions.each do |question|
      next unless [true, false].sample
      Poll::Answer.create!(question_id: question.id, author: user, answer: question.question_answers.sample.title)
    end
  end
  (Poll.expired + Poll.current + Poll.recounting).uniq.each do |poll|
    level_two_verified_users = User.level_two_verified
    level_two_verified_users = level_two_verified_users.where(geozone_id: poll.geozone_ids) if poll.geozone_restricted?
    user_groups = level_two_verified_users.in_groups(2)
    user_groups.first.each { |user| vote_poll_on_booth(user, poll) }
    user_groups.second.compact.each { |user| vote_poll_on_web(user, poll) }
  end
end
section "Creating Poll Recounts" do
  Poll.all.each do |poll|
    poll.booth_assignments.each do |booth_assignment|
      officer_assignment = poll.officer_assignments.first
      author = Poll::Officer.first.user
      Poll::Recount.create!(officer_assignment: officer_assignment,
                            booth_assignment: booth_assignment,
                            author: author,
                            date: poll.ends_at,
                            white_amount: rand(0..10),
                            null_amount: rand(0..10),
                            total_amount: rand(100..9999),
                            origin: "booth")
    end
  end
end
section "Creating Poll Results" do
  Poll.all.each do |poll|
    poll.booth_assignments.each do |booth_assignment|
      officer_assignment = poll.officer_assignments.first
      author = Poll::Officer.first.user
      poll.questions.each do |question|
        question.question_answers.each do |answer|
          Poll::PartialResult.create!(officer_assignment: officer_assignment,
                                      booth_assignment: booth_assignment,
                                      date: Date.current,
                                      question: question,
                                      answer: answer.title,
                                      author: author,
                                      amount: rand(999),
                                      origin: "booth")
        end
      end
    end
  end
end
section "Creating Poll Questions from Proposals" do
  3.times do
    proposal = Proposal.all.sample
    poll = Poll.current.first
    question = Poll::Question.create(poll: poll)
    Faker::Lorem.words((2..4).to_a.sample).each do |answer|
      Poll::Question::Answer.create!(question: question, title: answer.capitalize, description: Faker::ChuckNorris.fact)
    end
    question.copy_attributes_from_proposal(proposal)
    question.save!
  end
end
section "Creating Successful Proposals" do
  10.times do
    proposal = Proposal.all.sample
    poll = Poll.current.first
    question = Poll::Question.create(poll: poll)
    Faker::Lorem.words((2..4).to_a.sample).each do |answer|
      Poll::Question::Answer.create!(question: question, title: answer.capitalize, description: Faker::ChuckNorris.fact)
    end
    question.copy_attributes_from_proposal(proposal)
    question.save!
  end
end
section "Creating legislation processes" do
  5.times do
    process = ::Legislation::Process.create!(title: Faker::Lorem.sentence(3).truncate(60),
                                             description: Faker::Lorem.paragraphs.join("\n\n"),
                                             summary: Faker::Lorem.paragraph,
                                             additional_info: Faker::Lorem.paragraphs.join("\n\n"),
                                             start_date: Date.current - 3.days,
                                             end_date: Date.current + 3.days,
                                             debate_start_date: Date.current - 3.days,
                                             debate_end_date: Date.current - 1.day,
                                             draft_publication_date: Date.current + 1.day,
                                             allegations_start_date: Date.current + 2.days,
                                             allegations_end_date: Date.current + 3.days,
                                             result_publication_date: Date.current + 4.days,
                                             debate_phase_enabled: true,
                                             allegations_phase_enabled: true,
                                             draft_publication_enabled: true,
                                             result_publication_enabled: true,
                                             published: true)
  end
  ::Legislation::Process.all.each do |process|
    (1..3).each do |i|
      version = process.draft_versions.create!(title: "Version #{i}",
                                               body: Faker::Lorem.paragraphs.join("\n\n"))
    end
  end
end
=end
log "All dev seeds created successfuly 👍"
