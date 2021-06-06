<form method="post" id="admin-edit-book" name="admin-edit-book">
    <div class="edit">
        <div class="form-group">
            <label for="name">Tên: <span class="admin-edit-warning"></span></label>
            <input type="text" class="form-control" id="name" name="name">
        </div>
        <div class="form-group">   
            <label for="author">Tác giả: <span class="admin-edit-warning"></span></label>
            <input type="text" class="form-control" id="author" name="author">
        </div>
        <div class="form-group">
            <label for="publisher">NXB: <span class="admin-edit-warning"></span></label>
            <input type="text" class="form-control" id="publisher" name="publisher">
        </div>
        
        <div class="form-group">
            <label for="description">Mô tả: </label>
            <textarea class="form-control" id="description" name="description" rows="10"></textarea>
        </div>
        <div class="form-group">
            <label for="amount">Số lượng: <span class="admin-edit-warning"></span></label>
            <input type="number" min="0" class="form-control" id="amount" name="amount">
        </div>
        <div class="form-group">
            <label for="price">Giá: <span class="admin-edit-warning"></span></label>
            <input type="number" min="0" class="form-control" id="price" name="price">
        </div>
        <div class="form-group">
            <label for="image">Hình ảnh: </label>
            <!-- <input type="text" class="form-control" id=    "image" name="image" value="<?php echo htmlspecialchars($image);?>"> -->
            <input type="file" accept="image/*" name="image" id="image">
        </div>

        <div class="form-group">
            <label for="image">Tên file: <span class="admin-edit-warning"></span></label>
            <input type="text" class="form-control" id="image-name" name="image-name"> 
        </div>
        <button type="button" class="btn btn-primary" name="updated" id="update-btn">Cập nhật</button>
        <button type="button" class="btn btn-primary" name="updated" id="cancel-btn">Hủy bỏ</button>

    </div>
    <div class="preview">

        <div class="card admin-product admin" >
            <img class="card-img-top" id="prv-image" alt="Card image cap">
            <div class="card-body">
                <h5 class="card-title" id="prv-name"></h5>
            </div>
            <ul class="list-group list-group-flush">
                <li class="list-group-item">
                    <span class="left">Tác giả</span>
                    <span class="right bold" id="prv-author"></span>
                </li>

                <li class="list-group-item">
                    <span class="left">NXB</span>
                    <span class="right bold" id="prv-publisher"></span>
                </li>

                <li class="list-group-item">
                    <span class="left">Giá</span>
                    <span class="right bold" id="prv-price"></span>
                </li>

                <li class="list-group-item">
                    <span class="left">Số lượng</span>
                    <span class="right bold" id="prv-amount"></span>
                </li>

                
            </ul>
        </div>    
    </div>
</form>