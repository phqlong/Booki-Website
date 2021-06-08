<div class="mx-4 my-3 p-4 authen-form mx-auto">
    <p class="text-danger"><?php echo $warning; ?></p>
    <h1>Cập nhật thông tin:</h1>  
    <form method="post">
        <div class="form-group">
            <label for="name">Họ và Tên:</label>
            <input type="text" class="form-control" id="name" name="name" required>
        </div>
        
        <div class="form-group">
            <label for="name">Số điện thoại:</label>
            <input type="number" class="form-control" id="phone" name="phone" required>
        </div>

        <div class="form-group">
            <label for="name">Email:</label>
            <input type="text" class="form-control" id="email" name="email" required>
        </div>

        <div class="form-group">
            <label for="name">Mật khẩu cũ:</label>
            <input type="password" class="form-control" id="oldPassword" name="oldPassword" required>
        </div> 

        <div class="form-group">
            <label for="name">Mật khẩu mới:</label>
            <input type="password" class="form-control" id="newPassword" name="newPassword">
        </div>        

        <button type="submit" class="btn btn-lg btn-primary" name="user-edit-info-button">Cập nhật</button>
        <button type="button" class="btn btn-lg btn-danger" id="cancel-btn">Hủy bỏ</button>
    </form>
</div>    

