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
                        <span class="right bold username"><?php echo $row['username']?></span>
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
                        <?php if($row["username"] != "booki"): ?>
                            <span class="right bold role"><?php echo $row['role']?></span>
                        <?php else: ?>
                            <span class="right bold role">root</span>
                        <?php endif; ?>
                            
                    </li>
                    <li class="list-group-item">
                        <span class="left">Tình trạng</span>
                        <span class="right bold active-status"><?php echo $active?></span>
                    </li>
                </ul>
                <div class="card-footer">
                    <?php if($row["username"] == $_SESSION['username']): ?>
                        <div class="btn btn-primary disabled">Người dùng hiện tại</div>
                    <?php elseif($row["username"] == "booki"): ?>
                        <div class="btn btn-primary disabled">Không được phép</div>  
                    <?php else: ?>
                        <button type="button" class="btn btn-primary btn-edit" value="<?php echo $row["username"];?>">Chỉnh sửa</button>
                    <?php endif; ?>
                </div>
            </div>     

<?php 
        endwhile; 
    }
?>