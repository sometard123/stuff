package ninjakiwi.monkeyTown.btdModule.analytics
{
   import ninjakiwi.monkeyTown.btdModule.bloons.Bloon;
   import ninjakiwi.monkeyTown.btdModule.events.BloonEvent;
   import ninjakiwi.monkeyTown.common.btdModule.definitions.BloonsPoppedReport;
   
   public class BloonPopTracker
   {
       
      
      private var _report:BloonsPoppedReport;
      
      private const MOAB:int = Bloon.MOAB;
      
      private const DDT:int = Bloon.DDT;
      
      private const BFB:int = Bloon.BFB;
      
      private const BOSS:int = Bloon.BOSS;
      
      private const LEAD:int = Bloon.LEAD;
      
      private const CERAMIC:int = Bloon.CERAMIC;
      
      public var totalBloonsPopped:int = 0;
      
      public function BloonPopTracker()
      {
         this._report = new BloonsPoppedReport();
         super();
         this.init();
      }
      
      private function init() : void
      {
         Bloon.eventDispatcher.addEventListener(BloonEvent.PRE_DEGRADE,this.onBloonPop);
      }
      
      private function onBloonPop(param1:BloonEvent) : void
      {
         var _loc2_:Bloon = param1.bloon;
         this._report.totalBloonsPopped++;
         switch(_loc2_.type)
         {
            case this.MOAB:
               this._report.moabsPopped++;
               break;
            case this.DDT:
               this._report.ddtsPopped++;
               break;
            case this.BFB:
               this._report.bfbsPopped++;
               break;
            case this.BOSS:
               this._report.zomgsPopped++;
               break;
            case this.LEAD:
               this._report.leadsPopped++;
               break;
            case this.CERAMIC:
               this._report.ceramicsPopped++;
         }
         if(_loc2_.isCamo)
         {
            this._report.camosPopped++;
         }
      }
      
      public function reset() : void
      {
         this._report = new BloonsPoppedReport();
      }
      
      public function get report() : BloonsPoppedReport
      {
         return this._report;
      }
   }
}
