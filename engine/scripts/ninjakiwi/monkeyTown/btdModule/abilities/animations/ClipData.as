package ninjakiwi.monkeyTown.btdModule.abilities.animations
{
   public class ClipData
   {
       
      
      public var scale:Number = 1;
      
      public var clipClass:Class = null;
      
      public function ClipData(param1:Class, param2:Number = 1)
      {
         super();
         this.clipClass = param1;
         this.scale = param2;
      }
   }
}
