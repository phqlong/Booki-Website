<?php 
    require_once 'start.php';
    if(isLoggedIn() && getRole() == 'admin'){
        //require_once FRONTEND_INCLUDE . 'header.php';
        //require_once FRONTEND_INCLUDE . 'navbar.php';
        require_once BACKEND_AUTH . 'admin-edit-product.php';
        //require_once FRONTEND_PAGE . 'admin-edit-product.php';
        //require_once FRONTEND_INCLUDE . 'footer.php';
        require_once 'app/backend/core/clear.php';
    }      
?>