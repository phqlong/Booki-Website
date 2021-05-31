<nav class="navbar navbar-expand-lg navbar-dark ftco_navbar header-bar ftco-navbar-light" id="ftco-navbar">
    <div class="container">
        <a class="navbar-brand ml-2" href="index.php"><img src="images/icon.png" width="40"> Lina</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#ftco-nav" aria-controls="ftco-nav" aria-expanded="false" aria-label="Toggle navigation">
        <span class="oi oi-menu"></span> Menu
        </button>

        <div class="collapse navbar-collapse" id="ftco-nav">
        <ul class="navbar-nav ml-auto">
            <li class="nav-item mr-3"><a href="about.php" class="nav-link">Giới thiệu</a></li>
            <li class="nav-item mr-3"><a href="service.php" class="nav-link">Dịch vụ</a></li>
            <li class="nav-item mr-3"><a href="product.php" class="nav-link">Lina store</a></li>
            <li class="nav-item mr-3"><a href="contact.php" class="nav-link">Liên hệ</a></li>
            <?php if ($user->isLoggedIn()): ?>
                    <script>
                        function updateCartNum(num) {
                            const ele = document.getElementById("cart-count");
                            if (ele) {
                                ele.innerHTML = `[${num}]`;
                            }
                        }
                        let _count = <?php echo $cart->amount($user->data()->uid);?>;
                        setTimeout(() => updateCartNum(_count), 100);
                        setTimeout(() => updateCartNum(_count), 200);
                        setTimeout(() => updateCartNum(_count), 500);
                        setTimeout(() => updateCartNum(_count), 800);
                        setTimeout(() => updateCartNum(_count), 1000);
                        function addToCart(data) {
                            $.post('/cart.php', data, data => {
                                data = JSON.parse(data);
                                if (data.error) {
                                    _count -= 1;
                                    updateCartNum(_count);
                                    $.notify("Không thể thêm hàng vào giỏ. Hãy đăng nhập và thử lại.");
                                }
                            });
                            _count += 1;
                            updateCartNum(_count);
                        }
                    </script>
                <li class="nav-item mr-3">
                    <a id="shopping-cart" href="cart.php" class="nav-link">
                        <span class="icon-shopping_cart"></span>
                        <span id="cart-count">[0]</span>
                    </a>
                </li>
                <?php if ($user->isLoggedIn() && $user->hasPermission('admin')): ?>
                    <li class="nav-item mr-3"><a href="admin-product.php" class="nav-link"><i class='fa fa-cog'></i> Admin</a></li>
                <?php endif; ?>
                <li class="nav-item mr-3"><a href="profile.php" class="nav-link"><i class='fa fa-user'></i> <?php echo $user->data()->name;?></a></li>
            <?php else: ?>
                <li class="nav-item mr-3"><a href="register.php" class="nav-link">Đăng ký</a></li>
                <li class="nav-item mr-3"><a href="login.php" class="nav-link">Đăng nhập</a></li>
            <?php endif; ?>
        </ul>
        </div>
    </div>
</nav>