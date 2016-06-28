# -*- coding: utf-8 -*-
import sys
import os
import json
import urllib
import urllib2
import urlparse
import xbmcaddon
import xbmcgui
import xbmcplugin
import load_channels
import hashlib
import re
import time
import xbmc
import net
import server
import config
import shutil
import unicodedata
import xbmc
import base64

from t0mm0.common.addon import Addon
from metahandler import metahandlers

addon_id = 'plugin.video.pldstalker'
selfAddon = xbmcaddon.Addon(id=addon_id)
addon = Addon(addon_id, sys.argv)
fanart = xbmc.translatePath(os.path.join('special://home/addons/' + addon_id , 'fanart.jpg'))
iconlm = xbmc.translatePath(os.path.join('special://home/addons/' + addon_id, 'iconlm.png'))
iconhdm = xbmc.translatePath(os.path.join('special://home/addons/' + addon_id, 'iconhdm.png'))
iconts = xbmc.translatePath(os.path.join('special://home/addons/' + addon_id, 'iconts.png'))
icons = xbmc.translatePath(os.path.join('special://home/addons/' + addon_id, 'icons.png'))
icon = xbmc.translatePath(os.path.join('special://home/addons/' + addon_id, 'icon.png'))
Decode = base64.decodestring
directory = xbmc.translatePath('special://home/userdata/addon_data/script.tvguidetecbox/')
destinaddons = xbmc.translatePath('special://home/userdata/addon_data/script.tvguidetecbox/addons.ini')
destinsets = xbmc.translatePath('special://home/userdata/addon_data/script.tvguidetecbox/settings.xml')
directoryr = xbmc.translatePath('special://home/userdata/addon_data/script.renegadestv/')
destinaddonsr = xbmc.translatePath('special://home/userdata/addon_data/script.renegadestv/addons2.ini')
destinsetsr = xbmc.translatePath('special://home/userdata/addon_data/script.renegadestv/settings.xml')
destmw1dir = xbmc.translatePath('special://home/userdata/addon_data/plugin.video.pldstalker/')
destinf1 = xbmc.translatePath('special://home/userdata/addon_data/plugin.video.pldstalker/http_mw1_iptv66_tv-genres')
destinf2 = xbmc.translatePath('special://home/userdata/addon_data/plugin.video.pldstalker/http_mw1_iptv66_tv')
metaset = selfAddon.getSetting('enable_meta')

plugin_handle = int(sys.argv[1])

mysettings = xbmcaddon.Addon(id = 'plugin.video.pldstalker')
profile = mysettings.getAddonInfo('profile')
home = mysettings.getAddonInfo('path')
online_m3u = mysettings.getSetting('online_m3u')
local_m3u = mysettings.getSetting('local_m3u')
online_xml = ('http://shanghai.watchkodi.com/Sections/Sports/Live%20games%20+%20Events/Live%20Football.xml')
local_xml = mysettings.getSetting('local_xml')
xml_regex = '<title>(.*?)</title>\s*<link>(.*?)</link>\s*<thumbnail>(.*?)</thumbnail>'
m3u_thumb_regex = 'tvg-logo=[\'"](.*?)[\'"]'
m3u_regex = '#(.+?),(.+)\s*(.+)\s*'
u_tube = 'http://www.youtube.com'

addon       = xbmcaddon.Addon()
addonname   = addon.getAddonInfo('name')
addondir    = xbmc.translatePath( addon.getAddonInfo('profile') ) 

base_url = sys.argv[0]
addon_handle = int(sys.argv[1])
args = urlparse.parse_qs(sys.argv[2][1:])
go = True;

xbmcplugin.setContent(addon_handle, 'movies')

net = net.Net()
dialog = xbmcgui.Dialog()

def Main():
	addDir('[COLOR yellow]*** Seleccione una Opcion ***[/COLOR]','',0,icon, fanart)
	addDir('[COLOR blue]BORRAR CACHE[/COLOR]','0',1000,icon, fanart)
	addDir('[COLOR blue]BORRAR PAQUETES[/COLOR]','0',1001,icon, fanart)
	addDir('[COLOR blue]BORRAR DATA[/COLOR]','0',1002,icon, fanart)

	
	
	
	xbmc.executebuiltin('Container.SetViewMode(50)')

