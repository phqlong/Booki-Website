<?php 
    require_once 'start.php';
    if(isLoggedIn()){
        header('Location: index.php');
    }
    else{
        require_once FRONTEND_INCLUDE . 'header.php';
        require_once FRONTEND_INCLUDE . 'navbar.php';
        require_once BACKEND_AUTH . 'login.php';
        require_once FRONTEND_PAGE . 'login.php';
        require_once FRONTEND_INCLUDE . 'footer.php';
    }
?>
