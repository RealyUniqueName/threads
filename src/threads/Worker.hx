package threads;

import haxe.Timer;
import threads.DataTransport;
import usys.vm.Deque;
import usys.vm.Thread;


/**
* Worker class
*
*/
class Worker {
    /** worker's thread */
    public var thread (default,null) : Thread;
    /** amount of cycles per second */
    public var cps (get,set) : Float;
    private var _cps : Float = 1;
    /** time frame for one cycle */
    public var cycleDuration (get,set) : Float;
    private var _cycleDuration : Float = 1;
    /** incoming data */
    private var _inData : Deque<DataTransport>;
    /** outgoing data */
    private var _outData : Deque<DataTransport>;
    /** Worker will work until this is set to false */
    private var _keepWorking : Bool = true;


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
        this._inData  = new Deque();
        this._outData = new Deque();
    }//function new()


    /**
    * Start worker's thread
    *
    */
    public function run () : Void {
        if( this.thread != null ) throw "Worker can start one time only";

        this.thread = Thread.create(this._work);
    }//function run()


    /**
    * Stop worker
    *
    */
    public function stop () : Void {
        this._keepWorking = false;
    }//function stop()


    /**
    * Send some data to this owrker
    *
    */
    public function handle (data:DataTransport) : Void {
        data.sendTime = Timer.stamp();
        this._inData.add(data);
    }//function handle()


    /**
    * Send data to outgoing channel
    *
    */
    public function send (data:DataTransport) : Void {
        data.sendTime = Timer.stamp();
        this._outData.add(data);
    }//function send()


    /**
    * Get data from outgoing channel
    *
    */
    public function getData () : DataTransport {
        return this._outData.pop(false);
    }//function getData()


    /**
    * Worker method
    *
    */
    private function _work () : Void {
        var inTime       : Float = Timer.stamp();
        var nextTime     : Float = inTime + this._cycleDuration;
        var outTime      : Float;
        var dataSendTime : Float;
        var data         : DataTransport;

        while( this._keepWorking ){
            //process incoming data {
                data = this._inData.pop(false);
                while( data != null ){
                    dataSendTime = data.sendTime;
                    data.process(this);

                    if( dataSendTime < inTime ){
                        data = this._inData.pop(false);
                    }else{
                        data = null;
                    }
                }
            //}

            this.main();

            outTime = Timer.stamp();
            if( nextTime > outTime ){
                Sys.sleep(nextTime - outTime);
                inTime   = nextTime;
                nextTime = inTime + this._cycleDuration;
            }else{
                this.onOverwork();
            }
        }
    }//function _work()


    /**
    * Entry point for each cycle
    *
    */
    public function main () : Void {
    }//function main()


    /**
    * This method will be called if worker exceeds time limit for one cycle duration
    *
    */
    public function onOverwork () : Void {
    }//function onOverwork()


/*******************************************************************************
*       GETTERS / SETTERS
*******************************************************************************/

    /**
    * Getter `cps`.
    *
    */
    private inline function get_cps () : Float {
        return this._cps;
    }//function get_cps


    /**
    * Setter `cps`.
    *
    */
    private inline function set_cps (cps:Float) : Float {
        if( cps <= 0 ) cps = 1;
        this._cycleDuration = 1 / cps;

        return this._cps = cps;
    }//function set_cps


    /**
    * Getter `cycleDuration`.
    *
    */
    private inline function get_cycleDuration () : Float {
        return this._cycleDuration;
    }//function get_cycleDuration


    /**
    * Setter `cycleDuration`.
    *
    */
    private inline function set_cycleDuration (cycleDuration:Float) : Float {
        if( cycleDuration <= 0 ) cycleDuration = 1;
        this._cps = 1000 / cycleDuration;

        return this._cycleDuration = cycleDuration;
    }//function set_cycleDuration

}//class Worker