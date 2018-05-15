<?php

class db {
    protected $db_servername = 'db';
    protected $db_database = 'icecream';
    protected $db_username = 'root';
    protected $db_password = 'test123';

    private $conn = null;

    public $id;
    public $name;
    public $cost;

    function __construct() {
        // Create connection
        $this->conn = new mysqli($this->db_servername, $this->db_username, $this->db_password);

        // Check connection
        if ($this->conn->connect_error) {
            die("Connection failed: " . $conn->connect_error);
        }
    }

    function __destruct() {
        $this->conn->close();
    }

    protected function echo_data($tablename) {
        $table = $this->db_database . '.' . $tablename;
        $sql = "SELECT * FROM $table";
        $result = $this->conn->query($sql);

        if ($result->num_rows > 0) {
            // output data of each row
            while($row = $result->fetch_assoc()) {
                foreach ($row as $key=>$value) {
                    echo "$key: $value | ";
                }
                echo "<br>";
            }
        } else {
            echo "0 results";
        }
    }

    public function get_containers() {
        $this->echo_data('containers');
    }

    public function get_flavors() {
        $this->echo_data('flavors');
    }

    public function get_types() {
        $this->echo_data('types');
    }
}