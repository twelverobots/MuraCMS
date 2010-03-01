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
<cfcomponent extends="mura.cfobject" output="false">

<cfset variables.instance.subTypeID=""/>
<cfset variables.instance.siteID=""/>
<cfset variables.instance.type=""/>
<cfset variables.instance.subtype=""/>
<cfset variables.instance.baseTable=""/>
<cfset variables.instance.baseKeyField=""/>
<cfset variables.instance.dataTable="tclassextenddata"/>
<cfset variables.instance.isActive=1/>
<cfset variables.instance.sets=""/>
<cfset variables.instance.errors=structnew() />


<cffunction name="init" returntype="any" output="false" access="public">
	<cfargument name="configBean">
	<cfargument name="contentRenderer">
	
	<cfset variables.configBean=arguments.configBean />
	<cfset variables.contentRenderer=arguments.contentRenderer />
	<cfset variables.dsn=variables.configBean.getDatasource()/>
	<cfreturn this />
</cffunction>

<cffunction name="getExtendSetBean" returnType="any">
<cfset var extendSetBean=createObject("component","mura.extend.extendSet").init(variables.configBean,variables.contentRenderer) />
<cfset extendSetBean.setSubTypeID(getSubTypeID()) />
<cfset extendSetBean.setSiteID(getSiteID()) />
<cfreturn extendSetBean />
</cffunction>

<cffunction name="load">
	<cfset var rs=""/>
		<cfquery name="rs" datasource="#variables.dsn#" username="#variables.configBean.getDBUsername()#" password="#variables.configBean.getDBPassword()#">
		select * from tclassextend 
		where subTypeID=<cfqueryparam cfsqltype="cf_sql_varchar"  value="#getsubtypeID()#">
		or (
			siteid=<cfqueryparam cfsqltype="cf_sql_varchar"  value="#getSiteID()#">
			and type=<cfqueryparam cfsqltype="cf_sql_varchar"  value="#gettype()#">
			and subType=<cfqueryparam cfsqltype="cf_sql_varchar"  value="#getsubtype()#">
			)
		order by type,subType
		</cfquery>
	
	<cfif rs.recordcount>
		<cfset set(rs) />
	</cfif>
	
</cffunction>

<cffunction name="set" returnType="void" output="false" access="public">
		<cfargument name="data" type="any" required="true">

		<cfset var prop=""/>
		
		<cfif isquery(arguments.data)>
		
			<cfset setSubTypeID(arguments.data.subTypeID) />
			<cfset setSiteID(arguments.data.siteID) />
			<cfset setType(arguments.data.type) />
			<cfset setSubType(arguments.data.subType) />
			<cfset setBaseTable(arguments.data.BaseTable) />
			<cfset setDataTable(arguments.data.BaseTable) />
			<cfset setbaseKeyField(arguments.data.baseKeyField) />
			<cfset setIsActive(arguments.data.isActive) />
			
		<cfelseif isStruct(arguments.data)>
		
			<cfloop collection="#arguments.data#" item="prop">
				<cfif isdefined("variables.instance.#prop#")>
					<cfset evaluate("set#prop#(arguments.data[prop])") />
				</cfif>
			</cfloop>
			
		</cfif>
		
		<cfset validate() />
		
</cffunction>
  
<cffunction name="validate" access="public" output="false" returntype="void">
	<cfset variables.instance.errors=structnew() />
</cffunction>

<cffunction name="getErrors" returnType="struct" output="false" access="public">
    <cfreturn variables.instance.errors />
</cffunction>

<cffunction name="getSiteID" returntype="String" access="public" output="false">
	<cfreturn variables.instance.siteID />
</cffunction>

<cffunction name="setSiteID" access="public" output="false">
	<cfargument name="siteID" type="String" />
	<cfset variables.instance.siteID = trim(arguments.siteID) />
</cffunction>

<cffunction name="getSubTypeID" returntype="String" access="public" output="false">
	<cfif not len(variables.instance.SubTypeID)>
		<cfset variables.instance.SubTypeID = createUUID() />
	</cfif>
	<cfreturn variables.instance.SubTypeID />
</cffunction>

<cffunction name="setSubTypeID" access="public" output="false">
	<cfargument name="SubTypeID" type="String" />
	<cfset variables.instance.SubTypeID = trim(arguments.SubTypeID) />
</cffunction>

<cffunction name="getType" returntype="String" access="public" output="false">
	<cfreturn variables.instance.Type />
</cffunction>

