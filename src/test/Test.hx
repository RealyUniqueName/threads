package test;

import haxe.Timer;

/**
* Description
*
*/
class Test {


/*******************************************************************************
*       STATIC METHODS
*******************************************************************************/

    /**
    * Description
    *
    */
    static public function main () : Void {
trace('POP:');
        for(i in 0...5){
            Sys.sleep(0.5);

            var arr : Array<Int> = [for(i in 0...0xFFFFFF) i];

            var q : Int = 1;

            Sys.sleep(0.5);

            var tm = Timer.stamp();

            while(arr.length > q){
                arr.pop();
            }

            trace(haxe.Timer.stamp() - tm);
        }

trace('SPLICE:');
        for(i in 0...5){
            Sys.sleep(0.5);

            var arr : Array<Int> = [for(i in 0...0xFFFFFF) i];

            var q : Int = 1;

            Sys.sleep(0.5);

            var tm = Timer.stamp();

            arr.splice(q,0xFFFFFF);

            trace(haxe.Timer.stamp() - tm);
        }
    }//function main()

/*******************************************************************************
*       INSTANCE METHODS
*******************************************************************************/



/*******************************************************************************
*       GETTERS / SETTERS
*******************************************************************************/

}//class Test