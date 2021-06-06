$('.authen-form').submit((e) => {
    var valid = true;
    if($('#username').val() == ''){
        valid = false;
        $('#username').next().html('Vui lòng nhập tên đăng nhập');
    }
    if($('#password').val() == ''){
        valid = false;
        $('#password').next().html('Vui lòng nhập mật khẩu');
    }
    if(!valid){
        e.preventDefault();
    }
});