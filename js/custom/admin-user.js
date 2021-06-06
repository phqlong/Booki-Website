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
