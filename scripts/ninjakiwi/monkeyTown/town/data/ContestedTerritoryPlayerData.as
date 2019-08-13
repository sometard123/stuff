package ninjakiwi.monkeyTown.town.data
{
   public class ContestedTerritoryPlayerData
   {
      
      public static var captureTimeAdd:Number = 0;
       
      
      public var userID:String;
      
      public var userName:String;
      
      public var cityName:String;
      
      public var cityIndex:int;
      
      public var cityLevel:int;
      
      private var _timeHoldingTerritory:Number;
      
      public var timeHoldingTerritoryWithoutCurrent:Number;
      
      public var timestampOfLastCapture:Number;
      
      public var timestampOfLastCaptureWithDuration:Number;
      
      public var roundsBeatenBest:int;
      
      public var roundsBeatenCurrent:int;
      
      public function ContestedTerritoryPlayerData()
      {
         super();
         this.reset();
      }
      
      public function reset() : void
      {
         this.userID = "";
         this.userName = "";
         this.cityName = "";
         this.cityIndex = 0;
         this.cityLevel = 0;
         this.timeHoldingTerritory = 0;
         this.timeHoldingTerritoryWithoutCurrent = 0;
         this.timestampOfLastCapture = 0;
         this.timestampOfLastCaptureWithDuration = 0;
         this.roundsBeatenBest = 0;
         this.roundsBeatenCurrent = 0;
      }
      
      public function get timeHoldingTerritory() : Number
      {
         return this._timeHoldingTerritory;
      }
      
      public function set timeHoldingTerritory(param1:Number) : void
      {
         this._timeHoldingTerritory = param1;
      }
   }
}
