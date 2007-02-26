{* 
TestLink Open Source Project - http://testlink.sourceforge.net/ 
$Id: planAddTC_m1.tpl,v 1.10 2007/02/26 08:01:44 franciscom Exp $
Purpose: smarty template - generate a list of TC for adding to Test Plan 

20070224 - franciscom 
BUGID 600

20061105 - franciscom
added logic to manage active/inactive tcversions

*}

{include file="inc_head.tpl"}
{include file="inc_jsCheckboxes.tpl"}

<body>
<h1>{lang_get s='test_plan'}{$smarty.const.TITLE_SEP}{$testPlanName|escape}
</h1>


{if $has_tc }
<div class="workBack">

<form name='addTcForm' method='post'>
 
    <h1>
    {if $has_linked_items eq 0} 
		   {lang_get s='title_add_test_to_plan'}
    {else}
		   {lang_get s='title_add_remove_test_to_plan'}
    {/if}     
    </h1>
    {include file="inc_update.tpl" result=$sqlResult}
    <div style="padding-right: 20px; float: right;">
      <br /><input type='submit' name='do_action' 
		     {if $has_linked_items eq 0}
	      	   value='{lang_get s='btn_add_selected_tc'}'
		     {else}
             value='{lang_get s='btn_add_remove_selected_tc'}' 
		     {/if}
         />
   </div>
   <br />
   <br />
     
  {if $key ne ''}
	  <div style="margin-left: 20px; font-size: smaller;">
		  <br />{lang_get s='note_keyword_filter'}{$key|escape}</p>
	  </div>
  {/if}
  <br />
	{section name=tsuite_idx loop=$arrData}
	<div id="div_{$arrData[tsuite_idx].testsuite.id}" style="margin:0px 0px 0px {$arrData[tsuite_idx].level}0px;">
	    <h3>{$arrData[tsuite_idx].testsuite.name|escape}</h3>

      {* ------------------------------------------------------------------------- *}      
    	{if $arrData[tsuite_idx].write_buttons eq 'yes'}
      	<p>
	      	<input type='button' name='{$arrData[tsuite_idx].testsuite.name|escape}_check' 
	      	       onclick='javascript: box("div_{$arrData[tsuite_idx].testsuite.id}", true)' 
	      	       value='{lang_get s='btn_check'}' />
	      	<input type='button' name='{$arrData[tsuite_idx].testsuite.name|escape}_uncheck' 
	      	       onclick='javascript: box("div_{$arrData[tsuite_idx].testsuite.id}", false)' 
	      	       value='{lang_get s='btn_uncheck'}' />
	  		<b>{lang_get s='check_uncheck_tc'}</b>
  		  </p>
      {/if}
     {* ------------------------------------------------------------------------- *}      
 
 
     {* ------------------------------------------------------------------------- *}      
     {if $arrData[tsuite_idx].testcase_qty gt 0 }
        
        <table cellspacing="0" style="font-size:small;" width="100%">
          <tr style="background-color:blue;font-weight:bold;color:white">
			     <td class="checkbox_cell">&nbsp;</td>
			     <td class="tcase_id_cell">{lang_get s='th_id'}</td> 
			     <td>{lang_get s='th_test_case'}</td>
			     <td>{lang_get s='version'}</td>
           {if $arrData[tsuite_idx].linked_testcase_qty gt 0 }
            <td>&nbsp;</td>
				    <td>{lang_get s='remove_tc'}</td>
           {/if}
          </tr>   
          
          {foreach from=$arrData[tsuite_idx].testcases item=tcase}
          
            {if $tcase.tcversions_qty neq 0}  
            
    			    <tr {if $tcase.linked_version_id ne 0} style="background-color:yellow" {/if}>
    			      <td>
    				    
    				    {if $tcase.tcversions_qty eq 0}
    				       &nbsp;
    				    {else}
    				      <input type='checkbox' name='achecked_tc[{$tcase.id}]' value='{$tcase.id}' 
    					           {if $tcase.linked_version_id ne 0} checked disabled readonly {/if} />
    				    {/if}
    				    
    				    <input type='hidden' name='a_tcid[{$tcase.id}]' value='{$tcase.id}' />
    			      </td>
    			      
    			      <td>
    				    {$tcase.id}
    			      </td>
    			      <td>
    				    {$tcase.name|escape}
    			      </td>
    			      
                <td>
         				{if $tcase.tcversions_qty eq 0}
                  {lang_get s='inactive_testcase'}              
                {else}
         				  <select name="tcversion_for_tcid[{$tcase.id}]"
      			          {if $tcase.linked_version_id ne 0} disabled	{/if}>
         				      {html_options options=$tcase.tcversions selected=$tcase.linked_version_id}
         				  </select>
    				    
    				    {/if}
    				    
                </td>
        
                {* ------------------------------------------------------------------------- *}      
                {if $arrData[tsuite_idx].linked_testcase_qty gt 0 }
          				<td>&nbsp;</td>
          				<td>
          				   {if $tcase.linked_version_id ne 0} 
          						<input type='checkbox' name='remove_checked_tc[{$tcase.id}]' 
          				               value='{$tcase.linked_version_id}' />
          				   {else}
          						&nbsp;
          				   {/if}
                     {if $tcase.executed eq 'yes'}
                            &nbsp;&nbsp;&nbsp;{lang_get s='has_been_executed'}
                     {/if}    
          				</td>
                {/if}
                {* ------------------------------------------------------------------------- *}      
 
              </tr>
            {/if}  {* $tcase.tcversions_qty *}
  	      {/foreach}
      
        </table>
        
        <br />
        <input type="submit" name="do_action"  
      		{if $has_linked_items eq 0}
      	    	value="{lang_get s='btn_add_selected_tc'}"
      		{else}
              value="{lang_get s='btn_add_remove_selected_tc'}"
			        onclick = "return planRemoveTC(&quot;{lang_get s='warning_add_remove_selected_tc'}&quot;)" 
      		{/if}
        />
        <img src="{$smarty.const.TL_THEME_IMG_DIR}/sym_question.gif" 
             title="{lang_get s='add_remove_selected_tc_hint'}">
          
     {/if}  {* there are test cases to show ??? *}
    </div>

	{/section}

</form>
</div>

{else}
	<h2>{lang_get s='no_testcase_available'}</h2>
{/if}

</body>
</html>
