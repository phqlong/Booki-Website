<?php
    require_once 'app/backend/core/init.php';

    if($_SERVER["REQUEST_METHOD"] == "GET"){
        global $conn;
        $html = "";
        $username = $_GET["username"];
        $status = $_GET["status"];
        $query = "CALL GET_ALL_ORDERS(\"$username\", \"$status\")";
        $result = mysqli_query($conn, $query);
        while($row = mysqli_fetch_assoc($result)):
        
        ?>
            <tr>
                <td><?php echo $row["oid"];?></td>
                <td><?php echo $row["uid"];?></td>
                <td><?php echo $row["username"];?></td>
                <td><?php echo $row["name"];?></td>
                <td><?php echo $row["checkoutTime"];?></td>
                <td><?php echo $row["status"];?></td>
            </tr>  

<?php
        endwhile;
    }
    
?>