<form method="post" class="mx-4 my-3 p-4 authen-form mx-auto" name="register-form">
    <p class="text-danger"><?php echo $warning; ?> </p>
    <h3 class="text-center">Đăng ký</h3>

    <label for="username">Tên đăng nhập:</label>
    <input type="text" name="username" id="username" required>

    <label for="password">Mật khẩu:</label>
    <input type="password" name="password" id="password" required>

    <label for="name">Họ & tên:</label>
    <input type="text" name="name" required>

    <label for="email">Email:</label>
    <input type="email" name="email" required>

    <label for="phone">Số điện thoại:</label>
    <input type="number" name="phone" required>

    <p><small>Với việc đăng ký, bạn đã đồng ý với WeBooki về <a href="">Điều khoản dịch vụ</a> & <a href="">Chính sách bảo mật</a></small></p>
    <button type="submit" class="btn btn-lg btn-primary" name="register-button">Đăng ký</button>

</form>
