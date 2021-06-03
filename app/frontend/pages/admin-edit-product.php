<form method="post" id="admin-edit-book" name="admin-edit-book">
    <div class="edit">
        <div class="form-group">
            <label for="name">Tên: <span class="admin-edit-warning"></span></label>
            <input type="text" class="form-control" id="name" name="name" value="<?php echo htmlspecialchars($name);?>">
        </div>
        <div class="form-group">   
            <label for="author">Tác giả: <span class="admin-edit-warning"></span></label>
            <input type="text" class="form-control" id="author" name="author" value="<?php echo htmlspecialchars($author);?>">
        </div>
        <div class="form-group">
            <label for="publisher">NXB: <span class="admin-edit-warning"></span></label>
            <input type="text" class="form-control" id="publisher" name="publisher" value="<?php echo htmlspecialchars($publisher);?>">
        </div>
        
        <div class="form-group">
            <label for="description">Mô tả: </label>
            <textarea class="form-control" id="description" name="description" rows="10"><?php echo ($description);?></textarea>
        </div>
        <div class="form-group">
            <label for="amount">Số lượng: <span class="admin-edit-warning"></span></label>
            <input type="number" min="0" class="form-control" id="amount" name="amount" value="<?php echo htmlspecialchars($amount);?>">
        </div>
        <div class="form-group">
            <label for="price">Giá: <span class="admin-edit-warning"></span></label>
            <input type="number" min="0" class="form-control" id="price" name="price" value="<?php echo htmlspecialchars($price);?>">
        </div>
        <div class="form-group">
            <label for="image">Hình ảnh: </label>
            <!-- <input type="text" class="form-control" id=    "image" name="image" value="<?php echo htmlspecialchars($image);?>"> -->
            <input type="file" accept="image/*" name="image" id="image">
        </div>

        <div class="form-group">
            <label for="image">Tên file: <span class="admin-edit-warning"></span></label>
            <input type="text" class="form-control" id="image-name" name="image-name" value="<?php echo htmlspecialchars(explode('/', $imageName)[2]);?>"> 
        </div>
        <button type="submit" class="btn btn-primary" name="updated" id="update-btn" value="confirm">Cập nhật</button>
        <button type="submit" class="btn btn-primary" name="updated" id="cancel-btn" value="cancel">Hủy bỏ</button>

    </div>
    <div class="preview">

        <div class="card admin-product" >
            <img class="card-img-top" id="prv-image" src=<?php echo $imageName; ?> alt="Card image cap">
            <div class="card-body">
                <h5 class="card-title" id="prv-name"><?php echo $name; ?></h5>
            </div>
            <ul class="list-group list-group-flush">
                <li class="list-group-item">
                    <h6 class="card-subtitle mb-2 text-muted" id="prv-author"><?php echo $author; ?></h6>
                    <h6 class="card-subtitle mb-2 text-muted" id="prv-publisher"><?php echo $publisher; ?></h6>
                </li>
                <li class="list-group-item" id="prv-price">Giá: <?php echo $price; ?> VND</li>
                <li class="list-group-item" id="prv-amount">Số lượng: <?php echo $amount; ?></li>
            </ul>
        </div>    
    </div>
</form>