jQuery ->
  $(".activity").click ->
    $("#level_of_study").hide()
    $("#proposal_snip").hide()
    $("#proposal_price").hide()
    $("#proposal_executor").hide()
    $("#proposal_responsable").hide()
  $(".project").click ->
    $("#level_of_study").show()
  $(".idea").click ->
    $("#proposal_snip").hide()
    $("#proposal_price").hide()
    $("#proposal_executor").hide()
    $("#proposal_responsable").hide()
  $(".perfil").click ->
    $("#proposal_snip").hide()
    $("#proposal_price").show()
    $("#proposal_executor").show()
    $("#proposal_responsable").show()
  $(".expediente").click ->
    $("#proposal_snip").show()
    $("#proposal_price").show()
    $("#proposal_executor").show()
    $("#proposal_responsable").show()

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
