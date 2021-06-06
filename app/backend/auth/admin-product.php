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
                  <button type="button" class="btn btn-primary btn-edit" value="<?php echo $row["bid"];?>">Chỉnh sửa</button>
                  <button type="button" class="btn btn-danger btn-delete" value="<?php echo $row["bid"];?>">Xóa</button>
                </div>
            </div>     

<?php 
        endwhile; 
    }
?>