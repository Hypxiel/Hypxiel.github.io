<%
'如果没有调用popasp则跳转到首页
if isEmpty( POP_MVC ) then response.redirect "./"

'显示页面Trace信息
POP_MVC.config("SHOW_PAGE_TRACE") = 0

'网站是否处于上线状态，开发中设为1，上线后设为0
POP_MVC.config("APP_DEBUG") = 1

'动态默认网址的入口文件
POP_MVC.config("INDEX_PAGE") = "default.asp"

POP_MVC.config("WAP_NAME") = "wap"

'配置文件中的配置项的格式为 POP_MVC.config(key) = value

''URL访问模式支持 0 (普通模式); 1 (PATHINFO 模式); 
POP_MVC.config( "URL_MODE" ) = 1

private action

action = LCase(request.querystring("a"))

if action = "search" or action = "msearch" OR action = "tpl"  OR action = "ajax" OR action = "removeproductcart" then
	POP_MVC.config( "URL_MODE" ) = 0
end if

''PATHINFO模式下的参数分割符 
POP_MVC.config( "URL_DEPR" ) = "_"

''PATHINFO模式下的匹配规则
'第4个参数,有3种: get,post,ignore，默认为get
POP_MVC.config( "URL_RULE" ) = array( _
	Array( "^checkcode$" , "a" , "c=bbs--Top") _	
	,Array( "^checkcode_[\w\.]+$" , "a_id" , "c=bbs--Top" ) _
	,Array( "^upload4summernote_upload$" , "aspbbs_a" , "c=bbs--upload4summernote" ) _
	,Array( "^u_[0-9]+$" , "aspbbs_id" , "c=bbs--U" ) _
	,Array( "^v_[0-9]+$" , "aspbbs_id" , "c=bbs--U&a=timeline" ) _
	,Array( "^[1-9]\d*$" , "id" , "c=bbs--thread&a=detail" ) _
	,Array( "^[1-9]\d*_[1-9]\d*$" , "id_page" , "c=bbs--thread&a=detail" ) _
	,Array( "^p_[1-9]\d*$" , "aspbbs_id" , "c=bbs--thread&a=detail" ) _
	,Array( "^p_[1-9]\d*_[1-9]\d*$" , "aspbbs_id_page" , "c=bbs--thread&a=detail" ) _
	,Array( "^post_[1-9]\d*$" , "aspbbs_id" , "c=bbs--thread&a=detail" ) _
	,Array( "^post_[1-9]\d*_[1-9]\d*$" , "aspbbs_id_page" , "c=bbs--thread&a=detail" ) _
	,Array( "^thread_[1-9]\d*$" , "aspbbs_id" , "c=bbs--thread&a=detail" ) _
	,Array( "^thread_[1-9]\d*_[1-9]\d*$" , "aspbbs_id_page" , "c=bbs--thread&a=detail" ) _
	,Array( "^thread_[a-z][a-z0-9]*$" , "aspbbs_a" , "c=bbs--thread" ) _
	,Array( "^thread_[a-z][a-z0-9]*_[1-9]\d*$" , "aspbbs_a_page" , "c=bbs--thread" ) _
	,Array( "^index_[1-9]\d*$" , "a_page" , "c=bbs--thread&a=index&id=0" ) _
	,Array( "^list_[1-9]\d*$" , "aspbbs_id" , "c=bbs--thread&a=index" ) _
	,Array( "^list_[1-9]\d*_[1-9]\d*$" , "aspbbs_id_page" , "c=bbs--thread&a=index" ) _
	,Array( "^case$" , "" , "c=bbs--case" ) _
	,Array( "^thanks$" , "" , "c=bbs--thanks" ) _
	,Array( "^login$" , "" , "c=bbs--login" ) _
	,Array( "^logout$" , "" , "c=bbs--logout" ) _
	,Array( "^reg$" , "" , "c=bbs--reg" ) _
	,Array( "^post$" , "" , "c=bbs--Topic&a=Add" ) _
	,Array( "^sitemap$" , "" , "c=bbs--sitemap" ) _
	,Array( "^case_[1-9]\d*$" , "aspbbs_id" , "c=bbs--case&a=index" ) _
	,Array( "^case_[1-9]\d*_[1-9]\d*$" , "aspbbs_id_page" , "c=bbs--case&a=index" ) _
	,Array( "^[a-z0-9]+--[a-z][a-z0-9]*$" , "c" , "a=index" ) _
	,Array( "^bbs--File_redundancy$" , "c_a") _	
	,Array( "^bbs--File_redundancy_\w+$" , "c_a_action") _
	,Array( "^bbs--File_emptyFolder$" , "c_a") _	
	,Array( "^bbs--File_emptyFolder_\w+$" , "c_a_action") _	
	,Array( "^[a-z0-9]+--[a-z][a-z0-9]*_[0-9]+$" , "c_id" , "a=index" ) _
	,Array( "^[a-z0-9]+--[a-z][a-z0-9]*_[a-z][a-z0-9]*$" , "c_a" ) _
	,Array( "^[a-z0-9]+--Site*_Status*_[0-9]+$" , "c_a_MailAlert" ) _
	,Array( "^[a-z0-9]+--[a-z][a-z0-9]*_[a-z][a-z0-9]*_[0-9]+$" , "c_a_id" ) _
	,Array( "^[a-z0-9]+--[a-z][a-z0-9]*_[a-z][a-z0-9]*_[0-9]+_[1-9]\d*$" , "c_a_id_page" ) _
)

