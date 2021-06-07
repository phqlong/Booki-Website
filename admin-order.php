<?php 
    require_once 'start.php';
    if(isLoggedIn() && getRole() == 'admin'){
        require_once FRONTEND_INCLUDE . 'header.php';
        require_once FRONTEND_INCLUDE . 'navbar.php';
        require_once FRONTEND_PAGE . 'admin-edit-order.php';
        require_once FRONTEND_PAGE . 'admin-order.php';
        require_once FRONTEND_INCLUDE . 'footer.php';
?>
    
    <script src="js/custom/admin-order.js"></script>
    
<?php
        require_once FRONTEND_INCLUDE . 'closehtml.php';
    }
    else{
        header('Location: index.php');
    }
?>
<?php require_once 'app/backend/core/clear.php'; ?>