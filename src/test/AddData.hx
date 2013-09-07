package test;

import render.Scene;
import threads.DataTransport;
import threads.Worker;

/**
* Add more bannies
*
*/
class AddData extends DataTransport{

    /** how many bunnies to add */
    public var amount : Int = 1;


/*******************************************************************************
*       STATIC METHODS
*******************************************************************************/



/*******************************************************************************
*       INSTANCE METHODS
*******************************************************************************/

    /**
    * Description
    *
    */
    override public function process (worker:Worker) : Void {
        var scene : Scene = cast worker;
        var bunny : Bunny;
        while( amount-- > 0 ){
            bunny = new Bunny();
            bunny.x = scene.width * Math.random();
            bunny.y = scene.height * 0.5 * Math.random();
            scene.addSprite(bunny);
        }
    }//function process()

/*******************************************************************************
*       GETTERS / SETTERS
*******************************************************************************/

}//class AddData