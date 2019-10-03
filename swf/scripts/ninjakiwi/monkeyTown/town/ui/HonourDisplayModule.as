package ninjakiwi.monkeyTown.town.ui
{
   import assets.ui.HonourIconClip;
   import flash.text.TextField;
   
   public class HonourDisplayModule
   {
       
      
      private var _clip:HonourIconClip;
      
      private var _text:TextField;
      
      public function HonourDisplayModule(param1:HonourIconClip, param2:TextField = null)
      {
         super();
         this._clip = param1;
         this._text = param2;
      }
      
      public function setHonour(param1:int) : void
      {
         if(this._text != null)
         {
            this._text.text = String(Math.abs(param1));
         }
      }
   }
}
