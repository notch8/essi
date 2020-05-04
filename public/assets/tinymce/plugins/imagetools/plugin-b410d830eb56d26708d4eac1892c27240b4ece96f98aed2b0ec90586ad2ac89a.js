!function(m){"use strict";function a(r){for(var o=[],t=1;t<arguments.length;t++)o[t-1]=arguments[t];return function(){for(var t=[],e=0;e<arguments.length;e++)t[e]=arguments[e];var n=o.concat(t);return r.apply(null,n)}}function d(t,e){return f(m.document.createElement("canvas"),t,e)}function i(t){var e=d(t.width,t.height);return h(e).drawImage(t,0,0),e}function h(t){return t.getContext("2d")}function f(t,e,n){return t.width=e,t.height=n,t}function p(t){return t.naturalWidth||t.width}function g(t){return t.naturalHeight||t.height}function u(t){var r,e=t.src;return 0===e.indexOf("data:")?n(e):(r=e,new $(function(t,n){var e=new m.XMLHttpRequest;e.open("GET",r,!0),e.responseType="blob",e.onload=function(){200===this.status&&t(this.response)},e.onerror=function(){var t,e=this;n(0===this.status?((t=new Error("No access to download image")).code=18,t.name="SecurityError",t):new Error("Error "+e.status+" downloading image"))},e.send()}))}function c(u){return new $(function(t,e){function n(){a(),t(i)}function r(){a(),e("Unable to load data of type "+u.type+": "+o)}var o=m.URL.createObjectURL(u),i=new m.Image,a=function(){i.removeEventListener("load",n),i.removeEventListener("error",r)};i.addEventListener("load",n),i.addEventListener("error",r),i.src=o,i.complete&&n()})}function n(p){return new $(function(t,e){(function(){var t=p.split(","),e=/data:([^;]+)/.exec(t[0]);if(!e)return q.none();for(var n=e[1],r=t[1],o=m.atob(r),i=o.length,a=Math.ceil(i/1024),u=new Array(a),c=0;c<a;++c){for(var l=1024*c,f=Math.min(l+1024,i),s=new Array(f-l),d=l,h=0;d<f;++h,++d)s[h]=o[d].charCodeAt(0);u[c]=new Uint8Array(s)}return q.some(new m.Blob(u,{type:n}))})().fold(function(){e("uri is not base64: "+p)},t)})}function l(t,r,o){return r=r||"image/png",m.HTMLCanvasElement.prototype.toBlob?new $(function(e,n){t.toBlob(function(t){t?e(t):n()},r,o)}):n(t.toDataURL(r,o))}function r(t){return c(t).then(function(t){var e;e=t,m.URL.revokeObjectURL(e.src);var n=d(p(t),g(t));return h(n).drawImage(t,0,0),n})}function o(t,e,n){function r(r,o){return t.then(function(t){return n=o,e=(e=r)||"image/png",t.toDataURL(e,n);var e,n})}var o=e.type;return{getType:S(o),toBlob:function(){return $.resolve(e)},toDataURL:function(){return n},toBase64:function(){return n.split(",")[1]},toAdjustedBlob:function(e,n){return t.then(function(t){return l(t,e,n)})},toAdjustedDataURL:r,toAdjustedBase64:function(t,e){return r(t,e).then(function(t){return t.split(",")[1]})},toCanvas:function(){return t.then(i)}}}function e(e){return(n=e,new $(function(t){var e=new m.FileReader;e.onloadend=function(){t(e.result)},e.readAsDataURL(n)})).then(function(t){return o(r(e),e,t)});var n}function s(e,t){return l(e,t).then(function(t){return o($.resolve(e),t,e.toDataURL())})}function v(t,e,n){var r="string"==typeof t?parseFloat(t):t;return n<r?r=n:r<e&&(r=e),r}function y(t,e){for(var n,r=[],o=new Array(25),i=0;i<5;i++){for(var a=0;a<5;a++)r[a]=e[a+5*i];for(a=0;a<5;a++){for(var u=n=0;u<5;u++)n+=t[a+5*u]*r[u];o[a+5*i]=n}}return o}function w(t,n){return n=v(n,0,1),t.map(function(t,e){return e%6==0?t=1-(1-t)*n:t*=n,v(t,0,1)})}function b(a,u){return a.toCanvas().then(function(t){return e=t,n=a.getType(),r=u,i=function(t,e){for(var n,r,o,i,a=t.data,u=e[0],c=e[1],l=e[2],f=e[3],s=e[4],d=e[5],h=e[6],p=e[7],m=e[8],g=e[9],v=e[10],y=e[11],w=e[12],b=e[13],x=e[14],k=e[15],R=e[16],I=e[17],M=e[18],T=e[19],U=0;U<a.length;U+=4)n=a[U],r=a[U+1],o=a[U+2],i=a[U+3],a[U]=n*u+r*c+o*l+i*f+s,a[U+1]=n*d+r*h+o*p+i*m+g,a[U+2]=n*v+r*y+o*w+i*b+x,a[U+3]=n*k+r*R+o*I+i*M+T;return t}((o=h(e)).getImageData(0,0,e.width,e.height),r),o.putImageData(i,0,0),s(e,n);var e,n,r,o,i})}function x(a,u){return a.toCanvas().then(function(t){return e=t,n=a.getType(),r=u,i=function(t,e,n){function r(t,e,n){return n<t?t=n:t<e&&(t=e),t}for(var o=Math.round(Math.sqrt(n.length)),i=Math.floor(o/2),a=t.data,u=e.data,c=t.width,l=t.height,f=0;f<l;f++)for(var s=0;s<c;s++){for(var d=0,h=0,p=0,m=0;m<o;m++)for(var g=0;g<o;g++){var v=r(s+g-i,0,c-1),y=4*(r(f+m-i,0,l-1)*c+v),w=n[m*o+g];d+=a[y]*w,h+=a[y+1]*w,p+=a[y+2]*w}var b=4*(f*c+s);u[b]=r(d,0,255),u[b+1]=r(h,0,255),u[b+2]=r(p,0,255)}return e}((o=h(e)).getImageData(0,0,e.width,e.height),i=o.getImageData(0,0,e.width,e.height),r),o.putImageData(i,0,0),s(e,n);var e,n,r,o,i})}function t(u){return function(e,n){return e.toCanvas().then(function(t){return function(t,e,n){for(var r=h(t),o=new Array(256),i=0;i<o.length;i++)o[i]=u(i,n);var a=function(t,e){for(var n=t.data,r=0;r<n.length;r+=4)n[r]=e[n[r]],n[r+1]=e[n[r+1]],n[r+2]=e[n[r+2]];return t}(r.getImageData(0,0,t.width,t.height),o);return r.putImageData(a,0,0),s(t,e)}(t,e.getType(),n)})}}function k(n){return function(t,e){return b(t,n([1,0,0,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,1],e))}}function R(e){return function(t){return x(t,e)}}function I(t,e,n){var r=p(t),o=g(t),i=e/r,a=n/o,u=!1;(i<.5||2<i)&&(i=i<.5?.5:2,u=!0),(a<.5||2<a)&&(a=a<.5?.5:2,u=!0);var c,l,f,s=(c=t,l=i,f=a,new $(function(t){var e=p(c),n=g(c),r=Math.floor(e*l),o=Math.floor(n*f),i=d(r,o);h(i).drawImage(c,0,0,e,n,0,0,r,o),t(i)}));return u?s.then(function(t){return I(t,e,n)}):s}function M(c,l){return c.toCanvas().then(function(t){return e=t,n=c.getType(),r=l,i=h(o=d(e.width,e.height)),90!==(r=r<(u=a=0)?360+r:r)&&270!==r||f(o,o.height,o.width),90!==r&&180!==r||(a=o.width),270!==r&&180!==r||(u=o.height),i.translate(a,u),i.rotate(r*Math.PI/180),i.drawImage(e,0,0),s(o,n);var e,n,r,o,i,a,u})}function T(a,u){return a.toCanvas().then(function(t){return e=t,n=a.getType(),r=u,i=h(o=d(e.width,e.height)),"v"===r?(i.scale(1,-1),i.drawImage(e,0,-o.height)):(i.scale(-1,1),i.drawImage(e,-o.width,0)),s(o,n);var e,n,r,o,i})}function U(a,u,c,l,f){return a.toCanvas().then(function(t){return e=t,n=a.getType(),r=u,o=c,h(i=d(l,f)).drawImage(e,-r,-o),s(i,n);var e,n,r,o,i})}function G(t){return{blob:t,url:Ot.createObjectURL(t)}}function K(t){t&&Ot.revokeObjectURL(t.url)}function J(t){Z.each(t,K)}function C(i,a,t,e){function n(t){var e,n,r,o;e=y.find("#w")[0],n=y.find("#h")[0],r=parseInt(e.value(),10),o=parseInt(n.value(),10),y.find("#constrain")[0].checked()&&F&&V&&r&&o&&("w"===t.control.settings.name?(o=Math.round(r*W),n.value(o)):(r=Math.round(o*N),e.value(r))),F=r,V=o}function u(t){return Math.round(100*t)+"%"}function r(){y.find("#undo").disabled(!q.canUndo()),y.find("#redo").disabled(!q.canRedo()),y.statusbar.find("#save").disabled(!q.canUndo())}function c(){y.find("#undo").disabled(!0),y.find("#redo").disabled(!0)}function l(t){t&&M.imageSrc(t.url)}function o(e){return function(){var t=Z.grep(D,function(t){return t.settings.name!==e});Z.each(t,function(t){t.hide()}),e.show(),e.focus()}}function f(t){l(x=G(t))}function s(t){l(a=G(t)),J(q.add(a).removed),r()}function d(){var e=M.selection();Tt(a.blob).then(function(t){Rt(t,e.x,e.y,e.w,e.h).then(Y).then(function(t){s(t),h()})})}function h(){l(a),K(x),o(w)(),r()}function p(){x?(s(x.blob),h()):function n(t,e){x?e():setTimeout(function(){0<t--?n(t,e):i.windowManager.alert("Error: failed to apply image operation.")},10)}(100,p)}function m(t){return Bt.create("Form",{layout:"flex",direction:"row",labelGap:5,border:"0 0 1 0",align:"center",pack:"center",padding:"0 10 0 10",spacing:5,flex:0,minHeight:60,defaults:{classes:"imagetool",type:"button"},items:t})}function g(t,e){return m($([{text:"Back",onclick:h},{type:"spacer",flex:1},{text:"Apply",subtype:"primary",onclick:p}])).hide().on("show",function(){c(),Tt(a.blob).then(function(t){return e(t)}).then(Y).then(function(t){var e=G(t);l(e),K(x),x=e})})}function v(t,n,e,r,o){return m($([{text:"Back",onclick:h},{type:"spacer",flex:1},{type:"slider",flex:1,ondragend:function(t){var e;e=t.value,Tt(a.blob).then(function(t){return n(t,e)}).then(Y).then(function(t){var e=G(t);l(e),K(x),x=e})},minValue:i.rtl?o:r,maxValue:i.rtl?r:o,value:e,previewFilter:u},{type:"spacer",flex:1},{text:"Apply",subtype:"primary",onclick:p}])).hide().on("show",function(){this.find("slider").value(e),c()})}var y,w,b,x,k,R,I,M,T,U,C,A,E,O,_,j,z,L,B,S,P,H,D,F,V,W,N,q=function(){function t(){return 0<r}function e(){return-1!==r&&r<n.length-1}var n=[],r=-1;return{data:n,add:function(t){var e;return e=n.splice(++r),n.push(t),{state:t,removed:e}},undo:function(){if(t())return n[--r]},redo:function(){if(e())return n[++r]},canUndo:t,canRedo:e}}(),$=function(t){return i.rtl?t.reverse():t},X=function(e){var n=[].slice.call(arguments,1);return function(){Tt((x||a).blob).then(function(t){e.apply(this,[t].concat(n)).then(Y).then(f)})}},Y=function(t){return t.toBlob()};k=m($([{text:"Back",onclick:h},{type:"spacer",flex:1},{text:"Apply",subtype:"primary",onclick:d}])).hide().on("show hide",function(t){M.toggleCropRect("show"===t.type)}).on("show",c),R=m($([{text:"Back",onclick:h},{type:"spacer",flex:1},{type:"textbox",name:"w",label:"Width",size:4,onkeyup:n},{type:"textbox",name:"h",label:"Height",size:4,onkeyup:n},{type:"checkbox",name:"constrain",text:"Constrain proportions",checked:!0,onchange:function(t){!0===t.control.value()&&(W=V/F,N=F/V)}},{type:"spacer",flex:1},{text:"Apply",subtype:"primary",onclick:"submit"}])).hide().on("submit",function(t){var e=parseInt(y.find("#w").value(),10),n=parseInt(y.find("#h").value(),10);t.preventDefault(),function(e){for(var t=[],n=1;n<arguments.length;n++)t[n-1]=arguments[n];var r=[].slice.call(arguments,1);return function(){Tt(a.blob).then(function(t){e.apply(this,[t].concat(r)).then(Y).then(s)})}}(It,e,n)(),h()}).on("show",c),I=m($([{text:"Back",onclick:h},{type:"spacer",flex:1},{icon:"fliph",tooltip:"Flip horizontally",onclick:X(kt,"h")},{icon:"flipv",tooltip:"Flip vertically",onclick:X(kt,"v")},{icon:"rotateleft",tooltip:"Rotate counterclockwise",onclick:X(Mt,-90)},{icon:"rotateright",tooltip:"Rotate clockwise",onclick:X(Mt,90)},{type:"spacer",flex:1},{text:"Apply",subtype:"primary",onclick:p}])).hide().on("show",c),C=g(0,ft),B=g(0,st),S=g(0,dt),A=v(0,gt,0,-1,1),E=v(0,vt,180,0,360),O=v(0,yt,0,-1,1),_=v(0,wt,0,-1,1),j=v(0,bt,0,0,1),z=v(0,xt,0,0,1),L=function(t,o){function e(){var e,n,r;e=y.find("#r")[0].value(),n=y.find("#g")[0].value(),r=y.find("#b")[0].value(),Tt(a.blob).then(function(t){return o(t,e,n,r)}).then(Y).then(function(t){var e=G(t);l(e),K(x),x=e})}var n=i.rtl?2:0,r=i.rtl?0:2;return m($([{text:"Back",onclick:h},{type:"spacer",flex:1},{type:"slider",label:"R",name:"r",minValue:n,value:1,maxValue:r,ondragend:e,previewFilter:u},{type:"slider",label:"G",name:"g",minValue:n,value:1,maxValue:r,ondragend:e,previewFilter:u},{type:"slider",label:"B",name:"b",minValue:n,value:1,maxValue:r,ondragend:e,previewFilter:u},{type:"spacer",flex:1},{text:"Apply",subtype:"primary",onclick:p}])).hide().on("show",function(){y.find("#r,#g,#b").value(1),c()})}(0,mt),P=v(0,ht,0,-1,1),H=v(0,pt,1,0,2),b=m($([{text:"Back",onclick:h},{type:"spacer",flex:1},{text:"hue",icon:"hue",onclick:o(E)},{text:"saturate",icon:"saturate",onclick:o(O)},{text:"sepia",icon:"sepia",onclick:o(z)},{text:"emboss",icon:"emboss",onclick:o(S)},{text:"exposure",icon:"exposure",onclick:o(H)},{type:"spacer",flex:1}])).hide(),w=m($([{tooltip:"Crop",icon:"crop",onclick:o(k)},{tooltip:"Resize",icon:"resize2",onclick:o(R)},{tooltip:"Orientation",icon:"orientation",onclick:o(I)},{tooltip:"Brightness",icon:"sun",onclick:o(A)},{tooltip:"Sharpen",icon:"sharpen",onclick:o(B)},{tooltip:"Contrast",icon:"contrast",onclick:o(_)},{tooltip:"Color levels",icon:"drop",onclick:o(L)},{tooltip:"Gamma",icon:"gamma",onclick:o(P)},{tooltip:"Invert",icon:"invert",onclick:o(C)}])),M=Wt.create({flex:1,imageSrc:a.url}),T=Bt.create("Container",{layout:"flex",direction:"column",pack:"start",border:"0 1 0 0",padding:5,spacing:5,items:[{type:"button",icon:"undo",tooltip:"Undo",name:"undo",onclick:function(){l(a=q.undo()),r()}},{type:"button",icon:"redo",tooltip:"Redo",name:"redo",onclick:function(){l(a=q.redo()),r()}},{type:"button",icon:"zoomin",tooltip:"Zoom in",onclick:function(){var t=M.zoom();t<2&&(t+=.1),M.zoom(t)}},{type:"button",icon:"zoomout",tooltip:"Zoom out",onclick:function(){var t=M.zoom();.1<t&&(t-=.1),M.zoom(t)}}]}),U=Bt.create("Container",{type:"container",layout:"flex",direction:"row",align:"stretch",flex:1,items:$([T,M])}),D=[w,k,R,I,b,C,A,E,O,_,j,z,L,B,S,P,H],(y=i.windowManager.open({layout:"flex",direction:"column",align:"stretch",minWidth:Math.min(Lt.DOM.getViewPort().w,800),minHeight:Math.min(Lt.DOM.getViewPort().h,650),title:"Edit image",items:D.concat([U]),buttons:$([{text:"Save",name:"save",subtype:"primary",onclick:function(){t(a.blob),y.close()}},{text:"Cancel",onclick:"close"}])})).on("close",function(){e(),J(q.data),x=q=null}),q.add(a),r(),M.on("load",function(){F=M.imageSize().w,V=M.imageSize().h,W=V/F,N=F/V,y.find("#w").value(F),y.find("#h").value(V)}),M.on("crop",d)}var A,E,O,_,j,z,L=function(t){var e=t,n=function(){return e};return{get:n,set:function(t){e=t},clone:function(){return L(n())}}},B=tinymce.util.Tools.resolve("tinymce.PluginManager"),Z=tinymce.util.Tools.resolve("tinymce.util.Tools"),S=function(t){return function(){return t}},P=S(!1),H=S(!0),D=P,F=H,V=function(){return W},W=(_={fold:function(t){return t()},is:D,isSome:D,isNone:F,getOr:O=function(t){return t},getOrThunk:E=function(t){return t()},getOrDie:function(t){throw new Error(t||"error: getOrDie called on none.")},getOrNull:function(){return null},getOrUndefined:function(){return undefined},or:O,orThunk:E,map:V,ap:V,each:function(){},bind:V,flatten:V,exists:D,forall:F,filter:V,equals:A=function(t){return t.isNone()},equals_:A,toArray:function(){return[]},toString:S("none()")},Object.freeze&&Object.freeze(_),_),N=function(n){var t=function(){return n},e=function(){return o},r=function(t){return t(n)},o={fold:function(t,e){return e(n)},is:function(t){return n===t},isSome:F,isNone:D,getOr:t,getOrThunk:t,getOrDie:t,getOrNull:t,getOrUndefined:t,or:e,orThunk:e,map:function(t){return N(t(n))},ap:function(t){return t.fold(V,function(t){return N(t(n))})},each:function(t){t(n)},bind:r,flatten:t,exists:r,forall:r,filter:function(t){return t(n)?o:W},equals:function(t){return t.is(n)},equals_:function(t,e){return t.fold(D,function(t){return e(n,t)})},toArray:function(){return[n]},toString:function(){return"some("+n+")"}};return o},q={some:N,none:V,from:function(t){return null===t||t===undefined?W:N(t)}},$=window.Promise?window.Promise:function(){function c(t,e){return function(){return t.apply(e,arguments)}}function i(n){var r=this;null!==this._state?t(function(){var t=r._state?n.onFulfilled:n.onRejected;if(null!==t){var e;try{e=t(r._value)}catch(f){return void n.reject(f)}n.resolve(e)}else(r._state?n.resolve:n.reject)(r._value)}):this._deferreds.push(n)}function o(t){try{if(t===this)throw new TypeError("A promise cannot be resolved with itself.");if(t&&("object"==typeof t||"function"==typeof t)){var e=t.then;if("function"==typeof e)return void u(c(e,t),c(o,this),c(n,this))}this._state=!0,this._value=t,r.call(this)}catch(f){n.call(this,f)}}function n(t){this._state=!1,this._value=t,r.call(this)}function r(){for(var t=0,e=this._deferreds;t<e.length;t++){var n=e[t];i.call(this,n)}this._deferreds=[]}function a(t,e,n,r){this.onFulfilled="function"==typeof t?t:null,this.onRejected="function"==typeof e?e:null,this.resolve=n,this.reject=r}function u(t,e,n){var r=!1;try{t(function(t){r||(r=!0,e(t))},function(t){r||(r=!0,n(t))})}catch(o){if(r)return;r=!0,n(o)}}var l=function(t){if("object"!=typeof this)throw new TypeError("Promises must be constructed via new");if("function"!=typeof t)throw new TypeError("not a function");this._state=null,this._value=null,this._deferreds=[],u(t,c(o,this),c(n,this))},t=l.immediateFn||"function"==typeof window.setImmediate&&window.setImmediate||function(t){m.setTimeout(t,1)},f=Array.isArray||function(t){return"[object Array]"===Object.prototype.toString.call(t)};return l.prototype["catch"]=function(t){return this.then(null,t)},l.prototype.then=function(n,r){var o=this;return new l(function(t,e){i.call(o,new a(n,r,t,e))})},l.all=function(){for(var t=[],e=0;e<arguments.length;e++)t[e]=arguments[e];var u=Array.prototype.slice.call(1===t.length&&f(t[0])?t[0]:t);return new l(function(r,o){function i(e,t){try{if(t&&("object"==typeof t||"function"==typeof t)){var n=t.then;if("function"==typeof n)return void n.call(t,function(t){i(e,t)},o)}u[e]=t,0==--a&&r(u)}catch(c){o(c)}}if(0===u.length)return r([]);for(var a=u.length,t=0;t<u.length;t++)i(t,u[t])})},l.resolve=function(e){return e&&"object"==typeof e&&e.constructor===l?e:new l(function(t){t(e)})},l.reject=function(n){return new l(function(t,e){e(n)})},l.race=function(o){return new l(function(t,e){for(var n=0,r=o;n<r.length;n++)r[n].then(t,e)})},l}(),X=[0,.01,.02,.04,.05,.06,.07,.08,.1,.11,.12,.14,.15,.16,.17,.18,.2,.21,.22,.24,.25,.27,.28,.3,.32,.34,.36,.38,.4,.42,.44,.46,.48,.5,.53,.56,.59,.62,.65,.68,.71,.74,.77,.8,.83,.86,.89,.92,.95,.98,1,1.06,1.12,1.18,1.24,1.3,1.36,1.42,1.48,1.54,1.6,1.66,1.72,1.78,1.84,1.9,1.96,2,2.12,2.25,2.37,2.5,2.62,2.75,2.87,3,3.2,3.4,3.6,3.8,4,4.3,4.7,4.9,5,5.5,6,6.5,6.8,7,7.3,7.5,7.8,8,8.4,8.7,9,9.4,9.6,9.8,10],Y=(j=[-1,0,0,0,255,0,-1,0,0,255,0,0,-1,0,255,0,0,0,1,0,0,0,0,0,1],function(t){return b(t,j)}),Q=k(function(t,e){return y(t,[1,0,0,0,e=v(255*e,-255,255),0,1,0,0,e,0,0,1,0,e,0,0,0,1,0,0,0,0,0,1])}),tt=k(function(t,e){e=v(e,-180,180)/180*Math.PI;var n=Math.cos(e),r=Math.sin(e),o=.213,i=.715,a=.072;return y(t,[o+.787*n+r*-o,i+n*-i+r*-i,a+n*-a+.928*r,0,0,o+n*-o+.143*r,i+n*(1-i)+.14*r,a+n*-a+-.283*r,0,0,o+n*-o+-.787*r,i+n*-i+r*i,a+.928*n+r*a,0,0,0,0,0,1,0,0,0,0,0,1])}),et=k(function(t,e){var n=1+(0<(e=v(e,-1,1))?3*e:e);return y(t,[.3086*(1-n)+n,.6094*(1-n),.082*(1-n),0,0,.3086*(1-n),.6094*(1-n)+n,.082*(1-n),0,0,.3086*(1-n),.6094*(1-n),.082*(1-n)+n,0,0,0,0,0,1,0,0,0,0,0,1])}),nt=k(function(t,e){var n;return e=v(e,-1,1),y(t,[(n=(e*=100)<0?127+e/100*127:127*(n=0==(n=e%1)?X[e]:X[Math.floor(e)]*(1-n)+X[Math.floor(e)+1]*n)+127)/127,0,0,0,.5*(127-n),0,n/127,0,0,.5*(127-n),0,0,n/127,0,.5*(127-n),0,0,0,1,0,0,0,0,0,1])}),rt=k(function(t,e){return y(t,w([.33,.34,.33,0,0,.33,.34,.33,0,0,.33,.34,.33,0,0,0,0,0,1,0,0,0,0,0,1],e=v(e,0,1)))}),ot=k(function(t,e){return y(t,w([.393,.769,.189,0,0,.349,.686,.168,0,0,.272,.534,.131,0,0,0,0,0,1,0,0,0,0,0,1],e=v(e,0,1)))}),it=function(t,e,n,r){return b(t,(o=n,i=r,y([1,0,0,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,1],[v(e,0,2),0,0,0,0,0,o=v(o,0,2),0,0,0,0,0,i=v(i,0,2),0,0,0,0,0,1,0,0,0,0,0,1])));var o,i},at=R([0,-1,0,-1,5,-1,0,-1,0]),ut=R([-2,-1,0,-1,1,1,0,1,2]),ct=t(function(t,e){return 255*Math.pow(t/255,1-e)}),lt=t(function(t,e){return 255*(1-Math.exp(-t/255*e))}),ft=function(t){return Y(t)},st=function(t){return at(t)},dt=function(t){return ut(t)},ht=function(t,e){return ct(t,e)},pt=function(t,e){return lt(t,e)},mt=function(t,e,n,r){return it(t,e,n,r)},gt=function(t,e){return Q(t,e)},vt=function(t,e){return tt(t,e)},yt=function(t,e){return et(t,e)},wt=function(t,e){return nt(t,e)},bt=function(t,e){return rt(t,e)},xt=function(t,e){return ot(t,e)},kt=function(t,e){return T(t,e)},Rt=function(t,e,n,r,o){return U(t,e,n,r,o)},It=function(t,e,n){return o=e,i=n,(r=t).toCanvas().then(function(t){return I(t,o,i).then(function(t){return s(t,r.getType())})});var r,o,i},Mt=function(t,e){return M(t,e)},Tt=function(t){return e(t)},Ut="undefined"!=typeof m.window?m.window:Function("return this;")(),Ct=function(t,r){return function(t){for(var e=r!==undefined&&null!==r?r:Ut,n=0;n<t.length&&e!==undefined&&null!==e;++n)e=e[t[n]];return e}(t.split("."))},At=function(t,e){var n=Ct(t,e);if(n===undefined||null===n)throw new Error(t+" not available on this browser");return n},Et=function(){return At("URL")},Ot={createObjectURL:function(t){return Et().createObjectURL(t)},revokeObjectURL:function(t){Et().revokeObjectURL(t)}},_t=tinymce.util.Tools.resolve("tinymce.util.Delay"),jt=tinymce.util.Tools.resolve("tinymce.util.Promise"),zt=tinymce.util.Tools.resolve("tinymce.util.URI"),Lt=tinymce.util.Tools.resolve("tinymce.dom.DOMUtils"),Bt=tinymce.util.Tools.resolve("tinymce.ui.Factory"),St=tinymce.util.Tools.resolve("tinymce.geom.Rect"),Pt=function(n){return new jt(function(t){var e=function(){n.removeEventListener("load",e),t(n)};n.complete?t(n):n.addEventListener("load",e)})},Ht=tinymce.util.Tools.resolve("tinymce.dom.DomQuery"),Dt=tinymce.util.Tools.resolve("tinymce.util.Observable"),Ft=tinymce.util.Tools.resolve("tinymce.util.VK"),Vt=0,Wt={create:function(t){return new(Bt.get("Control").extend({Defaults:{classes:"imagepanel"},selection:function(t){return arguments.length?(this.state.set("rect",t),this):this.state.get("rect")},imageSize:function(){var t=this.state.get("viewRect");return{w:t.w,h:t.h}},toggleCropRect:function(t){this.state.set("cropEnabled",t)},imageSrc:function(t){var o=this,i=new m.Image;i.src=t,Pt(i).then(function(){var t,e,n=o.state.get("viewRect");if((e=o.$el.find("img"))[0])e.replaceWith(i);else{var r=m.document.createElement("div");r.className="mce-imagepanel-bg",o.getEl().appendChild(r),o.getEl().appendChild(i)}t={x:0,y:0,w:i.naturalWidth,h:i.naturalHeight},o.state.set("viewRect",t),o.state.set("rect",St.inflate(t,-20,-20)),n&&n.w===t.w&&n.h===t.h||o.zoomFit(),o.repaintImage(),o.fire("load")})},zoom:function(t){return arguments.length?(this.state.set("zoom",t),this):this.state.get("zoom")},postRender:function(){return this.imageSrc(this.settings.imageSrc),this._super()},zoomFit:function(){var t,e,n,r,o,i;t=this.$el.find("img"),e=this.getEl().clientWidth,n=this.getEl().clientHeight,r=t[0].naturalWidth,o=t[0].naturalHeight,1<=(i=Math.min((e-10)/r,(n-10)/o))&&(i=1),this.zoom(i)},repaintImage:function(){var t,e,n,r,o,i,a,u,c,l,f;f=this.getEl(),c=this.zoom(),l=this.state.get("rect"),a=this.$el.find("img"),u=this.$el.find(".mce-imagepanel-bg"),o=f.offsetWidth,i=f.offsetHeight,n=a[0].naturalWidth*c,r=a[0].naturalHeight*c,t=Math.max(0,o/2-n/2),e=Math.max(0,i/2-r/2),a.css({left:t,top:e,width:n,height:r}),u.css({left:t,top:e,width:n,height:r}),this.cropRect&&(this.cropRect.setRect({x:l.x*c+t,y:l.y*c+e,w:l.w*c,h:l.h*c}),this.cropRect.setClampRect({x:t,y:e,w:n,h:r}),this.cropRect.setViewPortRect({x:0,y:0,w:o,h:i}))},bindStates:function(){function n(t){r.cropRect=function(l,n,f,r,o){function s(t,e){return{x:e.x-t.x,y:e.y-t.y,w:e.w,h:e.h}}function a(t,e,n,r){var o,i,a,u,c;o=e.x,i=e.y,a=e.w,u=e.h,o+=n*t.deltaX,i+=r*t.deltaY,(a+=n*t.deltaW)<20&&(a=20),(u+=r*t.deltaH)<20&&(u=20),c=l=St.clamp({x:o,y:i,w:a,h:u},f,"move"===t.name),c=s(f,c),h.fire("updateRect",{rect:c}),d(c)}function e(e){function t(t,e){e.h<0&&(e.h=0),e.w<0&&(e.w=0),Ht("#"+m+"-"+t,r).css({left:e.x,top:e.y,width:e.w,height:e.h})}Z.each(u,function(t){Ht("#"+m+"-"+t.name,r).css({left:e.w*t.xMul+e.x,top:e.h*t.yMul+e.y})}),t("top",{x:n.x,y:n.y,w:n.w,h:e.y-n.y}),t("right",{x:e.x+e.w,y:e.y,w:n.w-e.x-e.w+n.x,h:e.h}),t("bottom",{x:n.x,y:e.y+e.h,w:n.w,h:n.h-e.y-e.h+n.y}),t("left",{x:n.x,y:e.y,w:e.x-n.x,h:e.h}),t("move",e)}function i(t){e(l=t)}function d(t){var e,n;i((e=f,{x:(n=t).x+e.x,y:n.y+e.y,w:n.w,h:n.h}))}var h,u,t,c,p="mce-",m=p+"crid-"+Vt++;return u=[{name:"move",xMul:0,yMul:0,deltaX:1,deltaY:1,deltaW:0,deltaH:0,label:"Crop Mask"},{name:"nw",xMul:0,yMul:0,deltaX:1,deltaY:1,deltaW:-1,deltaH:-1,label:"Top Left Crop Handle"},{name:"ne",xMul:1,yMul:0,deltaX:0,deltaY:1,deltaW:1,deltaH:-1,label:"Top Right Crop Handle"},{name:"sw",xMul:0,yMul:1,deltaX:1,deltaY:0,deltaW:-1,deltaH:1,label:"Bottom Left Crop Handle"},{name:"se",xMul:1,yMul:1,deltaX:0,deltaY:0,deltaW:1,deltaH:1,label:"Bottom Right Crop Handle"}],c=["top","right","bottom","left"],Ht('<div id="'+m+'" class="'+p+'croprect-container" role="grid" aria-dropeffect="execute">').appendTo(r),Z.each(c,function(t){Ht("#"+m,r).append('<div id="'+m+"-"+t+'"class="'+p+'croprect-block" style="display: none" data-mce-bogus="all">')}),Z.each(u,function(t){Ht("#"+m,r).append('<div id="'+m+"-"+t.name+'" class="'+p+"croprect-handle "+p+"croprect-handle-"+t.name+'"style="display: none" data-mce-bogus="all" role="gridcell" tabindex="-1" aria-label="'+t.label+'" aria-grabbed="false">')}),t=Z.map(u,function(e){var n;return new(Bt.get("DragHelper"))(m,{document:r.ownerDocument,handle:m+"-"+e.name,start:function(){n=l},drag:function(t){a(e,n,t.deltaX,t.deltaY)}})}),e(l),Ht(r).on("focusin focusout",function(t){Ht(t.target).attr("aria-grabbed","focus"===t.type)}),Ht(r).on("keydown",function(e){function t(t,e,n,r,o){t.stopPropagation(),t.preventDefault(),a(i,n,r,o)}var i;switch(Z.each(u,function(t){if(e.target.id===m+"-"+t.name)return i=t,!1}),e.keyCode){case Ft.LEFT:t(e,0,l,-10,0);break;case Ft.RIGHT:t(e,0,l,10,0);break;case Ft.UP:t(e,0,l,0,-10);break;case Ft.DOWN:t(e,0,l,0,10);break;case Ft.ENTER:case Ft.SPACEBAR:e.preventDefault(),o()}}),h=Z.extend({toggleVisibility:function(t){var e;e=Z.map(u,function(t){return"#"+m+"-"+t.name}).concat(Z.map(c,function(t){return"#"+m+"-"+t})).join(","),t?Ht(e,r).show():Ht(e,r).hide()},setClampRect:function(t){f=t,e(l)},setRect:i,getInnerRect:function(){return s(f,l)},setInnerRect:d,setViewPortRect:function(t){n=t,e(l)},destroy:function(){Z.each(t,function(t){t.destroy()}),t=[]}},Dt)}(t,r.state.get("viewRect"),r.state.get("viewRect"),r.getEl(),function(){r.fire("crop")}),r.cropRect.on("updateRect",function(t){var e=t.rect,n=r.zoom();e={x:Math.round(e.x/n),y:Math.round(e.y/n),w:Math.round(e.w/n),h:Math.round(e.h/n)},r.state.set("rect",e)}),r.on("remove",r.cropRect.destroy)}var r=this;r.state.on("change:cropEnabled",function(t){r.cropRect.toggleVisibility(t.value),r.repaintImage()}),r.state.on("change:zoom",function(){r.repaintImage()}),r.state.on("change:rect",function(t){var e=t.value;r.cropRect||n(e),r.cropRect.setRect(e)})}}))(t)}},Nt={edit:function(r,t){return new jt(function(e,n){return t.toBlob().then(function(t){C(r,G(t),e,n)})})}},qt={getImageSize:function(t){function e(t){return/^[0-9\.]+px$/.test(t)}var n,r;return n=t.style.width,r=t.style.height,n||r?e(n)&&e(r)?{w:parseInt(n,10),h:parseInt(r,10)}:null:(n=t.width,r=t.height,n&&r?{w:parseInt(n,10),h:parseInt(r,10)}:null)},setImageSize:function(t,e){var n,r;e&&(n=t.style.width,r=t.style.height,(n||r)&&(t.style.width=e.w+"px",t.style.height=e.h+"px",t.removeAttribute("data-mce-style")),n=t.width,r=t.height,(n||r)&&(t.setAttribute("width",e.w),t.setAttribute("height",e.h)))},getNaturalImageSize:function(t){return{w:t.naturalWidth,h:t.naturalHeight}}},$t=(z="function",function(t){return function(t){if(null===t)return"null";var e=typeof t;return"object"===e&&(Array.prototype.isPrototypeOf(t)||t.constructor&&"Array"===t.constructor.name)?"array":"object"===e&&(String.prototype.isPrototypeOf(t)||t.constructor&&"String"===t.constructor.name)?"string":e}(t)===z}),Xt=(Array.prototype.slice,function(t,e){for(var n=0,r=t.length;n<r;n++){var o=t[n];if(e(o,n,t))return q.some(o)}return q.none()});$t(Array.from)&&Array.from;var Yt=function(t){return null!==t&&t!==undefined},Gt=function(t,e){var n;return n=e.reduce(function(t,e){return Yt(t)?t[e]:undefined},t),Yt(n)?n:null},Kt=function(e){return new jt(function(n){var t=new(At("FileReader"));t.onload=function(t){var e=t.target;n(e.result)},t.readAsText(e)})},Jt=function(e,r,o){return new jt(function(t){var n;(n=new(At("XMLHttpRequest"))).onreadystatechange=function(){4===n.readyState&&t({status:n.status,blob:this.response})},n.open("GET",e,!0),n.withCredentials=o,Z.each(r,function(t,e){n.setRequestHeader(e,t)}),n.responseType="blob",n.send()})},Zt=function(t){var e;try{e=JSON.parse(t)}catch(E){}return e},Qt=[{code:404,message:"Could not find Image Proxy"},{code:403,message:"Rejected request"},{code:0,message:"Incorrect Image Proxy URL"}],te=[{type:"key_missing",message:"The request did not include an api key."},{type:"key_not_found",message:"The provided api key could not be found."},{type:"domain_not_trusted",message:"The api key is not valid for the request origins."}],ee=function(e){return"ImageProxy HTTP error: "+Xt(Qt,function(t){return e===t.code}).fold(S("Unknown ImageProxy error"),function(t){return t.message})},ne=function(t){var e=ee(t);return jt.reject(e)},re=function(e){return Xt(te,function(t){return t.type===e}).fold(S("Unknown service error"),function(t){return t.message})},oe=function(t,e){return Kt(e).then(function(t){var e,n,r=(e=Zt(t),"ImageProxy Service error: "+((n=Gt(e,["error","type"]))?re(n):"Invalid JSON in service error message"));return jt.reject(r)})},ie=function(t,e){return 400===(n=t)||403===n||500===n?oe(0,e):ne(t);var n},ae=ne,ue=function(t,e){var n,r,o,i={"Content-Type":"application/json;charset=UTF-8","tiny-api-key":e};return Jt((n=t,r=e,o=-1===n.indexOf("?")?"?":"&",/[?&]apiKey=/.test(n)||!r?n:n+o+"apiKey="+encodeURIComponent(r)),i,!1).then(function(t){return t.status<200||300<=t.status?ie(t.status,t.blob):jt.resolve(t.blob)})},ce=function(t,e,n){return e?ue(t,e):Jt(t,{},n).then(function(t){return t.status<200||300<=t.status?ae(t.status):jt.resolve(t.blob)})},le=0,fe=function(t,e){t.notificationManager.open({text:e,type:"error"})},se=function(t){return t.selection.getNode()},de=function(t,e){var n=e.src;return 0===n.indexOf("data:")||0===n.indexOf("blob:")||new zt(n).host===t.documentBaseURI.host},he=function(t,e){return-1!==Z.inArray(t.getParam("imagetools_cors_hosts",[],"string[]"),new zt(e.src).host)},pe=function(t,e){var n,r,o,i,a=e.src;return he(t,e)?ce(e.src,null,(r=t,o=e,-1!==Z.inArray(r.getParam("imagetools_credentials_hosts",[],"string[]"),new zt(o.src).host))):de(t,e)?u(e):(a=t.getParam("imagetools_proxy"),a+=(-1===a.indexOf("?")?"?":"&")+"url="+encodeURIComponent(e.src),n=(i=t).getParam("api_key",i.getParam("imagetools_api_key","","string"),"string"),ce(a,n,!1))},me=function(t){var e;return(e=t.editorUpload.blobCache.getByUri(se(t).src))?jt.resolve(e.blob()):pe(t,se(t))},ge=function(t){clearTimeout(t.get())},ve=function(c,l,f,s,d){return l.toBlob().then(function(t){var e,n,r,o,i,a,u;return r=c.editorUpload.blobCache,e=(i=se(c)).src,c.getParam("images_reuse_filename",!1,"boolean")&&(n=(o=r.getByUri(e))?(e=o.uri(),o.name()):(a=c,(u=e.match(/\/([^\/\?]+)?\.(?:jpeg|jpg|png|gif)(?:\?|$)/i))?a.dom.encode(u[1]):null)),o=r.create({id:"imagetools"+le++,blob:t,base64:l.toBase64(),uri:e,name:n}),r.add(o),c.undoManager.transact(function(){c.$(i).on("load",function r(){var t,e,n;c.$(i).off("load",r),c.nodeChanged(),f?c.editorUpload.uploadImagesAuto():(ge(s),t=c,e=s,n=_t.setEditorTimeout(t,function(){t.editorUpload.uploadImagesAuto()},t.getParam("images_upload_timeout",3e4,"number")),e.set(n))}),d&&c.$(i).attr({width:d.w,height:d.h}),c.$(i).attr({src:o.blobUri()}).removeAttr("data-mce-src")}),o})},ye=function(e,n,t,r){return function(){return e._scanForImages().then(a(me,e)).then(Tt).then(t).then(function(t){return ve(e,t,!1,n,r)},function(t){fe(e,t)})}},we=function(n,r,o){return function(){var t=qt.getImageSize(se(n)),e=t?{w:t.h,h:t.w}:null;return ye(n,r,function(t){return Mt(t,o)},e)()}},be=function(t,e,n){return function(){return ye(t,e,function(t){return kt(t,n)})()}},xe=function(e,r){return function(){var o=se(e),i=qt.getNaturalImageSize(o),n=function(r){return new jt(function(n){var t;(t=r,c(t)).then(function(t){var e=qt.getNaturalImageSize(t);i.w===e.w&&i.h===e.h||qt.getImageSize(o)&&qt.setImageSize(o,e),Ot.revokeObjectURL(t.src),n(r)})})};me(e).then(Tt).then(a(function(e,t){return Nt.edit(e,t).then(n).then(Tt).then(function(t){return ve(e,t,!0,r)},function(){})},e),function(t){fe(e,t)})}},ke=function(t,e){return t.dom.is(e,"img:not([data-mce-object],[data-mce-placeholder])")&&(de(t,e)||he(t,e)||t.settings.imagetools_proxy)},Re=ge,Ie=function(n,t){Z.each({mceImageRotateLeft:we(n,t,-90),mceImageRotateRight:we(n,t,90),mceImageFlipVertical:be(n,t,"v"),mceImageFlipHorizontal:be(n,t,"h"),mceEditImage:xe(n,t)},function(t,e){n.addCommand(e,t)})},Me=function(n,r,o){n.on("NodeChange",function(t){var e=o.get();e&&e.src!==t.element.src&&(Re(r),n.editorUpload.uploadImagesAuto(),o.set(null)),ke(n,t.element)&&o.set(t.element)})},Te=function(t){t.addButton("rotateleft",{title:"Rotate counterclockwise",cmd:"mceImageRotateLeft"}),t.addButton("rotateright",{title:"Rotate clockwise",cmd:"mceImageRotateRight"}),t.addButton("flipv",{title:"Flip vertically",cmd:"mceImageFlipVertical"}),t.addButton("fliph",{title:"Flip horizontally",cmd:"mceImageFlipHorizontal"}),t.addButton("editimage",{title:"Edit image",cmd:"mceEditImage"}),t.addButton("imageoptions",{title:"Image options",icon:"options",cmd:"mceImage"})},Ue=function(t){t.addContextToolbar(a(ke,t),t.getParam("imagetools_toolbar","rotateleft rotateright | flipv fliph | crop editimage imageoptions"))};B.add("imagetools",function(t){var e=L(0),n=L(null);Ie(t,e),Te(t),Ue(t),Me(t,e,n)})}(window);