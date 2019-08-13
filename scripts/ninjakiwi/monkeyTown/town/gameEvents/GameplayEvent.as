package ninjakiwi.monkeyTown.town.gameEvents
{
   import ninjakiwi.monkeyTown.sku.SkuSettingsLoader;
   
   public class GameplayEvent
   {
      
      private static const _keys:Array = ["type","dataID","uid","active","startTime","endTime"];
       
      
      public var type:String = "gameplayEvent";
      
      public var dataID:String = "defaultData";
      
      public var uid:String = "no_uid_set";
      
      public var active:Boolean = false;
      
      public var startTime:Number = 0;
      
      public var endTime:Number = 0;
      
      public var requiredLevel:int = 0;
      
      public function GameplayEvent(param1:Object)
      {
         var data:Object = param1;
         super();
         this.type = data.type;
         this.active = data.metadata.active;
         this.dataID = data.metadata.dataID;
         this.startTime = data.start;
         this.endTime = data.end;
         this.uid = data.id;
         SkuSettingsLoader.getGameEventDataByType(this.type,function(param1:Object):void
         {
            if(param1.hasOwnProperty("requiredLevel") && param1.requiredLevel is int)
            {
               requiredLevel = param1.requiredLevel;
            }
            if(param1.hasOwnProperty(dataID) && param1[dataID] is Object && param1[dataID].hasOwnProperty("requiredLevel"))
            {
               requiredLevel = param1[dataID].requiredLevel;
            }
         });
      }
      
      public static function validateData(param1:Object) : Boolean
      {
         return param1.hasOwnProperty("type") && param1.type is String && param1.hasOwnProperty("metadata") && param1.metadata is Object && param1.metadata.hasOwnProperty("active") && param1.metadata.active is Boolean && param1.metadata.hasOwnProperty("dataID") && param1.metadata.dataID is String && param1.hasOwnProperty("start") && param1.start is Number && param1.hasOwnProperty("end") && param1.end is Number && param1.hasOwnProperty("id") && param1.id is String;
      }
   }
}