def Ivue():
	if not os.path.exists(directory):
		dialog.ok(addonname, 'Please makesure you have ivue tv guide installed and you have run it at least once then use this function to enable integration')
		dialog.notification(addonname, 'please install and run ivue tv guide at least once', xbmcgui.NOTIFICATION_ERROR );
	
	if os.path.exists(directory):
		try: 
			os.makedirs(destmw1dir)
		except OSError:
			if not os.path.isdir(destmw1dir):
				raise
			
		addonsini = urllib.URLopener()
		addonsini.retrieve("http://proyectoluzdigital.info/tvguia/stalker/tvguidebox/addons.ini", destinaddons)
		addonsini = urllib.URLopener()
		addonsini.retrieve("http://proyectoluzdigital.info/tvguia/stalker/tvguidebox/settings.xml", destinsets)
		addonsini = urllib.URLopener()
		addonsini.retrieve("https://raw.githubusercontent.com/Inside4ndroid/kodi-15/master/http_mw1_iptv66_tv", destinf2)
		addonsini = urllib.URLopener()
		addonsini.retrieve("https://raw.githubusercontent.com/Inside4ndroid/kodi-15/master/http_mw1_iptv66_tv-genres", destinf1)
		addDir('[COLOR yellow]*** Todo Hecho Ahora Pulse Atrás ***[/COLOR]','0',0,icon,'',fanart)
	xbmc.executebuiltin('Container.SetViewMode(50)')
	
def Reneg():
	if not os.path.exists(directoryr):
		dialog.ok(addonname, 'Please makesure you have renegades tv guide installed and you have run it at least once then use this function to enable integration')
		dialog.notification(addonname, 'please install and run renegades tv guide at least once', xbmcgui.NOTIFICATION_ERROR );
	
	if os.path.exists(directoryr):
		try: 
			os.makedirs(destmw1dir)
		except OSError:
			if not os.path.isdir(destmw1dir):
				raise
				
		addonsinir = urllib.URLopener()
		addonsinir.retrieve("https://raw.githubusercontent.com/Inside4ndroid/kodi-15/master/addons2.ini", destinaddonsr)
		addonsinir = urllib.URLopener()
		addonsinir.retrieve("https://raw.githubusercontent.com/Inside4ndroid/kodi-15/master/settings.xml", destinsetsr)
		addonsini = urllib.URLopener()
		addonsini.retrieve("https://raw.githubusercontent.com/Inside4ndroid/kodi-15/master/http_mw1_iptv66_tv", destinf2)
		addonsini = urllib.URLopener()
		addonsini.retrieve("https://raw.githubusercontent.com/Inside4ndroid/kodi-15/master/http_mw1_iptv66_tv-genres", destinf1)
		addDir('[COLOR yellow]*** Todo Hecho Ahora Pulse Atrás ***[/COLOR]','0',0,icon,'',fanart)
	xbmc.executebuiltin('Container.SetViewMode(50)')

def DELETECACHE(url):
    print '###DELETING STANDARD CACHE###'
    xbmc_cache_path = os.path.join(xbmc.translatePath('special://home'), 'cache')
    if os.path.exists(xbmc_cache_path)==True:    
        for root, dirs, files in os.walk(xbmc_cache_path):
            file_count = 0
            file_count += len(files)
        
        # Count files and give option to delete
            if file_count > 0:
    
                dialog = xbmcgui.Dialog()
                if dialog.yesno("Borrando cahe en kodi", str(file_count) + " archivos encontrados", "¿Quieres eliminarlos??"):
                
                    for f in files:
                        try:
                            os.unlink(os.path.join(root, f))
                        except:
                            pass
                    for d in dirs:
                        try:
                            shutil.rmtree(os.path.join(root, d))
                        except:
                            pass
                        
            else:
                pass
    
    
    
	addDir('[COLOR yellow]*** Todo Hecho Ahora Pulse Atrás ***[/COLOR]','0',0,icon,'',fanart)
	xbmc.executebuiltin('Container.SetViewMode(50)')
	
