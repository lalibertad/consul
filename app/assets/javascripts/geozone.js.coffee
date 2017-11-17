jQuery ->
  $(".activity").click ->
    $("#level_of_study").hide()
  $(".project").click ->
    $("#level_of_study").show()
  $('.geozone_district').parent().hide()
  districts = $('.geozone_district').html()
  $('.geozone_district').prop('disabled','disabled')
  $('.geozone_province').change ->
    province = $('.geozone_province').val()
    options = $(districts).filter("option[data='#{province}']")
    if options && options.length > 0
      $('.geozone_district').html(options)
      $('.geozone_district').prepend("<option value='#{province}'>Toda la provincia</option>")
      $('.geozone_district').parent().show()
      $('.geozone_district').prop('disabled',false)
    else
      $('.geozone_district').empty()
      $('.geozone_district').parent().hide()
      $('.geozone_district').prop('disabled','disabled')
