package ninjakiwi.monkeyTown.btdModule.levels.rounds
{
   import ninjakiwi.monkeyTown.common.Constants;
   
   public class BloonSpawnType
   {
       
      
      private var _type:int;
      
      public var spacing:Number;
      
      public var camo:Boolean = false;
      
      public var regen:Boolean = false;
      
      public var typeModifier:int = 0;
      
      public function BloonSpawnType(param1:int)
      {
         super();
         this.Type(param1);
         this.spacing = Constants.SPACING_NORMAL;
      }
      
      public function Type(param1:int) : BloonSpawnType
      {
         this._type = param1;
         return this;
      }
      
      public function get type() : int
      {
         return this._type + this.typeModifier;
      }
      
      public function set type(param1:int) : void
      {
         this._type = param1;
      }
      
      public function Spacing(param1:Number) : BloonSpawnType
      {
         this.spacing = param1;
         return this;
      }
      
      public function Camo(param1:Boolean) : BloonSpawnType
      {
         this.camo = param1;
         return this;
      }
      
      public function Regen(param1:Boolean) : BloonSpawnType
      {
         this.regen = param1;
         return this;
      }
      
      public function TypeModifier(param1:int) : BloonSpawnType
      {
         this.typeModifier = param1;
         return this;
      }
   }
}