def DELETEPACKAGES(url):
    print '###DELETING PACKAGES###'
    packages_cache_path = xbmc.translatePath(os.path.join('special://home/addons/packages', ''))
    try:    
        for root, dirs, files in os.walk(packages_cache_path):
            file_count = 0
            file_count += len(files)
            
        # Count files and give option to delete
            if file_count > 0:
    
                dialog = xbmcgui.Dialog()
                if dialog.yesno("Delete Package Cache Files", str(file_count) + " archivos encontrados", "¿Quieres eliminarlos??"):
                            
                    for f in files:
                        os.unlink(os.path.join(root, f))
                    for d in dirs:
                        shutil.rmtree(os.path.join(root, d))
                    addDir('[COLOR yellow]*** Todo Hecho Ahora Pulse Atrás ***[/COLOR]','0',0,icon,'',fanart)
                else:
                        pass
            else:
				addDir('[COLOR yellow]*** No hay Paquetes para borrar ***[/COLOR]','0',0,icon,'',fanart)
				addDir('[COLOR yellow]*** Todo Hecho Ahora Pulse Atrás ***[/COLOR]','0',0,icon,'',fanart)
    except: 
		addDir('[COLOR yellow]*** ha ocurrido un herror ***[/COLOR]','0',0,icon,'',fanart)
		addDir('[COLOR yellow]*** Todo Hecho Ahora Pulse Atrás ***[/COLOR]','0',0,icon,'',fanart)
    return
	
def DELETEDATA(url):
    print '###BORRAR DATA###'
    xbmc_cache_path = os.path.join(xbmc.translatePath('special://home/userdata'), 'Database')
    if os.path.exists(xbmc_cache_path)==True:    
        for root, dirs, files in os.walk(xbmc_cache_path):
            file_count = 0
            file_count += len(files)
        
        # Count files and give option to delete
            if file_count > 0:
    
                dialog = xbmcgui.Dialog()
                if dialog.yesno("Borrando data en kodi", str(file_count) + " archivos encontrados", "¿Quieres eliminarlos??"):
                
                    for f in files:
                        try:
                            os.unlink(os.path.join(root, f))
                        except:
                            pass
                    for d in dirs:
                        try:
                            shutil.rmtree(os.path.join(root, d))
                        except:
                            pass
                        
            else:
                pass
    
    
    
	addDir('[COLOR yellow]*** Todo Hecho Ahora Pulse Atrás ***[/COLOR]','0',0,icon,'',fanart)
	xbmc.executebuiltin('Container.SetViewMode(50)')
	
def RESOLVE(url,name): 
    play=xbmc.Player(GetPlayerCore())
    import urlresolver
    try: play.play(url)
    except: pass
    from urlresolver import common
    dp = xbmcgui.DialogProgress()
    dp.create('[COLORlime]Architects@Work[/COLOR]','Opening %s Now'%(name))
    if dp.iscanceled(): 
        print "[COLORred]STREAM CANCELLED[/COLOR]" # need to get this part working    
        dp.update(100)
        dp.close()
        dialog = xbmcgui.Dialog()
        if dialog.yesno("[B]CANCELLED[/B]", '[B]Was There A Problem[/B]','', "",'Yes','No'):
            dialog.ok("Message Send", "Your Message Has Been Sent")
        else:
	         return
    else:
        try: play.play(url)
        except: pass
        try: ADDON.resolve_url(url) 
        except: pass 
  
def GetChannels():
    html=OPEN_URL('http://uktvnow.desistreams.tv/DesiStreams/index202.php?tag=get_all_channel&username=inside4ndroid')
    match = re.compile('"id":".+?","name":"(.+?)","img":"(.+?)","stream_url3":"(.+?)","cat_id":".+?","stream_url2":"(.+?)","stream_url":"(.+?)"}',re.DOTALL).findall(html)
    for name,img,url,url2,url3 in match:
        addDir1('[COLORwhite]'+name+'[/COLOR] [COLORgreen][I]L1[/I][/COLOR]',(url).replace('\\',''),1002,'http://uktvnow.desistreams.tv/' + (img).replace('\\',''))
        addDir1('[COLORwhite]'+name+'[/COLOR] [COLORgreen][I]L2[/I][/COLOR]',(url2).replace('\\',''),1002,'http://uktvnow.desistreams.tv/' + (img).replace('\\',''))
        addDir1('[COLORwhite]'+name+'[/COLOR] [COLORgreen][I]L3[/I][/COLOR]',(url3).replace('\\',''),1002,'http://uktvnow.desistreams.tv/' + (img).replace('\\',''))
		
