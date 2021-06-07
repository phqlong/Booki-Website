<?php 
    require_once 'start.php';
    if(isLoggedIn() && getRole() == 'customer'){
        require_once FRONTEND_INCLUDE . 'header.php';
        require_once FRONTEND_INCLUDE . 'navbar.php';
        require_once BACKEND_AUTH . 'checkout.php';
        require_once FRONTEND_PAGE . 'checkout.php';
        require_once FRONTEND_INCLUDE . 'footer.php';
?>
    <script src="js/custom/checkout.js"></script>
<?php
        require_once FRONTEND_INCLUDE . 'closehtml.php';
    }
    else{
        header('Location: index.php');
    }
?>