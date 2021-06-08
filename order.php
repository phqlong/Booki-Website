<?php 
    require_once 'start.php';
    if(isLoggedIn() && getRole() == 'customer'){
        require_once FRONTEND_INCLUDE . 'header.php';
        require_once FRONTEND_INCLUDE . 'navbar.php';
        require_once FRONTEND_PAGE . 'order-details.php';
        require_once FRONTEND_PAGE . 'order.php';
        require_once FRONTEND_INCLUDE . 'footer.php';
?>
    
    <script src="js/custom/order.js"></script>
    
<?php
        require_once FRONTEND_INCLUDE . 'closehtml.php';
    }
    else{
        header('Location: index.php');
    }
?>
<?php require_once 'app/backend/core/clear.php'; ?>