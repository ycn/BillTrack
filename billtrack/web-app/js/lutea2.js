//-- Leiothrix Base Module
//-- Autor sSeux
//-- Copyright 2009 Leiothrix, All Rights Reserved.

//-- Base Namespace
var _LT={
	Version:'2.0.1.6',
	Browser:{
		IE:!!(window.attachEvent&&navigator.userAgent.indexOf('Opera')===-1),
		IE6:navigator.userAgent.indexOf("MSIE 6.0")>-1,
		IE7:navigator.userAgent.indexOf("MSIE 7.0")>-1,
		Opera:navigator.userAgent.indexOf('Opera')>-1,
		WebKit:navigator.userAgent.indexOf('AppleWebKit/')>-1,
		Gecko:navigator.userAgent.indexOf('Gecko')>-1&&navigator.userAgent.indexOf('KHTML')===-1,
		MobileSafari:!!navigator.userAgent.match(/Apple.*Mobile.*Safari/)
	},
	Page:{
		isStrictMode:document.compatMode!="BackCompat",
		pageHeight:function(){return this.isStrictMode?Math.max(document.documentElement.scrollHeight,document.documentElement.clientHeight):Math.max(document.body.scrollHeight,document.body.clientHeight);},
		pageWidth:function(){return this.isStrictMode?Math.max(document.documentElement.scrollWidth,document.documentElement.clientWidth):Math.max(document.body.scrollWidth,document.body.clientWidth);},
		winWidth:function(){return this.isStrictMode?document.documentElement.clientWidth:document.body.clientWidth;},
		winHeight:function(){return this.isStrictMode?document.documentElement.clientHeight:document.body.clientHeight;},
		scrollTop:function(){return this.isStrictMode?document.documentElement.scrollTop:document.body.scrollTop;},
		scrollLeft:function(){return this.isStrictMode?document.documentElement.scrollLeft:document.body.scrollLeft;}
	},
	Cache:{
		DomReady:false,
		Readys:[],
		RunOnces:[],
		Handlers:[],
		Proxys:{}
	}
};

//-- Global Functions
//extend
var $extend=function(){
	var args=arguments;
	if (!args[1])args=[this,args[0]];
	for(var p in args[1]){args[0][p]=args[1][p];}
	return args[0];
};
// fetch dom element
var $=function(id){
	var ret=null;
	if(id.equals('HEAD')){
		ret=document.getElementsByTagName("head").item(0);
	}
	else if(id.equals('BODY')&&document.body){
		$extend(document.body,_LT.Element);
		ret=document.body;
	}
	else{
		var el=document.getElementById(id);
		if(el){$extend(el,_LT.Element);ret=el;}
	}
	return ret;
};
// create dom element
var $element=function(name){
	var ret=null;
	try{
		var el=document.createElement(name);
		if(el){$extend(el,_LT.Element);ret=el;}
	}catch(ex){}
	if(arguments[1]){ret.extend(arguments[1]);}
	return ret;
};
// dom ready
var $domReady=function(f){
	if(_LT.Cache.DomReady){f();}
	else{_LT.Cache.Readys.push(f);}
};

(function(){
	
	function run(i,v){v();return true;}
	
	if(_LT.Browser.WebKit){
		_LT.Cache._t1=setInterval(function(){
			if(/loaded|complete/.test(document.readyState)){
				clearInterval(_LT.Cache._t1);
				_LT.Cache.DomReady=true;
				_LT.Cache.Readys.each(run);
			}
		},10);
	}else{
		if(document.addEventListener){
			document.addEventListener("DOMContentLoaded",function(){
				_LT.Cache.DomReady=true;
				_LT.Cache.Readys.each(run);
			},false);
		}else{
			$('#Cache')._t1=setInterval(function(){
				try{
					document.body.doScroll("left");
					clearInterval(_LT.Cache._t1);
					_LT.Cache.DomReady=true;
					_LT.Cache.Readys.each(run);
				}catch(e){}
			},20);
		}
	}
	
})();

