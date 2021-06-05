<?php 
    require_once 'start.php';
    if(isLoggedIn() && getRole() == 'customer'){
        require_once FRONTEND_INCLUDE . 'header.php';
        require_once FRONTEND_INCLUDE . 'navbar.php';
        require_once BACKEND_AUTH . 'cart.php';
        require_once FRONTEND_PAGE . 'cart.php';
        require_once FRONTEND_INCLUDE . 'footer.php';
?>
    <script src="js/custom/view-cart.js"></script>
<?php
        require_once FRONTEND_INCLUDE . 'closehtml.php';
    }
    else{
        header('Location: index.php');
    }
?>