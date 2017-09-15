<section id="page" class="offcanvas-pusher" role="main">
<?php if($helper->getConfig('pavlandingpage') && (!isset($this->request->get['route']) || (isset($this->request->get['route']) && $this->request->get['route'] == 'common/home'))){?>
 	<div class="intro-landingpage hidden-sm hidden-xs">
 	<?php
   		if(!(isset($_COOKIE['pavlandingpage']) && $_COOKIE['pavlandingpage'])){
	   		$landingpage = $this->config->get('pavlandingpage');
	   		if ( !empty($landingpage) && file_exists(DIR_TEMPLATE.$themeName.'/template/common/addon/landingpage.tpl')) {  
	   			require_once( DIR_TEMPLATE.$themeName.'/template/common/addon/landingpage.tpl' ); 
	   		}
   		}
   ?>
   </div>
<?php } ?>

<div id="header-top">
	<div id="topbar" class="topbar-v1">
		<div class="container">				
			<div class="inner clearfix">
				<div class="show-desktop">
					<div class="quick-access">
						<div class="login links hidden-xs hidden-sm">
							<?php if (!$logged) { ?>
							<?php echo $text_welcome; ?>
							<?php } else { ?>
							<?php echo $text_logged; ?>
							<?php } ?> 
						</div>
						<!-- Single button -->
						<div class="btn-group">
							<div class="dropdown-toggle btn-theme-normal" >
								<i class="fa fa-user"></i>
								<span class="text-label">Account</span> 
								<span class="fa fa-angle-down"></span>									
							</div>
							
							<div class="quick-setting dropdown-menu">
								<ul>								
									<li><a href="<?php echo $wishlist; ?>" id="wishlist-total"><?php echo $text_wishlist; ?></a></li>
									<li><a href="<?php echo $account; ?>"><?php echo $text_account; ?></a></li>
									<li><a href="<?php echo $shopping_cart; ?>"><?php echo $text_shopping_cart; ?></a></li>
									<li><a class="last" href="<?php echo $checkout; ?>"><?php echo $text_checkout; ?></a></li>
								</ul>	
							</div>
						</div>

						<div class="btn-group second">
							<div class="dropdown-toggle btn-theme-normal" >
								<i class="fa fa-cog"></i>
								<span class="text-label">Setting</span> 
								<span class="fa fa-angle-down"></span>									
							</div>
							
							<div class="quick-localisation dropdown-menu">
								<div class="language">
									<?php echo $language; ?>
								</div>
								<div class="currency">
									<?php echo $currency; ?>
								</div> 	
							</div>
						</div>						

					</div>
					<div class="quick-action">
						<?php echo $cart; ?>
						<div id="search">					
						<div class="input-group">
							<input type="text" name="search" placeholder="<?php echo $text_search; ?>" value="<?php echo $search; ?>" class="input-search form-control" />
							<span class="input-group-btn">							
								<button class="button-search" type="button"><em class="fa fa-search"></em></button>
							</span>
						</div>		
										
					</div>	
					</div>
				</div>
			</div>	
		</div>
	</div>

	<div class="main-menu mainnav-v1">	
		<div class="nav-search visible">
	    	<div class="input-group">
				<input type="text" name="search" placeholder="<?php echo $text_search; ?>..." value="<?php echo $search; ?>" class="form-control search-control" />
				<span class="input-group-addon button-close"><span class="fa fa-times"></span></span>
			</div>
		</div>		
		<div class="container">
			<div class="row">
				<div class="col-lg-3 col-md-3 col-sm-12 col-xs-12 logo inner">
					<?php if( $logoType=='logo-theme'){ ?>
					<div id="logo-theme" class="logo-store">
						<a href="<?php echo $home; ?>">
							<span><?php echo $name; ?></span>
						</a>
					</div>
					<?php } elseif ($logo) { ?>
					<div id="logo" class="logo-store"><a href="<?php echo $home; ?>"><img src="<?php echo $logo; ?>" title="<?php echo $name; ?>" alt="<?php echo $name; ?>" /></a></div>
					<?php } ?> 
				</div>	
				<div id="pav-mainnav" class="col-lg-9 col-md-9 col-sm-12 col-xs-12">
				<?php 

				/**
				* Main Menu modules: as default if do not put megamenu, the theme will use categories menu for main menu
				*/

				$modules = $helper->getModulesByPosition( 'mainmenu' ); 
				if( count($modules) && !empty($modules) ){ 

				?>

				<?php foreach ($modules as $module) { ?>
				<?php echo $module; ?>
				<?php } ?>

				<?php } elseif ($categories) {  ?>

				<div class="navbar navbar-inverse"> 
					<nav id="mainmenutop" class="pav-megamenu" role="navigation"> 
						<div class="navbar-header">
							<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse">
								<span class="sr-only">Toggle navigation</span>
								<span class="fa fa-bars"></span>
							</button>
						</div>

						<div class="collapse navbar-collapse navbar-ex1-collapse">
							<ul class="nav navbar-nav">
								<li><a href="<?php echo $home; ?>" title="<?php echo $this->language->get('text_home');?>"><?php echo $this->language->get('text_home');?></a></li>
								<?php foreach ($categories as $category) { ?>

								<?php if ($category['children']) { ?>			
								<li class="parent dropdown deeper ">
									<a href="<?php echo $category['href'];?>" class="dropdown-toggle" data-toggle="dropdown"><?php echo $category['name']; ?>
										<b class="fa fa-angle-down"></b>
										<span class="triangles"></span>
									</a>
									<?php } else { ?>
									<li>
										<a href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a>
										<?php } ?>
										<?php if ($category['children']) { ?>
										<ul class="dropdown-menu">
											<?php for ($i = 0; $i < count($category['children']);) { ?>
											<?php $j = $i + ceil(count($category['children']) / $category['column']); ?>
											<?php for (; $i < $j; $i++) { ?>
											<?php if (isset($category['children'][$i])) { ?>
											<li><a href="<?php echo $category['children'][$i]['href']; ?>"><?php echo $category['children'][$i]['name']; ?></a></li>
											<?php } ?>
											<?php } ?>
											<?php } ?>
										</ul>
										<?php } ?>
									</li>
									<?php } ?>
								</ul>
							</div>	
						</nav>
					</div>   
					<?php } ?>
				</div>
			</div>	
		</div>	
	</div>
	
</div>
