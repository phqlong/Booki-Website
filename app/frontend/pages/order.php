<h2 class='text-center mt-4'>Quản lý đơn hàng</h2>
<div class="mx-4 my-6 p-4">
    <form method="get" id="order-search"  name="order-search">
        <div class="form-row justify-content-lg-center">
            <div class="form-group col-md-12 col-lg-3">
                <label for="order-search-status" class="text-body">Tình trạng</label>
                <div class="input-group">
                    <div class="input-group-prepend">
                        <span class="input-group-text icon-filter"></span>
                    </div>
                    <select name="order-search-status" class="form-control" id="order-search-status">
                        <option value="">Tất cả</option>
                        <option value="Đã đặt">Đã đặt</option>
                        <option value="Đang giao">Đang giao</option>
                        <option value="Thành công">Thành công</option>
                        <option value="Đã hủy">Đã hủy</option>
                    </select>
                </div>
            </div>
        </div>        
    </form>
    <div class="order-result table-responsive" id="order-result">
        <p id="order-no-record" class="text-body hidden text-center">Không tìm thấy đơn hàng.</p>
        <table class="table table-striped">
            <thead id="order-result-head" class="thead-dark hidden">
                <tr>
                    <th scope="col">Mã đơn hàng</th>
                    <th scope="col">Thời gian đặt hàng</th>
                    <th scope="col">Tình trạng</th>
                </tr>
            </thead>
            <tbody id="order-result-body" class="hidden">
            </tbody>
            
        </table>
    </div>
</div>
