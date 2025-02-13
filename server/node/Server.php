<?php

include_once "./dbconfig.php";

class Server
{
    protected $_dbconnection = null;
    protected $_dbname = DATADBNAME;
    protected $_request = [
        "type" => "UNKNOW",
        "data" => "",
    ];
    protected $_response = [
        "success" => false,
        "message" => "unknow error",
        "data" => ""
    ];
    public function __construct()
    {

    }

    public function __destruct()
    {
        $this->closeDB();
    }

    /**
     * connect to database 
     * 
     * @return bool
     */
    public function openDB()
    {
        $this->_dbconnection = @pg_connect("host=" . HOST . " port=" . PORT . " dbname=" . $this->_dbname . " user=" . USERNAME . " password=" . PASSWORD);

        if (!$this->_dbconnection) {
            $this->makeResponse(false, "Can not connect to database");
            return false;
        }
        return true;
    }

    /**
     * close database connection
     * 
     * @return void
     */
    public function closeDB()
    {
        if ($this->_dbconnection) {
            @pg_close($this->_dbconnection);
            $this->_dbconnection = null;
        }
    }

    /**
     * create a array which contains response info
     * @param mixed $success    varable success is set to true if the service run success, otherwise fasle
     * @param mixed $message    message of the service
     * @param mixed $data       data return to the client
     * @return void
     */
    protected function makeResponse($success, $message, $data = "")
    {
        $this->_response = [
            "success" => $success,
            "message" => $message,
            "data" => $data
        ];
    }

    /**
     * All subclass of Server must reimplement this function.
     * @return void
     */
    protected function process()
    {
        $result = @pg_query_params($this->_dbconnection, "select sc_service_run($1)", array(
            json_encode($this->_request)
        ));
        if (!$result) {
            $this->makeResponse(false, @pg_last_error($this->_dbconnection));
            return;
        }
        $row = @pg_fetch_row($result);
        $res = json_decode($row[0]);
        $this->makeResponse($res->success, $res->message, $res->data);
    }

    /**
     * Run the server.
     * This function will call process to start and finish the real task.
     * @return void
     */
    public function run()
    {
        if (!$this->openDB()) {
            return;
        }
        $this->process();
        $this->closeDB();
    }

    /**
     * Summary of getResponse
     * @return array
     */
    public function getResponse()
    {
        return $this->_response;
    }

    /**
     * Set request parameter for the server.
     * @param mixed $request
     *  A valid request should be a json object which must contains 2 fields: type, data. 
     *  The following codes is an example: 
     *  {
     *      "type": "USER_CREATE",
     *      "data": {
     *          "username": "email@163.com",
     *          "password": "some password",
     *          "verify_code": "aededf"
     *      }
     *  }
     * @return void
     */
    public function setRequest($request)
    {
        $this->_request = $request;
    }


    /**
     * Summary of executeSQL
     * @param mixed $sql
     * @param mixed $params
     * @return void
     */
    public function executeSQL($sql, $params = [])
    {
        $result = pg_query_params($this->_dbconnection, $sql, $params);
        if (!$result) {
            $this->makeResponse(false, @pg_last_error($this->_dbconnection));
            return;
        }
        @pg_free_result($result);
    }


    public function executeSQLAndReturnOneValue($sql, $params = [])
    {
        $result = pg_query_params($this->_dbconnection, $sql, $params);
        if (!$result) {
            $this->makeResponse(false, @pg_last_error($this->_dbconnection));
            return;
        }
        if (pg_num_rows($result) === 0) {
            return;
        }
        $row = pg_fetch_row($result);

        @pg_free_result($result);
        return $row[0];
    }
}
