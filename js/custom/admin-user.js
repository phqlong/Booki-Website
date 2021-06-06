
function fadeIn(elem, display){
    elem.fadeIn(200);
    elem.css('display', display);
}

window.onload = () => {

    $('.active-status').each(function () { 
        if($(this).html() == "Đã kích hoạt"){
            $(this).removeClass('deactive');
            $(this).addClass('active');
        }
        else if ($(this).html() == "Vô hiệu hóa"){
            $(this).removeClass('active');
            $(this).addClass('deactive');
        }
    });
}

$('.btn-edit').click(function(){
    var name = $(this).parent().siblings('.card-body').children('.card-title').html();
    var username = $(this).parent().prev().find(".username").html();
    var role = $(this).parent().prev().find(".role").html();
    var active = $(this).parent().prev().find(".active-status").html();
    if(active == "Đã kích hoạt"){
        active = "1";
    }
    else if(active == "Vô hiệu hóa"){
        active = "0";
    }

    fadeIn($('#admin-edit-user'), 'flex');
    $('#name').html(name);
    $('#username').html(username);
    $('#role').val(role);
    $('#active').val(active);

})

$('#update-btn').click(function(){
    var username = $('#username').html();
    formData = new FormData($('#admin-edit-user')[0])
    formData.append('username', username);
    $.ajax({
        type: "POST",
        url: "admin-edit-user.php",
        data: formData,
        cache: false,
        processData: false,
        contentType: false,
        success: function (response) {
            console.log(response)
            if(response == 1){
                alert("Cập nhật thành công");
                $('#admin-edit-user').fadeOut(200);
                location.reload();
            }
            else{
                alert("Cập nhật thất bại");
            }
        }
    });
})

$('#cancel-btn').click(() => {
    $('#admin-edit-user').fadeOut(200);
});