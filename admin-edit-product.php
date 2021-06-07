<?php 
    require_once 'start.php';
    if(isLoggedIn() && getRole() == 'admin'){
        require_once BACKEND_AUTH . 'admin-edit-product.php';
        require_once 'app/backend/core/clear.php';
    }      
    else{
        header('Location: index.php');
    }
?>