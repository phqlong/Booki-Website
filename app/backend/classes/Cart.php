<?php

class Cart {
    private $_db,
            $_data;

    public function __construct() {
        $this->_db = Database::getInstance();
    }

    public function add($userId = null, $productId = null) {
        if ($userId && $productId) {
            $result = $this->find($userId, $productId);
            if ($result) {
                if ((int)$result->amount < (int)$result->max) {
                    if ($this->_db->update('cart', $result->uid, array('amount' => ((int)$result->amount) + 1))) {
                        return true;
                    }
                } else {
                    if ($this->_db->update('cart', $result->uid, array('amount' => (int)$result->max))) {
                        return true;
                    }
                }
            } else {
                if ($this->_db->insert('cart', array('user_id' => $userId, 'product_id' => $productId, 'amount' => 1))) {
                    return true;
                }
            }
        }
        return false;
    }

    public function find($userId = null, $productId = null) {
        if ($userId) {
            if ($productId) {
                $query = $this->_db->query('SELECT product.*, product.amount as \'max\', cart.user_id, cart.amount, cart.uid from cart left join product on cart.product_id = product.uid where cart.user_id=? and cart.product_id=?',array($userId, $productId));
                if (!$query->error()) {
                    return $this->_db->first();
                }
            } else {
                if (!$this->_db->query('SELECT product.*, product.amount as \'max\', cart.user_id, cart.amount, cart.uid from cart left join product on cart.product_id = product.uid where cart.user_id=? and cart.amount > 0;',array($userId))->error()) {
                    return $this->_db->first();
                }
            }
        }
        return false;
    }

    public function findAll($userId = null, $productId = null) {
        if ($userId) {
            if ($productId) {
                if (!$this->_db->query('SELECT product.*, product.amount as \'max\', cart.user_id, cart.amount, cart.uid from cart left join product on cart.product_id = product.uid where cart.user_id=? and cart.product_id=? and cart.amount > 0',array($userId, $productId))->error()) {
                    return $this->_db->results();
                }
            } else {
                if (!$this->_db->query('SELECT product.*, product.amount as \'max\', cart.user_id, cart.amount, cart.uid from cart left join product on cart.product_id = product.uid where cart.user_id=? and cart.amount > 0;',array($userId))->error()) {
                    return $this->_db->results();
                }
            }
        }
        return false;
    }

    public function amount($user) {
        if ($user) {
            $result = $this->findAll($user);
            if ($result) {
                return array_reduce($result, function($v, $w) {
                    return $v + $w->amount;
                }, 0);
            }
        }
        return 0;
    }

    public function cash($user) {
        if ($user) {
            $result = $this->findAll($user);
            if ($result) {
                return array_reduce($result, function($v, $w) {
                    return $v + $w->amount * $w->price;
                }, 0);
            }
        }
        return 0;
    }

    public function clear($user = null) {
        if ($user) {
            if (!$this->_db->query('UPDATE cart SET amount=0 where cart.user_id=?;',array($user))->error()) {
                return true;
            }
        }
        return false;
    }

    public function data() {
        return $this->_data;
    }

}
