jQuery ->
  hideFields = ->
    $("#proposal_snip").hide()
    $("#proposal_price").hide()
    $("#proposal_executor").hide()
    $("#proposal_responsable").hide()
    $("#proposal_duration").hide()
    $("#proposal_price_first_year").hide()
  if $('input:radio[name="proposal[tipe]"]:checked').val() == "Actividad"
    $("#level_of_study").hide()
    hideFields()
  else
    $('#proposal_tipe_proyecto').prop("checked", true)
  if $('input:radio[name="proposal[level]"]:checked').val() == "Idea"
    hideFields()
  else
    $('#proposal_level_perfil').prop("checked", true)
  $("#proposal_tipe_actividad").click ->
    $("#level_of_study").hide()
    hideFields()
  $("#proposal_tipe_proyecto").click ->
    $("#level_of_study").show()
    $("#proposal_level_idea").prop("checked", true)
  $("#proposal_level_idea").click ->
    hideFields()
  $(".perfil").click ->
    $("#proposal_snip").show()
    $("#proposal_price").show()
    $("#proposal_executor").show()
    $("#proposal_responsable").show()
    $("#proposal_duration").show()
    $("#proposal_price_first_year").show()

  districts = $('.geozone_district').html()
  changer =(districts) ->
    province = $('.geozone_province').val()
    options = $(districts).filter("option[data='#{province}']")
    if options && options.length > 0
      $('.geozone_district').html(options)
      if $('.geozone_district').attr('id') != 'residence_postal_code'
        $('.geozone_district').prepend("<option value='#{province}'>Toda la provincia</option>")
      $('.geozone_district').parent().show()
      $('label[for="residence_portal_code"]').show()
      $('.geozone_district').prop('disabled',false)
    else
      $('.geozone_district').empty()
      $('.geozone_district').parent().hide()
      $('label[for="residence_portal_code"]').hide()
      $('.geozone_district').prop('disabled','disabled')

  $('.geozone_province').change ->
    changer districts
  changer districts
