<form class="admin-edit" id="admin-edit-order">
    <div class="edit">
        <h3 id="name" class="text-center">Name</h3>
        <div class="text-center text-body">
            <span>Username: </span>
            <span id="username" class="font-weight-bold text-success">Username</span>
        </div>
        <div class="text-center text-body">
            <span>Mã đơn hàng: </span>
            <span id="oid" class="font-weight-bold text-success">0001</span>
        </div>
        <div class="text-center text-body">
            <span>Trạng thái: </span>
            <span id="status" class="font-weight-bold text-success">0001</span>
        </div>
        
        <div class="form-group">
            <label class="text-body" for="status-select">Thay đổi trạng thái đơn hàng</label>
            <select name="status-select" id="status-select" class="form-control">
                <option value="Đang giao">Đang giao</option>
                <option value="Thành công">Hoàn tất giao hàng</option>
                <option value="Đã hủy">Hủy đơn hàng</option>
            </select>
        </div>
        <div class="table-responsive">
            <table class="table table-hover table-striped">
                <thead id="admin-order-detail-head" class="thead-dark">
                    <tr>
                        <th scope="col">Mã sách</th>
                        <th scope="col">Tên sách</th>
                        <th scope="col">Đơn giá</th>
                        <th scope="col">Số lượng</th>
                        <th scope="col">Thành tiền</th>
                    </tr>
                </thead>
                <tbody id="admin-order-detail-body">
    
                </tbody>
            </table>
        </div>
        <div class="btn-list">
            <button type="button" class="btn btn-success" name="updated" id="update-btn">Cập nhật</button>
            <button type="button" class="btn btn-secondary" name="updated" id="cancel-btn">Hủy bỏ</button>
        </div>
        
    </div>  
</form>