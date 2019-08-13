package ninjakiwi.monkeyTown.town.ui
{
   import assets.ui.TreasurePanelClip;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import ninjakiwi.localisation.LocalisationConstants;
   import ninjakiwi.monkeyTown.town.specialItems.SpecialItem;
   import ninjakiwi.monkeyTown.town.ui.treasure.SpecialItemIconModule;
   import ninjakiwi.monkeyTown.ui.HideRevealViewPopup;
   import ninjakiwi.monkeyTown.ui.buttons.ButtonControllerBase;
   
   public class TreasureChestPanel extends HideRevealViewPopup
   {
      
      private static const TYPE_CHEST:int = 0;
      
      private static const TYPE_MISSION:int = 1;
      
      private static const TYPE_BLOONSTONES:int = 2;
      
      private static const TYPE_BLOONTONIUMS:int = 3;
      
      private static const TYPE_CASH:int = 4;
       
      
      private const _clip:TreasurePanelClip = new TreasurePanelClip();
      
      private const _closeButton:ButtonControllerBase = new ButtonControllerBase(this._clip.closeButton);
      
      private const _buffer:Vector.<TreasureElement> = new Vector.<TreasureElement>();
      
      private const _icon:SpecialItemIconModule = new SpecialItemIconModule(this._clip.itemIcon);
      
      private const _iconInChest:SpecialItemIconModule = new SpecialItemIconModule(this._clip.treasureChest.itemIcon);
      
      private var _doTreasureChestAnimation:Boolean = false;
      
      public function TreasureChestPanel(param1:DisplayObjectContainer)
      {
         super(param1);
         this.isModal = true;
         this._closeButton.setClickFunction(hide);
         this.enableDefaultOnResize(this._clip);
         this.addChild(this._clip);
         this._clip.treasureChest.stop();
         this._clip.itemIcon.stop();
         this._clip.itemIcon.spinningLight.stop();
         this._clip.knowledgePackInfo.visible = false;
      }
      
      public function foundTreasure(param1:SpecialItem) : void
      {
         var _loc2_:TreasureElement = new TreasureElement();
         _loc2_.treasure = param1;
         _loc2_.type = TYPE_MISSION;
         this._buffer.push(_loc2_);
      }
      
      public function foundTreasureChest(param1:SpecialItem, param2:Object = null) : void
      {
         var _loc3_:TreasureElement = new TreasureElement();
         _loc3_.treasure = param1;
         _loc3_.type = TYPE_CHEST;
         _loc3_.monkeyKnowledgeRewards = param2;
         this._buffer.push(_loc3_);
      }
      
      public function foundBloonstones(param1:int) : void
      {
         var _loc2_:TreasureElement = new TreasureElement();
         _loc2_.value = param1;
         _loc2_.type = TYPE_BLOONSTONES;
         this._buffer.push(_loc2_);
      }
      
      public function foundBloontoniums(param1:int) : void
      {
         var _loc2_:TreasureElement = new TreasureElement();
         _loc2_.value = param1;
         _loc2_.type = TYPE_BLOONTONIUMS;
         this._buffer.push(_loc2_);
      }
      
      public function foundCash(param1:int) : void
      {
         var _loc2_:TreasureElement = new TreasureElement();
         _loc2_.value = param1;
         _loc2_.type = TYPE_CASH;
         this._buffer.push(_loc2_);
      }
      
      override public function reveal(param1:Number = 0.2) : void
      {
         var _loc3_:Object = null;
         var _loc4_:MovieClip = null;
         this._doTreasureChestAnimation = false;
         this._clip.knowledgePackInfo.visible = false;
         this._clip.gotoAndStop(1);
         var _loc2_:TreasureElement = this._buffer.shift();
         if(_loc2_ != null)
         {
            switch(_loc2_.type)
            {
               case TYPE_CHEST:
                  if(_loc2_.treasure != null)
                  {
                     this._clip.treasureChest.gotoAndStop(1);
                     this._doTreasureChestAnimation = true;
                     this._clip.treasureChest.visible = true;
                     this._clip.itemIcon.visible = false;
                     this._clip.itemIcon.spinningLight.stop();
                     this._iconInChest.setIconFrame(_loc2_.treasure.definition);
                     this._clip.titleTxt.text = _loc2_.treasure.definition.name;
                     this._clip.descriptionTxt.text = _loc2_.treasure.getStringForRevealedUI();
                     this._clip.gotoAndStop(2);
                     if(_loc2_.monkeyKnowledgeRewards !== null)
                     {
                        _loc3_ = _loc2_.monkeyKnowledgeRewards;
                        _loc4_ = this._clip.knowledgePackInfo;
                        _loc4_.visible = true;
                        this._clip.knowledgePackInfo.infoField.htmlText = "Monkey Knowledge Pack x " + _loc3_.packs;
                        if(_loc3_.ancientPacks > 0)
                        {
                           _loc4_.packIcon.gotoAndStop(2);
                           this._clip.knowledgePackInfo.infoField.htmlText = this._clip.knowledgePackInfo.infoField.htmlText + ("Ancient Monkey Knowledge Pack x " + _loc3_.packs);
                        }
                        else
                        {
                           _loc4_.packIcon.gotoAndStop(1);
                        }
                     }
                  }
                  break;
               case TYPE_MISSION:
                  if(_loc2_.treasure != null)
                  {
                     this._clip.treasureChest.stop();
                     this._clip.treasureChest.visible = false;
                     this._clip.itemIcon.visible = true;
                     this._clip.itemIcon.spinningLight.play();
                     this._icon.setIconFrame(_loc2_.treasure.definition);
                     this._clip.titleTxt.text = _loc2_.treasure.definition.name;
                     this._clip.descriptionTxt.text = _loc2_.treasure.getStringForRevealedUI();
                  }
                  break;
               case TYPE_BLOONSTONES:
                  this._clip.treasureChest.visible = false;
                  this._clip.treasureChest.stop();
                  this._clip.itemIcon.visible = true;
                  this._clip.itemIcon.spinningLight.play();
                  this._clip.titleTxt.text = _loc2_.value + " " + LocalisationConstants.BLOONSTONES;
                  this._clip.descriptionTxt.text = LocalisationConstants.FOUND_BLOONSTONES.split("<bloonstones>").join(String(_loc2_.value));
                  this._icon.setBloonstoneFrame();
                  break;
               case TYPE_BLOONTONIUMS:
                  this._clip.treasureChest.visible = false;
                  this._clip.treasureChest.stop();
                  this._clip.itemIcon.visible = true;
                  this._clip.itemIcon.spinningLight.play();
                  this._clip.titleTxt.text = _loc2_.value + " " + LocalisationConstants.BLOONTONIUM;
                  this._clip.descriptionTxt.text = LocalisationConstants.FOUND_BLOONTONIUMS.split("<bloontonium>").join(String(_loc2_.value));
                  this._icon.setBloontoniumFrame();
                  break;
               case TYPE_CASH:
                  this._clip.treasureChest.visible = false;
                  this._clip.treasureChest.stop();
                  this._clip.itemIcon.visible = true;
                  this._clip.itemIcon.spinningLight.play();
                  this._clip.titleTxt.text = _loc2_.value + " " + LocalisationConstants.CITY_CASH;
                  this._clip.descriptionTxt.text = LocalisationConstants.FOUND_CITY_CASH.split("<cash>").join(String(_loc2_.value));
                  this._icon.setCashFrame();
            }
         }
         super.reveal(param1);
      }
      
      override protected function onHideComplete() : void
      {
         super.onHideComplete();
         this._clip.itemIcon.spinningLight.stop();
      }
      
      override protected function onRevealComplete() : void
      {
         super.onRevealComplete();
         if(this._doTreasureChestAnimation == true)
         {
            this._clip.treasureChest.gotoAndPlay(1);
         }
      }
   }
}

import ninjakiwi.monkeyTown.town.specialItems.SpecialItem;

class TreasureElement
{
    
   
   public var treasure:SpecialItem;
   
   public var value:int;
   
   public var type:int;
   
   public var monkeyKnowledgeRewards:Object;
   
   function TreasureElement()
   {
      super();
   }
}
