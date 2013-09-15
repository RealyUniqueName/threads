package phys;

import nape.shape.Polygon;
import nape.phys.BodyType;
import nape.phys.Body;
import nape.geom.Vec2;
import nape.space.Space;
import threads.Worker;

/**
* Thread worker for physics simulation
*
*/
class Sim extends Worker {

    /** physical world */
    public var space (default,null) : Space = null;


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
        this.space = new Space(Vec2.weak(0, 600));
    }//function new()


    /**
    * Make static borders around game world
    *
    */
    public function boxWorld (width:Int, height:Int) : Void {
        var box : Body = new Body(BodyType.STATIC);
        //ceiling
        box.shapes.add(new Polygon(Polygon.rect(0, -10, width, 0)));
        //left wall
        box.shapes.add(new Polygon(Polygon.rect(-10, 0, 0, height)));
        //right wall
        box.shapes.add(new Polygon(Polygon.rect(width, 0, width + 10, height)));
        //floor
        box.shapes.add(new Polygon(Polygon.rect(0, height, width, height + 10)));

        box.space = this.space;
    }//function boxWorld()


    /**
    * Main cycle
    *
    */
    override public function main () : Void {
        this.space.step(this.cycleDuration);
    }//function main()

/*******************************************************************************
*       GETTERS / SETTERS
*******************************************************************************/



}//class Sim