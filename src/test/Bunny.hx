package test;

import render.Sprite;



/**
* Bunnies
*
*/
class Bunny extends Sprite{
    static public inline var MAX_SPEED = 5;
    static public inline var G = 0.3;

    /** speed */
    public var speedX : Float = 0;
    public var speedY : Float = 0;
    public var angularSpeed : Float = 0;

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
        this.tile = 0;
        this.runUpdate = true;

        this.speedX = MAX_SPEED * (2 * Math.random() - 1);
        this.speedY = 0;

        this.angularSpeed = Math.PI / 10 * (2 * Math.random() - 1);

        this.scaleX = -1 + 2 * Math.random();
        this.scaleY = -1 + 2 * Math.random();

        this.alpha = 0.2 + 0.8 * Math.random();
        this.red   = 0.2 + 0.8 * Math.random();
        this.green = 0.2 + 0.8 * Math.random();
        this.blue  = 0.2 + 0.8 * Math.random();
    }//function new()


    /**
    * Update cycle
    *
    */
    override public function update () : Void {
        if( this.y > this.scene.height ){
            this.speedY *= -1;
        }else{
            this.speedY += G;
        }

        if( this.x < 0 || this.x > this.scene.height ){
            this.speedX *= -1;
        }

        this.x += this.speedX;
        this.y += this.speedY;

        this.scaleX += 0.05;
        this.scaleY += 0.05;

        if( this.scaleX > 1 || this.scaleX < -1 ) this.scaleX *= -1;
        if( this.scaleY > 1 || this.scaleY < -1 ) this.scaleY *= -1;

        this.rotation += this.angularSpeed;
    }//function update()

/*******************************************************************************
*       GETTERS / SETTERS
*******************************************************************************/

}//class Bunny