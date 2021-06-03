<?php
    require_once 'app/backend/core/init.php';
    $bid = "";
    if($_SERVER["REQUEST_METHOD"] = "GET"):
        if(isset($_GET["bid"])):
            $bid = $_GET["bid"];
            $query = "CALL GET_BOOK(\"$bid\")";
            $result = mysqli_query($conn, $query);
            while($row = mysqli_fetch_assoc($result)): ?>   

                <form method="post">
                    <div class="edit">
                        <div class="form-group">
                            <label for="name">Tên</label>
                            <input type="text" class="form-control" id="name" value="<?php echo htmlspecialchars($row["name"]);?>">
                        </div>

                        <div class="form-group">
                            <label for="author">Tác giả</label>
                            <input type="text" class="form-control" id="author" value="<?php echo htmlspecialchars($row["author"]);?>">
                        </div>
                    </div>

                    <div class="preview">

                    </div>

                </form>
<?php
            endwhile;        
        
        elseif(isset($_GET["deleteBid"])):
            $bid = $_GET["deleteBid"];
            $query = "CALL REMOVE_BOOK(\"$bid\")";
            // mysqli_query($conn, $query);
            unset($_GET["deleteBid"]);
            header("Location: admin-product.php");
        endif;
    endif;
?>
            