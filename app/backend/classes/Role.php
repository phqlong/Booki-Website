<?php

class Role {
    private $_db,
            $_data;

    public function __construct() {
        $this->_db = Database::getInstance();
    }

    public function update($fields = array(), $uid = null) {
        if ($this->_db->update('role', $uid, $fields)) {
            return true;
        }
        return false;
    }

    public function create($fields = array()) {
        if ($this->_db->insert('role', $fields)) {
            return true;
        }
        return false;
    }

    public function find($user = null) {
        if ($user) {
            $data = $this->_db->get('role', array('uid', '=', $user));
            if ($data->count()) {
                $this->_data = $data->first();
                return $this->_data;
            }
        }
        return false;
    }

    public function getAll() {
        $data = $this->_db->get('role');
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
        $uid = $this->data()->uid;
        if ($this->_db->delete('role', array('uid', '=', $uid))) {
            return true;
        }
        return false;
    }
}
