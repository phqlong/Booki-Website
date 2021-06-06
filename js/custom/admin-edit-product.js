// Preview
$('#name').change(function () { 
    changed = true;
    $('#prv-name').html($('#name').val());
});

$('#author').change(function () { 
    changed = true;
    $('#prv-author').html($('#author').val());
});

$('#publisher').change(function () { 
    changed = true;
    $('#prv-publisher').html($('#publisher').val());
});

$('#amount').change(function () { 
    changed = true;
    $('#prv-amount').html($('#amount').val());
});

$('#price').change(function () { 
    changed = true;
    var price_pretty = parseInt($('#price').val()).toLocaleString();
    $('#prv-price').html(price_pretty);
});

$("#image").change(function(){
    changed = true;
    if(this.files && this.files[0]){
        $('#prv-image').on('load', () => {
            URL.revokeObjectURL($('#prv-image').attr('src'));
        });
        $('#prv-image').attr('src', URL.createObjectURL(this.files[0]));
    }
});

$("#description").change(function() { 
    changed = true;
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
    
    if(valid){
        var bid = $(this).val();
        var formdata = new FormData($('form#admin-edit-book')[0]);
        formdata.append('bid', bid);
        $.ajax({
            type: "POST",
            url: "admin-edit-product.php",
            
            cache: false,
            processData: false,
            contentType: false,
            data: formdata,
            
            success: function (response) {

                if(response == 1){
                    alert('Cập nhật thành công!');
                    location.reload();
                }
                else{
                    alert('Cập nhật thất bại, vui lòng thử lại sau.');
                }
            }
        });
    }

    
});
$('#cancel-btn').click(function(){
    if(!changed || confirm('Có thay đổi chưa được lưu, bạn có chắc muốn hủy chỉnh sửa không?')){
        $('#admin-edit-book').css('display', 'none');
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