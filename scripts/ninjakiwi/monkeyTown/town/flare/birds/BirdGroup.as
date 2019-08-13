package ninjakiwi.monkeyTown.town.flare.birds
{
   import com.codecatalyst.promise.Promise;
   import com.lgrey.vectors.LGVector2D;
   import flash.display.BitmapData;
   import flash.geom.Rectangle;
   import flash.net.URLRequest;
   import flash.utils.getTimer;
   import ninjakiwi.link.URLLoaderPromise;
   import ninjakiwi.link.User;
   import ninjakiwi.monkeyTown.town.bmcEvents.GameSignals;
   import ninjakiwi.monkeyTown.town.data.GameMods;
   import ninjakiwi.monkeyTown.town.flare.FlareManager;
   import ninjakiwi.monkeyTown.town.quests.QuestCounter;
   
   public class BirdGroup
   {
       
      
      public var target:LGVector2D;
      
      private var _numberOfBirds:int = 3;
      
      private var _birds:Vector.<Bird>;
      
      private var _timeOfLastSyncToMouse:Number = 0;
      
      private var _syncToMouseFrequency:Number = 60000.0;
      
      public function BirdGroup()
      {
         this.target = new LGVector2D();
         this._birds = new Vector.<Bird>();
         super();
      }
      
      public function init(param1:Class, param2:int) : void
      {
         var _loc3_:Bird = null;
         this._numberOfBirds = param2;
         var _loc4_:Number = 0.5;
         var _loc5_:int = 0;
         while(_loc5_ < param2)
         {
            _loc3_ = new param1();
            _loc3_.target = this.target;
            _loc3_.speed = (3 + Math.random()) * _loc4_;
            _loc3_.velocity.set(0,1);
            _loc3_.velocity.setLength(_loc3_.speed);
            _loc3_.steeringSpeed = 0.05 * _loc4_;
            _loc3_.velocity.setAngle(Math.random() * 2 * Math.PI);
            this._birds.push(_loc3_);
            _loc5_++;
         }
         this._syncToMouseFrequency = 1000 * 60 + 1000 * (Math.random() * 10);
      }
      
      public function syncTargetToMouse() : void
      {
         this.target.x = FlareManager.mousePositionInWorld.x + 200 * ((Math.random() - 0.5) * 2);
         this.target.y = FlareManager.mousePositionInWorld.y + 200 * ((Math.random() - 0.5) * 2);
      }
      
      private function update() : void
      {
         var _loc1_:Number = getTimer();
         if(_loc1_ - this._timeOfLastSyncToMouse > this._syncToMouseFrequency)
         {
            this.syncTargetToMouse();
            this._timeOfLastSyncToMouse = _loc1_;
         }
         var _loc2_:int = 0;
         while(_loc2_ < this._numberOfBirds)
         {
            this._birds[_loc2_].update();
            _loc2_++;
         }
      }
      
      public function render(param1:BitmapData, param2:Rectangle) : void
      {
         this.update();
         var _loc3_:int = 0;
         while(_loc3_ < this._birds.length)
         {
            this._birds[_loc3_].render(param1,param2);
            _loc3_++;
         }
      }
   }
}
