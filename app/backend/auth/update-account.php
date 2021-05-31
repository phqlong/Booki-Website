<?php
require_once 'app/backend/core/Init.php';

if (Input::exists()) {
    $validate = new Validation();
    $validation = $validate->check($_POST, array(
        'name'  => array(
            'required'  => true,
            'min'       => 2,
            'max'       => 50
            ),
        'username'  => array(
            'required'  => true,
            'min'       => 2,
            'max'       => 20
            ),
        'current_password'  => array(
            'required'  => true,
            'min'       => 6,
            'verify'     => 'password'
            ),
        'new_password'  => array(
            'optional'  => true,
            'min'       => 6,
            'bind'      => 'confirm_new_password'
            ),
        'confirm_new_password' => array(
            'optional'  => true,
            'min'       => 6,
            'match'   => 'new_password',
            'bind' => 'new_password',
            ),
    ));
    if ($validation->passed()) {
        $result = $user->update(array(
            'name'  => Input::get('name'),
            'username'  => Input::get('username'),
        ));
        if ($result) {
            if ($validation->optional()) {
                $result = $user->update(array(
                    'password' => Password::hash(Input::get('new_password'))
                ));
                if ($result) {
                    Session::flash('user-update-success', 'Profile successfully updated!');
                    Redirect::to('index.php');
                } else {
                    echo '<div class="alert alert-danger"><strong></strong>Cannot update password</div>';
                }
            } else {
                Session::flash('user-update-success', 'Profile successfully updated!');
                Redirect::to('index.php');
            }
        } else {
            echo '<div class="alert alert-danger"><strong></strong>Cannot update user account</div>';
        }
    } else {
        echo '<div class="alert alert-danger"><strong></strong>' . cleaner($validation->error()) . '</div>';
    }
}
