package threads;

import haxe.Timer;
import threads.Worker;



/**
* Data transfer interface
*
*/
class DataTransport {
    /** time of last data modification */
    public var sendTime : Float = 0;

/*******************************************************************************
*       STATIC METHODS
*******************************************************************************/



/*******************************************************************************
*       INSTANCE METHODS
*******************************************************************************/


    /**
    * Constructor
    *
    */
    public function new () : Void {
    }//function new()


    /**
    * This methid will be called once data is received by worker
    *
    */
    public function process (worker:Worker) : Void {
    }//function process()


/*******************************************************************************
*       GETTERS / SETTERS
*******************************************************************************/


}//interface DataTransport