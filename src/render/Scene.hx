package render;

import render.RenderData;
import render.Sprite;
import threads.Worker;



/**
* Scene
*
*/
class Scene extends Worker{

    /** available container for drawTiles data */
    private var _renderData : RenderData = null;
    /** frames per second */
    public var fps (get,set) : Int;
    /** sprites on this scene */
    private var _children : Array<Sprite>;
    /** Scene width */
    public var width : Float = 800;
    /** scene height */
    public var height : Float = 600;

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
    * Get empty render data
    *
    */
    public inline function getFreeRenderData () : RenderData {
        if( this._renderData == null ){
            return new RenderData();

        }else{
            var data = this._renderData;
            data.dataLength = 0;

            this._renderData = null;

            return data;
        }
    }//function getFreeRenderData()


    /**
    * Store free data transport
    *
    */
    public inline function setFreeRenderData (data:RenderData) : Void {
        this._renderData = data;
    }//function setFreeRenderData()


    /**
    * Main cycle
    *
    */
    override public function main () : Void {
        var sprite : Sprite;
        var data   : RenderData = this.getFreeRenderData();
        var cos    : Float;
        var sin    : Float;

        for(i in 0...this._children.length){
            sprite = this._children[i];

            if( sprite.visible ){
                cos = Math.cos(sprite.rotation);
                sin = Math.sin(sprite.rotation);

                data.drawData[ data.dataLength++ ] = sprite.x;
                data.drawData[ data.dataLength++ ] = sprite.y;
                data.drawData[ data.dataLength++ ] = sprite.tile;
                data.drawData[ data.dataLength++ ] = sprite.scaleX * cos;
                data.drawData[ data.dataLength++ ] = sin;
                data.drawData[ data.dataLength++ ] = -sin;
                data.drawData[ data.dataLength++ ] = sprite.scaleY * cos;

                // data.drawData[ data.dataLength++ ] = sprite.red;
                // data.drawData[ data.dataLength++ ] = sprite.green;
                // data.drawData[ data.dataLength++ ] = sprite.blue;
                data.drawData[ data.dataLength++ ] = sprite.alpha;
            }

            if( sprite.runUpdate ){
                sprite.update();
            }
        }

        this.send(data);
    }//function main()


    /**
    * Too much work
    *
    */
    override public function onOverwork () : Void {
        trace('Overwork - ' + this._children.length);
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