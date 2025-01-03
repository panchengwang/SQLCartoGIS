<?php
include_once "./dbconfig.php";
include_once "./Server.php";

class UserServer extends Server
{

    /**
     * 
     */
    public function __construct()
    {
        parent::__construct();
        $this->_dbname = "sc_user_db";
    }

    public function __destruct()
    {
        parent::__destruct();
    }

    protected function process()
    {
        if ($this->_request->type === "USER_CREATE") {
            parent::process();
            if (!$this->_response["success"]) {
                return;
            }
            $this->createUser();
        } else {
            parent::process();
        }

    }

    protected function createUser()
    {
        $this->makeResponse(true, "Create user success!");
        $userid = $this->executeSQLAndReturnOneValue("select sc_user_get_id_by_name($1)", [
            $this->_request->data->username
        ]);
        $this->executeSQL("create database sc_db_$userid with template=sc_template");
        $this->executeSQL("alter database sc_db_$userid owner to sc_user_$userid");
        $this->executeSQL("grant all on database sc_db_$userid to sc_user_$userid");

        // $conn = @pg_connect("host=" . HOST . " port=" . PORT . " dbname=sc_db_$userid user=" . USERNAME . " password= ");
        // if (!$conn) {
        //     $this->makeResponse(false, "Can not connect to db sc_db_$userid");
        //     return;
        // }
        // @pg_query_params($conn, "create extension dblink", []);
        // @pg_query_params($conn, "create extension \"uuid-ossp\"", []);
        // @pg_query_params($conn, "create extension postgis", []);
        // @pg_query_params($conn, "create extension postgis_sfcgal", []);
        // @pg_query_params($conn, "create extension postgis_sqlcarto", []);

        // @pg_close($conn);
    }

}
