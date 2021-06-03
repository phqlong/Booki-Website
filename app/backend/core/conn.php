<?php
    $hostname = "localhost"; 
    $username = "root";
    $password = "";
    $database = "booki";
    //connection to the database
    $conn = mysqli_connect($hostname, $username, $password) 
        or die("Unable to connect to MySQL");

    $select = mysqli_select_db($conn, $database)
        or die("Could not select ");
?>