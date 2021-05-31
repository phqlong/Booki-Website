<?php
require_once 'app/backend/core/Init.php';

if (Input::exists()) {
    $validate = new Validation();
    $validation = $validate->check($_POST, array(
        'uid'  => array(
            'required'  => true,
        ),
        'name'  => array(
            'required'  => true,
            'min'       => 2,
            'max'       => 50
        ),
        'address'  => array(
            'required'  => true,
            'min'       => 10,
            'max'       => 1000
        ),
        'phone'  => array(
            'required'  => true,
            'min'       => 7,
        ),
        'email'  => array(
            'required'  => true,
            'min'       => 6,
        ),
    ));
    if ($validation->passed()) {
        $result = $user->update(array(
            'name'  => Input::get('name'),
            'address'  => Input::get('address'),
            'phone'  => Input::get('phone'),
            'email'  => Input::get('email'),
        ), Input::get('uid'));
        if ($result) {
            if ($cart->clear($user->data()->uid)) {
                Session::flash('checkout-success', 'Đã đặt hàng thành công!');
                Redirect::to('index.php');
                return;
            } else {
                echo '<div class="alert alert-danger"><strong></strong>Cannot process your cart!</div>';
            };
        } else {
            echo '<div class="alert alert-danger"><strong></strong>Cannot update user!</div>';
        }
    } else {
        echo '<div class="alert alert-danger"><strong></strong>' . cleaner($validation->error()) . '</div>';
    }
}
