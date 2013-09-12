package test;

import usys.vm.Deque;
import usys.vm.Mutex;
import haxe.Timer;

/**
* Description
*
*/
class Test {
    private var mtx : Mutex;
    private var arr : Array<Int>;
    private var deq : Deque<Int>;
/*******************************************************************************
*       STATIC METHODS
*******************************************************************************/

    /**
    * Description
    *
    */
    static public function main () : Void {
        var t = new Test();
        var repeat = 10000;

        trace('MUTEX');
        for(q in 0...5){
            Sys.sleep(0.5);
            var tm = Timer.stamp();
            for(i in 0...repeat){
                t.mtxAdd(i);
            }
            trace(Timer.stamp() - tm);
        }

        trace('DEQUE');
        for(q in 0...3){
            Sys.sleep(0.5);
            var tm = Timer.stamp();
            for(i in 0...repeat){
                t.deqAdd(i);
            }
            trace(Timer.stamp() - tm);
        }
    }//function main()

/*******************************************************************************
*       INSTANCE METHODS
*******************************************************************************/

    public function new(){
        mtx = new Mutex();
        arr = [];
        deq = new Deque();
    }


    public inline function mtxAdd(v:Int){
        this.mtx.acquire();
        //arr.push(v);
        arr.pop();
        this.mtx.release();
    }

    public inline function deqAdd(v:Int){
        //deq.push(v);
        deq.pop(false);
    }

/*******************************************************************************
*       GETTERS / SETTERS
*******************************************************************************/

}//class Test