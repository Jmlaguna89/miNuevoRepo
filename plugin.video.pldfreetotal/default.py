import xbmc,xbmcaddon,xbmcgui,xbmcplugin,os,sys,urlparse,re,time,urllib,urllib2,json,random,net,base64,logging
import pyxbmct.addonwindow as pyxbmct
from addon.common.addon import Addon

net = net.Net()
addon_id = 'plugin.video.pldfreetotal'
selfAddon = xbmcaddon.Addon(id=addon_id)
skintheme=selfAddon.getSetting('skin')
artpath='/resources/'+skintheme
icon = xbmc.translatePath(os.path.join('special://home/addons/' + addon_id, 'ico.png'))
fanart = xbmc.translatePath(os.path.join('special://home/addons/' + addon_id, 'fanart.jpg'))
button_quit= xbmc.translatePath(os.path.join('special://home/addons/' + addon_id + artpath, 'power.png'))
button_quit_focus= xbmc.translatePath(os.path.join('special://home/addons/' + addon_id + artpath, 'power_focus.png'))
button_focus = xbmc.translatePath(os.path.join('special://home/addons/' + addon_id + artpath, 'button_focus2.png'))
button_no_focus = xbmc.translatePath(os.path.join('special://home/addons/' + addon_id + artpath, 'button_no_focus2.png'))
button_focus1 = xbmc.translatePath(os.path.join('special://home/addons/' + addon_id + artpath, 'button_focus1.png'))
button_no_focus1 = xbmc.translatePath(os.path.join('special://home/addons/' + addon_id + artpath, 'button_no_focus1.png'))
bg = xbmc.translatePath(os.path.join('special://home/addons/' + addon_id + artpath, 'main-bg2.png'))
logos = os.path.join('logos')
window  = pyxbmct.AddonDialogWindow('')
window.setGeometry(1240, 650, 100, 50)
background=pyxbmct.Image(bg)
window.placeControl(background, -5, 0, 125, 51)
addon = Addon(addon_id, sys.argv)
mode = addon.queries.get('mode', '')

