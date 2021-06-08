<?php 
    require_once 'start.php';
    if(isLoggedIn() && getRole() == 'customer'){
        require_once BACKEND_AUTH . 'order.php';
        require_once 'app/backend/core/clear.php';
    }      
    else{
        header('Location: index.php');
    }
?>