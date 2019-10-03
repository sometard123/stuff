package ninjakiwi.monkeyTown.btdModule.ingame
{
   import assets.module.DirectUseButtonClip;
   import flash.events.MouseEvent;
   import ninjakiwi.monkeyTown.btdModule.abilities.def.AbilityDef;
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   
   public class DirectUseAbilityButton extends ButtonControllerBase
   {
       
      
      private var _linkedTower:Tower;
      
      private var _linkedAbility:AbilityDef;
      
      private var _enabled:Boolean = true;
      
      public function DirectUseAbilityButton(param1:Tower, param2:AbilityDef)
      {
         super(new DirectUseButtonClip());
         this._linkedAbility = param2;
         this._linkedTower = param1;
      }
      
      override protected function mouseClickHandler(param1:MouseEvent = null) : void
      {
         super.mouseClickHandler(param1);
         if(this._linkedTower != null && this._linkedAbility != null)
         {
            if(this._linkedTower.abilityTimer(this._linkedAbility.id).running == false)
            {
               this._linkedTower.level.useAbility(this._linkedTower,this._linkedAbility.id);
            }
         }
      }
      
      public function set enable(param1:Boolean) : void
      {
         if(param1 == true)
         {
            unlock(1);
         }
         else
         {
            lock(3);
         }
         this._enabled = param1;
      }
      
      public function get enable() : Boolean
      {
         return this._enabled;
      }
   }
}