def OPEN_URL(url):
    req = urllib2.Request(url)
    req.add_header('User-Agent', 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-GB; rv:1.9.0.3) Gecko/2008092417 Firefox/3.0.3')
    response = urllib2.urlopen(req)
    link=response.read()
    response.close()
    return link

def addLink(name,url,mode,iconimage,fanart,description=''):
		u=sys.argv[0]+"?url="+urllib.quote_plus(url)+"&mode="+str(mode)+"&name="+urllib.quote_plus(name)+"&description="+str(description)
		ok=True
		liz=xbmcgui.ListItem(name, iconImage="DefaultFolder.png", thumbnailImage=iconimage)
		liz.setInfo( type="Video", infoLabels={ "Title": name, 'plot': description } )
		liz.setProperty('fanart_image', fanart)
		ok=xbmcplugin.addDirectoryItem(handle=int(sys.argv[1]),url=u,listitem=liz,isFolder=False)
		return ok

def addDir(name,url,mode,iconimage,fanart,description=''):
		u=sys.argv[0]+"?url="+urllib.quote_plus(url)+"&mode="+str(mode)+"&name="+urllib.quote_plus(name)+"&description="+str(description)
		ok=True
		liz=xbmcgui.ListItem(name, iconImage="DefaultFolder.png", thumbnailImage=iconimage)
		liz.setInfo( type="Video", infoLabels={ "Title": name, 'plot': description } )
		liz.setProperty('fanart_image', fanart)
		ok=xbmcplugin.addDirectoryItem(handle=int(sys.argv[1]),url=u,listitem=liz,isFolder=True)
		return ok
		
def addDir1(name,url,mode,iconimage):
        u=sys.argv[0]+"?url="+urllib.quote_plus(url)+"&mode="+str(mode)+"&name="+urllib.quote_plus(name)
        ok=True
        liz=xbmcgui.ListItem(name, iconImage="DefaultFolder.png", thumbnailImage=iconimage)
        liz.setInfo( type="Video", infoLabels={ "Title": name } )
        ok=xbmcplugin.addDirectoryItem(handle=int(sys.argv[1]),url=u,listitem=liz,isFolder=False)
        return ok

def GetPlayerCore(): 
    try: 
        PlayerMethod=getSet("core-player") 
        if   (PlayerMethod=='DVDPLAYER'): PlayerMeth=xbmc.PLAYER_CORE_DVDPLAYER 
        elif (PlayerMethod=='MPLAYER'): PlayerMeth=xbmc.PLAYER_CORE_MPLAYER 
        elif (PlayerMethod=='PAPLAYER'): PlayerMeth=xbmc.PLAYER_CORE_PAPLAYER 
        else: PlayerMeth=xbmc.PLAYER_CORE_AUTO 
    except: PlayerMeth=xbmc.PLAYER_CORE_AUTO 
    return PlayerMeth 
    return True 

def get_params():
		param=[]
		paramstring=sys.argv[2]
		if len(paramstring)>=2:
				e4=sys.argv[2]
				cleanedparams=e4.replace('?','')
				if (e4[len(e4)-1]=='/'):
						e4=e4[0:len(e4)-2]
				pairsofparams=cleanedparams.split('&')
				param={}
				for i in range(len(pairsofparams)):
						splitparams={}
						splitparams=pairsofparams[i].split('=')
						if (len(splitparams))==2:
								param[splitparams[0]]=splitparams[1]	
		return param
		   
e4=get_params()
url=None
name=None
mode=None
iconimage=None
description=None

try:url=urllib.unquote_plus(e4["url"])
except:pass
try:name=urllib.unquote_plus(e4["name"])
except:pass
try:mode=int(e4["mode"])
except:pass
try:iconimage=urllib.unquote_plus(e4["iconimage"])
except:pass

if mode==None or url==None or len(url)<1:Main()
elif mode==1:GetChannels()
elif mode==9:Ivue()
elif mode==10:Reneg()
elif mode==1000:DELETECACHE(url)
elif mode==1001:DELETEPACKAGES(url)
elif mode==1002:DELETEDATA(url)

def removeAccents(s):
	return ''.join((c for c in unicodedata.normalize('NFD', s.decode('utf-8')) if unicodedata.category(c) != 'Mn'))
					
