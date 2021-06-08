<?php
    require_once 'app/backend/core/init.php';
?>

<?php
    $username = "";
    $name = "";
    $email = "";
    $phone = "";

    $usn = getUsername();
    $query = "CALL GET_USER_BY_USN(\"$usn\")";
    $result = mysqli_query($conn, $query);
    
    if (mysqli_num_rows($result) > 0) {
        while($row = mysqli_fetch_assoc($result)){
            $username = $row['username'];
            $name = $row['name'];
            $email = $row['email'];
            $phone = $row['phone'];
        }
    }
?>