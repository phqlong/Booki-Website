<?php

class Setting {
    private $_db,
            $_data;

    public function __construct() {
        $this->_db = Database::getInstance();
    }

    public function update($fields = array(), $_key = null) {
        if ($this->_db->updateSetting('setting', $_key, $fields)) {
            return true;
        }
        return false;
    }

    public function create($fields = array()) {
        if ($this->_db->insert('setting', $fields)) {
            return true;
        }
        return false;
    }

    public function find($_key = null) {
        if ($_key) {
            $data = $this->_db->get('setting', array('_key', '=', $_key));
            if ($data->count()) {
                $this->_data = $data->first();
                return $this->_data;
            }
        }
        return false;
    }

    public function getAll($condition = array()) {
        $data = $this->_db->get('setting', $condition);
        if ($data->count()) {
            $this->_data = $data->results();
            return $this->_data;
        }
        return false;
    }

    public function data() {
        return $this->_data;
    }

    public function deleteMe() {
        $_key = $this->data()->_key;
        if ($this->_db->delete('setting', array('_key', '=', $_key))) {
            return true;
        }
        return false;
    }
}
