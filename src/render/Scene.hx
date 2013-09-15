package render;

import render.Sprite;
import threads.Worker;



/**
* Scene
*
*/
class Scene extends Worker{

    /** frames per second */
    public var fps (get,set) : Int;
    /** sprites on this scene */
    private var _children : Array<Sprite>;
    /** Scene width */
    public var width : Float = 800;
    /** scene height */
    public var height : Float = 600;
    /** object for preparing data for drawTiles() calls */
    private var _drawDataPrep : Array<Float>;
    /** prepared data for drawTiles() calls */
    public var drawData (default,null) : Array<Float>;
    /** helper var for array swapping */
    private var _tmpData : Array<Float>;
    

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
        this._children = [];
        this._drawDataPrep = [];
        this.drawData  = [];
    }//function new()


    /**
    * Add sprite to scene at specified index
    *
    */
    public function addSprite (sprite:Sprite, index:Int = 0xFFFFFF) : Void {
        sprite.scene = this;
        this._children.insert(index, sprite);
    }//function addSprite()


    /**
    * Main cycle
    *
    */
    override public function main () : Void {
        for(i in 0...this._children.length){
            if( this._children[i].runUpdate ){
//                this._children[i].lock();
                this._children[i].update();
//                this._children[i].release();
            }
        }
    }//function main()


    /**
    * Gather draw data
    *
    */
    public function getDrawData() : Array<Float> {
        var cos        : Float;
        var sin        : Float;
        var dataLength : Int = 0;

        for(i in 0...this._children.length){
            if( this._children[i].visible ){
//                this._children[i].lock();

                cos = Math.cos(this._children[i].rotation);
                sin = Math.sin(this._children[i].rotation);

                this._drawDataPrep[ dataLength++ ] = this._children[i].x;
                this._drawDataPrep[ dataLength++ ] = this._children[i].y;
                this._drawDataPrep[ dataLength++ ] = this._children[i].tile;
                // [ a, b
                //   c, d ]
                //a
                this._drawDataPrep[ dataLength++ ] = this._children[i].scaleX * cos;
                //b
                this._drawDataPrep[ dataLength++ ] = this._children[i].scaleX * sin;
                //c
                this._drawDataPrep[ dataLength++ ] = -this._children[i].scaleY * sin;
                //d
                this._drawDataPrep[ dataLength++ ] = this._children[i].scaleY * cos;

                this._drawDataPrep[ dataLength++ ] = this._children[i].red;
                this._drawDataPrep[ dataLength++ ] = this._children[i].green;
                this._drawDataPrep[ dataLength++ ] = this._children[i].blue;
                this._drawDataPrep[ dataLength++ ] = this._children[i].alpha;

//                this._children[i].release();
            }
        }

        if( dataLength < this._drawDataPrep.length ){
            this._drawDataPrep.splice(dataLength, 0xFFFFFF);
        }

        return this._drawDataPrep;
    }//function getDrawData()


    /**
    * Too much work
    *
    */
    override public function onOverwork (delta:Float) : Void {
        trace('Overwork - ' + this._children.length + ' - by ' + delta + ' seconds');
    }//function onOverwork()

/*******************************************************************************
*       GETTERS / SETTERS
*******************************************************************************/

    /**
    * Getter `fps`.
    *
    */
    private inline function get_fps () : Int {
        return Std.int(this.cps);
    }//function get_fps


    /**
    * Setter `fps`.
    *
    */
    private inline function set_fps (fps:Int) : Int {
        this.cps = fps;

        return fps;
    }//function set_fps

}//class Scene