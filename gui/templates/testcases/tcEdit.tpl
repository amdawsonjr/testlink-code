{* TestLink Open Source Project - http://testlink.sourceforge.net/ *}
{* $Id: tcEdit.tpl,v 1.3 2008/03/24 19:33:28 havlat Exp $ *}
{* Purpose: smarty template - edit test specification: test case *}
{include file="inc_head.tpl" openHead='yes' jsValidate="yes"}
<script language="JavaScript" src="gui/javascript/OptionTransfer.js" type="text/javascript"></script>
<script language="JavaScript" src="gui/javascript/expandAndCollapseFunctions.js" type="text/javascript"></script>


<script type="text/javascript" language="JavaScript">
var {$opt_cfg->js_ot_name} = new OptionTransfer("{$opt_cfg->from->name}","{$opt_cfg->to->name}");
{$opt_cfg->js_ot_name}.saveRemovedLeftOptions("{$opt_cfg->js_ot_name}_removedLeft");
{$opt_cfg->js_ot_name}.saveRemovedRightOptions("{$opt_cfg->js_ot_name}_removedRight");
{$opt_cfg->js_ot_name}.saveAddedLeftOptions("{$opt_cfg->js_ot_name}_addedLeft");
{$opt_cfg->js_ot_name}.saveAddedRightOptions("{$opt_cfg->js_ot_name}_addedRight");
{$opt_cfg->js_ot_name}.saveNewLeftOptions("{$opt_cfg->js_ot_name}_newLeft");
{$opt_cfg->js_ot_name}.saveNewRightOptions("{$opt_cfg->js_ot_name}_newRight");
</script>
{literal}
<script type="text/javascript">
{/literal}
var warning_empty_testcase_name = "{lang_get s='warning_empty_tc_title'}";
{literal}
function validateForm(f)
{
  if (isWhitespace(f.testcase_name.value)) 
  {
      alert(warning_empty_testcase_name);
      selectField(f, 'testcase_name');
      return false;
  }
  return true;
}
</script>
{/literal}

</head>

<body onLoad="{$opt_cfg->js_ot_name}.init(document.forms[0]);focusInputField('testcase_name')">
{config_load file="input_dimensions.conf" section="tcNew"}
<h1>{lang_get s='title_edit_tc'}{$smarty.const.TITLE_SEP}{$tc.name|escape}
	{$smarty.const.TITLE_SEP_TYPE3}{lang_get s='version'} {$tc.version}</h1> 

<div class="workBack" style="width:97%;">

{if $has_been_executed}
    {lang_get s='warning_editing_executed_tc' var="warning_edit_msg"}
    <div class="warning_message" align="center">{$warning_edit_msg}</div>
{/if}

<form method="post" action="lib/testcases/tcEdit.php" name="tc_edit"
      onSubmit="javascript:return validateForm(this);">

	<input type="hidden" name="testcase_id" value="{$tc.testcase_id}" />
	<input type="hidden" name="tcversion_id" value="{$tc.id}" />
	<input type="hidden" name="version" value="{$tc.version}" />
	

	<div class="groupBtn">
		<input id="do_update" type="submit" name="do_update" value="{lang_get s='btn_save'}" />
		<input type="button" name="go_back" value="{lang_get s='cancel'}" 
		       onclick="javascript: history.back();"/>
	</div>	

	{assign var=this_template_dir value=$smarty.template|dirname}
	{include file="$this_template_dir/tcEdit_New_viewer.tpl"}
    
	<div class="groupBtn">
		<input id="do_update" type="submit" name="do_update" value="{lang_get s='btn_save'}" />
		<input type="button" name="go_back" value="{lang_get s='cancel'}" 
		       onclick="javascript: history.back();"/>
	</div>	
</form>

<script type="text/javascript" defer="1">
   	document.forms[0].testcase_name.focus()
</script>

</div>
</body>
</html>