def read_file(file):
    try:
        f = open(file, 'r')
        content = f.read()
        f.close()
        return content
    except:
        pass

def make_request(url):
	try:
		req = urllib2.Request(url)
		req.add_header('User-Agent', 'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:19.0) Gecko/20100101 Firefox/19.0')
		response = urllib2.urlopen(req)	  
		link = response.read()
		response.close()  
		return link
	except urllib2.URLError, e:
		print 'We failed to open "%s".' % url
		if hasattr(e, 'code'):
			print 'We failed with error code - %s.' % e.code	
		if hasattr(e, 'reason'):
			print 'We failed to reach a server.'
			print 'Reason: ', e.reason
			
def main():
	if len(online_xml) > 0:	
		add_dir('', u_tube, 0, icon, fanart)
			
def xml_online():			
	content = make_request('https://raw.githubusercontent.com/Inside4ndroid/kodi-15/master/old-stuff/pu.xml')
	match = re.compile(xml_regex).findall(content)
	for name, url, thumb in match:
		try:
			xml_playlist(name, url, thumb)
		except:
			pass
			
def xml_onlineb():			
	contentb = make_request('https://raw.githubusercontent.com/Inside4ndroid/kodi-15/master/old-stuff/pb.xml')
	match = re.compile(xml_regex).findall(contentb)
	for name, url, thumb in match:
		try:
			xml_playlist(name, url, thumb)
		except:
			pass
			
def xml_onlinew():			
	contentw = make_request('https://raw.githubusercontent.com/Inside4ndroid/kodi-15/master/old-stuff/pw.xml')
	match = re.compile(xml_regex).findall(contentw)
	for name, url, thumb in match:
		try:
			xml_playlist(name, url, thumb)
		except:
			pass

def xml_onlinet():			
	contentt = make_request('https://raw.githubusercontent.com/Inside4ndroid/kodi-15/master/old-stuff/pt.xml')
	match = re.compile(xml_regex).findall(contentt)
	for name, url, thumb in match:
		try:
			xml_playlist(name, url, thumb)
		except:
			pass	

def xml_onlinem():			
	contentm = make_request('https://raw.githubusercontent.com/Inside4ndroid/kodi-15/master/old-stuff/pm.xml')
	match = re.compile(xml_regex).findall(contentm)
	for name, url, thumb in match:
		try:
			xml_playlist(name, url, thumb)
		except:
			pass			

def xml_onlinei():			
	contentm = make_request('https://raw.githubusercontent.com/Inside4ndroid/kodi-15/master/old-stuff/ivue.xml')
	match = re.compile(xml_regex).findall(contentm)
	for name, url, thumb in match:
		try:
			xml_playlist(name, url, thumb)
		except:
			pass
			
def xml_playlist(name, url, thumb):
	name = re.sub('\s+', ' ', name).strip()			
	url = url.replace('"', ' ').replace('&amp;', '&').strip()
	if ('youtube.com/user/' in url) or ('youtube.com/channel/' in url) or ('youtube/user/' in url) or ('youtube/channel/' in url):
		if len(thumb) > 0:	
			add_dir(name, url, '', thumb, thumb)			
		else:	
			add_dir(name, url, '', icon, fanart)
	else:
		if 'youtube.com/watch?v=' in url:
			url = 'plugin://plugin.video.youtube/play/?video_id=%s' % (url.split('=')[-1])
		elif 'dailymotion.com/video/' in url:
			url = url.split('/')[-1].split('_')[0]
			url = 'plugin://plugin.video.dailymotion_com/?mode=playVideo&url=%s' % url	
		else:			
			url = url
		if len(thumb) > 0:		
			add_link(name, url, 1, thumb, thumb)			
		else:			
			add_link(name, url, 1, icon, fanart)	
	
def play_video(url):
	media_url = url
	item = xbmcgui.ListItem(name, path = media_url)
	xbmcplugin.setResolvedUrl(int(sys.argv[1]), True, item)
	return

def get_params():
	param = []
	paramstring = sys.argv[2]
	if len(paramstring)>= 2:
		params = sys.argv[2]
		cleanedparams = params.replace('?', '')
		if (params[len(params)-1] == '/'):
			params = params[0:len(params)-2]
		pairsofparams = cleanedparams.split('&')
		param = {}
		for i in range(len(pairsofparams)):
			splitparams = {}
			splitparams = pairsofparams[i].split('=')
			if (len(splitparams)) == 2:
				param[splitparams[0]] = splitparams[1]
	return param

