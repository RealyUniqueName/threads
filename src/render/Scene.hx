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
    /** whether to skip one frame update */
    public var skipFrame : Bool = false;


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
        var sprite     : Sprite;
        var cos        : Float;
        var sin        : Float;
        var dataLength : Int = 0;

        for(i in 0...this._children.length){
            sprite = this._children[i];

            if( sprite.visible && !this.skipFrame ){

                cos = Math.cos(sprite.rotation);
                sin = Math.sin(sprite.rotation);

                this._drawDataPrep[ dataLength++ ] = sprite.x;
                this._drawDataPrep[ dataLength++ ] = sprite.y;
                this._drawDataPrep[ dataLength++ ] = sprite.tile;
                // [ a, b
                //   c, d ]
                //a
                this._drawDataPrep[ dataLength++ ] = sprite.scaleX * cos;
                //b
                this._drawDataPrep[ dataLength++ ] = sprite.scaleX * sin;
                //c
                this._drawDataPrep[ dataLength++ ] = -sprite.scaleY * sin;
                //d
                this._drawDataPrep[ dataLength++ ] = sprite.scaleY * cos;

                this._drawDataPrep[ dataLength++ ] = sprite.red;
                this._drawDataPrep[ dataLength++ ] = sprite.green;
                this._drawDataPrep[ dataLength++ ] = sprite.blue;
                this._drawDataPrep[ dataLength++ ] = sprite.alpha;
            }

            if( sprite.runUpdate ){
                sprite.update();
            }
        }

        //don't update draw data if we need to skip this frame
        if( this.skipFrame ){
            this.skipFrame = false;

        //update draw data
        }else{
            if( dataLength < this._drawDataPrep.length ){
                this._drawDataPrep.splice(dataLength, 0xFFFFFF);
            }

            this._tmpData      = this.drawData;
            this.drawData      = this._drawDataPrep;
            this._drawDataPrep = this._tmpData;
        }
    }//function main()


    /**
    * Too much work
    *
    */
    override public function onOverwork (delta:Float) : Void {
        this.skipFrame = true;
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