'数据库存放目录文件名
POP_MVC.config("DATA_NAME") = "data"

''仅适用于sqlserver、mysql
POP_MVC.config("DB_HOST") = "localhost"

'数据库名,mysql或sqlserver数据时设置有效
POP_MVC.config("DB_NAME") = "aspbbs"

''数据库用户名，仅适用于sqlserver、mysql
POP_MVC.config("DB_USER") = "root"

''数据库密码，数据库密码，仅适用于sqlserver、mysql
POP_MVC.config("DB_PWD") = "123456"

'数据库类型，支持 access、sqlite3、mysql 三种
POP_MVC.config("DB_TYPE") = "access"

'sqlite3数据库安装好驱动后，这里填写对应的驱动名称
POP_MVC.config("SQLITE3_DRIVER_NAME") = "SQLite3 ODBC Driver"

if POP_MVC.config("DB_TYPE") = "access" then
	POP_MVC.config("DB_PATH") = POP_MVC.config("CORE_NAME") & "/" & POP_MVC.config("DATA_NAME") & "/#aspbbs#.mdb"
elseif POP_MVC.config("DB_TYPE") = "sqlite3" then
	POP_MVC.config("DB_PATH") = POP_MVC.config("CORE_NAME") & "/" & POP_MVC.config("DATA_NAME") & "/#aspbbs#.db"
end if

'幻灯片设置
'POP_MVC.config("slide_name_list") = Array("幻灯片A","幻灯片B","幻灯片C","幻灯片D")

'上传文件路径，必须写成根目录，如果是二级目录不用更改，后面不用加/
POP_MVC.config("CMS_UPLOAD_PATH") = "/upload"

''上传的文件限制
POP_MVC.config("UPLOAD_MAX_FILESIZE") = 10*1024*1024

''上传限制
POP_MVC.config("UPLOAD_MAX_SIZE") = 100*1024*1024

''允许上传的类型,只允许上传图片jpg;jpeg;png;gif;bmp
POP_MVC.config("UPLOAD_ALLOW_TYPES") = "png;jpg;jpeg;gif;bmp;flv;swf;mkv;avi;rm;rmvb;mpeg;mpg;ogg;ogv;mov;wmv;mp4;webm;mp3;wav;mid;rar;zip;tar;gz;7z;bz2;cab;iso;doc;docx;xls;xlsx;ppt;pptx;pdf;txt;md;xml;wma;ico"







'''''''''''''''以下内容由项目开发者设置，切勿改动'''''''''''''''''
POP_MVC.config("CMS_NAME") = "ASPBBS"
POP_MVC.config("CMS_POWER_NAME") = "ASPBBS"

'数据表名前缀
POP_MVC.config( "DB_PREFIX" ) = "iAspCms_"

'插件数据表名前缀
POP_MVC.config( "EXTEND_TBL_PREFIX" ) = "iAspCms_self_"

'数据库查询语句表名前缀
POP_MVC.config( "DB_INNER_PREFIX" ) = "{prefix}"

'CMS版本号
POP_MVC.config("CMS_VERSION") = "1.1.2"

'文章内容分页标识符
POP_MVC.config("content_page_lable") = "{aspbbs:page}"

'cms类名
POP_MVC.config("CMS_CLASS_NAME") = "aspbbs"

'标签标识符{aspbbs:item}
POP_MVC.config("CMS_TAG_LABEL") = "aspbbs"

'自定义标签标识符{label:item}
POP_MVC.config("CMS_SELF_TAG_LABEL") = "label"

'后台管理日志，1记录，0不记录
'POP_MVC.config("CMS_ADMIN_LOG") = 1

'共用静态资源存放目录文件名
POP_MVC.config("STATIC_NAME") = "static"

'动态链接后缀
POP_MVC.config( "URL_SUFFIX" ) = ".html"

''''''''''''''''''''''''''''''''''''''''''''''''
%>