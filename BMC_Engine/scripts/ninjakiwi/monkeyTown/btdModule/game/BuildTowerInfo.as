package ninjakiwi.monkeyTown.btdModule.game
{
   public class BuildTowerInfo
   {
       
      
      public var id:String;
      
      public var type:String;
      
      public var x:Number;
      
      public var y:Number;
      
      public var rotation:Number;
      
      public function BuildTowerInfo(param1:String, param2:String, param3:Number, param4:Number, param5:Number)
      {
         super();
         this.id = param1;
         this.type = param2;
         this.x = param3;
         this.y = param4;
         this.rotation = param5;
      }
   }
}
