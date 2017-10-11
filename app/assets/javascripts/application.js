// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require popper
//= require bootstrap-sprockets
//= require rails-ujs
//= require turbolinks
//= require_tree .




$(document).on("turbolinks:load", function (){
  console.log("ready");

  $(".add-to-cart-btn").on("click", function(e){
    e.preventDefault();
    var id = $(this).val()
    console.log("clicked addtocart");
//    console.log($(".add-to-cart-btn").val());
    
//    var id = $(".add-to-cart-btn").val();
    console.log(id);
    $.ajax('/order_items',{
        type: 'POST',
        dataType: 'json',
        data: {id: id},
        success: function(result){
          console.log(result);
          var msg = $("<p></p>");
          msg.append('<i class="fa fa-check-square-o"></i> '+ "Add to cart success" + "<br>");
          msg.append("Quantity: "+ result.order_item.quantity + "<br>");
          //$(".show-add-recent").html(msg);
          $(".popup-inner").html(msg);
          $(".popup").show(300);
          

          

        },
    });
    
  });
  
  // Popup jquery
  $('[data-popup-open]').on('mouseover', function(e) {
    var targeted_popup_class = $(this).attr('data-popup-open');
    $('[data-popup="' + targeted_popup_class + '"]').fadeIn(350);
    e.preventDefault();
  });

  $('[data-popup="popup-cart"]').on('mouseout', function(e) {
    e.preventDefault();
    $(this).fadeOut(300);
  });
  
  // Close popup

  // Dropdown when click dropbtn
  $('.dropbtn').on('click', function(e){
    console.log("click dropbtn");
    e.preventDefault();
//    $('.dropdown').css("display","block");
//    $('.dropdown_content').css("display", "block");
    $('.dropdown_content').show(300);
  });

  // For size div and image
  window.addEventListener("resize", function(e){
    var mapElement = document.getElementsByClassName("product-box");
    map.Element.style.height = mapElement.offsetWidth * 1.72;
    e.preventDefault();
  });
  

  // For produc-box hover
  $('.product-box').on('mouseover', function(e){
    $(this).css("opacity", "1");
  });
  $('.product-box').on('mouseout', function(e){
    $(this).css("opacity", "0.6");
  });

  // Edit address button
  var adrform = $('.address_form')
  $('.edit_address_btn').on('click', function(e){
    e.preventDefault(); 
    adrform.fadeIn();  
  });

  // Ajax for update adress button
  //adrform.on('submit', function(e){
  $('.update_address_btn').on('click', function(e){
    e.preventDefault();
    $.ajax('/checkout/edit_address', {
      type: 'PATCH',
      //contenType: 'application/json',
      dataType: 'json',
      data: adrform.serialize(),
      success: function(result){
        console.log(result);      
        adrform.fadeOut();
        msg = $('<p></p>');
        msg.append("Your address changed to "+ result.name +"\n" +  result.city);
        //$('.show_address_changed').html(msg);
        //$('.show_address_changed').show().fadeOut(3000);
      },
    });
  });

  // ========= Radio button tag and paytype
  $('input:radio[name="paytype"]').change(function(){
    if (this.value == "cash"){
      console.log("clicked cash");
      $('#cash').show();
      $('#card').hide();
      $('#paypal').hide();

    }
    else if (this.value == "card"){
      console.log("clicked card");
      $('#card').show();
      $('#cash').hide();
      $('#paypal').hide();
    }
    else if (this.value == "paypal"){
      console.log("clicked paypal");
      $('#paypal').show();
      $('#cash').hide();
      $('#card').hide();
    }
  });
  
  // For checkout_btn
 /* 
  $('.checkout_btn').on('click', function(e){
    e.preventDefault();
    var ship_address_id = 2;
    $.ajax('/checkout/c/c/c', {
      type: 'POST',
      dataType: 'json',
      data: {ship_address_id: ship_address_id, fee_amount = 60000.0},
      success: function(result){
        console.log("damn yeah");
      },
      error: function(xhr){
        console.log(xhr.status + xhr.statusText +xhr.responseText);
      }
    });
  });
*/
  
  

});

var windowSize = window.innerWidth;
// For hide popup or dropdown when click out their side
$(document).mouseup(function (e)
    {
      var container = new Array();
      container.push($('.popup'));
      if (window.innerWidth <= 480 ){
      container.push($('.dropdown_content'));
      console.log(window.innerWidth);
      }
      $.each(container, function(key, value) {
        if (!$(value).is(e.target) && $(value).has(e.target).length ===0)
        {
          $(value).hide(300);
        }
      });
    });
