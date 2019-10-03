package ninjakiwi.monkeyTown.saleEvents
{
   import flash.events.TimerEvent;
   import flash.utils.Dictionary;
   import ninjakiwi.monkeyTown.ui.panelManager.PanelManager;
   
   public class SaleEventItem
   {
       
      
      public var type:String = "saleEvent";
      
      public var active:Boolean = false;
      
      public var dataID:String = null;
      
      public var startTime:Number = 0;
      
      public var endTime:Number = 0;
      
      public var uid:String = "no_uid_set";
      
      public function SaleEventItem(param1:Object)
      {
         super();
         this.init(param1);
      }
      
      public static function validateData(param1:Object) : Boolean
      {
         return param1.hasOwnProperty("type") && param1.type is String && param1.hasOwnProperty("metadata") && param1.metadata is Object && param1.metadata.hasOwnProperty("active") && param1.metadata.active is Boolean && param1.metadata.hasOwnProperty("dataID") && param1.metadata.dataID is String && param1.hasOwnProperty("start") && param1.start is Number && param1.hasOwnProperty("end") && param1.end is Number && param1.hasOwnProperty("id") && param1.id is String;
      }
      
      private function init(param1:Object) : void
      {
         this.type = param1.type;
         this.active = param1.metadata.active;
         this.dataID = param1.metadata.dataID;
         this.startTime = param1.start;
         this.endTime = param1.end;
         this.uid = param1.id;
      }
   }
}
