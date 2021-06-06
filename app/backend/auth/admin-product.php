<?php
    require_once 'app/backend/core/init.php';

    function getBook(){
        global $conn;
        $query = "CALL GET_ALL_BOOKS()";
        $result = mysqli_query($conn, $query);

        while($row = mysqli_fetch_assoc($result)):?>
            <div class="card admin admin-product" >
                <img class="card-img-top" src="<?php echo $row["image"]; ?>" alt="Card image cap">
                <div class="card-body">
                  <h5 class="card-title"><?php echo $row["name"]; ?></h5>
                </div>
                <ul class="list-group list-group-flush">
                  <li class="list-group-item">
                    <span class="left">Tác giả</span>
                    <span class="right bold"><?php echo $row["author"]; ?></span>
                  </li>

                  <li class="list-group-item">
                    <span class="left">NXB</span>
                    <span class="right bold"><?php echo $row["publisher"]; ?></span>
                  </li>
                  
                  <li class="list-group-item">
                    <span class="left">Giá</span>
                    <span class="right bold"><?php echo number_format($row["price"], 0, '', ','); ?> VND</span>
                  </li>
                  <li class="list-group-item">
                    <span class="left">Số lượng</span> 
                    <span class="right bold"><?php echo $row["amount"]; ?></span>
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