<cffunction name="setType" access="public" output="false">
	<cfargument name="Type" type="String" />
	<cfset variables.instance.Type = trim(arguments.Type) />
</cffunction>

<cffunction name="getSubType" returntype="String" access="public" output="false">
	<cfreturn variables.instance.SubType />
</cffunction>

<cffunction name="setSubType" access="public" output="false">
	<cfargument name="SubType" type="String" />
	<cfset variables.instance.SubType = trim(arguments.SubType) />
</cffunction>

<cffunction name="getDataTable" returntype="String" access="public" output="false">
	<cfreturn variables.instance.DataTable />
</cffunction>

<cffunction name="setDataTable" access="public" output="false">
	<cfargument name="DataTable" type="String" />
	<cfif len(trim(arguments.dataTable))>
		<cfset variables.instance.DataTable = trim(arguments.DataTable) />
	</cfif>
</cffunction>

<cffunction name="getBaseTable" returntype="String" access="public" output="false">
	<cfreturn variables.instance.BaseTable />
</cffunction>

<cffunction name="setBaseTable" access="public" output="false">
	<cfargument name="BaseTable" type="String" />
	<cfset variables.instance.BaseTable = trim(arguments.BaseTable) />
</cffunction>

<cffunction name="getbaseKeyField" returntype="String" access="public" output="false">
	<cfreturn variables.instance.baseKeyField />
</cffunction>

<cffunction name="setbaseKeyField" access="public" output="false">
	<cfargument name="baseKeyField" type="String" />
	<cfset variables.instance.baseKeyField = trim(arguments.baseKeyField) />
</cffunction>

<cffunction name="getIsActive" returntype="numeric" access="public" output="false">
	<cfreturn variables.instance.IsActive />
</cffunction>

<cffunction name="setIsActive" access="public" output="false">
	<cfargument name="IsActive"/>
	<cfif isNumeric(arguments.isActive)>
		<cfset variables.instance.IsActive = arguments.IsActive />
	</cfif>
</cffunction>

<cffunction name="getExtendSets" access="public" returntype="array">
<cfargument name="Inherit" required="true" default="false"/>
<cfargument name="doFilter" required="true" default="false"/>
<cfargument name="filter" required="true" default=""/>
<cfargument name="container" required="true" default=""/>
<cfset var rs=""/>
<cfset var tempArray=""/>
<cfset var extendSet=""/>
<cfset var extendArray=arrayNew(1) />
<cfset var rsSets=""/>
<cfset var extendSetBean=""/>
<cfset var s=0/>

	<cfset rsSets=getSetsQuery(arguments.inherit,arguments.doFilter,arguments.filter,arguments.container)/>
	
	<cfif rsSets.recordcount>
		<cfset tempArray=createObject("component","mura.queryTool").init(rsSets).toArray() />
		
		<cfloop from="1" to="#rsSets.recordcount#" index="s">
			
			<cfset extendSetBean=getExtendSetBean() />
			<cfset extendSetBean.set(tempArray[s]) />
			<cfset arrayAppend(extendArray,extendSetBean)/>
		</cfloop>
		
	</cfif>
	
	<cfreturn extendArray />
</cffunction>

