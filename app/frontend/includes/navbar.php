<?php if(isLoggedIn() && getRole() == 'customer'): ?>
    <a href="cart.php" class="icon-shopping_cart btn-cart"></a>
<?php endif; ?>
<nav class="navbar navbar-expand-lg navbar-dark ftco_navbar header-bar ftco-navbar-light" id="ftco-navbar">
    <div class="container">
        <a class="navbar-brand ml-2" href="index.php"><img src="images/icon.png" width="40"> WeBooki</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#ftco-nav" aria-controls="ftco-nav" aria-expanded="false" aria-label="Toggle navigation">
        <span class="oi oi-menu"></span> Menu
        </button>

        <div class="collapse navbar-collapse" id="ftco-nav">
        <ul class="navbar-nav ml-auto">
            <?php if(!isLoggedIn()):?>
                <li class="nav-item mr-3"><a href="product.php" class="nav-link nav-decorate">Sách</a></li>
                <li class="nav-item mr-3"><a href="contact.php" class="nav-link nav-decorate">Liên hệ</a></li>
                <li class="nav-item mr-3"><a href="login.php" class="nav-link nav-decorate">Đăng nhập</a></li>
                <li class="nav-item mr-3"><a href="register.php" class="nav-link nav-decorate">Đăng ký</a></li>
            <?php else:
                if(getRole() == 'customer'): ?>
                    <li class="nav-item mr-3"><a href="product.php" class="nav-link nav-decorate">Sách</a></li>
                    <li class="nav-item mr-3"><a href="contact.php" class="nav-link nav-decorate">Liên hệ</a></li>
                    <!-- <li class="nav-item mr-3"><a href="cart.php" class="nav-link nav-decorate">Giỏ hàng</a></li> -->
                    <li class="nav-item mr-3"><a href="order.php" class="nav-link nav-decorate">Đơn hàng</a></li>
                <?php elseif(getRole() == 'admin'): ?>

                        <li class="nav-item dropdown">
                            <a class="nav-link nav-decorate dropdown-toggle" href="#" id="manage-dropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                Quản lý
                            </a>
                            <div class="dropdown-menu dropdown-menu-default" aria-labelledby="navbarDropdown">
                                <a class="dropdown-item nav-link nav-decorate" href="admin-product.php">Quản lý sách</a>
                                <a class="dropdown-item nav-link nav-decorate" href="admin-user.php">Quản lý người dùng</a>
                                <a class="dropdown-item nav-link nav-decorate" href="admin-order.php">Quản lý đơn hàng</a>
                            </div>
                        </li>
                    <!-- <li class="nav-item mr-3"><a href="admin-product.php" class="nav-link">Quản lý sách</a></li>
                    <li class="nav-item mr-3"><a href="admin-user.php" class="nav-link">Quản lý người dùng</a></li>
                    <li class="nav-item mr-3"><a href="order.php" class="nav-link">Quản lý đơn hàng</a></li> -->
                    
                <?php endif;?>
                <li class="nav-item mr-3"><a href="user-info.php" class="nav-link nav-decorate"><?php echo getUsername();?></a></li>
                <li class="nav-item mr-3"><a href="logout.php" class="nav-link nav-decorate">Đăng xuất</a></li>
            <?php endif;?>
        </ul>
        </div>
    </div>
</nav>