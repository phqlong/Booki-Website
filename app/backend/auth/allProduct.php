<?php
if (isset($_POST['viewproducts'])){
    $data="<h1>alo</h1>";
    // '<thead class="thead-dark">
    // <tr>
    //     <th>ID</th>
    //     <th>Name</th>
    //     <th>Year</th>
    //     <th>Edit</th>
    //     <th>Delete</th>
    // </tr>
    // </thead>
    // <tbody>';

    // $sql = "SELECT id, name, year FROM cars";
    // $result = mysqli_query($conn, $sql);

    // if (mysqli_num_rows($result) > 0) {
    //     while ($row = mysqli_fetch_assoc($result)) {
    //         $data .= '<tr>';
    //         $data .= '<td>' . $row['id'] . '</td>' . "<td>" . $row['name'] . '</td>' . "<td>" . $row['year'] . '</td>' . '<td><button class="btn-edit btn btn-success btn-block btn-sm" onclick="edit(' . $row['id'] . ')">Edit</button></td><td><button class="btn-delete btn btn-secondary btn-block btn-sm" onclick="deleteRecord(' . $row['id'] . ')">Delete</button></td>';
    //         $data .= '</tr>';
    //     }
    // } else {
    //     echo "0 result found";
    // }
    // $data=$data.'</tbody>';
    echo $data;
}
?>