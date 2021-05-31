<?php
require_once 'app/backend/core/Init.php';

if (Input::exists()) {
    $validate   = new Validation();

    $validation = $validate->check($_POST, array(
        'username' => array(
            'required' => true,
        ),
        'password' => array(
            'required' => true
        ),
    ));

    if ($validation->passed()) {
        $remember   = (Input::get('remember') === 'on') ? true : false;
        $login      = $user->login(Input::get('username'), Input::get('password'), $remember);
        if ($login) {
            if ($user->hasPermission('admin')) {
                Redirect::to('admin-product.php');
            } else {
                Redirect::to('index.php');
            }
        } else {
            echo '<div class="alert alert-danger"><strong></strong>Username or password are incorrect! Please try again...</div>';
        }
    } else {
        foreach ($validation->errors() as $error) {
            echo '<div class="alert alert-danger"><strong></strong>' . cleaner($error) . '</div>';
        }
    }
}