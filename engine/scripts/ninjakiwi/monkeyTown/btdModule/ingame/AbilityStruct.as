package ninjakiwi.monkeyTown.btdModule.ingame
{
   import assets.ability.CannotDoSymbol;
   import assets.module.useTactics_btn;
   import ninjakiwi.monkeyTown.btdModule.abilities.def.AbilityDef;
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   import ninjakiwi.monkeyTown.btdModule.utils.GameSpeedTimer;
   
   public class AbilityStruct
   {
       
      
      public var tower:Tower;
      
      public var abilityDef:AbilityDef;
      
      public var timer:GameSpeedTimer;
      
      public var button:useTactics_btn;
      
      public var cannotDoSymbol:CannotDoSymbol;
      
      public function AbilityStruct()
      {
         super();
      }
   }
}
