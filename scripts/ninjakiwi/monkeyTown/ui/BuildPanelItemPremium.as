package ninjakiwi.monkeyTown.ui
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.text.TextField;
   import ninjakiwi.dancingShadows.DancingShadows;
   import ninjakiwi.dancingShadows.INumber;
   import ninjakiwi.monkeyTown.premiums.PremiumBuildingManager;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.data.definitions.MonkeyTownBuildingDefinition;
   import ninjakiwi.monkeyTown.town.ui.BuildingIcon;
   
   public class BuildPanelItemPremium extends BuildPanelItem
   {
       
      
      private var _premiumItemBuildComponent:PremiumItemBuyComponent;
      
      private var _contentContainer:Sprite;
      
      private var _counter:TextField;
      
      private var _purchaseBurstEffect:MovieClip;
      
      private var _currentlyPlaced:INumber;
      
      private var _numberAllowed:INumber;
      
      private var _costInNKCoins:INumber;
      
      public function BuildPanelItemPremium(param1:MonkeyTownBuildingDefinition, param2:Sprite)
      {
         this._currentlyPlaced = DancingShadows.getOne();
         this._numberAllowed = DancingShadows.getOne();
         this._costInNKCoins = DancingShadows.getOne();
         this._contentContainer = param2;
         super(param1);
         this.updateFields();
      }
      
      override protected function init(param1:MonkeyTownBuildingDefinition) : void
      {
         super.init(param1);
         this._premiumItemBuildComponent = new PremiumItemBuyComponent(this,this,param1);
         this._costInNKCoins.value = param1.nkCoinCost;
         this.updateFields();
         PremiumBuildingManager.premiumBuildingPurchasedSignal.add(this.onPremiumBuildingPurchased);
      }
      
      private function onPremiumBuildingPurchased(param1:int, param2:int, param3:String) : void
      {
         if(buildingDefinition.id == param3)
         {
            this.updateFields();
            this._purchaseBurstEffect.play();
         }
      }
      
      public function updateFields() : void
      {
         this._currentlyPlaced.value = MonkeySystem.getInstance().city.buildingManager.getBuildingCount(buildingDefinition.id);
         this._numberAllowed.value = PremiumBuildingManager.getInstance().buildingsBoughtINumbers[buildingDefinition.id].value;
         var _loc1_:int = this._numberAllowed.value - this._currentlyPlaced.value;
         this._counter.text = _loc1_ != 0?_loc1_.toString():"";
      }
      
      override protected function createClip() : void
      {
         _clip = new BuildPanelItemPremiumClip();
         _iconContainer = _clip.iconContainer;
         _titleField = _clip.titleField;
         _bodyField = _clip.bodyField;
         this._counter = _clip.counter;
         _background = _clip.background;
         this._purchaseBurstEffect = _clip.purchaseBurst;
         this._purchaseBurstEffect.gotoAndStop(this._purchaseBurstEffect.totalFrames);
      }
      
      override public function getIcon() : BuildingIcon
      {
         var _loc1_:MovieClip = new buildingDefinition.iconGraphicClass();
         var _loc2_:BuildingIcon = new BuildingIcon(_loc1_);
         _loc2_._costLabel.visible = false;
         _loc2_.buildingDefinition = buildingDefinition;
         return _loc2_;
      }
   }
}
