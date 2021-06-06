<?php 
    require_once 'start.php';
    if(isLoggedIn() && getRole() == 'admin'){
        require_once FRONTEND_INCLUDE . 'header.php';
        require_once FRONTEND_INCLUDE . 'navbar.php';
        require_once BACKEND_AUTH . 'admin-user.php';
        require_once FRONTEND_PAGE . 'admin-edit-user.php';
        require_once FRONTEND_PAGE . 'admin-user.php';
        require_once FRONTEND_INCLUDE . 'footer.php';
?>
    <script src="js/custom/admin-user.js"></script>
    <script src="js/custom/admin-edit-user.js"></script>
<?php
        require_once FRONTEND_INCLUDE . 'closehtml.php';
    }
    else{
        header('Location: index.php');
    }
?>
<?php require_once 'app/backend/core/clear.php'; ?>