//-- Prototype
(function(){
	
	var has=false;
	
	has=(typeof Object)=='undefined'?false:true;
	if(has){
		$extend(Object.prototype,{
			isObject:true,
			extend:$extend,
			equals:function(other){return other===this;}
		});
	}
	
	has=(typeof Function)=='undefined'?false:true;
	if(has){
		Function.prototype.extend({
			isFunction:true,
			bind:function(_x){
				var _1=this;
				var _t=_x.This||_1;
				_t.extend(_x);
				return function(){
					_1.apply(_t,arguments);
				};
			},
			runOnce:function(){
				if(_LT.Cache.RunOnces[this])return null;
				_LT.Cache.RunOnces[this]=true;
				return this;
			}
		});
	}
	
	has=(typeof String)=='undefined'?false:true;
	if(has){
		String.prototype.extend({
			isString:true,
			trim:function(){return this.replace(/^\s+|\s+$/g,"");},
			trimLeft:function(){return this.replace(/^\s+/,"");},
			trimRight:function(){return this.replace(/\s+$/,"");},
			trimTags:function(){return this.replace(/<\/?[^>]+>/igm,"");},
			escapeHTML:function(){return this.replace(/&/g,"&amp;").replace(/</g,"&lt;").replace(/>/g,"&gt;");},
			unescapeHTML:function(){return this.replace(/&lt;/g,"<").replace(/&gt;/g,">").replace(/&nbsp;/g," ").replace(/&quot;/g,"\"").replace(/&amp;/g,"&");},
			startsWith:function(s){return this.indexOf(s)===0;},
			endsWith:function(s){var d=this.length-s.length;return d>=0&&this.lastIndexOf(s)===d;},
			equals:function(s){return s.isString&&s==this;},
			isBlank:function(){return /^\s*$/.test(this);},
			isEmail:function(){return /^[A-Z_a-z0-9-\.]+@([A-Z_a-z0-9-]+\.)+[a-z0-9A-Z]{2,4}$/.test(this);},
			isUrl:function(){return /^(http:|ftp:)\/\/[A-Za-z0-9]+\.[A-Za-z0-9]+[\/=\?%\-&_~`@[\]\':+!]*([^<>\"])*$/.test(this);},
			isIp:function(){return /^(0|[1-9]\d?|[0-1]\d{2}|2[0-4]\d|25[0-5]).(0|[1-9]\d?|[0-1]\d{2}|2[0-4]\d|25[0-5]).(0|[1-9]\d?|[0-1]\d{2}|2[0-4]\d|25[0-5]).(0|[1-9]\d?|[0-1]\d{2}|2[0-4]\d|25[0-5])$/.test(this);},
			isNumber:function(){return /^\d+$/.test(this);}
		});
	}
		
	has=(typeof Array)=='undefined'?false:true;
	if(has){
		Array.prototype.extend({
			isArray:true,
			each:function(_h){
				if(!_h)return;
				var _1=this;
				for(var i=0,j=_1.length;i<j;i++){
					if(_h.call(_1,i,_1[i])===false)break;
				}
			},
			contain:function(_1){
				var r=false;
				this.each(this,function(i,v){
					if(v===_1){r=true;return false;}
					return true;
				});
				return r;
			}
		});
	}
	
	has=(typeof Element)=='undefined'?false:true;
	if(has){
		Element.prototype.extend(_LT.Element);
	}
	
	has=(typeof Event)=='undefined'?false:true;
	if(has){
		Event.prototype.extend(_LT.Event);
	}
	
})();

//-- _LT.Ajax
_LT.Ajax=function(){
	
	function getDomain(link){
        var a=$create('a');
        a.href=link;
        return a.hostname;
    }
	
	function init(w){
        _1.req=_1.getRequest(w);
    }
	
	var _1=this;
	_1.url=arguments[0];
	_1.extend(arguments[1]);
	if(/^http/.test(_1.url)){
		var cd=getDomain(window.location.href);
        var nd=getDomain(_1.url);
        if(cd!=nd){
        	if(_LT.Cache.Proxys[nd]){init(_LT.Cache.Proxys[nd]);}
        	else{
	        	var iframe=$create('iframe').hide();
	        	iframe.src='http://'+nd+'/AjaxProxy.html';
	        	iframe.addEvent('load',function(){
	        		try{
	        			init(iframe.contentWindow);
	        			_LT.Cache.Proxys[nd]=iframe.contentWindow;
	        		}
	        		catch(e){}
	        	});
	        	document.body.appendChild(iframe);
        	}
    	}
        else{init(window);}
	}
	else{init(window);}
	return _1;
};

(function(){
	
	if(_LT.Browser.IE){
		_LT.Ajax.prototype.getRequest=function(w){
			if(w!==window)return w.getRequest();
			try{
				return new ActiveXObject("Msxml2.XMLHTTP");
			}catch(e){
				return new ActiveXObject("Microsoft.XMLHTTP");
			}
		}
	}else{
		_LT.Ajax.prototype.getRequest=function(w){
			if(w!==window)return w.getRequest();
			return new XMLHttpRequest();
		}
	}
	
})();

_LT.Ajax.prototype={
	isAjax:true,
	method:"post",
	url:null,
	data:"",
	headers:null,
	req:null,
	asyn:true,
	onSuccess:null,
	onFailure:null,
	abort:function(){
		this.req.abort();
	},
	request:function(_x){
		var _1=this;
		if(_x)_1.extend(_x);
		var _url=_1.url;
		if(!_url||_url==='')return;
		if(_1.method==='get'){_url+="?"+_1.data;}
		if(_1.asyn){_1.req.onreadystatechange=_1.onStateChange.bind(_1);}
		_1.req.open(_1.method,_url,_1.asyn);
		_1.req.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
		if(_1.headers){
			for(var i in _1.headers){
				if(_1.headers[i].isString)_1.req.setRequestHeader(i,_1.headers[i]);
			}
		}
		_1.req.send(_1.method=="post"?_1.data:null);
	},
	onStateChange:function(){
		var _1=this.req;
		if(_1.readyState==4){
			if(_1.status==undefined||_1.status==0||(_1.status>=200&&_1.status<300)){
				if(this.onSuccess)this.onSuccess.call(null,_1);
			}else{
				if(this.onFailure)this.onFailure.call(null,_1);
			}
		}
	}
};

//-- _LT.Cookie
_LT.cookie={
	get:function(k){
		var reg=new RegExp("\\s*"+k+"=([^;]*);?");
		var arr=document.cookie.match(reg);
		if(arr){return decodeURIComponent(arr[1]);}
		else return null;
	},
	set:function(k,v,days){
		days=days||30;
		var exp=new Date();
		exp.setTime(exp.getTime()+days*24*60*60*1000);  
		document.cookie=k+"="+encodeURIComponent(v)+";expires="+exp.toGMTString();   
	},
	del:function(k){
		var exp=new Date();  
		exp.setTime(exp.getTime()-1);
		var cval=this.get(k);
		if(cval!=null){document.cookie=k+"="+cval+";expires="+exp.toGMTString();}
	}
};

//-- _LT.Event
_LT.Event={
	isEvent:true,
	isCapsLockOn:function(){
		var _1=this;
		var c=_1.keyCode||_1.which;
		var s=_1.shiftKey;
		if(((c>=65&&c<=90)&&!s)||((c>=97&&c<=122)&&s))return true;
		return false;
	},
	pointerX:function(){
		return this.pageX||(this.clientX+(document.documentElement.scrollLeft||document.body.scrollLeft));
	},
	pointerY:function(e){
		return this.pageY||(this.clientY+(document.documentElement.scrollTop||document.body.scrollTop));
	}
};

//-- _LT.Element
_LT.Element={
	isElement:true,
	insertAfterEL:function(el){
		var f=el.parentNode;
		if(f.lastChild==el){f.appendChild(this);}
		else{f.insertBefore(this,el.nextSibling);}
		return this;
	},
	insertBeforeEL:function(el){
		var f=el.parentNode;
		f.insertBefore(this,el);
		return this;
	},

	visible:function(){return this.style.display!='none'&&this.style.visibility!='hidden';return this;},
	hide:function(){if(this.style.display!='none')this.style.display='none';return this;},
	show:function(){if(this.style.display=='none')this.style.display='';return this;},
	hover:function(cls,_2){
		_2=_2||this;
		this.addEvent('mouseover',function(){_2.addClass(cls);});
		this.addEvent('mouseleave',function(){_2.removeClass(cls);});
		return this;
	},
	
	hasClass:function(cls){var reg=new RegExp('\\b'+cls+'\\b');return this.className.match(reg)?true:false;return this;},
	setClass:function(cls){this.className=cls;return this;},
	addClass:function(cls){this.className+=' '+cls;return this;},
	removeClass:function(cls){var reg=new RegExp('\\b\\s*'+cls+'\\s*\\b','gm');this.className=this.className.replace(reg,'');return this;},
	toggleClass:function(cls){if(this.hasClass(cls))this.removeClass(cls);else this.addClass(cls);return this;},
	
	setStyle:function(_1){this.style.cssText=_1;return this;},
	addStyle:function(_1){this.style.cssText+=_1+';';return this;},
	removeStyle:function(_1){var reg=new RegExp('\\b\\s*'+_1+'\\s*\\b:[^:;]+;','gm');this.style.cssText=this.style.cssText.replace(reg,'');return this;},
	getStyle:function(_1){
		_1=_1=="float"?"cssFloat":_1;
		var _s=this.style[_1];
		if(!_s){
			var css=document.defaultView.getComputedStyle(this,null);
			_s=css?css[_1]:null;
		}
		if(_1=="opacity"){
			return _s?parseFloat(_1):1;
		}
		return _s=="auto"?null:_s;
	},
	
	getPosition:function(f){
		f=f||$('BODY');
		var rl=0,rt=0;
		var p=this;
		try{
			while(p&&p!=f){
				rl+=p.offsetLeft;
				rt+=p.offsetTop;
				p=p.offsetParent;
			}
		}catch(e){}
		return {"left":rl,"top":rt};
	},
	realLeft:function(f){return this.getPosition(this,f).left;},
	realTop:function(f){return this.getPosition(this,f).top;}
};

(function(){
	
	if(_LT.Browser.IE){
		_LT.Element.addEvent=function(e,h){
			if(!e||!h)return;
			if(e=="keypress"){e="keydown";}
			if(e=="input"){e="propertychange";}
			if(!_LT.Cache.Handlers[h])
				_LT.Cache.Handlers[h]=function(_e){
					_e=_e||window.event;
					$extend(_e,_LT.Event);
					h.call(this,_e);
				}
			}
			this.attachEvent("on"+e,_LT.Cache.Handlers[h]);
		};
		_LT.Element.removeEvent=function(e,h){
			if(!e||!h)return;
			if(e=="keypress"){e="keydown";}
			if(e=="input"){e="propertychange";}
			if(_LT.Cache.Handlers[h])
				this.detachEvent("on"+e,h);
		};
		_LT.Element.stopEvents=function(){
			this.returnValue=false;
			this.cancelBubble=true;
		};
	}
	else{
		if(window.addEventListener){
			
			function isRelatedNode(_1,_2){
				var p=_1.relatedTarget;
				while(p&&p!=_2){
					try{p=p.parentNode;}
					catch(e){p=_2;}
				}
				return p!==_2;
			}
			
			_LT.Element.addEvent=function(e,h,useCapture){
				if(!e||!h)return;
				useCapture=useCapture||false;
				if(e=="mouseleave"){
					this.onmouseleave=function(_e){
						_e=_e||window.event;
						if(isRelatedNode(_e,this)&&h){h.call(this,_e);}
					};
					this.addEventListener("mouseout",this.onmouseleave,useCapture);
				}
				if(e=="keypress"&&_LT.Browser.WebKit){e="keydown";}
				this.addEventListener(e,h,useCapture);
			};
			_LT.Element.removeEvent=function(e,h,useCapture){
				if(!e||!h)return;
				useCapture=useCapture||false;
				if(e=="mouseleave"){this.removeEventListener("mouseout",this.onmouseleave,useCapture);}
				if(e=="keypress"&&_LT.Browser.WebKit){e="keydown";}
				this.removeEventListener(e,h,useCapture);
			};
			_LT.Element.stopEvents=function(){
				this.preventDefault();
				this.stopPropagation();
			};
		}
	}
	
})();
