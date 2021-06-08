<?php 
    require_once 'start.php';
    if(!isLoggedIn()){
        header('Location: index.php');
    }
    else{
        require_once FRONTEND_INCLUDE . 'header.php';
        require_once FRONTEND_INCLUDE . 'navbar.php';
        require_once BACKEND_AUTH . 'user-info.php';
        require_once FRONTEND_PAGE . 'user-info.php';
        require_once FRONTEND_INCLUDE . 'footer.php';
        require_once FRONTEND_INCLUDE . 'closehtml.php';
    }
?>
<?php require_once 'app/backend/core/clear.php'; ?>