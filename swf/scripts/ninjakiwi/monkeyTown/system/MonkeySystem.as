package ninjakiwi.monkeyTown.system
{
   import com.ninjakiwi.gateway.nk.NKGateway;
   import com.ninjakiwi.gateway.nk.NKGatewayUser;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Stage;
   import flash.events.EventDispatcher;
   import flash.geom.ColorTransform;
   import flash.text.StyleSheet;
   import flash.utils.getTimer;
   import flash.utils.setTimeout;
   import ninjakiwi.monkeyTown.Main;
   import ninjakiwi.monkeyTown.town.city.ActiveCity;
   import ninjakiwi.monkeyTown.town.townMap.TownMap;
   import ninjakiwi.monkeyTown.userServices.kong.Kong;
   import ninjakiwi.monkeyTown.utils.IntPoint2D;
   import ninjakiwi.monkeyTown.utils.Random;
   import org.osflash.signals.Signal;
   
   public class MonkeySystem
   {
      
      public static const unavailableColorTransform:ColorTransform = new ColorTransform(0.29,0.29,0.29,1,146,111,50,0);
      
      private static var _instance:MonkeySystem;
       
      
      public const CENTRAL_DISPATCHER:EventDispatcher = new EventDispatcher();
      
      public var RENDER_SURFACE_WIDTH:int = 800;
      
      public var RENDER_SURFACE_HEIGHT:int = 600;
      
      public const TOWN_MAP_WIDTH_GRIDSPACE:int = 60;
      
      public const TOWN_MAP_HEIGHT_GRIDSPACE:int = 50;
      
      public const VILLAGE_POSITION_X:int = int(this.TOWN_MAP_WIDTH_GRIDSPACE * 0.5) - 1;
      
      public const VILLAGE_POSITION_Y:int = int(this.TOWN_MAP_HEIGHT_GRIDSPACE * 0.5) - 1;
      
      public const FIRST_BUILDING:IntPoint2D = new IntPoint2D(this.VILLAGE_POSITION_X + 3,this.VILLAGE_POSITION_Y + 0);
      
      public const TOWN_MAP_PIXEL_WIDTH:int = this.TOWN_MAP_WIDTH_GRIDSPACE * this.TOWN_GRID_UNIT_SIZE;
      
      public const TOWN_MAP_PIXEL_HEIGHT:int = this.TOWN_MAP_HEIGHT_GRIDSPACE * this.TOWN_GRID_UNIT_SIZE;
      
      public const TOWN_GRID_UNIT_SIZE:int = 64;
      
      public const USE_BAKED_DATA_FOR_DEV:Boolean = true;
      
      public const USE_BAKED_DATA_IN_LIVE:Boolean = false;
      
      public const NO_LIVES_LOST_BLOONSTONES_BONUS:int = 5;
      
      public const SECOND_CITY_DIFFICULTY_MODIFIER:Number = 1.1;
      
      public const resizeSignal:Signal = new Signal(int,int);
      
      public var flashStage:Stage = null;
      
      private var _serverTimeHasBeenInitialised:Boolean = false;
      
      public var serverTimeHasBeenInitialisedSignal:Signal;
      
      public var secureStartTime:Number = 0;
      
      private var _secureStartTimeSystemTimeAtInit:Number = 0;
      
      public var loadInProgress:Boolean = false;
      
      public const RND:Random = new Random();
      
      public var city:ActiveCity;
      
      public var map:TownMap;
      
      public const HORIZON_HEIGHT:int = 128.0;
      
      public const CLIFFS_HEIGHT:int = 144.0;
      
      public const styleSheet:StyleSheet = new StyleSheet();
      
      public const styleSheetString:String = ["h1{ font-size:20px; text-align: center; leading:10px; font-family:Oetztype; }",".title{ font-size:16px; font-family:Oetztype; } ",".subContent{ color:#333333; font-size:12px; } ",".bold{ font-weight:bold; }",".red{ color:#E21717; font-size:12px; font-weight:bold; } ",".green{ color:#60BE02; font-size:12px; font-weight:bold;} ",".blue{ color:#3366FF; font-size:12px; font-weight:bold; } ",".yellow{ color:#FFCC33; font-size:12px; font-weight:bold; } ",".space { font-size:1px; leading:5px; } ",".upgradeNow { color:#ccccFF;font-size:14px; }",".imperative { color:#ffffff; font-weight:bold; }",".bolded { font-weight:bold;}"].join();
      
      public var useUserSeed:Boolean = false;
      
      public var userSeed:uint = 1;
      
      private var _nkGatewayUser:NKGatewayUser = null;
      
      public var nkGateway:NKGateway = null;
      
      private var _timeHackerHasBeenReported:Boolean = false;
      
      public function MonkeySystem(param1:SingletonBlocker#1693)
      {
         this.serverTimeHasBeenInitialisedSignal = new Signal();
         super();
         if(param1 == null)
         {
            throw new Error("Error: Instantiation failed: Use MonkeySystem.getInstance() instead of new.");
         }
         this.init();
      }
      
      public static function getInstance() : MonkeySystem
      {
         if(_instance == null)
         {
            _instance = new MonkeySystem(new SingletonBlocker#1693());
         }
         return _instance;
      }
      
      private function init() : void
      {
         this.initCSS();
      }
      
      private function initCSS() : void
      {
         this.styleSheet.parseCSS(this.styleSheetString);
      }
      
      public function getSecureTime() : Number
      {
         if(!this.serverTimeHasBeenInitialised)
         {
            throw new Error("attempted to get secure server time before it was initialised");
         }
         var _loc1_:Number = new Date().getTime();
         var _loc2_:Number = getTimer();
         var _loc3_:Number = this.secureStartTime + _loc2_;
         return _loc3_;
      }
      
      public function setServerTime(param1:Number) : void
      {
         this.secureStartTime = param1 - getTimer();
         this._secureStartTimeSystemTimeAtInit = new Date().getTime();
         this._serverTimeHasBeenInitialised = true;
         this.serverTimeHasBeenInitialisedSignal.dispatch();
      }
      
      public function yield(param1:Function, param2:Array = null, param3:* = null, param4:Number = 0) : void
      {
         var f:Function = param1;
         var args:Array = param2;
         var thisArg:* = param3;
         var delay:Number = param4;
         if(Array != null)
         {
            setTimeout(function():void
            {
               f.apply(thisArg,args);
            },delay);
         }
         else if(thisArg != null)
         {
            setTimeout(function():void
            {
               f.call(thisArg);
            },delay);
         }
         else
         {
            setTimeout(f,delay);
         }
      }
      
      public function get nkGatewayUser() : NKGatewayUser
      {
         if(this._nkGatewayUser === null)
         {
            Main.instance.unLockReturnToHomeScreen();
            Main.instance.returnToHomeScreen();
            return null;
         }
         return this._nkGatewayUser;
      }
      
      public function setNKGatewayUser(param1:NKGatewayUser) : void
      {
         this._nkGatewayUser = param1;
      }
      
      public function get userName() : String
      {
         if(Kong.isOnKong())
         {
            return Kong.getKongUsername();
         }
         return this._nkGatewayUser.loginInfo.name;
      }
      
      public function get mainBitmap() : Bitmap
      {
         return Main.instance.mainBitmap;
      }
      
      public function get renderSurface() : BitmapData
      {
         return Main.instance.mainBitmapData;
      }
      
      public function get serverTimeHasBeenInitialised() : Boolean
      {
         return this._serverTimeHasBeenInitialised;
      }
   }
}

class SingletonBlocker#1693
{
    
   
   function SingletonBlocker#1693()
   {
      super();
   }
}