def START():
	global Entertainment
	global Movies
	global Music
	global News
	global Sport
	global Docs
	global Kids
	global Food
	global USA
	global Religion
	global List
	global Icon

	#create butttons
	if 'Red' in button_quit:text='0xffffffff'
	elif 'Blue' in button_quit:text='0xffffffff'
	else:text='0xFF000000'
	Entertainment= pyxbmct.Button('1',focusTexture=button_focus,noFocusTexture=button_no_focus,textColor=text,focusedColor=text)
	Movies = pyxbmct.Button('2',focusTexture=button_focus,noFocusTexture=button_no_focus,textColor=text,focusedColor=text)
	Music = pyxbmct.Button('3',focusTexture=button_focus,noFocusTexture=button_no_focus,textColor=text,focusedColor=text)
	News = pyxbmct.Button('4',focusTexture=button_focus,noFocusTexture=button_no_focus,textColor=text,focusedColor=text)
	Sport = pyxbmct.Button('5',focusTexture=button_focus,noFocusTexture=button_no_focus,textColor=text,focusedColor=text)
	Docs = pyxbmct.Button('6',focusTexture=button_focus,noFocusTexture=button_no_focus,textColor=text,focusedColor=text)
	Kids= pyxbmct.Button('7',focusTexture=button_focus,noFocusTexture=button_no_focus,textColor=text,focusedColor=text)
	Food = pyxbmct.Button('8',focusTexture=button_focus,noFocusTexture=button_no_focus,textColor=text,focusedColor=text)
	USA = pyxbmct.Button('9',focusTexture=button_focus,noFocusTexture=button_no_focus,textColor=text,focusedColor=text)
	Religion = pyxbmct.Button('0',focusTexture=button_focus,noFocusTexture=button_no_focus,textColor=text)
	List = pyxbmct.List(buttonFocusTexture=button_focus1,buttonTexture=button_no_focus1,_space=11,_itemTextYOffset=-7,textColor=text)
	Icon=pyxbmct.Image(icon, aspectRatio=2)
	Icon.setImage(icon)
	Quit = pyxbmct.Button(' ',noFocusTexture=button_quit,focusTexture=button_quit_focus)

	#place buttons
	window.placeControl(Entertainment,52, 2,  8, 2)
	window.placeControl(Movies ,52, 4, 8, 2)
	window.placeControl(Music,52, 6, 8, 2)
	window.placeControl(News,61, 2, 8, 2)
	window.placeControl(Sport,61, 4, 8, 2)
	window.placeControl(Docs,61, 6, 8, 2)
	window.placeControl(Kids,70, 2, 8, 2)
	window.placeControl(Food,70, 4, 8, 2)
	window.placeControl(USA,70, 6, 8, 2)
	window.placeControl(Religion,79, 4, 8, 2)
	window.placeControl(List, 23, 12, 80, 18)
	window.placeControl(Icon, 61, 35, 20, 10)
	window.placeControl(Quit, 18, 6, 7, 2)

	#capture mouse moves or up down arrows
	window.connectEventList(
	[pyxbmct.ACTION_MOVE_DOWN,
	pyxbmct.ACTION_MOVE_UP,
		pyxbmct.ACTION_MOUSE_MOVE],
	LIST_UPDATE)

	#navigation
	Entertainment.controlRight(Movies)
	Entertainment.controlLeft(Quit)
	Entertainment.controlDown(List)
	Movies.controlRight(Music)
	Movies.controlLeft(Entertainment)
	Movies.controlDown(List)
	Music.controlRight(News)
	Music.controlLeft(Movies)
	Music.controlDown(List)
	News.controlRight(Sport)
	News.controlLeft(Music)
	News.controlDown(List)
	Sport.controlRight(Docs)
	Sport.controlLeft(News)
	Sport.controlDown(List)
	Docs.controlRight(Kids)
	Docs.controlLeft(Sport)
	Docs.controlDown(List)
	Kids.controlRight(Food)
	Kids.controlLeft(Docs)
	Kids.controlDown(List)
	Food.controlRight(USA)
	Food.controlLeft(Kids)
	Food.controlDown(List)
	USA.controlRight(Religion)
	USA.controlLeft(Food)
	USA.controlDown(List)
	Religion.controlRight(Quit)
	Religion.controlLeft(USA)
	Religion.controlDown(List)
	List.controlUp(Entertainment)
	List.controlLeft(Entertainment)
	List.controlRight(Quit)
	Quit.controlLeft(Religion)
	Quit.controlRight(Entertainment)
	Icon.setImage(icon)
	
	#button actions	
	window.connect(Entertainment,ENT)
	window.connect(Movies,MOVIES)
	window.connect(Music,MUSIC)
	window.connect(News,NEWS)
	window.connect(Sport,SPORT)
	window.connect(Docs,DOCS)
	window.connect(Kids,KIDS)
	window.connect(Food,FOOD)
	window.connect(USA,USAMERICA)
	window.connect(Religion,RELIGION)
	window.connect(List, PlayStream)
	window.connect(Quit, window.close)
	secstore=selfAddon.getSetting('secstore')
	GetChannels(int(secstore))
	if secstore=='1':window.setFocus(Entertainment)
	if secstore=='2':window.setFocus(Movies)
	if secstore=='3':window.setFocus(Music)
	if secstore=='4':window.setFocus(News)
	if secstore=='5':window.setFocus(Sport)
	if secstore=='6':window.setFocus(Docs)
	if secstore=='7':window.setFocus(Kids)
	if secstore=='8':window.setFocus(Food)
	if secstore=='9':window.setFocus(USA)
	if secstore=='10':window.setFocus(Religion)

def PlayStream():
	window.close()
	liz=xbmcgui.ListItem(name, iconImage=iconimage,thumbnailImage=iconimage)
	xbmc.Player ().play(playurl, liz, False)

def ENT():
	List.reset()
	logging.warning('ENT SELECTED')
	sec=1
	selfAddon.setSetting('secstore',str(sec))
	GetChannels(sec)
	
def MOVIES():
	List.reset()
	logging.warning('MOVIES SELECTED')
	sec=2
	selfAddon.setSetting('secstore',str(sec))
	GetChannels(sec)

def MUSIC():
	List.reset()
	logging.warning('MUSIC SELECTED')
	sec=3
	selfAddon.setSetting('secstore',str(sec))
	GetChannels(sec)
	
def NEWS():
	List.reset()
	logging.warning('NEWS SELECTED')
	sec=4
	selfAddon.setSetting('secstore',str(sec))
	GetChannels(sec)
	
def SPORT():
	List.reset()
	logging.warning('SPORT SELECTED')
	sec=5
	selfAddon.setSetting('secstore',str(sec))
	GetChannels(sec)
	
def DOCS():
	List.reset()
	logging.warning('DOCS SELECTED')
	sec=6
	selfAddon.setSetting('secstore',str(sec))
	GetChannels(sec)
	
def KIDS():
	List.reset()
	logging.warning('KIDS SELECTED')
	sec=7
	selfAddon.setSetting('secstore',str(sec))
	GetChannels(sec)
	
