<div id="my-profile">
    <h1>My Profile</h1>
    <table class="table table-user-info">
            <tr>
                <td>Tên đăng nhập: </td>
                <td><?php echo $username; ?></td>
            </tr>
                                    
            <tr>
                <td>Họ và tên:</td>
                <td><?php echo $name; ?></td>
            </tr>
                                    
            <tr>
                <td>Số điện thoại:</td>
                <td><?php echo $phone; ?></td>
            </tr>

            <tr>
                <td>Email:</td>
                <td><?php echo $email; ?></td>
            </tr>             
    </table>    
</div>
<div class="update-user-info">
    <a href="user-edit-info.php">Cập nhật thông tin</a>
</div>

