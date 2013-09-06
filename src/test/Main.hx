package test;

import test.Counter;
import test.Transport;




/**
* Entry
*
*/
class Main {


/*******************************************************************************
*       STATIC METHODS
*******************************************************************************/

    /**
    * Entry
    *
    */
    static public function main () : Void {

        var c = new Counter();
        c.run();

        for(i in 0...10){
            var d = new Transport();
            d.data = i;
            c.handle(d);
        }

        while(true){
            Sys.sleep(10);
        }
    }//function main()


/*******************************************************************************
*       INSTANCE METHODS
*******************************************************************************/

    /**
    * Constructor
    *
    */
    public function new () : Void {
        //code...
    }//function new()

/*******************************************************************************
*       GETTERS / SETTERS
*******************************************************************************/

}//class Main