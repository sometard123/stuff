package ninjakiwi.monkeyTown.town.gameEvents.awarders
{
   import flash.events.Event;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import ninjakiwi.monkeyTown.data.ResourceStore;
   import ninjakiwi.monkeyTown.smallEvents.monkeyMerchant.MonkeyMerchantWare;
   import ninjakiwi.monkeyTown.town.specialItems.SpecialItemStore;
   
   public class RewardSet
   {
       
      
      private var _awarders:Vector.<Awarder>;
      
      public function RewardSet(param1:Object)
      {
         this._awarders = new Vector.<Awarder>();
         super();
         if(param1.hasOwnProperty("cash") && param1.cash != 0)
         {
            this._awarders.push(new CashAwarder(param1.cash));
         }
         if(param1.hasOwnProperty("bloonstones") && param1.bloonstones != 0)
         {
            this._awarders.push(new BloonstonesAwarder(param1.bloonstones));
         }
         if(param1.hasOwnProperty("crates") && param1.crates != 0)
         {
            this._awarders.push(new CratesAwarder(param1.crates));
         }
         if(param1.hasOwnProperty("boosts") && param1.boosts != 0)
         {
            this._awarders.push(new MonkeyBoostAwarder(param1.boosts));
         }
         if(param1.hasOwnProperty("spikes") && param1.spikes != 0)
         {
            this._awarders.push(new RedHotSpikesAwarder(param1.spikes));
         }
         if(ResourceStore.getInstance().townLevel >= 12)
         {
            if(param1.hasOwnProperty("knowledgePack") && param1.knowledgePack != 0)
            {
               this._awarders.push(new KnowledgePackAwarder(param1.knowledgePack));
            }
            if(param1.hasOwnProperty("ancientKnowledgePack") && param1.ancientKnowledgePack != 0)
            {
               this._awarders.push(new AncientKnowledgePackAwarder(param1.ancientKnowledgePack));
            }
            if(param1.hasOwnProperty("wildcardKnowledgePack") && param1.wildcardKnowledgePack != 0)
            {
               this._awarders.push(new WildcardKnowledgePackAwarder(param1.wildcardKnowledgePack));
            }
            if(param1.hasOwnProperty("bossBanes") && param1.bossBanes != 0)
            {
               this._awarders.push(new BossBaneAwarder(param1.bossBanes));
            }
            if(param1.hasOwnProperty("bossChills") && param1.bossChills != 0)
            {
               this._awarders.push(new BossChillAwarder(param1.bossChills));
            }
            if(param1.hasOwnProperty("bossBlasts") && param1.bossBlasts != 0)
            {
               this._awarders.push(new BossBlastAwarder(param1.bossBlasts));
            }
            if(param1.hasOwnProperty("bossWeakens") && param1.bossWeakens != 0)
            {
               this._awarders.push(new BossWeakenAwarder(param1.bossWeakens));
            }
         }
      }
      
      public function award() : void
      {
         var _loc2_:Awarder = null;
         var _loc1_:int = 0;
         while(_loc1_ < this._awarders.length)
         {
            _loc2_ = this._awarders[_loc1_];
            _loc2_.award();
            _loc1_++;
         }
      }
   }
}
