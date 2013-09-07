package render;

import render.Scene;
import threads.DataTransport;
import threads.Worker;


/**
* Tiles data for Tilesheet.drawTiles()
*
*/
class RenderData extends DataTransport{

    /** draw data array */
    public var drawData : Array<Float>;
    /** amount of up-to-date elements in drawData */
    public var dataLength : Int = 0;

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
        super();
        this.drawData = [];
    }//function new()


    /**
    * Process received data
    *
    */
    override public function process (worker:Worker) : Void {
        cast(worker, Scene).setFreeRenderData(this);
    }//function process()

/*******************************************************************************
*       GETTERS / SETTERS
*******************************************************************************/

}//class RenderData