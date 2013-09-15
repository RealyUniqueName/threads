package render;

import usys.vm.Thread;
import usys.vm.Mutex;
import render.Scene;



/**
* Basic sprite
*
*/
class Sprite {
    /** x coordinate */
    public var x : Float = 0;
    /** y coordinate */
    public var y : Float = 0;
    /** rotation (radians) */
    public var rotation : Float = 0;
    /** transparency */
    public var alpha : Float = 1;
    /** scale alogn x axis */
    public var scaleX : Float = 1;
    /** scale along y axis */
    public var scaleY : Float = 1;
    /** tile index from tilesheed */
    public var tile : Int = 0;
    /** red color multiplier */
    public var red : Float = 1;
    /** green color multiplier */
    public var green : Float = 1;
    /** blue color multiplier */
    public var blue : Float = 1;
    /** do we need to call `.update()` on every frame? */
    public var runUpdate : Bool = false;
    /** visibility */
    public var visible : Bool = true;
    /** scene instance */
    public var scene : Scene = null;
    /** mutex for sprite locking */
    private var _mutex : Mutex;
    /** thread, which acquired this sprite for some actions */
    private var _lockerThread : Thread;

/*******************************************************************************
*       STATIC METHODS
*******************************************************************************/



/*******************************************************************************
*       INSTANCE METHODS
*******************************************************************************/

    /**
    * Construcotr
    *
    */
    public function new () : Void {
        this._mutex = new Mutex();
    }//function new()


    /**
    * Set `.runUpdate` to true to make this method get called on every frame
    *
    */
    public function update () : Void {
    }//function update()


    /**
    * Lock this sprite to prevent modification by other threads
    *
    */
    public function lock() : Void {
        if( this._lockerThread == Thread.current() ){
            return;
        }else{
            this._mutex.acquire();
            this._lockerThread = Thread.current();
        }
    }//function lock()

    
    /**
    * Release this sprite to allow modification by other threads
    *
    */
    public function release() : Void {
        this._lockerThread = null;
        this._mutex.release();
    }//function release()


/*******************************************************************************
*       GETTERS / SETTERS
*******************************************************************************/

}//class Sprite