<form class="admin-edit" id="admin-edit-user">
    <div class="edit">
        <div class="form-group">
            <label for="role">Loại người dùng</label>
            <select name="role" id="role" class="form-control">
                <option value="customer">Customer</option>
                <option value="admin">Admin</option>
            </select>
        </div>
        <div class="form-group">
            <label for="active">Kích hoạt</label>
            <select name="active" id="active" class="form-control">
                <option value="1">Kích hoạt</option>
                <option value="0">Vô hiệu hóa</option>
            </select>
        </div>
        <button type="button" class="btn btn-success" name="updated" id="update-btn">Cập nhật</button>
        <button type="button" class="btn btn-danger" name="updated" id="cancel-btn">Hủy bỏ</button>
    </div>
    

</form>