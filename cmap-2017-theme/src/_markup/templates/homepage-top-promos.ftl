<div id="headerTop">
	<div class="inner" style="background-image: url($PrimaryImage.getData())">
		<h1>
			$PrimaryHeadline.getData()</h1>
		$PrimaryContent.getData()
	</div>
</div>
<div class="sub-bg">
	&nbsp;</div>
<div class="header-sub">
	<div class="inner">
		<h3>
			$SecondHeadline.getData()</h3>
		$SecondContent.getData()
	</div>
</div>
<div class="header-sub">
	<div class="inner">
		<h3>
			$ThirdHeadline.getData()</h3>
		$ThirdContent.getData()
	</div>
</div>
<div class="header-sub">
	<div class="inner">
		<h3>
			$FourthHeadline.getData()</h3>
		$FourthContent.getData()
	</div>
</div>
<style type="text/css">

.bg-shim {
background: -webkit-linear-gradient(top, $PrimaryTopGradientColor.getData() 0%, $PrimaryBottomGradientColor.getData() 100%);
background: -o-linear-gradient(top, $PrimaryTopGradientColor.getData() 0%, $PrimaryBottomGradientColor.getData() 100%);
background: -ms-linear-gradient(top, $PrimaryTopGradientColor.getData() 0%, $PrimaryBottomGradientColor.getData() 100%);
background: -moz-linear-gradient(top, $PrimaryTopGradientColor.getData() 0%, $PrimaryBottomGradientColor.getData() 100%);
background: linear-gradient(to bottom, $PrimaryTopGradientColor.getData() 0%, $PrimaryBottomGradientColor.getData() 100%);
}
div.header-sub:nth-child(3) {
    background-image: url($SecondImage.getData());
}
div.header-sub:nth-child(4) {
    background-image: url($ThirdImage.getData());
}
div.header-sub:nth-child(5) {
    background-image: url($FourthImage.getData());
}

</style>
