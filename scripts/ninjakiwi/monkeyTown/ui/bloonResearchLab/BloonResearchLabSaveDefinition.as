package ninjakiwi.monkeyTown.ui.bloonResearchLab
{
   import ninjakiwi.data.NKDefinition;
   import ninjakiwi.monkeyTown.town.ui.clock.ClockSaveDefinition;
   
   public class BloonResearchLabSaveDefinition extends NKDefinition
   {
      
      protected static const _propertyNames:Array = ["currentTier","isUpgrading","clockSave"];
       
      
      public var currentTier:int;
      
      public var isUpgrading:Boolean = false;
      
      public var clockSave:ClockSaveDefinition;
      
      public function BloonResearchLabSaveDefinition()
      {
         super();
      }
      
      public function CurrentTier(param1:int) : BloonResearchLabSaveDefinition
      {
         this.currentTier = param1;
         return this;
      }
      
      public function IsUpgrading(param1:Boolean) : BloonResearchLabSaveDefinition
      {
         this.isUpgrading = param1;
         return this;
      }
      
      public function ClockSave(param1:ClockSaveDefinition) : BloonResearchLabSaveDefinition
      {
         this.clockSave = param1;
         return this;
      }
   }
}
