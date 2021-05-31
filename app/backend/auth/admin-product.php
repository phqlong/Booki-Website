<?php
require_once 'app/backend/core/Init.php';

if (Input::exists()) {
    $validate = new Validation();
    $validation = $validate->check($_POST, array(
        'name'  => array(
            'required'  => true,
            'min'       => 2,
            'max'       => 100
        ),
        'description'  => array(
            'required'  => true,
            'min'       => 2,
            'max'       => 1000
        ),
        'price'  => array(
            'required'  => true,
        ),
        'image'  => array(
            'required'  => true,
            'min'       => 6,
        ),
        'type'  => array(
            'required'  => true,
        ),
        'amount'  => array(
            'required'  => true,
        ),
    ));
    if ($validation->passed()) {
        if (Input::get('uid')) {
            $result = $product->update(array(
                'name'  => Input::get('name'),
                'description'  => Input::get('description'),
                'price'  => Input::get('price'),
                'image'  => Input::get('image'),
                'type'  => Input::get('type'),
                'amount'  => Input::get('amount'),
            ), Input::get('uid'));
            if ($result) {
                Session::flash('product-update-success', 'Product successfully updated!');
                Redirect::to('admin-product.php');
            } else {
                echo '<div class="alert alert-danger"><strong></strong>Cannot update product!</div>';
            }
        } else {
            $result = $product->create(array(
                'name'  => Input::get('name'),
                'description'  => Input::get('description'),
                'price'  => Input::get('price'),
                'image'  => Input::get('image'),
                'type'  => Input::get('type'),
                'amount'  => Input::get('amount'),
            ));
            if ($result) {
                Session::flash('product-create-success', 'Product successfully created!');
                Redirect::to('admin-product.php');
            } else {
                echo '<div class="alert alert-danger"><strong></strong>Cannot create product!</div>';
            }
        }
    } else {
        echo '<div class="alert alert-danger"><strong></strong>' . cleaner($validation->error()) . '</div>';
    }
}
