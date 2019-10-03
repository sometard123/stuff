package ninjakiwi.monkeyTown.btdModule.abilities
{
   import assets.cursor.Wrench;
   import ninjakiwi.monkeyTown.btdModule.entities.Cursor;
   
   public class OverclockWrench
   {
       
      
      public var wrench:Cursor = null;
      
      private var _hasSelectedWrench:Boolean = false;
      
      public function OverclockWrench()
      {
         super();
      }
      
      public function reset() : void
      {
         if(this.wrench)
         {
            this.wrench.destroy();
            this.wrench = null;
         }
         this._hasSelectedWrench = false;
      }
      
      public function onOverclockAbilitySelect() : void
      {
         if(this._hasSelectedWrench)
         {
            return;
         }
         this.wrench = new Cursor();
         this.wrench.initialise(Wrench);
         Main.instance.game.level.addEntity(this.wrench);
         this._hasSelectedWrench = true;
      }
      
      public function onOverclockTowerSelect() : void
      {
         this.reset();
      }
      
      public function get hasSelectedWrench() : Boolean
      {
         return this._hasSelectedWrench;
      }
   }
}
