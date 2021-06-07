<div class="update-user-info">
    <h1>Cập nhật thông tin cá nhân</h1>  
    <form action="user-edit-info.php" method="post">
        <div class="form-group">
            <label for="name">Họ và Tên:</label>
            <input type="text" class="form-control" id="name" placeholder="Nhập họ và tên" name="name" required>
        </div>
        
        <div class="form-group">
            <label for="name">Phone:</label>
            <input type="number" class="form-control" id="phone" placeholder="Nhập số điện thoại" name="phone" required>
        </div>

        <div class="form-group">
            <label for="name">Email:</label>
            <input type="text" class="form-control" id="email" placeholder="Nhập email" name="email" required>
        </div>

        <button type="submit" name="user-edit-info-button">Cập nhật</button>
    </form>
</div>    

