<h2 class='text-center mt-4'>Quản lý đơn hàng</h2>
<div class="mx-4 my-6 p-4">
    <form method="get" id="admin-order-search"  name="admin-order-search">
        <div class="form-row justify-content-lg-center">
            <div class="form-group col-md-12 col-lg-2 ">
                <label for="admin-order-search-status" class="text-body">Tình trạng</label>
                <div class="input-group">
                    <div class="input-group-prepend">
                        <span class="input-group-text icon-filter"></span>
                    </div>
                    <select name="admin-order-search-status" class="form-control" id="admin-order-search-status">
                        <option value="">Tất cả</option>
                        <option value="Đã đặt">Đã đặt</option>
                        <option value="Đang giao">Đang giao</option>
                        <option value="Thành công">Thành công</option>
                        <option value="Đã hủy">Đã hủy</option>
                    </select>
                </div>
            </div>
            <div class="form-group col-md-12 col-lg-4 offset-lg-1">
                <label for="admin-order-search-usn" class="text-body">Tên đăng nhập</label>
                <div class="input-group">
                    
                    <input type="text" class="form-control" id="admin-order-search-usn" name="admin-order-search-usn" placeholder="Để trống: tất cả người dùng">
                    <button type="button" class="input-group-prepend btn" id="admin-order-search-btn" name="admin-order-search-btn">
                        <span class="input-group-text icon-search" ></span>
                    </button>
                </div>

            </div>
        </div>

        <div class="admin-order-result" id="admin-order-result">
            <table class="table table-striped">
                <thead id="admin-order-result-head" class="thead-dark hidden">
                    <tr>
                        <th scope="col">Mã đơn hàng</th>
                        <th scope="col">Số tài khoản</th>
                        <th scope="col">Tài khoản</th>
                        <th scope="col">Tên</th>
                        <th scope="col">Thời gian đặt hàng</th>
                        <th scope="col">Tình trạng</th>
                    </tr>
                </thead>
                <tbody id="admin-order-result-body" class="hidden">

                </tbody>
                <p id="admin-order-no-record" class="text-body hidden text-center">Không tìm thấy đơn hàng.</p>
            </table>
        </div>
    </form>
</div>
