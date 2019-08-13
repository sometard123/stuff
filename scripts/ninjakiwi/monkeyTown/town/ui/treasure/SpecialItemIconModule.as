package ninjakiwi.monkeyTown.town.ui.treasure
{
   import flash.display.MovieClip;
   import flash.geom.ColorTransform;
   import flash.text.TextField;
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.system.MonkeySystem;
   import ninjakiwi.monkeyTown.town.specialItems.SpecialItemData;
   import ninjakiwi.monkeyTown.town.specialItems.definition.SpecialItemDefinition;
   
   public class SpecialItemIconModule
   {
       
      
      private var _linkedClip:MovieClip;
      
      private var _quantityClip:MovieClip;
      
      private var _quantityTextfield:TextField;
      
      public function SpecialItemIconModule(param1:MovieClip)
      {
         super();
         this._linkedClip = param1;
         this._quantityClip = this._linkedClip.bonusCount;
         this._quantityTextfield = this._quantityClip.counter as TextField;
         this._linkedClip.gotoAndStop(1);
      }
      
      public function setIconFrame(param1:SpecialItemDefinition) : void
      {
         this._quantityClip.visible = false;
         if(param1.id == SpecialItemData.getInstance().BLESSED_DART.id)
         {
            this._linkedClip.gotoAndStop(1);
         }
         else if(param1.id == SpecialItemData.getInstance().MAGIC_BANANA_BAG.id)
         {
            this._linkedClip.gotoAndStop(2);
         }
         else if(param1.id == SpecialItemData.getInstance().BANANA_REPLICATOR.id)
         {
            this._linkedClip.gotoAndStop(3);
         }
         else if(param1.id == SpecialItemData.getInstance().REVENGE_STICK.id)
         {
            this._linkedClip.gotoAndStop(4);
         }
         else if(param1.id == SpecialItemData.getInstance().PORTABLE_DART_MONKEY.id)
         {
            this._linkedClip.gotoAndStop(5);
         }
         else if(param1.id == SpecialItemData.getInstance().MAGIC_COIN_PURSE.id)
         {
            this._linkedClip.gotoAndStop(7);
         }
         else if(param1.id == SpecialItemData.getInstance().EPIC_MAGIC_COIN_PURSE.id)
         {
            this._linkedClip.gotoAndStop(8);
         }
         else if(param1.id == SpecialItemData.getInstance().LOGISTICAL_BOOTS.id)
         {
            this._linkedClip.gotoAndStop(9);
         }
         else if(param1.id == SpecialItemData.getInstance().MAGIC_SPANNER.id)
         {
            this._linkedClip.gotoAndStop(10);
         }
         else if(param1.id == SpecialItemData.getInstance().DARK_TEMPLE_IDOL.id)
         {
            this._linkedClip.gotoAndStop(11);
         }
         else if(param1.id == SpecialItemData.getInstance().BOTTLE_ROCKET.id)
         {
            this._linkedClip.gotoAndStop(12);
         }
         else if(param1.id == SpecialItemData.getInstance().ENCHANTED_BOOMERANG.id)
         {
            this._linkedClip.gotoAndStop(13);
         }
         else if(param1.id == SpecialItemData.getInstance().NINJASCROLLS.id)
         {
            this._linkedClip.gotoAndStop(14);
         }
         else if(param1.id == SpecialItemData.getInstance().SHARD_OF_EVERFROST.id)
         {
            this._linkedClip.gotoAndStop(15);
         }
         else if(param1.id == SpecialItemData.getInstance().EXTRA_STICKY_SUBSTANCE.id)
         {
            this._linkedClip.gotoAndStop(16);
         }
         else if(param1.id == SpecialItemData.getInstance().ANTI_CAMO_DUST.id)
         {
            this._linkedClip.gotoAndStop(17);
         }
         else if(param1.id == SpecialItemData.getInstance().CUDDLY_BEAR.id)
         {
            this._linkedClip.gotoAndStop(18);
         }
         else if(param1.id == SpecialItemData.getInstance().CITY_CASH.id)
         {
            this._linkedClip.gotoAndStop(21);
         }
         else if(param1.id == SpecialItemData.getInstance().RED_HOT_SPIKES.id)
         {
            this._linkedClip.gotoAndStop(22);
            this.setQuantity(ResourceStore.getInstance().redHotSpikes);
         }
         else if(param1.id == SpecialItemData.getInstance().MONKEY_BOOSTS.id)
         {
            this._linkedClip.gotoAndStop(23);
            this.setQuantity(ResourceStore.getInstance().monkeyBoosts);
         }
         else if(param1.id == SpecialItemData.getInstance().BOSS_CHILL.id)
         {
            this._linkedClip.gotoAndStop(24);
            this.setQuantity(ResourceStore.getInstance().bossChills);
         }
         else if(param1.id == SpecialItemData.getInstance().BOSS_BANE.id)
         {
            this._linkedClip.gotoAndStop(25);
            this.setQuantity(ResourceStore.getInstance().bossBanes);
         }
         else if(param1.id == SpecialItemData.getInstance().BOSS_BLAST.id)
         {
            this._linkedClip.gotoAndStop(26);
            this.setQuantity(ResourceStore.getInstance().bossBlasts);
         }
         else if(param1.id == SpecialItemData.getInstance().BOSS_WEAKEN.id)
         {
            this._linkedClip.gotoAndStop(27);
            this.setQuantity(ResourceStore.getInstance().bossWeakens);
         }
      }
      
      public function setQuantity(param1:int) : void
      {
         this._quantityTextfield.text = param1.toString();
         this._quantityClip.visible = param1 > 0;
      }
      
      public function getQuantity() : int
      {
         return int(this._quantityTextfield.text);
      }
      
      public function setBloontoniumFrame() : void
      {
         this._linkedClip.gotoAndStop(20);
      }
      
      public function setBloonstoneFrame() : void
      {
         this._linkedClip.gotoAndStop(19);
      }
      
      public function setCashFrame() : void
      {
         this._linkedClip.gotoAndStop(21);
      }
      
      public function setEmptyFrame() : void
      {
         this._linkedClip.gotoAndStop(22);
      }
      
      public function setGreyScale() : void
      {
         this._linkedClip.transform.colorTransform = MonkeySystem.unavailableColorTransform;
      }
      
      public function setNormalColor() : void
      {
         this._linkedClip.transform.colorTransform = new ColorTransform();
      }
   }
}
