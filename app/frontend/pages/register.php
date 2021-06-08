<form method="post" class="mx-4 my-3 p-4 authen-form mx-auto" name="register-form">
    <p class="text-danger"><?php echo $warning; ?> </p>
    <h3 class="text-center">Đăng ký</h3>

    <div class="form-group">
        <label for="username">Tên đăng nhập:</label>
        <input class="form-control" type="text" name="username" id="username" required>
    </div>
    
    <div class="form-group">
        <label for="password">Mật khẩu:</label>
        <input class="form-control" type="password" name="password" id="password" required>
    </div>
    

    <div class="form-group">
        <label for="name">Họ & tên:</label>
        <input class="form-control" type="text" name="name" required>
    </div>
    
    <div class="form-group">
        <label for="email">Email:</label>
        <input class="form-control" type="email" name="email" required>
    </div>
    

    <div class="form-group">
        <label for="phone">Số điện thoại:</label>
        <input class="form-control" type="number" name="phone" required>
    </div>
    

    <p><small>Với việc đăng ký, bạn đã đồng ý với WeBooki về <a href="">Điều khoản dịch vụ</a> & <a href="">Chính sách bảo mật</a></small></p>
    <button type="submit" class="btn btn-lg btn-primary" name="register-button">Đăng ký</button>

</form>