def FOOD():
	List.reset()
	logging.warning('FOOD SELECTED')
	sec=8
	selfAddon.setSetting('secstore',str(sec))
	GetChannels(sec)
	
def USAMERICA():
	List.reset()	
	logging.warning('USA SELECTED')
	sec=9
	selfAddon.setSetting('secstore',str(sec))
	GetChannels(sec)
	
def RELIGION():
	List.reset()
	logging.warning('RELIGION SELECTED')
	sec=10
	selfAddon.setSetting('secstore',str(sec))
	GetChannels(sec)

def GetChannels(sec):
	global chname
	global chicon
	global chstream1
	global chstream2
	chname=[]
	chicon=[]
	chstream1=[]
	chstream2=[]
	match = GetContent()
	for name,iconimage,stream1,stream2,cat in match:
	  if not 'Planett' in name:
	     if not 'HD' in name:
		if name=='null':name='Channel'
		name=name.replace('"','').replace('*','').replace('Disnep','Disney')
		thumb='https:///'+iconimage+'|User-Agent=Dalvik/2.1.0 (Linux; U; Android 5.1.1; SM-G920F Build/LMY47X)'
		if int(cat)==sec:
			chname.append(name)
			chicon.append(thumb)
			chstream1.append(stream1)
			chstream2.append(stream2)
			List.addItem(name)


		   
def GetContent():
	
	headers={'Content-Type':'application/x-www-form-urlencoded; charset=UTF-8',
			 'Accept-Encoding' : 'gzip',
			 'Connection':'Keep-Alive',}
	channels = net.http_POST('aHR0cDovL2Nsb3VkLjYxMzkyNTMtMC5hbG9qYW1pZW50by13ZWIuZXMvZG93bmxvYWQvZnJlZXRvdGFsL2xpc3RhMS8xMDUueG1sP3Jhdz10cnVl'.decode('base64'),headers).content
	channels = channels.replace('aXBob25lcw=='.decode('base64'),'YWxwaGFjcw=='.decode('base64')).replace('YWxmYQ=='.decode('base64'),'dXNlcg=='.decode('base64'))
	channellist=re.compile('"channel_name":"(.+?)","img":"(.+?)","http_stream":"(.+?)","rtmp_stream":"(.+?)","cat_id":"(.+?)"').findall(channels)
	return channellist

def local_time(zone='Asia/Karachi'):
	from datetime import datetime
	from pytz import timezone
	other_zone = timezone(zone)
	other_zone_time = datetime.now(other_zone)
	return other_zone_time.strftime('%b-%d-%Y')
	


def cleanHex(text):
	def fixup(m):
		text = m.group(0)
		if text[:3] == "&#x": return unichr(int(text[3:-1], 16)).encode('utf-8')
		else: return unichr(int(text[2:-1])).encode('utf-8')
	try :return re.sub("(?i)&#\w+;", fixup, text.decode('ISO-8859-1').encode('utf-8'))
	except:return re.sub("(?i)&#\w+;", fixup, text.encode("ascii", "ignore").encode('utf-8'))
	
	 
########################################## ADDON SPECIFIC FUNCTIONS
def LIST_UPDATE():
	global playurl
	global playurl2
	global iconimage
	global name
	if window.getFocus() == List:
		pos=List.getSelectedPosition()
		iconimage=chicon[pos]
		name=chname[pos]
		Icon.setImage(iconimage)
		playurl=chstream1[pos]
		playurl2=chstream2[pos]
		playurl=playurl.split('|')[0]+'|User-Agent=Dalvik/2.1.0 (Linux; U; Android 5.1.1; SM-G920F Build/LMY47X)'

		  
def addLink(name,url,mode,iconimage,fanart,description=''):
		u=sys.argv[0]+"?url="+urllib.quote_plus(url)+"&mode="+str(mode)+"&name="+urllib.quote_plus(name)+"&description="+str(description)
		ok=True
		liz=xbmcgui.ListItem(name, iconImage="DefaultFolder.png", thumbnailImage=iconimage)
		liz.setInfo( type="Video", infoLabels={ "Title": name, 'plot': description } )
		liz.setProperty('fanart_image', fanart)
		ok=xbmcplugin.addDirectoryItem(handle=int(sys.argv[1]),url=u,listitem=liz,isFolder=False)
		return ok

START()

window.doModal()
del window
if mode==1:START()
#addLink('[COLOR gold]Relaunch Gui[/COLOR]','url',1,icon,fanart,description='')
xbmcplugin.endOfDirectory(int(sys.argv[1]))

