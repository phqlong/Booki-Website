<?php
    require_once 'app/backend/core/init.php';
    if($_SERVER["REQUEST_METHOD"] == "GET"){
        if($_GET["rq"] == "list_orders"){
            $html = "";
            $username = getUsername();
            $status = $_GET["status"];
            $query = "CALL GET_ALL_ORDERS(\"$username\", \"$status\")";
            $result = mysqli_query($conn, $query);
            while($row = mysqli_fetch_assoc($result)){?>
                <tr>
                    <td class="text-body oid"><?php echo $row["oid"];?></td>
                    <td class="text-body checkoutTime"><?php echo $row["checkoutTime"];?></td>
                    <td class="text-body status">
                        <span><?php echo $row["status"];?></span>
                        <button type="button" class="icon-info btn text-info view-details-btn"></button>
                        <?php if($row["status"] == "Đã đặt"):?>
                            <button type="button" class="icon-trash btn text-danger cancel-order-btn"></button>
                        <?php endif; ?>     
                    </td>     
                </tr>
<?php
            }
        }
        else if($_GET["rq"] == "order_details"){
            $oid = $_GET["oid"];
            $query = "CALL GET_ORDER_ITEMS(\"$oid\")";
            $result = mysqli_query($conn, $query);
            $total = 0;
            while($row = mysqli_fetch_assoc($result)){?>
                <tr>
                    <td class="text-body"><?php echo $row["bid"];?></td>
                    <td class="text-body"><?php echo $row["name"];?></td>
                    <td class="text-body"><?php echo $row["price"];?></td>
                    <td class="text-body"><?php echo $row["amount"];?></td>
                    <td class="text-body"><?php echo $row["total_price"];?></td>
                </tr>
<?php
                $total += $row["price"]*$row["amount"];
            }
?>
            <tr>
                <td colspan="4" class="text-body table-danger bold">Tổng cộng: </td>
                <td class="text-body table-danger bold"><?php echo $total?></td>
            </tr>
<?php
        }
    }

    else if ($_SERVER["REQUEST_METHOD"] == "POST"){
        $oid = $_POST["oid"];
        $status = "Đã hủy";
        $query = "CALL CHANGE_ORDER_STATUS($oid, \"$status\")";
        echo mysqli_query($conn, $query);
    }
?>