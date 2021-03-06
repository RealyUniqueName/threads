package test;

import haxe.Timer;
import threads.DataTransport;
import threads.Worker;



/**
* Description
*
*/
class Counter extends Worker{
    /** description */
    public var stamp : Float = 0;

/*******************************************************************************
*       STATIC METHODS
*******************************************************************************/



/*******************************************************************************
*       INSTANCE METHODS
*******************************************************************************/

    /**
    * Entry
    *
    */
    override public function main () : Void {
        trace(Timer.stamp() - this.stamp);
        this.stamp = Timer.stamp();
    }//function main()


/*******************************************************************************
*       GETTERS / SETTERS
*******************************************************************************/

}//class Counter