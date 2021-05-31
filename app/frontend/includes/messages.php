<?php

if (Session::exists('register-success')) {
  echo '<div class="alert alert-success"><strong></strong>' . Session::flash('register-success') . '</div>';
}

if (Session::exists('update-success')) {
  echo '<div class="alert alert-success"><strong></strong>' . Session::flash('update-success') . '</div>';
}

if (Session::exists('product-update-success')) {
  echo '<div class="alert alert-success"><strong></strong>' . Session::flash('product-update-success') . '</div>';
}

if (Session::exists('product-create-success')) {
  echo '<div class="alert alert-success"><strong></strong>' . Session::flash('product-create-success') . '</div>';
}

if (Session::exists('product-delete-success')) {
    echo '<div class="alert alert-success"><strong></strong>' . Session::flash('product-delete-success') . '</div>';
}

  if (Session::exists('product-delete-fail')) {
  echo '<div class="alert alert-danger"><strong></strong>' . Session::flash('product-delete-fail') . '</div>';
}

if (Session::exists('user-delete-success')) {
    echo '<div class="alert alert-success"><strong></strong>' . Session::flash('user-delete-success') . '</div>';
}

if (Session::exists('user-delete-fail')) {
  echo '<div class="alert alert-danger"><strong></strong>' . Session::flash('user-delete-fail') . '</div>';
}

if (Session::exists('user-update-success')) {
  echo '<div class="alert alert-success"><strong></strong>' . Session::flash('user-update-success') . '</div>';
}

if (Session::exists('checkout-success')) {
  echo '<div class="alert alert-success"><strong></strong>' . Session::flash('checkout-success') . '</div>';
}
