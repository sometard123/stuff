package ninjakiwi.monkeyTown.btdModule.ingame.monkeyKnowledge
{
   import ninjakiwi.data.NKDefinition;
   
   public class Buff extends NKDefinition
   {
      
      protected static const _propertyNames:Array = ["buffPathID","buffValue","buffMethodModuleClass","hasBeenInvoked"];
       
      
      public var buffPathID:String = "";
      
      public var buffValue:Number = 0;
      
      public var buffMethodModuleClass:Class = null;
      
      public var hasBeenInvoked:Boolean = false;
      
      public function Buff()
      {
         super();
      }
      
      public function BuffPathID(param1:String) : Buff
      {
         this.buffPathID = param1;
         return this;
      }
      
      public function BuffValue(param1:Number) : Buff
      {
         this.buffValue = param1;
         return this;
      }
      
      public function BuffMethodModuleClass(param1:Class) : Buff
      {
         this.buffMethodModuleClass = param1;
         return this;
      }
      
      public function HasBeenInvoked(param1:Boolean) : Buff
      {
         this.hasBeenInvoked = param1;
         return this;
      }
   }
}
