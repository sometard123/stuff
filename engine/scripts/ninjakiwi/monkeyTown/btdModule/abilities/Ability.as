package ninjakiwi.monkeyTown.btdModule.abilities
{
   import ninjakiwi.monkeyTown.btdModule.abilities.def.AbilityDef;
   import ninjakiwi.monkeyTown.btdModule.entities.Effect;
   import ninjakiwi.monkeyTown.btdModule.sound.MaxSound;
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   
   public class Ability
   {
       
      
      public function Ability()
      {
         super();
      }
      
      public function execute(param1:Tower, param2:AbilityDef) : void
      {
         var _loc3_:Effect = null;
         if(param2.effect != null)
         {
            _loc3_ = new Effect(param2.effectBlend);
            _loc3_.initialise(param2.effect,3);
            _loc3_.x = param1.x;
            _loc3_.y = param1.y;
            param1.level.addEntity(_loc3_);
         }
         if(param2.sound != null)
         {
            new MaxSound(param2.sound).play();
         }
      }
      
      public function get isReady() : Boolean
      {
         return true;
      }
   }
}