def add_dir(name, url, mode, iconimage, fanart):
	u = sys.argv[0] + "?url=" + urllib.quote_plus(url) + "&mode=" + str(mode) + "&name=" + urllib.quote_plus(name) + "&iconimage=" + urllib.quote_plus(iconimage)
	ok = True
	liz = xbmcgui.ListItem(name, iconImage = "DefaultFolder.png", thumbnailImage = iconimage)
	liz.setInfo( type = "Video", infoLabels = { "Title": name } )
	liz.setProperty('fanart_image', fanart)
	if ('youtube.com/user/' in url) or ('youtube.com/channel/' in url) or ('youtube/user/' in url) or ('youtube/channel/' in url):
		u = 'plugin://plugin.video.youtube/%s/%s/' % (url.split( '/' )[-2], url.split( '/' )[-1])
		ok = xbmcplugin.addDirectoryItem(handle = int(sys.argv[1]), url = u, listitem = liz, isFolder = True)
		return ok		
	ok = xbmcplugin.addDirectoryItem(handle = int(sys.argv[1]), url = u, listitem = liz, isFolder = True)
	return ok

def add_link(name, url, mode, iconimage, fanart):
	u = sys.argv[0] + "?url=" + urllib.quote_plus(url) + "&mode=" + str(mode) + "&name=" + urllib.quote_plus(name) + "&iconimage=" + urllib.quote_plus(iconimage)	
	liz = xbmcgui.ListItem(name, iconImage = "DefaultVideo.png", thumbnailImage = iconimage)
	liz.setInfo( type = "Video", infoLabels = { "Title": name } )
	liz.setProperty('fanart_image', fanart)
	liz.setProperty('IsPlayable', 'true') 
	ok = xbmcplugin.addDirectoryItem(handle = int(sys.argv[1]), url = u, listitem = liz)  
		
params = get_params()
url = None
name = None
mode = None
iconimage = None

try:
	url = urllib.unquote_plus(params["url"])
except:
	pass
try:
	name = urllib.unquote_plus(params["name"])
except:
	pass
try:
	mode = int(params["mode"])
except:
	pass
try:
	iconimage = urllib.unquote_plus(params["iconimage"])
except:
	pass  

print "Mode: " + str(mode)
print "URL: " + str(url)
print "Name: " + str(name)
print "iconimage: " + str(iconimage)		
"""
if mode == None or url == None or len(url) < 1:
	main()

elif mode == 1:
	play_video(url)
	
elif mode == 4:
	xml_online()
	
elif mode == 5:
	xml_onlineb()
	
elif mode == 6:
	xml_onlinew()
	
elif mode == 7:
	xml_onlinet()

elif mode == 8:
	xml_onlinem()
	
elif mode == 11:
	xml_onlinei()
"""
def addPortal(portal):

	if portal['url'] == '':
		return;

	url = build_url({
		'mode': 'genres', 
		'portal' : json.dumps(portal)
		});
	
	cmd = 'XBMC.RunPlugin(' + base_url + '?mode=cache&stalker_url=' + portal['url'] + ')';	
	
	li = xbmcgui.ListItem(portal['name'], iconImage=icon,)
	li.addContextMenuItems([ ('Clear Cache', cmd) ]);

	xbmcplugin.addDirectoryItem(handle=addon_handle, url=url, listitem=li, isFolder=True);
	
	
def build_url(query):
	return base_url + '?' + urllib.urlencode(query)


def homeLevel():
	global portal_1, portal_2, portal_3, go;
	
	#todo - check none portal

	if go:
		addPortal(portal_1);
		addPortal(portal_2);
		addPortal(portal_3);
	
		xbmcplugin.endOfDirectory(addon_handle);

