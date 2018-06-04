section "Creating Settings" do
  Setting.create(key: 'official_level_1_name',
                 value: I18n.t('seeds.settings.official_level_1_name'))
  Setting.create(key: 'official_level_2_name',
                 value: I18n.t('seeds.settings.official_level_2_name'))
  Setting.create(key: 'official_level_3_name',
                 value: I18n.t('seeds.settings.official_level_3_name'))
  Setting.create(key: 'official_level_4_name',
                 value: I18n.t('seeds.settings.official_level_4_name'))
  Setting.create(key: 'official_level_5_name',
                 value: I18n.t('seeds.settings.official_level_5_name'))
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
  Setting.create(key: 'feature.allow_attached_documents', value: "true")
  Setting.create(key: 'feature.public_stats', value: "true")
  Setting.create(key: 'feature.guides', value: nil)
  Setting.create(key: 'feature.user.skip_verification', value: nil)

  Setting.create(key: 'per_page_code_head', value: "")
  Setting.create(key: 'per_page_code_body', value: "")
  Setting.create(key: 'comments_body_max_length', value: '1000')
  Setting.create(key: 'mailer_from_name', value: 'Decide La Libertad')
  Setting.create(key: 'mailer_from_address', value: 'decide@regionlalibertad.gob.pe')
  Setting.create(key: 'meta_title', value: 'Decide La Libertad')
  Setting.create(key: 'meta_description', value: 'Aplicación de Participación y Decisión Ciudadana')
  Setting.create(key: 'meta_keywords', value: 'participación ciudadana, gobierno abierto')
  Setting.create(key: 'verification_offices_url', value: 'http://www.regionlalibertad.gob.pe/contacto')
  Setting.create(key: 'min_age_to_participate', value: '18')
  Setting.create(key: 'proposal_improvement_path', value: nil)
  Setting.create(key: 'map_latitude', value: -8.112595421768354)
  Setting.create(key: 'map_longitude', value: -79.02875661849977)
  Setting.create(key: 'map_zoom', value: 12)
  Setting.create(key: 'related_content_score_threshold', value: -0.3)

  Setting['feature.homepage.widgets.feeds.proposals'] = true
  Setting['feature.homepage.widgets.feeds.debates'] = true
  Setting['feature.homepage.widgets.feeds.processes'] = true
end
