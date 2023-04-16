$('.arrow-right').on('click',function(e){
	e.preventDefault();
	var value = parseFloat($(this).prev().val()), newValue = parseFloat(value + 1), max = $(this).parent().parent().find('.label-value').attr('data-legend');
	if(newValue <= max){
		$(this).prev().val(newValue);
		$(this).parent().parent().find('.label-value').text(newValue+'/'+max);
	}
});

$('.arrow-left').on('click',function(e){
	e.preventDefault();
	var value = parseFloat($(this).next().val()), newValue = parseFloat(value - 1), max = $(this).parent().parent().find('.label-value').attr('data-legend');
	if(newValue > -1){
		$(this).next().val(newValue);
		$(this).parent().parent().find('.label-value').text(newValue+'/'+max);
	}
});

$('.item-info').each(function(){
	var max = $(this).find('.label-value').attr('data-legend'), val = $(this).find('input').val();
	$(this).find('.label-value').text(val+'/'+max);
})

$('input[type=range]').change(function(){
	var value = parseFloat($(this).val()), max = $(this).parent().parent().find('.label-value').attr('data-legend');
	$(this).parent().parent().find('.label-value').text(value+'/'+max);
});


var x = 0;
var n = 1000;
$(document).keydown(function(e){
	if (e.which == 40){
		x += n;
		$('#formBarbershop').animate({
			scrollTop: x
		},4000);
	}

	if (e.which == 38){
		x -= n;
		$('#formBarbershop').animate({
			scrollTop: x
		},4000);
	}
});