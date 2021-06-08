<form class="admin-edit" id="order-details">
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
        
        <div class="table-responsive">
            <table class="table table-hover table-striped">
                <thead id="order-details-head" class="thead-dark">
                    <tr>
                        <th scope="col">Mã sách</th>
                        <th scope="col">Tên sách</th>
                        <th scope="col">Đơn giá</th>
                        <th scope="col">Số lượng</th>
                        <th scope="col">Thành tiền</th>
                    </tr>
                </thead>
                <tbody id="order-details-body">
    
                </tbody>
            </table>
        </div>
        
        <div class="btn-list">
            <button type="button" class="btn btn-secondary" name="updated" id="cancel-btn">Đóng</button>
        </div>
        
    </div>  
</form>