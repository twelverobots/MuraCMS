<!--- This file is part of Mura CMS.

Mura CMS is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, Version 2 of the License.

Mura CMS is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. �See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with Mura CMS. �If not, see <http://www.gnu.org/licenses/>.

Linking Mura CMS statically or dynamically with other modules constitutes
the preparation of a derivative work based on Mura CMS. Thus, the terms and 	
conditions of the GNU General Public License version 2 (�GPL�) cover the entire combined work.

However, as a special exception, the copyright holders of Mura CMS grant you permission
to combine Mura CMS with programs or libraries that are released under the GNU Lesser General Public License version 2.1.

In addition, as a special exception, �the copyright holders of Mura CMS grant you permission
to combine Mura CMS �with independent software modules that communicate with Mura CMS solely
through modules packaged as Mura CMS plugins and deployed through the Mura CMS plugin installation API,
provided that these modules (a) may only modify the �/trunk/www/plugins/ directory through the Mura CMS
plugin installation API, (b) must not alter any default objects in the Mura CMS database
and (c) must not alter any files in the following directories except in cases where the code contains
a separately distributed license.

/trunk/www/admin/
/trunk/www/tasks/
/trunk/www/config/
/trunk/www/requirements/mura/

You may copy and distribute such a combined work under the terms of GPL for Mura CMS, provided that you include
the source code of that other code when and as the GNU GPL requires distribution of source code.

For clarity, if you create a modified version of Mura CMS, you are not obligated to grant this special exception
for your modified version; it is your choice whether to do so, or to make such modified version available under
the GNU General Public License version 2 �without this exception. �You may, if you choose, apply this exception
to your own modified versions of Mura CMS.
--->

<cfinclude template="act_defaults.cfm"/>
<cfoutput>
<h2>#application.rbFactory.getKeyValue(session.rb,"dashboard.dashboard")#</h2>

<div class="wrap">

<div id="contentPrimary">
</cfoutput>
<cfset rsPluginScripts=application.pluginManager.getScripts("onDashboardPrimaryTop",attributes.siteID)>
<cfoutput query="rsPluginScripts" group="pluginID">
<div<cfif rsPluginScripts.currentrow gt 1> class="separate"</cfif>>
	<h3>#HTMLEditformat(rsPluginScripts.name)#</h3>
	<cfoutput>
	<cfset request.pluginConfig=application.pluginManager.getConfig(rsPluginScripts.pluginID)>
	<cfinclude template="/#application.configBean.getWebRootMap()#/plugins/#rsPluginScripts.directory#/#rsPluginScripts.scriptfile#">
	</cfoutput>
</div>
</cfoutput>
<cfoutput>	
<div id="userActivity"<cfif rsPluginScripts.recordcount> class="separate"</cfif>>
<h3>#application.rbFactory.getKeyValue(session.rb,"dashboard.useractivity")# <span><a href="index.cfm?fuseaction=cDashboard.sessionSearch&siteID=#attributes.siteID#&newSearch=true">(#application.rbFactory.getKeyValue(session.rb,"dashboard.advancedsessionsearch")#)</a></span></h3>
<span id="userActivityData"></span>
</div>
<script type="text/javascript">loadUserActivity('#attributes.siteid#');</script>
<div id="popularContent" class="separate">
<h3>#application.rbFactory.getKeyValue(session.rb,"dashboard.popularcontent")# <span>(#application.rbFactory.getResourceBundle(session.rb).messageFormat(application.rbFactory.getKeyValue(session.rb,"dashboard.span"),attributes.span)#)</span></h3>
<span id="popularContentData"></span>
</div>
<script type="text/javascript">loadPopularContent('#attributes.siteid#');</script>
<cfif application.settingsManager.getSite(session.siteid).getdatacollection() and  application.permUtility.getModulePerm("00000000000000000000000000000000004","#session.siteid#")>
<div id="recentFormActivity" class="separate">
<h3>#application.rbFactory.getKeyValue(session.rb,"dashboard.formactivity")#</h3>
<span id="recentFormActivityData"></span>
</div>
<script type="text/javascript">loadFormActivity('#attributes.siteid#');</script>
</cfif>

<cfif application.settingsManager.getSite(session.siteid).getemailbroadcaster() and  application.permUtility.getModulePerm("00000000000000000000000000000000009","#session.siteid#")>
<span id="emailBroadcastsData">
<div id="emailBroadcasts" class="separate">

</div>
</span>
<script type="text/javascript">loadEmailActivity('#attributes.siteid#');</script>
</cfif>
</cfoutput>
<cfset rsPluginScripts=application.pluginManager.getScripts("onDashboardPrimaryBottom",attributes.siteID)>
<cfoutput query="rsPluginScripts" group="pluginID">
<div class="separate">
	<h3>#HTMLEditformat(rsPluginScripts.name)#</h3>
	<cfoutput>
	<cfset request.pluginConfig=application.pluginManager.getConfig(rsPluginScripts.pluginID)>
	<cfinclude template="/#application.configBean.getWebRootMap()#/plugins/#rsPluginScripts.directory#/#rsPluginScripts.scriptfile#">
	</cfoutput>
</div>
</cfoutput>
</div>
<cfoutput>
<div id="contentSecondary" class="sidebar">

<div id="editcontent">
<h3>#application.rbFactory.getKeyValue(session.rb,"dashboard.keywordsearch")#</h3>
<dl>
<dt>#application.rbFactory.getKeyValue(session.rb,"dashboard.searchtext")#:</dt>
<dd><form id="siteSearch" name="siteSearch" method="get"><input name="keywords" value="#HTMLEditFormat(session.keywords)#" type="text" class="text" align="absmiddle" />  
	<a class="submit" href="javascript:;" onclick="return submitForm(document.forms.siteSearch);"><span>Search</span></a>
	<input type="hidden" name="fuseaction" value="cArch.search">
	<input type="hidden" name="siteid" value="#attributes.siteid#">
	<input type="hidden" name="moduleid" value="00000000000000000000000000000000000">
