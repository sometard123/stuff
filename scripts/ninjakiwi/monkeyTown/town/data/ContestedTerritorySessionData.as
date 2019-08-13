package ninjakiwi.monkeyTown.town.data
{
   import ninjakiwi.dancingShadows.DancingShadows;
   import ninjakiwi.dancingShadows.INumber;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.townMap.TrackData;
   
   public class ContestedTerritorySessionData
   {
       
      
      public var roomID:String;
      
      public var numberOfPlayersJoined:int;
      
      public var trackName:String;
      
      public var trackData:TrackData;
      
      public var minimumRound:int;
      
      public var roundGeneratorSeed:Number;
      
      private var _cash:INumber;
      
      private var _cashPerHour:INumber;
      
      private var _levelTier:INumber;
      
      private var _lastLootTime:INumber;
      
      private var _amLeading:INumber;
      
      private var _week:INumber;
      
      public function ContestedTerritorySessionData()
      {
         this._cash = DancingShadows.getOne();
         this._cashPerHour = DancingShadows.getOne();
         this._levelTier = DancingShadows.getOne();
         this._lastLootTime = DancingShadows.getOne();
         this._amLeading = DancingShadows.getOne();
         this._week = DancingShadows.getOne();
         super();
         this.reset();
      }
      
      public function reset() : void
      {
         this.roomID = "Not set";
         this.numberOfPlayersJoined = 0;
         this.trackName = "Not set";
         this.trackData = null;
         this.minimumRound = 0;
         this.roundGeneratorSeed = 0;
         this._cash.value = 0;
         this._cashPerHour.value = 0;
         this._levelTier.value = 0;
         this._lastLootTime.value = 0;
         this._amLeading.value = 0;
         this._week.value = 0;
      }
      
      public function get cash() : Number
      {
         return this._cash.value;
      }
      
      public function set cash(param1:Number) : void
      {
         this._cash.value = param1;
      }
      
      public function get cashPerHour() : Number
      {
         return this._cashPerHour.value;
      }
      
      public function set cashPerHour(param1:Number) : void
      {
         this._cashPerHour.value = param1;
      }
      
      public function get levelTier() : int
      {
         return this._levelTier.value;
      }
      
      public function set levelTier(param1:int) : void
      {
         this._levelTier.value = param1;
      }
      
      public function get lastLootTime() : Number
      {
         return this._lastLootTime.value;
      }
      
      public function set lastLootTime(param1:Number) : void
      {
         this._lastLootTime.value = param1;
      }
      
      public function get amLeading() : Boolean
      {
         return this._amLeading.value != 0;
      }
      
      public function set amLeading(param1:Boolean) : void
      {
         this._amLeading.value = !!param1?Number(1):Number(0);
      }
      
      public function get week() : int
      {
         return this._week.value;
      }
      
      public function set week(param1:int) : void
      {
         this._week.value = param1;
      }
      
      public function getDaysRemaining() : Number
      {
         var _loc1_:Number = NaN;
         _loc1_ = 1000 * 60 * 60 * 24;
         var _loc2_:Number = _loc1_ * 7;
         var _loc3_:Number = 4;
         var _loc4_:Number = MonkeySystem.getInstance().getSecureTime() - _loc3_ * _loc1_;
         var _loc5_:Number = _loc4_ % _loc2_;
         var _loc6_:Number = _loc4_ % _loc1_;
         var _loc7_:Number = (_loc1_ - _loc6_) / _loc1_;
         var _loc8_:Number = (_loc2_ - _loc5_) / _loc2_;
         var _loc9_:Number = Number(int(_loc8_ * 7 * 10)) / 10;
         return _loc9_;
      }
   }
}
