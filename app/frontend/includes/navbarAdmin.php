<nav class="navbar navbar-expand-lg navbar-dark ftco_navbar header-bar ftco-navbar-light" id="ftco-navbar">
    <div class="container">
        <a class="navbar-brand ml-2" href="index.php"><img src="images/icon.png" width="40"> Lina Admin</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#ftco-nav" aria-controls="ftco-nav" aria-expanded="false" aria-label="Toggle navigation">
        <span class="oi oi-menu"></span> Menu
        </button>

        <div class="collapse navbar-collapse" id="ftco-nav">
        <ul class="navbar-nav ml-auto">
            <li class="nav-item mr-3"><a href="admin-product.php" class="nav-link">Sản Phẩm</a></li>
            <li class="nav-item mr-3"><a href="admin-user.php" class="nav-link">Người dùng</a></li>
            <li class="nav-item mr-3"><a href="admin-info.php" class="nav-link">Thông tin Shop</a></li>
            <?php if ($user->isLoggedIn()): ?>
                <li class="nav-item mr-3"><a href="profile.php" class="nav-link"><i class='fa fa-user'></i> <?php echo $user->data()->name;?></a></li>
            <?php else: ?>
                <li class="nav-item mr-3"><a href="register.php" class="nav-link">Đăng ký</a></li>
                <li class="nav-item mr-3"><a href="login.php" class="nav-link">Đăng nhập</a></li>
            <?php endif; ?>
        </ul>
        </div>
    </div>
</nav>