<cffunction name="save"  access="public" output="false" returntype="void">
<cfset var rs=""/>
<cfset var extendSetBean=""/>

	<cfquery name="rs" datasource="#variables.dsn#" username="#variables.configBean.getDBUsername()#" password="#variables.configBean.getDBPassword()#">
	select subTypeID from tclassextend where subTypeID=<cfqueryparam cfsqltype="cf_sql_varchar" value="#getSubTypeID()#">
	</cfquery>
	
	<cfif rs.recordcount>
		
		<cfquery datasource="#variables.dsn#" username="#variables.configBean.getDBUsername()#" password="#variables.configBean.getDBPassword()#">
		update tclassextend set
		siteID = <cfqueryparam cfsqltype="cf_sql_varchar" null="#iif(getSiteID() neq '',de('no'),de('yes'))#" value="#getSiteID()#">,
		type = <cfqueryparam cfsqltype="cf_sql_varchar" null="#iif(getType() neq '',de('no'),de('yes'))#" value="#getType()#">,
		subType = <cfqueryparam cfsqltype="cf_sql_varchar" null="#iif(getSubType() neq '',de('no'),de('yes'))#" value="#getSubType()#">,
		baseTable = <cfqueryparam cfsqltype="cf_sql_varchar" null="#iif(getBaseTable() neq '',de('no'),de('yes'))#" value="#getBaseTable()#">,
		baseKeyField = <cfqueryparam cfsqltype="cf_sql_varchar" null="#iif(getbaseKeyField() neq '',de('no'),de('yes'))#" value="#getbaseKeyField()#">,
		dataTable=<cfqueryparam cfsqltype="cf_sql_varchar" null="#iif(getDataTable() neq '',de('no'),de('yes'))#" value="#getDataTable()#">,
		isActive = #getIsActive()#
		where subTypeID=<cfqueryparam cfsqltype="cf_sql_varchar"  value="#getSubTypeID()#">
		</cfquery>
		
	<cfelse>
	
		<cfquery datasource="#variables.dsn#" username="#variables.configBean.getDBUsername()#" password="#variables.configBean.getDBPassword()#">
		Insert into tclassextend (subTypeID,siteID,type,subType,baseTable,baseKeyField,dataTable,isActive) 
		values(
		<cfqueryparam cfsqltype="cf_sql_varchar"  value="#getsubTypeID()#">,
		<cfqueryparam cfsqltype="cf_sql_varchar" null="#iif(getSiteID() neq '',de('no'),de('yes'))#" value="#getSiteID()#">,
		<cfqueryparam cfsqltype="cf_sql_varchar" null="#iif(getType() neq '',de('no'),de('yes'))#" value="#getType()#">,
		<cfqueryparam cfsqltype="cf_sql_varchar" null="#iif(getSubType() neq '',de('no'),de('yes'))#" value="#getSubType()#">,
		<cfqueryparam cfsqltype="cf_sql_varchar" null="#iif(getBaseTable() neq '',de('no'),de('yes'))#" value="#getBaseTable()#">,
		<cfqueryparam cfsqltype="cf_sql_varchar" null="#iif(getbaseKeyField() neq '',de('no'),de('yes'))#" value="#getbaseKeyField()#">,
		<cfqueryparam cfsqltype="cf_sql_varchar" null="#iif(getDataTable() neq '',de('no'),de('yes'))#" value="#getDataTable()#">,
		#getIsActive()#)
		</cfquery>
		
		<cfset extendSetBean=getExtendSetBean() />
		<cfset extendSetBean.setName('Default') />
		<cfset extendSetBean.setSiteID(getSiteID()) />
		<cfset extendSetBean.save() />
	</cfif>
	
</cffunction>

<cffunction name="getExtendSetByName" access="public" output="false" returntype="any">
<cfargument name="name">
<cfset var extendSets=getExtendSets()/>
<cfset var i=0/>
<cfset var extendSet=""/>
	<cfif arrayLen(extendSets)>
	<cfloop from="1" to="#arrayLen(extendSets)#" index="i">
		<cfif extendSets[i].getName() eq arguments.name>
			<cfreturn extendSets[i]/>
		</cfif>
	</cfloop>
	</cfif>
	
	<cfset extendSet=getExtendSetBean()>
	<cfset extendSet.setName(arguments.name)>
	<cfreturn extendSet/>
</cffunction>

<cffunction name="delete" access="public" returntype="void">
<cfset var rs=""/>
<cfset var rsSets=""/>


	<cfset rsSets=getSetsQuery()/>
	
	<cfif rsSets.recordcount>	
		<cfloop query="rsSets">
			<cfset deleteSet(rsSets.ExtendSetID)/>
		</cfloop>
	</cfif>
	
	<cfquery datasource="#variables.dsn#" username="#variables.configBean.getDBUsername()#" password="#variables.configBean.getDBPassword()#">
	delete from tclassextend 
	where 
	subTypeID=<cfqueryparam cfsqltype="cf_sql_varchar"  value="#getsubtypeID()#">
	</cfquery>
	
	<cfquery datasource="#variables.dsn#" username="#variables.configBean.getDBUsername()#" password="#variables.configBean.getDBPassword()#">
	update #getBaseTable()#
	set subType='Default'
	where 
	siteID=<cfqueryparam cfsqltype="cf_sql_varchar"  value="#getSiteID()#">
	and subType=<cfqueryparam cfsqltype="cf_sql_varchar"  value="#getsubtype()#">
	</cfquery>

	
</cffunction>

<cffunction name="loadSet" access="public" returntype="any">
<cfargument name="ExtendSetID">
<cfset var extendSetBean=getExtendSetBean() />
	
	<cfset extendSetBean.setExtendSetID(arguments.ExtendSetID)/>
	<cfset extendSetBean.load()/>
	<cfreturn extendSetBean/>

</cffunction>


<cffunction name="addExtendSet" access="public" output="false" returntype="void">
<cfargument name="rawdata">
<cfset var extendSet=""/>
<cfset var data=arguments.rawdata />

	<cfif not isObject(data)>
		<cfset extendSet=getExtendSetBean() />
		<cfset extendSet.set(data)/>
	<cfelse>
		<cfset extendSet=data />
	</cfif>
	
	<cfset extendSet.setSubTypeID(getSubTypeID())/>
	<cfset extendSet.setSiteID(getSiteID())/>
	<cfset extendSet.save()/>
	<cfset arrayAppend(getExtendSets(),extendSet)/>
	
</cffunction>

<cffunction name="deleteSet" access="public" returntype="void">
<cfargument name="ExtendSetID">
<cfset var extendSetBean=getExtendSetBean() />
			
			<cfset extendSetBean.setExtendSetID(ExtendSetID) />
			<cfset extendSetBean.delete() />
</cffunction>

<cffunction name="getSetsQuery" access="public" returntype="query">
<cfargument name="Inherit" required="true" default="false"/>
<cfargument name="doFilter" required="true" default="false"/>
<cfargument name="filter" required="true" default=""/>
<cfargument name="container" required="true" default=""/>
<cfset var rs=""/>
<cfset var rsFinal=""/>
<cfset var f=""/>
<cfset var rsDefault=""/>
<cfset var fLen=listLen(arguments.filter)/>

		<cfquery name="rs" datasource="#variables.dsn#" username="#variables.configBean.getDBUsername()#" password="#variables.configBean.getDBPassword()#">
		select ExtendSetID,subTypeID,name,orderno,isActive,siteID,categoryID,orderno,0 as setlevel from tclassextendsets 
		where subTypeID=<cfqueryparam cfsqltype="cf_sql_varchar"  value="#getsubtypeID()#">
		and siteID=<cfqueryparam cfsqltype="cf_sql_varchar"  value="#getSiteID()#">
		<cfif arguments.doFilter and fLen>
		and (
		<cfloop from="1" to="#fLen#" index="f">
		categoryID like '%#listGetAt(arguments.filter,f)#%' <cfif f lt fLen>or</cfif> 
		</cfloop>
		)
		<cfelseif arguments.doFilter>
		and categoryID is null
		</cfif>
		
		<cfif len(arguments.container)>
		and tclassextendsets.container=<cfqueryparam cfsqltype="cf_sql_varchar"  value="#arguments.container#">
		</cfif>
		
		<cfif arguments.inherit and getSubType() neq "Default">
			Union All

			select tclassextendsets.ExtendSetID,tclassextendsets.subTypeID,tclassextendsets.name,tclassextendsets.orderno,tclassextendsets.isActive,tclassextendsets.siteID,tclassextendsets.categoryID,tclassextendsets.orderno,1 as setlevel from tclassextendsets 
		    Inner Join tclassextend
		    On (tclassextendsets.subTypeID=tclassextend.subTypeID)
			where
			tclassextend.type=<cfqueryparam cfsqltype="cf_sql_varchar"  value="#getType()#">
			and tclassextend.subType=<cfqueryparam cfsqltype="cf_sql_varchar"  value="Default">
			and tclassextend.siteID=<cfqueryparam cfsqltype="cf_sql_varchar"  value="#getSiteID()#">
			<cfif arguments.doFilter and fLen>
			and (
			<cfloop from="1" to="#fLen#" index="f">
			tclassextendsets.categoryID like '%#listGetAt(arguments.filter,f)#%' <cfif f lt fLen>or</cfif> 
			</cfloop>
			)
			<cfelseif arguments.doFilter>
			and tclassextendsets.categoryID is null
			</cfif>
			<cfif len(arguments.container)>
			and tclassextendsets.container=<cfqueryparam cfsqltype="cf_sql_varchar"  value="#arguments.container#">
			</cfif>
		</cfif>
		</cfquery>

		<cfquery name="rsFinal" dbtype="query">
		select * from rs order by setlevel desc, orderno
		</cfquery>
		
	<cfreturn rsFinal />
</cffunction>

<cffunction name="getTypeAsString" returntype="string">

<cfif isNumeric(getType())>
	<cfif arguments.type eq 1>
	<cfreturn "User Group">
	<cfelse>
	<cfreturn "User">
	</cfif>
<cfelse>
	<cfreturn getType() />
</cfif>
</cffunction>

</cfcomponent>