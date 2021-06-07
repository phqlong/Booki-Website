<?php
    require_once 'app/backend/core/init.php';

    if($_SERVER["REQUEST_METHOD"] == "GET"){
        if($_GET["rq"] = "list_orders"){
            $html = "";
            $username = $_GET["username"];
            $status = $_GET["status"];
            $query = "CALL GET_ALL_ORDERS(\"$username\", \"$status\")";
            $result = mysqli_query($conn, $query);
            while($row = mysqli_fetch_assoc($result)):?>
                <tr>
                    <td class="text-body oid"><?php echo $row["oid"];?></td>
                    <td class="text-body uid"><?php echo $row["uid"];?></td>
                    <td class="text-body username"><?php echo $row["username"];?></td>
                    <td class="text-body name"><?php echo $row["name"];?></td>
                    <td class="text-body checkoutTime"><?php echo $row["checkoutTime"];?></td>
                    <td class="text-body status">
                        <span><?php echo $row["status"];?></span>
                        <?php if($row["status"] != "Thành công" && $row["status"] != "Đã hủy"):?>
                            <button type="button" class="icon-edit btn edit-status-btn">Edit</button>
                        <?php endif; ?>     
                    </td>     
                </tr>          
<?php
            endwhile;
        }
        else if($_GET["rq"] == "order_details"){

        }
    }

    
?>