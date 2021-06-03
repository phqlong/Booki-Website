// Preview
$('#name').change(function () { 
    $('#prv-name').html($('#name').val());
});

$('#author').change(function () { 
    $('#prv-author').html($('#author').val());
});

$('#publisher').change(function () { 
    $('#prv-publisher').html($('#publisher').val());
});

$('#amount').change(function () { 
    $('#prv-amount').html('Số lượng: ' + $('#amount').val());
});

$('#price').change(function () { 
    $('#prv-price').html('Giá: ' + $('#price').val() + ' VND');
});

$("#image").change(function(){
    if(this.files && this.files[0]){
        $('#prv-image').on('load', () => {
            URL.revokeObjectURL($('#prv-image').attr('src'));
        });
        $('#prv-image').attr('src', URL.createObjectURL(this.files[0]));
    }
});

//Warning
$('input').blur(function(){
    validator[this.name](this);
    console.log(this);
});

$('#update-btn').click(function(){
    valid = true;
    $('#admin-edit-book *').filter(':input').each(function(){
        if(validator[this.name](this)==false){
            valid=false;
        }
    })
    console.log(valid);
    if(!(valid)){
        $(this).attr("type", "button");
    }
    else{
        $(this).attr("type", "submit");
    }
    
});


var validator = {
    "name": (jObj) =>{
        if(jObj.value == ""){
            $(jObj).parent().children('label').children('span').html('Không được để trống');
            return false
        }
        else{
            $(jObj).parent().children('label').children('span').html('');
            return true;
        }
    },
    "author": (jObj) =>{
        if(jObj.value == ""){
            $(jObj).parent().children('label').children('span').html('Không được để trống');
            return false;
        }
        else{
            $(jObj).parent().children('label').children('span').html('');
            return true;
        }
    },
    "publisher": (jObj) =>{
        if(jObj.value == ""){
            $(jObj).parent().children('label').children('span').html('Không được để trống');
            return false;
        }
        else{
            $(jObj).parent().children('label').children('span').html('');
            return true;
        }
    },
    "description": (jObj) =>{
        return true;
    },
    "amount": (jObj) =>{
        if(jObj.value == ""){
            $(jObj).parent().children('label').children('span').html('Không được để trống');
            return false;
        }
        else if(parseInt(jObj.value) < 0){
            $(jObj).parent().children('label').children('span').html('Không được là số âm');
            return false;
        }
        else{
            $(jObj).parent().children('label').children('span').html('');
            return true;
        }
    },
    "price": (jObj) =>{
        if(jObj.value == ""){
            $(jObj).parent().children('label').children('span').html('Không được để trống');
            return false;
        }
        else if(parseInt(jObj.value) < 0){
            $(jObj).parent().children('label').children('span').html('Không được là số âm');
            return false;
        }
        else{
            $(jObj).parent().children('label').children('span').html('');
            return true;
        }
        
    },
    "image": (jObj) =>{
        return true;
    },
    "image-name": (jObj) =>{
        if(jObj.value.indexOf('/') != -1){
            $(jObj).parent().children('label').children('span').html('Ký tự / không được phép');
            return false
        }
        else{
            $(jObj).parent().children('label').children('span').html('');
            return true;
        }

    },
    "updated": (jObj) =>{
        return true;
    },
}