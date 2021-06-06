<form method="post" class="mx-4 my-3 p-4 authen-form mx-auto" name="login-form">
    <p class="text-danger"><?php echo $warning; ?> </p>
    <h3 class="text-center">Đăng nhập</h3>
    <div class="form-group">
        <label for="username">Tên đăng nhập</label>
        <input class="form-control" type="text" name="username" id="username">
        <div class="login-warning"></div>
    </div>  
    
    <div class="form-group">
        <label  for="password">Mật khẩu</label>
        <input class="form-control" type="password" name="password" id="password">
        <div class="login-warning"></div>
    </div>
    
    <div class="form-group">
        <label for="role">Đăng nhập với tư cách</label>
        <select class="form-control" name="role" id="role">
            <option value="customer">Người dùng</option>
            <option value="admin">Admin</option>
        </select>
    </div>

    <button id="login-btn" class="btn btn-danger btn-lg mt-3" type="submit" name="login">Login</button>
</form>

