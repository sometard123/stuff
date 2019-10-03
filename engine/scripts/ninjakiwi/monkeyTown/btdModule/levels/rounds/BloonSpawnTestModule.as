package ninjakiwi.monkeyTown.btdModule.levels.rounds
{
   import flash.display.Stage;
   import flash.events.KeyboardEvent;
   import ninjakiwi.monkeyTown.btdModule.bloons.Bloon;
   import ninjakiwi.monkeyTown.common.Constants;
   
   public class BloonSpawnTestModule
   {
      
      private static var _stage:Stage;
      
      private static var _roundGenerator:RoundGenerator;
       
      
      public function BloonSpawnTestModule()
      {
         super();
      }
      
      public static function setStage(param1:Stage) : void
      {
      }
      
      private static function keyDownHandler(param1:KeyboardEvent) : void
      {
         var _loc2_:int = Bloon.RED;
         var _loc3_:int = 1;
         var _loc4_:Number = Constants.SPACING_NORMAL;
         var _loc5_:Boolean = false;
         var _loc6_:Boolean = false;
         if(param1.keyCode === "1".charCodeAt(0))
         {
            _loc2_ = Bloon.CERAMIC;
            _loc3_ = 50;
            _loc4_ = 0.5 / _loc3_;
            _loc5_ = true;
            _loc6_ = true;
         }
         else if(param1.keyCode === "2".charCodeAt(0))
         {
            _loc2_ = Bloon.MOAB;
            _loc3_ = 20;
            _loc4_ = 1.5 / _loc3_;
         }
         else if(param1.keyCode === "3".charCodeAt(0))
         {
            _loc2_ = Bloon.BFB;
            _loc3_ = 6;
            _loc4_ = 1.5 / _loc3_;
         }
         else if(param1.keyCode === "4".charCodeAt(0))
         {
            _loc2_ = Bloon.DDT;
            _loc3_ = 3;
            _loc4_ = 0.5;
         }
         else if(param1.keyCode === "5".charCodeAt(0))
         {
            _loc2_ = Bloon.BOSS;
            _loc3_ = 1;
            _loc4_ = 0.5;
         }
         else if(param1.keyCode === "6".charCodeAt(0))
         {
            _loc2_ = Bloon.BLACK;
            _loc3_ = 10;
            _loc4_ = 0.1;
         }
         else if(param1.keyCode === "7".charCodeAt(0))
         {
            _loc2_ = Bloon.LEAD;
            _loc3_ = 10;
            _loc4_ = 0.1;
         }
         else
         {
            return;
         }
         spawn(_loc2_,_loc3_,_loc4_,_loc5_,_loc6_);
      }
      
      public static function setRoundGenerator(param1:RoundGenerator) : void
      {
         _roundGenerator = param1;
      }
      
      public static function spawn(param1:int, param2:int = 1, param3:Number = 0.6, param4:Boolean = false, param5:Boolean = false) : void
      {
         var _loc6_:BloonSpawnType = new BloonSpawnType(param1).Spacing(param3).Camo(param4).Regen(param5);
         _roundGenerator.insertSpawnGroup(new GroupDefinition(_loc6_,param2,1));
      }
   }
}
