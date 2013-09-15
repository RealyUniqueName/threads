package threads;


import usys.vm.Mutex;

/**
* Safe data transfer across threads.
* FIFO
*/
class Pipe<T> {

    /** internal data storage */
    private var _data : Array<T> = null;
    /** mutex for locking access */
    private var _lock : Mutex = null;


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
        this._lock = new Mutex();
        this._data = [];
    }//function new()


    /**
    * Push data to storage
    *
    */
    public function push (value:T) : Void {
        this._lock.acquire();
        this._data.push(value);
        this._lock.release();
    }//function push()


    /**
    * Pop data from storage
    *
    */
    public function pop () : T {
        this._lock.acquire();
        var value = this._data.pop();
        this._lock.release();

        return value;
    }//function pop()

/*******************************************************************************
*       GETTERS / SETTERS
*******************************************************************************/



}//class Pipe