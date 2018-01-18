// Overrides and adds customized javascripts in this file
// Read more on documentation:
// * English: https://github.com/consul/consul/blob/master/CUSTOMIZE_EN.md#javascript
// * Spanish: https://github.com/consul/consul/blob/master/CUSTOMIZE_ES.md#javascript
//
//
function showUser(id) {
  $.ajax({
    url: '/more-show/' + id,
    success: function (response) {
      if (response.estado === 1){
        $('#uname').text(response.citizen.username);
        $('#udoc').text(response.citizen.document_number);
        $('#uema').text(response.citizen.email);
        if (response.zone){
          $('#udist').text(response.zone.name);
          $('#uham').text(response.citizen.hamlet_or_urbanization);
        } else {
          $('#udist').text('');
          $('#uham').text('');
        }
        $('#uyea').text((new Date().getFullYear() - new Date(response.citizen.date_of_birth).getFullYear()));
        $('#usex').text(response.citizen.gender);
        $('#upro').text(response.citizen.profession);
        $('#showUsers').foundation('open');
      } else {
        var alertBox = '<div id="alert" data-alert="" class="notice-container callout-slide" data-closable="">' +
          '    <div class="callout notice alert">' +
          '      <button class="close-button" aria-label="Cerrar" type="button" data-close="">' +
          '        <span aria-hidden="true">×</span>' +
          '      </button>' +
          '      <div class="notice-text">' +
          '        Información del usuario no disponible.' +
          '      </div>' +
          '    </div>' +
          '  </div>';
        $(".admin-content").append(alertBox).foundation();
      }
    }
  });
}
