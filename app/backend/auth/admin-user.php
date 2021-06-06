<?php
    require_once 'app/backend/core/init.php';

    function getUsers(){
        global $conn;
        $query = "CALL GET_ALL_USERS()";
        $result = mysqli_query($conn, $query);
        
        while($row = mysqli_fetch_assoc($result)):
            $active = "";
            if($row["active"] == "1"){
                $active = "Đã kích hoạt";
            }
            else{
                $active = "Vô hiệu hóa";
            }
        ?>
            <div class="card admin admin-user" >
                <img class="card-img-top" src="images/star.png" alt="Card image cap">
                <div class="card-body">
                  <h5 class="card-title"><?php echo $row["name"]; ?></h5>
                </div>
                <ul class="list-group list-group-flush">
                    <li class="list-group-item">
                        <span class="left">Username</span>
                        <span class="right bold"><?php echo $row['username']?></span>
                    </li>

                    <li class="list-group-item">
                        <span class="left">Số điện thoại</span>
                        <span class="right bold"><?php echo $row['phone']?></span>
                    </li>

                    <li class="list-group-item">
                        <span class="left">Email</span>
                        <span class="right bold"><?php echo $row['email']?></span>
                    </li>

                    <li class="list-group-item">
                        <span class="left">Loại người dùng</span>
                        <span class="right bold"><?php echo $row['role']?></span>
                    </li>

                    <li class="list-group-item">
                        <span class="left">Tình trạng</span>
                        <span class="right bold active-status"><?php echo $active?></span>
                    </li>
                </ul>

                <div class="card-footer">
                  <button type="button" class="btn btn-primary btn-edit" value="<?php echo $row["bid"];?>">Chỉnh sửa</button>
                  <button type="button" class="btn btn-danger btn-delete" value="<?php echo $row["bid"];?>">Xóa</button>
                </div>
            </div>     

<?php 
        endwhile; 
    }
?>