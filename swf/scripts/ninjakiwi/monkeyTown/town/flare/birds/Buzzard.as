package ninjakiwi.monkeyTown.town.flare.birds
{
   public class Buzzard extends Bird
   {
       
      
      public function Buzzard()
      {
         super();
      }
      
      override protected function initView() : void
      {
         _animationClasses.push("assets.flare.BuzzardLeft");
         _animationClasses.push("assets.flare.BuzzardLeftInb");
         _animationClasses.push("assets.flare.BuzzardUpLeft");
         _animationClasses.push("assets.flare.BuzzardUpLeftInb");
         _animationClasses.push("assets.flare.BuzzardUp");
         _animationClasses.push("assets.flare.BuzzardUpInb");
         _animationClasses.push("assets.flare.BuzzardUpRight");
         _animationClasses.push("assets.flare.BuzzardUpRightInb");
         _animationClasses.push("assets.flare.BuzzardRight");
         _animationClasses.push("assets.flare.BuzzardRightInb");
         _animationClasses.push("assets.flare.BuzzardDownRight");
         _animationClasses.push("assets.flare.BuzzardDownRightInb");
         _animationClasses.push("assets.flare.BuzzardDown");
         _animationClasses.push("assets.flare.BuzzardDownInb");
         _animationClasses.push("assets.flare.BuzzardDownLeft");
         _animationClasses.push("assets.flare.BuzzardDownLeftInb");
         super.initView();
      }
   }
}
