<?php
require_once 'app/backend/core/Init.php';

if (Input::exists()) {
    $validate = new Validation();
    $validation = $validate->check($_POST, array(
        'uid'  => array(
            'required'  => true,
        ),
        'role'  => array(
            'required'  => true,
        ),
    ));
    if ($validation->passed()) {
        $result = $user->update(array(
            'role'  => Input::get('role'),
        ), Input::get('uid'));
        var_dump($result);
        if ($result) {
            Session::flash('user-update-success', 'User successfully updated!');
            Redirect::to('admin-user.php');
        } else {
            echo '<div class="alert alert-danger"><strong></strong>Cannot update user!</div>';
        }
    } else {
        echo '<div class="alert alert-danger"><strong></strong>' . cleaner($validation->error()) . '</div>';
    }
}
