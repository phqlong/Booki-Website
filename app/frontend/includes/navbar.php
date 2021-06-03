<nav class="navbar navbar-expand-lg navbar-dark ftco_navbar header-bar ftco-navbar-light" id="ftco-navbar">
    <div class="container">
        <a class="navbar-brand ml-2" href="index.php"><img src="images/icon.png" width="40"> WeBooki</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#ftco-nav" aria-controls="ftco-nav" aria-expanded="false" aria-label="Toggle navigation">
        <span class="oi oi-menu"></span> Menu
        </button>

        <div class="collapse navbar-collapse" id="ftco-nav">
        <ul class="navbar-nav ml-auto">
            <?php if(!isLoggedIn()):?>
                <li class="nav-item mr-3"><a href="product.php" class="nav-link">Sách</a></li>
                <li class="nav-item mr-3"><a href="contact.php" class="nav-link">Liên hệ</a></li>
                <li class="nav-item mr-3"><a href="login.php" class="nav-link">Đăng nhập</a></li>
                <li class="nav-item mr-3"><a href="register.php" class="nav-link">Đăng ký</a></li>
            <?php else:
                if(getRole() == 'customer'): ?>
                    <li class="nav-item mr-3"><a href="product.php" class="nav-link">Sách</a></li>
                    <li class="nav-item mr-3"><a href="contact.php" class="nav-link">Liên hệ</a></li>
                    <li class="nav-item mr-3"><a href="cart.php" class="nav-link">Giỏ hàng</a></li>
                <?php elseif(getRole() == 'admin'): ?>
                    <li class="nav-item mr-3"><a href="admin-product.php" class="nav-link">Quản lý sách</a></li>
                    <li class="nav-item mr-3"><a href="admin-user.php" class="nav-link">Quản lý người dùng</a></li>
                    
                <?php endif;?>
                <li class="nav-item mr-3"><a href="user-info.php" class="nav-link"><?php echo getUsername();?></a></li>
                <li class="nav-item mr-3"><a href="logout.php" class="nav-link">Đăng xuất</a></li>
            <?php endif;?>
        </ul>
        </div>
    </div>
</nav>