package test;

import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.Lib;
import flash.text.TextField;
import openfl.Assets;
import openfl.display.Tilesheet;
import render.RenderData;
import render.Scene;

import haxe.Timer;
import test.AddData;

// import test.Counter;
// import test.Transport;




/**
* Entry
*
*/
class Main {
    /** description */
    static public var ts : Tilesheet;
    /** description */
    static public var scene : Scene;
    /** flag to add more bunnies */
    static public var addMore : Bool = false;
    /** description */
    static public var counter : TextField;
/*******************************************************************************
*       STATIC METHODS
*******************************************************************************/

    /**
    * Entry
    *
    */
    static public function main () : Void {
        var bmp =  Assets.getBitmapData('assets/bunny.png');
        ts = new Tilesheet(bmp);
        ts.addTileRect( new Rectangle(0, 0, bmp.width, bmp.height), new Point(bmp.width / 2, bmp.height / 2) );

        scene = new Scene();
        scene.fps = Std.int(Lib.current.stage.frameRate);
        scene.run();

        Lib.current.addEventListener(Event.ENTER_FRAME, onFrame);
        Lib.current.stage.addEventListener(MouseEvent.MOUSE_DOWN, function(e:MouseEvent){ addMore = true; });
        Lib.current.stage.addEventListener(MouseEvent.MOUSE_UP, function(e:MouseEvent){ addMore = false; });

        Lib.current.addChild(new openfl.display.FPS());
        counter = cast Lib.current.addChild(new TextField());
        counter.text = '0';
        counter.x = Lib.current.stage.stageWidth / 2;
    }//function main()


    /**
    * Description
    *
    */
    static public function onFrame (e:Event = null) : Void {
        var data  : RenderData = cast scene.getData();
        var data2 : RenderData = cast scene.getData();
        while( data2 != null ){
            scene.handle(data);
            data  = data2;
            data2 = cast scene.getData();
        }

        if( data != null ){
            Lib.current.graphics.clear();
            if( data.drawData.length > data.dataLength ){
                data.drawData.splice(data.dataLength, 0xFFFFFF);
            }
            ts.drawTiles(Lib.current.graphics, data.drawData, true, Tilesheet.TILE_TRANS_2x2 /* | Tilesheet.TILE_RGB */ | Tilesheet.TILE_ALPHA);
            scene.handle(data);
        }

        if( addMore ){
            var add = new AddData();
            add.amount = 1000;
            scene.handle(add);
            counter.text = '' + (Std.parseInt(counter.text) + add.amount);
        }
    }//function onFrame()

/*******************************************************************************
*       INSTANCE METHODS
*******************************************************************************/

    /**
    * Constructor
    *
    */
    public function new () : Void {
    }//function new()

/*******************************************************************************
*       GETTERS / SETTERS
*******************************************************************************/

}//class Main