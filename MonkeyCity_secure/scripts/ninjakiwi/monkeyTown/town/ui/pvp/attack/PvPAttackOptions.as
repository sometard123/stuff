package ninjakiwi.monkeyTown.town.ui.pvp.attack
{
   import assets.town.PvPAdvancedAttackClipNewVersion;
   import ninjakiwi.monkeyTown.town.data.BloonResearchLabUpgrades;
   import ninjakiwi.monkeyTown.town.gameEvents.GameEventManager;
   import ninjakiwi.monkeyTown.town.quests.QuestData;
   import ninjakiwi.monkeyTown.town.quests.QuestDefinition;
   import ninjakiwi.monkeyTown.town.ui.OnOffSwitch;
   import ninjakiwi.monkeyTown.ui.bloonResearchLab.BloonResearchLabState;
   
   public class PvPAttackOptions extends PvPAttackBase
   {
      
      private static const FREE_CHECK_BOX_CLIP_FRAME:int = 6;
       
      
      private const _costRegrowAssault:int = 15;
      
      private const _costCamoAssault:int = 10;
      
      private const _costMoreLead:int = 10;
      
      private const _costMoreMoab:int = 10;
      
      private var _regenSwitch:OnOffSwitch;
      
      private var _leadSwitch:OnOffSwitch;
      
      private var _camoSwitch:OnOffSwitch;
      
      private var _moabSwitch:OnOffSwitch;
      
      public function PvPAttackOptions(param1:PvPAdvancedAttackClipNewVersion)
      {
         super(param1);
         this._regenSwitch = new OnOffSwitch(param1.switchRegen,this._costRegrowAssault);
         this._camoSwitch = new OnOffSwitch(param1.switchCamo,this._costCamoAssault);
         this._leadSwitch = new OnOffSwitch(param1.switchLead,this._costMoreLead);
         this._moabSwitch = new OnOffSwitch(param1.switchMoab,this._costMoreMoab);
         this._regenSwitch.changed.add(needSync);
         this._camoSwitch.changed.add(needSync);
         this._leadSwitch.changed.add(needSync);
         this._moabSwitch.changed.add(needSync);
         this.refresh();
      }
      
      public function reset() : void
      {
         this._regenSwitch.reset();
         this._camoSwitch.reset();
         this._leadSwitch.reset();
         this._moabSwitch.reset();
      }
      
      override public function refresh() : void
      {
         super.refresh();
      }
      
      public function getTotalCosts(param1:int) : int
      {
         var _loc2_:int = 0;
         if(false == GameEventManager.getInstance().warmonger.freeBonusRegen)
         {
            _loc2_ = _loc2_ + this._regenSwitch.getCostCharged();
         }
         if(false == GameEventManager.getInstance().warmonger.freeBonusCamo)
         {
            _loc2_ = _loc2_ + this._camoSwitch.getCostCharged();
         }
         if(false == GameEventManager.getInstance().warmonger.freeBonusLead)
         {
            _loc2_ = _loc2_ + this._leadSwitch.getCostCharged();
         }
         if(false == GameEventManager.getInstance().warmonger.freeBonusMoab)
         {
            _loc2_ = _loc2_ + this._moabSwitch.getCostCharged();
         }
         return _loc2_;
      }
      
      public function getRegenDescription() : int
      {
         return this._regenSwitch.description;
      }
      
      public function getCamoDescription() : int
      {
         return this._camoSwitch.description;
      }
      
      public function getLeadDescription() : int
      {
         return this._leadSwitch.description;
      }
      
      public function getMoabDescription() : int
      {
         return this._moabSwitch.description;
      }
      
      public function syncTickboxes(param1:Boolean, param2:Boolean = false, param3:Boolean = false) : void
      {
         if(param1)
         {
            this.checkUpgrade(BloonResearchLabUpgrades.RUBBER_REPAIR.id,this._regenSwitch,true);
         }
         else
         {
            this.checkUpgrade(BloonResearchLabUpgrades.RUBBER_REPAIR.id,this._regenSwitch);
         }
         this.checkUpgrade(BloonResearchLabUpgrades.CAMO_MOD_TECH.id,this._camoSwitch);
         if(param2)
         {
            this.checkUpgrade(BloonResearchLabUpgrades.HEAVY_BLOON_ARMOUR.id,this._leadSwitch);
         }
         else
         {
            this.checkUpgrade(BloonResearchLabUpgrades.HEAVY_BLOON_ARMOUR.id,this._leadSwitch,true);
         }
         if(param3)
         {
            this.checkUpgrade(BloonResearchLabUpgrades.MOABS.id,this._moabSwitch);
         }
         else
         {
            this.checkUpgrade(BloonResearchLabUpgrades.MOABS.id,this._moabSwitch,true);
         }
         needSync();
      }
      
      private function checkUpgrade(param1:String, param2:OnOffSwitch, param3:Boolean = false) : void
      {
         if(!param3 && BloonResearchLabState.hasUpgrade(param1))
         {
            if(GameEventManager.getInstance().warmonger.isFreeForResearch(param1))
            {
               param2.select(true);
               param2.setEnable(false);
               param2.lock(FREE_CHECK_BOX_CLIP_FRAME);
            }
            else
            {
               param2.setEnable(true);
            }
         }
         else
         {
            param2.setEnable(false);
         }
      }
   }
}
