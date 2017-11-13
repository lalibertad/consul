// Overrides and adds customized javascripts in this file
// Read more on documentation:
// * English: https://github.com/consul/consul/blob/master/CUSTOMIZE_EN.md#javascript
// * Spanish: https://github.com/consul/consul/blob/master/CUSTOMIZE_ES.md#javascript
//
//
$(document).ready(function(){
    showDistrict($('#province').val());
    $(".activity").click(function(){
        $("#level_of_study").hide();
    });
    $(".project").click(function(){
        $("#level_of_study").show();
    });
});