def genreLevel():
	
	try:
		data = load_channels.getGenres(portal['mac'], portal['url'], portal['serial'], addondir);
		
	except Exception as e:
		xbmcgui.Dialog().notification(addonname, str(e), xbmcgui.NOTIFICATION_ERROR );
		
		return;

	data = data['genres'];
		
	url = build_url({
		'mode': 'vod', 
		'portal' : json.dumps(portal)
	});
			
	li = xbmcgui.ListItem('VoD', iconImage='DefaultVideo.png')
	xbmcplugin.addDirectoryItem(handle=addon_handle, url=url, listitem=li, isFolder=True);
	
	
	for id, i in data.iteritems():

		title 	= i["title"];
		
		url = build_url({
			'mode': 'channels', 
			'genre_id': id, 
			'genre_name': title.title(), 
			'portal' : json.dumps(portal)
			});
			
		if id == '10':
			iconImage = 'OverlayLocked.png';
		else:
			iconImage = 'DefaultVideo.png';
			
		li = xbmcgui.ListItem(title.title(), iconImage=iconImage)
		xbmcplugin.addDirectoryItem(handle=addon_handle, url=url, listitem=li, isFolder=True);
		

	xbmcplugin.endOfDirectory(addon_handle);

def vodLevel():
	
	try:
		data = load_channels.getVoD(portal['mac'], portal['url'], portal['serial'], addondir);
		
	except Exception as e:
		xbmcgui.Dialog().notification(addonname, str(e), xbmcgui.NOTIFICATION_ERROR );
		return;
	
	
	data = data['vod'];
	
		
	for i in data:
		name 	= i["name"];
		cmd 	= i["cmd"];
		logo 	= i["logo"];
		
		
		if logo != '':
			logo_url = portal['url'] + logo;
		else:
			logo_url = 'DefaultVideo.png';
				
				
		url = build_url({
				'mode': 'play', 
				'cmd': cmd, 
				'tmp' : '0', 
				'title' : name.encode("utf-8"),
				'genre_name' : 'VoD',
				'logo_url' : logo_url, 
				'portal' : json.dumps(portal)
				});
			

		li = xbmcgui.ListItem(name, iconImage=logo_url, thumbnailImage=logo_url)
		li.setInfo(type='Video', infoLabels={ "Title": name })

		xbmcplugin.addDirectoryItem(handle=addon_handle, url=url, listitem=li)
	
	xbmcplugin.addSortMethod(addon_handle, xbmcplugin.SORT_METHOD_UNSORTED);
	xbmcplugin.addSortMethod(addon_handle, xbmcplugin.SORT_METHOD_TITLE);
	xbmcplugin.endOfDirectory(addon_handle);

def channelLevel():
	stop=False;
		
	try:
		data = load_channels.getAllChannels(portal['mac'], portal['url'], portal['serial'], addondir);
		
	except Exception as e:
		xbmcgui.Dialog().notification(addonname, str(e), xbmcgui.NOTIFICATION_ERROR );
		return;
	
	
	data = data['channels'];
	genre_name 	= args.get('genre_name', None);
	
	genre_id_main = args.get('genre_id', None);
	genre_id_main = genre_id_main[0];
	
	if genre_id_main == '10' and portal['parental'] == 'true':
		result = xbmcgui.Dialog().input('Parental', hashlib.md5(portal['password'].encode('utf-8')).hexdigest(), type=xbmcgui.INPUT_PASSWORD, option=xbmcgui.PASSWORD_VERIFY);
		if result == '':
			stop = True;

	
	if stop == False:
		for i in data.values():
			
			name 		= i["name"];
			cmd 		= i["cmd"];
			tmp 		= i["tmp"];
			number 		= i["number"];
			genre_id 	= i["genre_id"];
			logo 		= i["logo"];
		
			if genre_id_main == '*' and genre_id == '10' and portal['parental'] == 'true':
				continue;
		
		
			if genre_id_main == genre_id or genre_id_main == '*':
		
				if logo != '':
					logo_url = portal['url'] + '/stalker_portal/misc/logos/320/' + logo;
				else:
					logo_url = 'DefaultVideo.png';
				
				
				url = build_url({
					'mode': 'play', 
					'cmd': cmd, 
					'tmp' : tmp, 
					'title' : name.encode("utf-8"),
					'genre_name' : genre_name,
					'logo_url' : logo_url,  
					'portal' : json.dumps(portal)
					});
			

				li = xbmcgui.ListItem(name, iconImage=logo_url, thumbnailImage=logo_url);
				li.setInfo(type='Video', infoLabels={ 
					'title': name,
					'count' : number
					});

				xbmcplugin.addDirectoryItem(handle=addon_handle, url=url, listitem=li);
		
		xbmcplugin.addSortMethod(addon_handle, xbmcplugin.SORT_METHOD_PLAYLIST_ORDER);
		xbmcplugin.addSortMethod(addon_handle, xbmcplugin.SORT_METHOD_TITLE);
		xbmcplugin.addSortMethod(addon_handle, xbmcplugin.SORT_METHOD_PROGRAM_COUNT);
		
		
		xbmcplugin.endOfDirectory(addon_handle);

