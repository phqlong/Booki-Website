<?php
    require_once 'app/backend/core/init.php';
    if($_SERVER['REQUEST_METHOD'] == 'POST'){ 
        $username = $_POST['username'];
        $role = $_POST['role'];
        $active = $_POST['active'];
        $query = "CALL CHANGE_ROLE_STATUS(
            \"$username\",
            \"$role\",
            $active
        )";
        echo mysqli_query($conn, $query);            
    }
?>
            