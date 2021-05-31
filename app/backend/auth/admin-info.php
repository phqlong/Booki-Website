<?php
require_once 'app/backend/core/Init.php';

if (Input::exists()) {

    $validate = new Validation();
    $validation = $validate->check($_POST, array(
        'address'  => array(
            'required'  => true
        ),
        'phone'  => array(
            'required'  => true
        ),
        'email'  => array(
            'required'  => true
        ),
        'website'  => array(
            'required'  => true
        )
    ));

    if ($validation->passed()) {
        $result = $setting->update(array(
            '_key' => 'address',
            'value' => Input::get('address')
        ), 'address');
        if ($result) {
            $result = $setting->update(array(
                '_key' => 'phone',
                'value' => Input::get('phone')
            ),'phone');
            if ($result) {
                $result = $setting->update(array(
                    '_key' => 'email',
                    'value' => Input::get('email')
                ),'email');
                if ($result) {
                    $result = $setting->update(array(
                        '_key' => 'website',
                        'value' => Input::get('website')
                    ), 'website');
                    if ($result) {
                        echo '<div class="alert alert-success"><strong></strong>Updated information successfully!</div>';
                    } else {
                        echo '<div class="alert alert-danger"><strong></strong>Cannot update information!</div>';
                    }
                } else {
                    echo '<div class="alert alert-danger"><strong></strong>Cannot update information!</div>';
                }
            } else {
                echo '<div class="alert alert-danger"><strong></strong>Cannot update information!</div>';
            }
        } else {
            echo '<div class="alert alert-danger"><strong></strong>Cannot update information!</div>';
        }
    } else {
        echo '<div class="alert alert-danger"><strong></strong>' . cleaner($validation->error()) . '</div>';
    }
}
