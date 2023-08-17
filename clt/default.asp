<!--#include file="./core/popasp/popasp.asp"-->
<%
'为了安全考虑，核心路径最好修改成别人不容易猜出的名称
'将上面两行include包含语句中的 core 与下面的coreName 同时进行修改
'比如将 core 改成 core123
private coreName
coreName = "core" 'coreName
'coreName = "core123"

'如果给该文件重命名，系统将无法正常运行

'指定框架路径
POP_MVC.mvc_dir = coreName & "/popasp/"
POP_MVC.appPath = coreName
POP_MVC.config("EXTEND_PATH") = coreName & "/Extend"
POP_MVC.config("PLUGIN_PATH") = coreName & "/"
POP_MVC.config("CORE_NAME") = coreName
POP_MVC.config("DEFAULT_MODULE") = "bbs--index"

'内存缓存
'application.contents.removeAll
'POP_MVC.applicationOn = 1

if POP_MVC.config("EXT_CONFIG") = "" then POP_MVC.config("EXT_CONFIG") = "./config.asp"

POP_MVC.init

Private script_name

script_name = LCase(POP_MVC.file.basename( Array(POP_MVC.vars("SCRIPT_NAME") , 1) ))

if script_name <> "nocms" then
	dim setting,config
	private sitePath
	sitePath = POP_MVC.get_site_path

	POP_MVC.config("sitePath") = sitePath
	
	if sitePath <> "" then
		POP_MVC.config("CMS_UPLOAD_PATH") = sitePath & POP_MVC.config("CMS_UPLOAD_PATH")
	end if	

	'得到配置
	set config = T_("CONFIGS")

	'配置表验证
	if config is nothing then
		POP_MVC.exit( "网站配置文件损坏，无法打开" )
	end if

	'if config.charset = "gb2312" then
	'	Response.Charset = config.charset
	'	Response.codepage = 936
	'end if

	'网站禁用
	if config.siteMode = 0 then POP_MVC.exit( config.siteHelp )
	
	POP_MVC.config("APP_DEBUG") = Cint( config.appDebug )

	Private home_page,LanguageAlias,entranceasp

	'得到首页与语言
	if script_name = "popasp_inc" then
		LanguageAlias = ""
	elseif script_name = "index" or script_name = "default" then
		home_page = "./index.html"
	elseif script_name = POP_MVC.config("WAP_NAME") then
		home_page = "./" & POP_MVC.config("WAP_NAME") & "/index.html"
		POP_MVC.config("isWap") = 1	
	elseif inStr(script_name , POP_MVC.config("WAP_NAME") ) > 1 then
		LanguageAlias = left( script_name , len(script_name) - 3 )
		home_page = "./" & LanguageAlias & "/" & POP_MVC.config("WAP_NAME") & "/index.html"
		POP_MVC.config("isWap") = 1	
	else
		LanguageAlias = script_name
		home_page = "./" & LanguageAlias & "/index.html"
	end if


	'打开静态页面
	if config.runMode = 1 and Request.QueryString = "" then
		if POP_MVC.file.isFile( home_page ) then
			response.write POP_MVC.file_get_contents( home_page ) 
			response.end
		end if
	end if
	
	set setting = config

	if LanguageAlias = "" then		
		POP_MVC.config("ENTRY_PAGE") = POP_MVC.config("INDEX_PAGE")
	else
		POP_MVC.config("ENTRY_PAGE") = LanguageAlias & ".asp"
	end if

	'该语言网站关闭
	if setting.LanguageStatus = 0 then
		POP_MVC.exit( setting.LanguageName & " 网站关闭" )
	end if

	if POP_MVC.config("isWap") = 1 then
		setting.htmlFilePath = POP_MVC.config("WAP_NAME")
		if LanguageAlias = "" then
			POP_MVC.config("ENTRY_PAGE") = POP_MVC.config("WAP_PAGE")
		else
			POP_MVC.config("ENTRY_PAGE") = LanguageAlias & POP_MVC.config("WAP_PAGE")
		end if
	else
		if LanguageAlias = "" then
			POP_MVC.config("ENTRY_PAGE") = POP_MVC.config("INDEX_PAGE")
		else
			POP_MVC.config("ENTRY_PAGE") = LanguageAlias & ".asp"
		end if

		'如果开启了手机版本，请选择了直接切换手机版本
		if config.switchWapStatus = 1 and config.switchWapMode = 1 then
			'判断是否手机版访问
			if checkWap() then
				if POP_MVC.file.isFolder( "templates/" & setting.DefaultTemplate & "/" & POP_MVC.config("WAP_NAME") ) then
					'如果手机版入口文件存在
					response.redirect iif(LanguageAlias = "" , "" , LanguageAlias) & POP_MVC.config("WAP_PAGE") & iif(Request.QueryString = "" , "" , "?" & Request.QueryString)
				end if
			end if
		end if
	end if

	'水印
	if config.waterType = 1 then
		POP_MVC.config("WATERMARK_PATH") = config.waterMarkFont
	else
		POP_MVC.config("WATERMARK_PATH") = config.waterMarkPic
	end if

	dim objCMS

	set objCMS = P_( C_("CMS_CLASS_NAME") )
	objCMS.baseTable = "self_GuestConfig"
end if
POP_MVC.isExecuteExtends = false
POP_MVC.start
%>