</form></dd>
</dl>
</div> 
</cfoutput>
<cfset rsPluginScripts=application.pluginManager.getScripts("onDashboardSidebarTop",attributes.siteID)>
<cfoutput query="rsPluginScripts" group="pluginID">
<div class="divide">
	<h3>#HTMLEditformat(rsPluginScripts.name)#</h3>
	<cfoutput>
	<cfset request.pluginConfig=application.pluginManager.getConfig(rsPluginScripts.pluginID)>
	<cfinclude template="/#application.configBean.getWebRootMap()#/plugins/#rsPluginScripts.directory#/#rsPluginScripts.scriptfile#">
	</cfoutput>
</div>
</cfoutput>
<cfoutput>
<div id="siteSummary" class="divide">
<h3>#application.rbFactory.getKeyValue(session.rb,"dashboard.sitesummary")#</h3>
<dl>
<dt>#application.rbFactory.getKeyValue(session.rb,"dashboard.activepages")#</dt><dd>#application.dashboardManager.getcontentTypeCount(attributes.siteID,"Page").total#</dd>
<dt>#application.rbFactory.getKeyValue(session.rb,"dashboard.files")#</dt><dd>#application.dashboardManager.getcontentTypeCount(attributes.siteID,"File").total#</dd>
<dt>#application.rbFactory.getKeyValue(session.rb,"dashboard.links")#</dt><dd>#application.dashboardManager.getcontentTypeCount(attributes.siteID,"Link").total#</dd>
<dt>#application.rbFactory.getKeyValue(session.rb,"dashboard.internalfeeds")#</dt><dd>#application.dashboardManager.getFeedTypeCount(attributes.siteID,"Local").total#</dd>
<cfif application.settingsManager.getSite(attributes.siteID).getExtranet() eq 1><dt>#application.rbFactory.getKeyValue(session.rb,"dashboard.sitemembers")#</dt><dd>#application.dashboardManager.getTotalMembers(attributes.siteID)#</dd></cfif>
<dt>#application.rbFactory.getKeyValue(session.rb,"dashboard.administrativeusers")#</dt><dd>#application.dashboardManager.getTotalAdministrators(attributes.siteID)#</dd>
</dl>
</div>

<div id="recentcontent" class="divide">
<h3>#application.rbFactory.getKeyValue(session.rb,"dashboard.recentcontent")#</h3>
<cfset rsList=application.dashboardManager.getRecentUpdates(attributes.siteID,5) />
<ul>
	<cfloop query="rslist">
	<cfset crumbdata=application.contentManager.getCrumbList(rslist.contentid, attributes.siteid)/>
	<cfset verdict=application.permUtility.getnodePerm(crumbdata)/>
	<cfif verdict neq 'none'>
	<li><a title="Version History" href="index.cfm?fuseaction=cArch.hist&contentid=#rslist.ContentID#&type=#rslist.type#&parentid=#rslist.parentID#&topid=#rslist.contentID#&siteid=#attributes.siteid#&moduleid=#rslist.moduleid#">#HTMLEditFormat(rsList.menuTitle)#</a> #application.rbFactory.getKeyValue(session.rb,"dashboard.by")# #HTMLEditFormat(rsList.lastUpdateBy)# (#LSDateFormat(rsList.lastUpdate,session.dateKeyFormat)#)</li>
	<cfelse><li>#HTMLEditFormat(rslist.menuTitle)# #application.rbFactory.getKeyValue(session.rb,"dashboard.by")# #HTMLEditFormat(rsList.lastUpdateBy)# (#LSDateFormat(rsList.lastUpdate,session.dateKeyFormat)#)</li>
	</cfif>
	</cfloop>
</ul>
</div>

<cfset rsList=application.dashboardManager.getDraftList(attributes.siteID,listFirst(getAuthUser(),'^'),5) />
<div id="drafts" class="divide">
<h3>#application.rbFactory.getKeyValue(session.rb,"dashboard.draftsforreview")#</h3>
<ul><cfif rsList.recordcount>
	<cfloop query="rslist">
	<li><a title="Version History" href="index.cfm?fuseaction=cArch.hist&contentid=#rslist.ContentID#&type=#rslist.type#&parentid=#rslist.parentID#&topid=#rslist.contentID#&siteid=#attributes.siteid#&moduleid=#rslist.moduleid#">#HTMLEditFormat(rsList.menuTitle)#</a> #application.rbFactory.getKeyValue(session.rb,"dashboard.by")# #HTMLEditFormat(rsList.lastUpdateBy)# (#LSDateFormat(rsList.lastUpdate,session.dateKeyFormat)#)</li>
	</cfloop>
	<cfelse>
	<li>#application.rbFactory.getKeyValue(session.rb,"dashboard.nodrafts")#</li>
	</cfif>
</ul>
</div>
</cfoutput>
<cfset rsPluginScripts=application.pluginManager.getScripts("onDashboardSidebarBottom",attributes.siteID)>
<cfoutput query="rsPluginScripts" group="pluginID">
<div class="divide">
	<h3>#HTMLEditformat(rsPluginScripts.name)#</h3>
	<cfoutput>
	<cfset request.pluginConfig=application.pluginManager.getConfig(rsPluginScripts.pluginID)>
	<cfinclude template="/#application.configBean.getWebRootMap()#/plugins/#rsPluginScripts.directory#/#rsPluginScripts.scriptfile#">
	</cfoutput>
</div>
</cfoutput>
</div></div>
