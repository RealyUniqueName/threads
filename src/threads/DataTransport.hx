package threads;

import haxe.Timer;
import threads.Worker;



/**
* Data transfer interface
*
*/
class DataTransport {
    /** time of last data modification */
    public var modifyTime (default,null) : Float = 0;
    /** data container */
    public var data (get,set) : Dynamic;
    public var _data : Dynamic;

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
        this.modifyTime = Timer.stamp();
    }//function new()


/*******************************************************************************
*       GETTERS / SETTERS
*******************************************************************************/

    /**
    * Getter `data`.
    *
    */
    private function get_data () : Dynamic {
        return this._data;
    }//function get_data


    /**
    * Set data
    *
    */
    private function set_data (data:Dynamic) : Dynamic {
        this.modifyTime = Timer.stamp();
        return this._data = data;
    }//function setData()

}//interface DataTransport