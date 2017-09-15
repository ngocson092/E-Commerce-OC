<div class="box pavblogs-comments-box">
	<div class="box-heading"><span><?php echo $heading_title; ?></span></div>
	<div class="box-content padding" >
		<?php if( !empty($comments) ) { ?>
		<div class="pavblog-comments clearfix">
			 <?php $default=''; foreach( $comments as $comment ) { ?>
				<div class="pav-comment media">
					<a  class="pull-left" href="<?php echo $comment['link'];?>" title="<?php echo $comment['user'];?>">
					<img src="<?php echo "http://www.gravatar.com/avatar/" . md5( strtolower( trim( $comment['email'] ) ) ) . "?d=" . urlencode( $default ) . "&s=60" ?>" align="left"/>
					</a>
					<div class="media-body">
						<div class="comment"><?php echo utf8_substr( $comment['comment'], 50 ); ?></div>
						<span class="comment-author"><?php echo $objlang->get('text_postedby');?> <?php echo $comment['user'];?>...</span>
					</div>
				</div>
			 <?php } ?>
		</div>
		<?php } ?>
	</div>
 </div>
