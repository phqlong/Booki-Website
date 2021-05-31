<?php
require_once 'app/backend/core/Init.php';

$setting = new Setting();
$Setting = $setting->getAll();
function getSetting($key) {
    global $Setting;
    $result = current(array_filter($Setting, function($element) use($key) {
        return $element->_key == $key;
    }));
    if ($result && array_key_exists('value', $result)) {
        return $result->value;
    }
    return false;
}
function refreshSetting() {
    global $Setting, $setting;
    $Setting = $setting->getAll();
}