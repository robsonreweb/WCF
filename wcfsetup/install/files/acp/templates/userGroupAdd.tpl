{include file='header' pageTitle='wcf.acp.group.'|concat:$action}

<script type="text/javascript">
	//<![CDATA[
	$(function() {
		WCF.TabMenu.init();
	});
	//]]>
</script>

<header class="boxHeadline">
	<hgroup>
		<h1>{lang}wcf.acp.group.{@$action}{/lang}</h1>
	</hgroup>
</header>

{if $errorField}
	<p class="error">{lang}wcf.global.form.error{/lang}</p>
{/if}

{if $warningSelfEdit|isset}
	<p class="warning">{lang}wcf.acp.group.edit.warning.selfIsMember{/lang}</p>
{/if}

{if $success|isset}
	<p class="success">{lang}wcf.global.success.{@$action}{/lang}</p>
{/if}

<div class="contentNavigation">
	<nav>
		<ul>
			<li><a href="{link controller='UserGroupList'}{/link}" title="{lang}wcf.acp.menu.link.group.list{/lang}" class="button"><span class="icon icon16 icon-list"></span> <span>{lang}wcf.acp.menu.link.group.list{/lang}</span></a></li>
			
			{event name='contentNavigationButtons'}
		</ul>
	</nav>
</div>

<form method="post" action="{if $action == 'add'}{link controller='UserGroupAdd'}{/link}{else}{link controller='UserGroupEdit' id=$groupID}{/link}{/if}">
	<div class="container containerPadding marginTop">
		<fieldset>
			<legend>{lang}wcf.global.form.data{/lang}</legend>
			
			<dl{if $errorType.groupName|isset} class="formError"{/if}>
				<dt><label for="groupName">{lang}wcf.global.name{/lang}</label></dt>
				<dd>
					<input type="text" id="groupName" name="groupName" value="{$i18nPlainValues['groupName']}" autofocus="autofocus" class="medium" />
					{if $errorType.groupName|isset}
						<small class="innerError">
							{if $errorType.groupName == 'empty'}
								{lang}wcf.global.form.error.empty{/lang}
							{else}
								{lang}wcf.acp.group.groupName.error.{@$errorType}{/lang}
							{/if}
						</small>
					{/if}
					
					{include file='multipleLanguageInputJavascript' elementIdentifier='groupName' forceSelection=false}
				</dd>
			</dl>
			
			{event name='dataFields'}
		</fieldset>
		
		{event name='fieldsets'}
		
		<div class="tabMenuContainer" data-active="{$activeTabMenuItem}" data-store="activeTabMenuItem">
			<nav class="tabMenu">
				<ul>
					{foreach from=$optionTree item=categoryLevel1}
						<li><a href="{@$__wcf->getAnchor($categoryLevel1[object]->categoryName)}">{lang}wcf.acp.group.option.category.{@$categoryLevel1[object]->categoryName}{/lang}</a></li>
					{/foreach}
				</ul>
			</nav>
			
			{foreach from=$optionTree item=categoryLevel1}
				<div id="{@$categoryLevel1[object]->categoryName}" class="container containerPadding tabMenuContainer tabMenuContent">
					<nav class="menu">
						<ul>
							{foreach from=$categoryLevel1[categories] item=$categoryLevel2}
								{assign var=__categoryLevel2Name value=$categoryLevel1[object]->categoryName|concat:'-':$categoryLevel2[object]->categoryName}
								<li><a href="{@$__wcf->getAnchor($__categoryLevel2Name)}">{lang}wcf.acp.group.option.category.{@$categoryLevel2[object]->categoryName}{/lang}</a></li>
							{/foreach}
						</ul>
					</nav>
					
					{foreach from=$categoryLevel1[categories] item=categoryLevel2}
						<div id="{@$categoryLevel1[object]->categoryName}-{@$categoryLevel2[object]->categoryName}" class="hidden">
							{if $categoryLevel2[options]|count}
								<fieldset>
									<legend>{lang}wcf.acp.group.option.category.{@$categoryLevel2[object]->categoryName}{/lang}</legend>
									{hascontent}<small>{content}{lang __optional=true}wcf.acp.group.option.category.{@$categoryLevel2[object]->categoryName}.description{/lang}{/content}</small>{/hascontent}
								
									{include file='optionFieldList' options=$categoryLevel2[options] langPrefix='wcf.acp.group.option.'}
								</fieldset>
							{/if}
							
							{if $categoryLevel2[categories]|count}
								{foreach from=$categoryLevel2[categories] item=categoryLevel3}
									<fieldset>
										<legend>{lang}wcf.acp.group.option.category.{@$categoryLevel3[object]->categoryName}{/lang}</legend>
										{hascontent}<small>{content}{lang __optional=true}wcf.acp.group.option.category.{@$categoryLevel3[object]->categoryName}.description{/lang}{/content}</small>{/hascontent}
										
										{include file='optionFieldList' options=$categoryLevel3[options] langPrefix='wcf.acp.group.option.'}
									</fieldset>
								{/foreach}
							{/if}
						</div>
					{/foreach}
				</div>
			{/foreach}
		</div>
	</div>
	
	<div class="formSubmit">
		<input type="submit" value="{lang}wcf.global.button.submit{/lang}" accesskey="s" />
		<input type="hidden" name="action" value="{@$action}" />
	</div>
</form>

{include file='footer'}
