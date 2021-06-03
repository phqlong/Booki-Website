<?php
    require_once 'app/backend/core/init.php';

    function getBook(){
        global $conn;
        $query = "CALL GET_ALL_BOOKS()";
        $result = mysqli_query($conn, $query);

        while($row = mysqli_fetch_assoc($result)):?>
            <div class="card admin-product" >
                <img class="card-img-top" src=<?php echo $row["image"]; ?> alt="Card image cap">
                <div class="card-body">
                  <h5 class="card-title"><?php echo $row["name"]; ?></h5>
                </div>
                <ul class="list-group list-group-flush">
                  <li class="list-group-item">
                    <h6 class="card-subtitle mb-2 text-muted"><?php echo $row["author"]; ?></h6>
                    <h6 class="card-subtitle mb-2 text-muted"><?php echo $row["publisher"]; ?></h6>
                  </li>
                  <li class="list-group-item">Giá: <?php echo $row["price"]; ?> VND</li>
                  <li class="list-group-item">Số lượng: <?php echo $row["amount"]; ?></li>
                </ul>

                <div class="card-footer">
                  <a href="admin-edit-product.php?bid=<?php echo $row["bid"]?>" class="btn btn-primary">Chỉnh sửa</a>
                  <a href="admin-edit-product.php?deleteBid=<?php echo $row["bid"]?>" class="btn btn-danger">Xóa</a>
                </div>
            </div>     

<?php 
        endwhile; 
    }
?>