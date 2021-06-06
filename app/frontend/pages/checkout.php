<div class="container">
    <div class="py-5 text-center">
        <h1>Booki Shop</h1>
    </div>

    <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="index.php">Trang chủ</a></li>
            <li class="breadcrumb-item"><a href="cart.php">Giỏ hàng</a></li>
            <li class="breadcrumb-item active" aria-current="page">Thanh toán</li>
        </ol>
    </nav>

    <div class="row">
        <div class="col-md-4 order-md-2 mb-4">
            <h4 class="d-flex justify-content-between align-items-center mb-3">
                <span class="text-muted">Giỏ hàng</span>
                <span class="badge badge-secondary badge-pill"><?php echo count($_SESSION["cart"]); ?></span>
            </h4>
            <ul class="list-group mb-3">
                <li class="list-group-item d-flex justify-content-between lh-condensed">
                    <div>
                        <h6 class="my-0">Product name</h6>
                        <small class="text-muted">Brief description</small>
                    </div>
                    <span class="text-muted">$12</span>
                </li>
                <li class="list-group-item d-flex justify-content-between lh-condensed">
                    <div>
                        <h6 class="my-0">Second product</h6>
                        <small class="text-muted">Brief description</small>
                    </div>
                    <span class="text-muted">$8</span>
                </li>
                <li class="list-group-item d-flex justify-content-between lh-condensed">
                    <div>
                        <h6 class="my-0">Third item</h6>
                        <small class="text-muted">Brief description</small>
                    </div>
                    <span class="text-muted">$5</span>
                </li>
                <li class="list-group-item d-flex justify-content-between bg-light">
                    <div class="text-success">
                        <h6 class="my-0">Promo code</h6>
                        <small>EXAMPLECODE</small>
                    </div>
                    <span class="text-success">-$5</span>
                </li>
                <li class="list-group-item d-flex justify-content-between">
                    <span>Total (USD)</span>
                    <strong>$20</strong>
                </li>
            </ul>

            <form class="card p-2">
                <div class="input-group">
                    <input type="text" class="form-control" placeholder="Mã giảm giá / Voucher">
                    <div class="input-group-append">
                        <button type="submit" class="btn btn-success">Nhập</button>
                    </div>
                </div>
            </form>
        </div>

        <div class="col-md-8 order-md-1">
            <h4 class="mb-3">Thông tin giao hàng</h4>
            <form class="needs-validation" novalidate>
                <div class="mb-3">
                    <label for="fullName">Họ và tên (*)</label>
                    <input type="text" class="form-control" id="fullName" placeholder="Bắt buộc" value="" required>
                    <div class="invalid-feedback">Vui lòng nhập họ tên </div>
                </div>

                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label for="phone">Số điện thoại</label>
                        <input type="tel" class="form-control" id="phone" placeholder="">
                        <div class="invalid-feedback">Vui lòng nhập đúng số điện thoại</div>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label for="email">Email</label>
                        <input type="email" class="form-control" id="email" placeholder="Tùy chọn">
                        <div class="invalid-feedback">Vui lòng nhập đúng địa chỉ email</div>
                    </div>
                </div>

                <div class="mb-3">
                    <label for="address">Địa chỉ</label>
                    <input type="text" class="form-control" id="address" placeholder="Địa chỉ" required>
                    <div class="invalid-feedback">Địa chỉ không được trống</div>
                </div>

                <div class="row">
                    <div class="col-md-4 mb-3">
                        <label for="province">Tỉnh / thành</label>
                        <select class="custom-select d-block w-100" id="province" required>
                            <option value="">Chọn ...</option>
                            <option>United States</option>
                        </select>
                        <div class="invalid-feedback">Vui lòng chọn tỉnh thành</div>
                    </div>
                    <div class="col-md-4 mb-3">
                        <label for="district">Quận / huyện</label>
                        <select class="custom-select d-block w-100" id="district" required>
                            <option value="">Chọn...</option>
                            <option>California</option>
                        </select>
                        <div class="invalid-feedback">Vui lòng chọn quận huyện</div>
                    </div>
                    <div class="col-md-4 mb-3">
                        <label for="ward">Phường / xã</label>
                        <select class="custom-select d-block w-100" id="ward" required>
                            <option value="">Chọn...</option>
                            <option>Cam county</option>
                        </select>
                        <div class="invalid-feedback">Vui lòng chọn phường xã</div>
                    </div>

                </div>

                <hr class="mb-4">

                <div class="row">
                    <div class="col-md-6 mb-3">
                        <h4 class="mb-3">Phương thức thanh toán</h4>

                        <div class="d-block my-3">
                            <div class="custom-control custom-radio">
                                <input id="cod" name="paymentMethod" type="radio" class="custom-control-input" checked required>
                                <label class="custom-control-label" for="cod">Thanh toán trực tiếp khi nhận hàng (COD)</label>
                            </div>
                            <div class="custom-control custom-radio">
                                <input id="transfer" name="paymentMethod" type="radio" class="custom-control-input" required>
                                <label class="custom-control-label" for="transfer">Chuyển khoản</label>
                            </div>
                            <div class="custom-control custom-radio">
                                <input id="momo" name="paymentMethod" type="radio" class="custom-control-input" required>
                                <label class="custom-control-label" for="momo">Momo</label>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-6 mb-3">
                        <h4 class="mb-3">Phương thức vận chuyển</h4>

                        <div class="d-block my-2">
                            <div class="custom-control custom-radio">
                                <input id="standard" name="shippingMethod" type="radio" class="custom-control-input" checked required>
                                <label class="custom-control-label" for="standard">Giao hàng tiêu chuẩn: 25,000đ</label>
                            </div>

                            <div class="custom-control custom-radio">
                                <input id="standard" name="shippingMethod" type="radio" class="custom-control-input" checked required>
                                <label class="custom-control-label" for="standard">Giao hàng nhanh: 50,000đ</label>
                            </div>
                        </div>
                    </div>
                </div>
           
                <hr class="mb-4">

                <div class="custom-control custom-checkbox">
                    <input type="checkbox" class="custom-control-input" id="save-info">
                    <label class="custom-control-label" for="save-info">Lưu thông tin địa chỉ giao hàng</label>
                </div>

                <hr class="mb-4">

                <button class="btn btn-primary btn-lg btn-block" id="checkout-btn" type="submit">Đặt hàng</button>
            </form>
        </div>
    </div>


</div>

<script>
    // Example starter JavaScript for disabling form submissions if there are invalid fields
    (function() {
        'use strict';

        window.addEventListener('load', function() {
            // Fetch all the forms we want to apply custom Bootstrap validation styles to
            var forms = document.getElementsByClassName('needs-validation');

            // Loop over them and prevent submission
            var validation = Array.prototype.filter.call(forms, function(form) {
                form.addEventListener('submit', function(event) {
                    if (form.checkValidity() === false) {
                        event.preventDefault();
                        event.stopPropagation();
                    }
                    form.classList.add('was-validated');
                }, false);
            });
        }, false);
    })();
</script>