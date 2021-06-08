<div class="mx-4 my-3 p-4 authen-form mx-auto" name="user-info">
    <h1>Thông tin cá nhân</h1>
    <table>
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
    <a class="btn btn-lg btn-primary" style="margin-top:15px" href="user-edit-info.php">Cập nhật thông tin</a>
</div>


