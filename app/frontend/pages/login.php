<form method="post">
    <p>Warning: <?php echo $warning; ?> </p>
    <label for="username">Tên đăng nhập</label>
    <input type="text" name="username" id="username">

    <label for="password">Mật khẩu</label>
    <input type="text" name="password" id="password">

    <select name="role" id="role">
        <option value="customer">Người dùng</option>
        <option value="admin">Admin</option>
    </select>

    <button type="submit" name="login">Login</button>
</form>