def playLevel():
	
	dp = xbmcgui.DialogProgressBG();
	dp.create('Channel', 'Loading ...');
	
	title 	= args['title'][0];
	cmd 	= args['cmd'][0];
	tmp 	= args['tmp'][0];
	genre_name 	= args['genre_name'][0];
	logo_url 	= args['logo_url'][0];
	
	try:
		if genre_name != 'VoD':
			url = load_channels.retriveUrl(portal['mac'], portal['url'], portal['serial'], cmd, tmp);
		else:
			url = load_channels.retriveVoD(portal['mac'], portal['url'], portal['serial'], cmd);

	
	except Exception as e:
		dp.close();
		xbmcgui.Dialog().notification(addonname, str(e), xbmcgui.NOTIFICATION_ERROR );
		return;

	
	dp.update(80);
	
	title = title.decode("utf-8");
	
	title += ' (' + portal['name'] + ')';
	
#	li = xbmcgui.ListItem(title, iconImage=logo_url); <modified 9.0.19
	li = xbmcgui.ListItem(title, iconImage='DefaultVideo.png', thumbnailImage=logo_url);
	li.setInfo('video', {'Title': title, 'Genre': genre_name});
	xbmc.Player().play(item=url, listitem=li);
	
	dp.update(100);
	
	dp.close();


mode = args.get('mode', None);
portal =  args.get('portal', None)


if portal is None:
	portal_1 = config.portalConfig('1');
	portal_2 = config.portalConfig('2');
	portal_3 = config.portalConfig('3');	

else:
	portal = json.loads(portal[0]);

#  Modification to force outside call to portal_1 (9.0.19)

	portal_2 = config.portalConfig('2');
	portal_3 = config.portalConfig('3');	

	if not ( portal['name'] == portal_2['name'] or portal['name'] == portal_3['name'] ) :
		portal = config.portalConfig('1');

	

if mode is None:
	homeLevel();

elif mode[0] == 'cache':	
	stalker_url = args.get('stalker_url', None);
	stalker_url = stalker_url[0];	
	load_channels.clearCache(stalker_url, addondir);

elif mode[0] == 'genres':
	genreLevel();
		
elif mode[0] == 'vod':
	vodLevel();

elif mode[0] == 'channels':
	channelLevel();
	
elif mode[0] == 'play':
	playLevel();
	
elif mode[0] == 'server':
	port = addon.getSetting('server_port');
	
	action =  args.get('action', None);
	action = action[0];
	
	dp = xbmcgui.DialogProgressBG();
	dp.create('IPTV', 'Just A Second ...');
	
	if action == 'start':
	
		if server.serverOnline():
			xbmcgui.Dialog().notification(addonname, 'Server already started.\nPort: ' + str(port), xbmcgui.NOTIFICATION_INFO );
		else:
			server.startServer();
			time.sleep(5);
			if server.serverOnline():
				xbmcgui.Dialog().notification(addonname, 'Server started.\nPort: ' + str(port), xbmcgui.NOTIFICATION_INFO );
			else:
				xbmcgui.Dialog().notification(addonname, 'Server not started. Wait one moment and try again. ', xbmcgui.NOTIFICATION_ERROR );
				
	else:
		if server.serverOnline():
			server.stopServer();
			time.sleep(5);
			xbmcgui.Dialog().notification(addonname, 'Server stopped.', xbmcgui.NOTIFICATION_INFO );
		else:
			xbmcgui.Dialog().notification(addonname, 'Server is already stopped.', xbmcgui.NOTIFICATION_INFO );
			
	dp.close();



	
xbmcplugin.endOfDirectory(int(sys.argv[1]))
xbmcplugin.endOfDirectory(plugin_handle)
