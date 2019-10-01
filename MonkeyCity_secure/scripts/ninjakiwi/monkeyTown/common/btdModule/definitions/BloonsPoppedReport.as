package ninjakiwi.monkeyTown.common.btdModule.definitions
{
   import ninjakiwi.data.NKDefinition;
   
   public class BloonsPoppedReport extends NKDefinition
   {
      
      protected static const _propertyNames:Array = ["totalBloonsPopped","moabsPopped","ddtsPopped","bfbsPopped","zomgsPopped","leadsPopped","ceramicsPopped","camosPopped"];
       
      
      public var totalBloonsPopped:int = 0;
      
      public var moabsPopped:int = 0;
      
      public var ddtsPopped:int = 0;
      
      public var bfbsPopped:int = 0;
      
      public var zomgsPopped:int = 0;
      
      public var leadsPopped:int = 0;
      
      public var ceramicsPopped:int = 0;
      
      public var camosPopped:int = 0;
      
      public function BloonsPoppedReport()
      {
         super();
      }
      
      public function TotalBloonsPopped(param1:int) : BloonsPoppedReport
      {
         this.totalBloonsPopped = param1;
         return this;
      }
      
      public function MoabsPopped(param1:int) : BloonsPoppedReport
      {
         this.moabsPopped = param1;
         return this;
      }
      
      public function DdtsPopped(param1:int) : BloonsPoppedReport
      {
         this.ddtsPopped = param1;
         return this;
      }
      
      public function BfbsPopped(param1:int) : BloonsPoppedReport
      {
         this.bfbsPopped = param1;
         return this;
      }
      
      public function ZomgsPopped(param1:int) : BloonsPoppedReport
      {
         this.zomgsPopped = param1;
         return this;
      }
      
      public function LeadsPopped(param1:int) : BloonsPoppedReport
      {
         this.leadsPopped = param1;
         return this;
      }
      
      public function CeramicsPopped(param1:int) : BloonsPoppedReport
      {
         this.ceramicsPopped = param1;
         return this;
      }
      
      public function CamosPopped(param1:int) : BloonsPoppedReport
      {
         this.camosPopped = param1;
         return this;
      }
   }
}
