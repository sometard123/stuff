package ninjakiwi.monkeyTown.btdModule.abilities.antiBossAbilities.def
{
   import ninjakiwi.data.NKDefinition;
   
   public class AntiBossAbilityDef extends NKDefinition
   {
      
      protected static const _propertyNames:Array = ["type","cooldown","duration","activationLimit","bonusCount","behaviourClass","buttonClipClass","cost","tooltipName","tooltipDescription"];
       
      
      public var type:String = null;
      
      public var cooldown:Number = -1;
      
      public var duration:Number = -1;
      
      public var activationLimit:int = -1;
      
      public var bonusCount:int = -1;
      
      public var behaviourClass:Class = null;
      
      public var buttonClipClass:Class = null;
      
      public var cost:int = 0;
      
      public var tooltipName:String = "";
      
      public var tooltipDescription:String = "";
      
      public function AntiBossAbilityDef()
      {
         super();
      }
      
      public function Type(param1:String) : AntiBossAbilityDef
      {
         this.type = param1;
         return this;
      }
      
      public function Cooldown(param1:Number) : AntiBossAbilityDef
      {
         this.cooldown = param1;
         return this;
      }
      
      public function Duration(param1:Number) : AntiBossAbilityDef
      {
         this.duration = param1;
         return this;
      }
      
      public function ActivationLimit(param1:int) : AntiBossAbilityDef
      {
         this.activationLimit = param1;
         return this;
      }
      
      public function BonusCount(param1:int) : AntiBossAbilityDef
      {
         this.bonusCount = param1;
         return this;
      }
      
      public function BehaviourClass(param1:Class) : AntiBossAbilityDef
      {
         this.behaviourClass = param1;
         return this;
      }
      
      public function ButtonClipClass(param1:Class) : AntiBossAbilityDef
      {
         this.buttonClipClass = param1;
         return this;
      }
      
      public function Cost(param1:int) : AntiBossAbilityDef
      {
         this.cost = param1;
         return this;
      }
      
      public function TooltipName(param1:String) : AntiBossAbilityDef
      {
         this.tooltipName = param1;
         return this;
      }
      
      public function TooltipDescription(param1:String) : AntiBossAbilityDef
      {
         this.tooltipDescription = param1;
         return this;
      }
   }
}
