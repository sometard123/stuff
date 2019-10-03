package ninjakiwi.monkeyTown.town.gameEvents.ui
{
   import assets.ui.RewardItemIndicatorClip;
   import flash.display.Sprite;
   
   public class RewardItem extends Sprite
   {
      
      public static const FRAME_CASH:int = 1;
      
      public static const FRAME_BS:int = 2;
      
      public static const FRAME_CRATE:int = 3;
      
      public static const FRAME_BOOST:int = 4;
      
      public static const FRAME_SPIKES:int = 5;
      
      public static const FRAME_KNOWLEDGE_PACK:int = 6;
      
      public static const FRAME_ANCIENT_KNOWLEDGE_PACK:int = 7;
      
      public static const FRAME_BOSS_BANE:int = 8;
      
      public static const FRAME_BOSS_CHILL:int = 9;
      
      public static const FRAME_BOSS_BLAST:int = 10;
      
      public static const FRAME_BOSS_WEAKEN:int = 11;
      
      public static const FRAME_WILD_KNOWLEDGE_PACK:int = 12;
       
      
      public var sortIndex:int = 0;
      
      private var _clip:RewardItemIndicatorClip;
      
      public function RewardItem(param1:String, param2:int)
      {
         this._clip = new RewardItemIndicatorClip();
         super();
         addChild(this._clip);
         this.setup(param1,param2);
      }
      
      private function setup(param1:String, param2:int) : void
      {
         switch(param1)
         {
            case "cash":
               this._clip.icon.gotoAndStop(FRAME_CASH);
               this._clip.rewardsName.text = "City Cash";
               this._clip.numberField.text = "$" + param2.toString();
               this.sortIndex = FRAME_CASH;
               break;
            case "bloonstones":
               this._clip.icon.gotoAndStop(FRAME_BS);
               this._clip.rewardsName.text = this.pluralify("Bloonstone",param2);
               this._clip.numberField.text = "x" + param2.toString();
               this.sortIndex = FRAME_BS;
               break;
            case "crates":
               this._clip.icon.gotoAndStop(FRAME_CRATE);
               this._clip.rewardsName.text = this.pluralify("Crate",param2);
               this._clip.numberField.text = "x" + param2.toString();
               this.sortIndex = FRAME_CRATE;
               break;
            case "boosts":
               this._clip.icon.gotoAndStop(FRAME_BOOST);
               this._clip.rewardsName.text = this.pluralify("Monkey Boost",param2);
               this._clip.numberField.text = "x" + param2.toString();
               this.sortIndex = FRAME_BOOST;
               break;
            case "spikes":
               this._clip.icon.gotoAndStop(FRAME_SPIKES);
               this._clip.rewardsName.text = this.pluralify("Red Hot Spike",param2);
               this._clip.numberField.text = "x" + param2.toString();
               this.sortIndex = FRAME_SPIKES;
               break;
            case "knowledgePack":
               this._clip.icon.gotoAndStop(FRAME_KNOWLEDGE_PACK);
               this._clip.rewardsName.text = this.pluralify("Knowledge Pack",param2);
               this._clip.numberField.text = "x" + param2.toString();
               this.sortIndex = FRAME_KNOWLEDGE_PACK;
               break;
            case "ancientKnowledgePack":
               this._clip.icon.gotoAndStop(FRAME_ANCIENT_KNOWLEDGE_PACK);
               this._clip.rewardsName.text = this.pluralify("Ancient Pack",param2);
               this._clip.numberField.text = "x" + param2.toString();
               this.sortIndex = FRAME_ANCIENT_KNOWLEDGE_PACK;
               break;
            case "wildcardKnowledgePack":
               this._clip.icon.gotoAndStop(FRAME_WILD_KNOWLEDGE_PACK);
               this._clip.rewardsName.text = this.pluralify("Wildcard Pack",param2);
               this._clip.numberField.text = "x" + param2.toString();
               this.sortIndex = FRAME_WILD_KNOWLEDGE_PACK;
               break;
            case "bossBanes":
               this._clip.icon.gotoAndStop(FRAME_BOSS_BANE);
               this._clip.rewardsName.text = this.pluralify("Boss Bane",param2);
               this._clip.numberField.text = "x" + param2.toString();
               this.sortIndex = FRAME_BOSS_BANE;
               break;
            case "bossChills":
               this._clip.icon.gotoAndStop(FRAME_BOSS_CHILL);
               this._clip.rewardsName.text = this.pluralify("Boss Chill",param2);
               this._clip.numberField.text = "x" + param2.toString();
               this.sortIndex = FRAME_BOSS_CHILL;
               break;
            case "bossBlasts":
               this._clip.icon.gotoAndStop(FRAME_BOSS_BLAST);
               this._clip.rewardsName.text = this.pluralify("Boss Blast",param2);
               this._clip.numberField.text = "x" + param2.toString();
               this.sortIndex = FRAME_BOSS_BANE;
               break;
            case "bossWeakens":
               this._clip.icon.gotoAndStop(FRAME_BOSS_WEAKEN);
               this._clip.rewardsName.text = this.pluralify("Boss Weaken",param2);
               this._clip.numberField.text = "x" + param2.toString();
               this.sortIndex = FRAME_BOSS_CHILL;
         }
      }
      
      private function pluralify(param1:String, param2:int) : String
      {
         if(param2 !== 1)
         {
            return param1 + "s";
         }
         return param1;
      }
   }
}
