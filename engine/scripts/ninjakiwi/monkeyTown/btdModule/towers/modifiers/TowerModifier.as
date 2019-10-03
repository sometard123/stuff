package ninjakiwi.monkeyTown.btdModule.towers.modifiers
{
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   import ninjakiwi.state.State;
   
   public class TowerModifier
   {
       
      
      public var tower:Tower;
      
      public var dead:Boolean = false;
      
      public var mustBeUnique:Boolean = false;
      
      public function TowerModifier(param1:Tower)
      {
         super();
         this.tower = param1;
      }
      
      public function die() : void
      {
         this.reset();
         this.dead = true;
      }
      
      public function apply() : void
      {
      }
      
      public function reset() : void
      {
      }
      
      public function update(param1:Number) : void
      {
      }
   }
}
