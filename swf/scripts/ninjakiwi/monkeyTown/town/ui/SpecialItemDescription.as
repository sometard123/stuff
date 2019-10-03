package ninjakiwi.monkeyTown.town.ui
{
   import assets.town.SpecialItemDescriptionClip;
   import ninjakiwi.monkeyTown.town.specialItems.SpecialItem;
   import ninjakiwi.monkeyTown.town.specialItems.SpecialItemData;
   import ninjakiwi.monkeyTown.town.specialItems.definition.SpecialItemDefinition;
   import ninjakiwi.monkeyTown.town.ui.treasure.SpecialItemIconModule;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   
   public class SpecialItemDescription extends SpecialItemDescriptionClip
   {
       
      
      private var _item:SpecialItem;
      
      private var _definition:SpecialItemDefinition;
      
      private var _useButton:ButtonControllerBase;
      
      private var _toggleButton:ButtonControllerBase;
      
      private var _iconModule:SpecialItemIconModule;
      
      public function SpecialItemDescription(param1:SpecialItemDefinition)
      {
         super();
         this._definition = param1;
         this.resetDescription();
         this._useButton = new ButtonControllerBase(useButton);
         this._useButton.setClickFunction(this.onClickUse);
         this._toggleButton = new ButtonControllerBase(toggleButton);
         this._toggleButton.setClickFunction(this.onToggle);
         this._iconModule = new SpecialItemIconModule(itemIcon);
         this.syncWithItem(null);
         this.nameTxt.width = 400;
      }
      
      private function resetDescription() : void
      {
         this.descriptionTxt.text = "Collect a Special Item";
         this.nameTxt.text = "Empty";
         this.useButton.visible = false;
      }
      
      public function syncWithItem(param1:SpecialItem) : void
      {
         this._item = param1;
         if(param1 != null)
         {
            if(this._definition == null)
            {
               this._definition = this._item.definition;
            }
            if(param1.definition.id == this._definition.id)
            {
               this.descriptionTxt.text = this._definition.gameDescription;
               this.nameTxt.text = this._definition.name;
            }
            if(this.isConsumable())
            {
               this.descriptionTxt.text = this._definition.gameDescription;
               this.nameTxt.text = this._definition.name;
               this._iconModule.setIconFrame(this._definition);
               this._iconModule.setNormalColor();
               this.bg.gotoAndStop(1);
               if(this._iconModule.getQuantity() <= 0)
               {
                  this._iconModule.setGreyScale();
               }
            }
            else
            {
               this._iconModule.setIconFrame(this._definition);
               this._iconModule.setNormalColor();
               this.bg.gotoAndStop(1);
            }
         }
         else if(this.isConsumable())
         {
            this.descriptionTxt.text = this._definition.gameDescription;
            this.nameTxt.text = this._definition.name;
            this._iconModule.setIconFrame(this._definition);
            this._iconModule.setNormalColor();
            this.bg.gotoAndStop(1);
            if(this._iconModule.getQuantity() <= 0)
            {
               this._iconModule.setGreyScale();
            }
         }
         else
         {
            this.resetDescription();
            this._iconModule.setIconFrame(this._definition);
            this._iconModule.setGreyScale();
            this.bg.gotoAndStop(2);
         }
         this.refreshStockCount();
      }
      
      public function isConsumable() : Boolean
      {
         return this._definition.id == SpecialItemData.getInstance().RED_HOT_SPIKES.id || this._definition.id == SpecialItemData.getInstance().MONKEY_BOOSTS.id || this._definition.id == SpecialItemData.getInstance().BOSS_CHILL.id || this._definition.id == SpecialItemData.getInstance().BOSS_BANE.id || this._definition.id == SpecialItemData.getInstance().BOSS_BLAST.id || this._definition.id == SpecialItemData.getInstance().BOSS_WEAKEN.id;
      }
      
      public function get specialItemID() : String
      {
         if(this._definition != null)
         {
            return this._definition.id;
         }
         return "";
      }
      
      private function onClickUse() : void
      {
         if(this._item != null)
         {
            this._item.useAbility();
            this.refreshStockCount();
         }
      }
      
      private function onToggle() : void
      {
      }
      
      private function refreshStockCount() : void
      {
         this._useButton.target.visible = false;
         this._toggleButton.target.visible = false;
         if(this._item != null)
         {
            if(this._item.definition.charges > 0)
            {
               if(this._item.inStockCount > 0)
               {
                  this.nameTxt.text = this._item.definition.name + " x" + this._item.inStockCount;
                  this._useButton.target.visible = true;
               }
               else
               {
                  this.resetDescription();
               }
            }
         }
      }
      
      public function get isItemSet() : Boolean
      {
         if(this._item != null)
         {
            return true;
         }
         return false;
      }
   }
}
