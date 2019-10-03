package ninjakiwi.monkeyTown.btdModule.abilities
{
   import flash.events.Event;
   import ninjakiwi.monkeyTown.btdModule.abilities.def.AbilityDef;
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   
   public class OverclockPick extends Ability
   {
       
      
      public var tower:Tower;
      
      public var input:Vector.<Tower>;
      
      public var def:AbilityDef;
      
      public function OverclockPick()
      {
         super();
      }
      
      override public function execute(param1:Tower, param2:AbilityDef) : void
      {
         if(Main.instance.game.overclockWrench.hasSelectedWrench)
         {
            return;
         }
         Main.instance.game.inGameMenu.removeEventListener("TowerSelected",this.select);
         this.tower = param1;
         this.def = param2;
         Main.instance.game.inGameMenu.addEventListener("TowerSelected",this.select);
         param1.abilityCooldowns[param2.id].current = param1.abilityCooldowns[param2.id].delay;
         super.execute(param1,param2);
         Main.instance.game.overclockWrench.onOverclockAbilitySelect();
      }
      
      public function select(param1:Event) : void
      {
         if(this.tower.abilityCooldowns == null)
         {
            return;
         }
         this.tower.abilityCooldowns["OverclockPick"].reset();
         this.tower.abilityCooldowns["OverclockPick"].start();
         new Overclock().execute(Main.instance.game.inGameMenu.towerSelectedState.tower,this.def);
         Main.instance.game.level.sigTowerAbilityUsed.dispatch(this.tower.id,"Overclock");
         Main.instance.game.inGameMenu.removeEventListener("TowerSelected",this.select);
         Main.instance.game.overclockWrench.onOverclockTowerSelect();
      }
   }
}
