<?php
    //session_start();
    function isLoggedIn(){
        return isset($_SESSION['username']);
    }
    function getUsername(){
        return($_SESSION['username']);
    }
    function getRole(){
        return $_SESSION['role'];
    }
?>




