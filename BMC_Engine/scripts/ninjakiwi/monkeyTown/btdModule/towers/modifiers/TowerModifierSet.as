package ninjakiwi.monkeyTown.btdModule.towers.modifiers
{
   import flash.utils.getDefinitionByName;
   import flash.utils.getQualifiedClassName;
   import ninjakiwi.monkeyTown.btdModule.towers.Tower;
   
   public class TowerModifierSet
   {
       
      
      private var _tower:Tower;
      
      private var _modifiers:Vector.<TowerModifier>;
      
      public function TowerModifierSet(param1:Tower)
      {
         this._modifiers = new Vector.<TowerModifier>();
         super();
         this._tower = param1;
      }
      
      public function update(param1:Number) : void
      {
         var _loc4_:TowerModifier = null;
         var _loc2_:Boolean = false;
         var _loc3_:int = 0;
         while(_loc3_ < this._modifiers.length)
         {
            _loc4_ = this._modifiers[_loc3_];
            _loc4_.update(param1);
            if(_loc4_.dead)
            {
               _loc2_ = true;
            }
            _loc3_++;
         }
         if(_loc2_)
         {
            this.removeDead();
         }
      }
      
      private function removeDead() : void
      {
         var _loc2_:TowerModifier = null;
         var _loc1_:int = this._modifiers.length - 1;
         while(_loc1_ >= 0)
         {
            _loc2_ = this._modifiers[_loc1_];
            if(_loc2_.dead)
            {
               this._modifiers.splice(_loc1_,1);
            }
            _loc1_--;
         }
      }
      
      public function add(param1:TowerModifier) : void
      {
         var _loc2_:int = this._modifiers.indexOf(param1);
         if(_loc2_ === -1)
         {
            if(param1.mustBeUnique)
            {
               this.addUnique(param1);
            }
            else
            {
               this._modifiers.push(param1);
               param1.apply();
            }
         }
      }
      
      public function addUnique(param1:TowerModifier) : void
      {
         var _loc4_:TowerModifier = null;
         var _loc2_:Class = getDefinitionByName(getQualifiedClassName(param1)) as Class;
         var _loc3_:int = this._modifiers.length - 1;
         while(_loc3_ >= 0)
         {
            _loc4_ = this._modifiers[_loc3_];
            if(_loc4_ is _loc2_)
            {
               _loc4_.die();
               this._modifiers[_loc3_] = param1;
               param1.apply();
               return;
            }
            _loc3_--;
         }
         this._modifiers.push(param1);
         param1.apply();
      }
      
      public function remove(param1:TowerModifier) : void
      {
         var _loc2_:int = this._modifiers.indexOf(param1);
         if(_loc2_ !== -1)
         {
            this._modifiers.splice(_loc2_,1);
         }
      }
      
      public function clearModifersOfType(param1:Class) : void
      {
         var _loc3_:TowerModifier = null;
         var _loc2_:int = this._modifiers.length - 1;
         while(_loc2_ >= 0)
         {
            _loc3_ = this._modifiers[_loc2_];
            if(_loc3_ is param1)
            {
               _loc3_.die();
            }
            _loc2_--;
         }
      }
      
      public function clear() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this._modifiers.length)
         {
            this._modifiers[_loc1_].die();
            _loc1_++;
         }
         this._modifiers.length = 0;
      }
   }
}
