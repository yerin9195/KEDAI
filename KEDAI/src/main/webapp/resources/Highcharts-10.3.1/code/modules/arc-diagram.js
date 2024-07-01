/*
 Highcharts JS v10.3.1 (2022-10-31)

 Arc diagram module

 (c) 2021 Piotr Madej

 License: www.highcharts.com/license
*/
(function(a){"object"===typeof module&&module.exports?(a["default"]=a,module.exports=a):"function"===typeof define&&define.amd?define("highcharts/modules/arc-diagram",["highcharts","highcharts/modules/sankey"],function(e){a(e);a.Highcharts=e;return a}):a("undefined"!==typeof Highcharts?Highcharts:void 0)})(function(a){function e(a,n,u,e){a.hasOwnProperty(n)||(a[n]=e.apply(null,u),"function"===typeof CustomEvent&&window.dispatchEvent(new CustomEvent("HighchartsModuleLoaded",{detail:{path:n,module:a[n]}})))}
a=a?a._modules:{};e(a,"Series/ArcDiagram/ArcDiagramPoint.js",[a["Series/NodesComposition.js"],a["Core/Series/SeriesRegistry.js"],a["Core/Utilities.js"]],function(a,n,e){var t=this&&this.__extends||function(){var a=function(b,l){a=Object.setPrototypeOf||{__proto__:[]}instanceof Array&&function(a,b){a.__proto__=b}||function(a,b){for(var l in b)b.hasOwnProperty(l)&&(a[l]=b[l])};return a(b,l)};return function(b,l){function e(){this.constructor=b}a(b,l);b.prototype=null===l?Object.create(l):(e.prototype=
l.prototype,new e)}}();e=e.extend;n=function(a){function b(){var b=null!==a&&a.apply(this,arguments)||this;b.fromNode=void 0;b.index=void 0;b.linksFrom=void 0;b.linksTo=void 0;b.options=void 0;b.series=void 0;b.scale=void 0;b.shapeArgs=void 0;b.toNode=void 0;return b}t(b,a);b.prototype.isValid=function(){return!0};return b}(n.seriesTypes.sankey.prototype.pointClass);e(n.prototype,{setState:a.setNodeState});return n});e(a,"Series/ArcDiagram/ArcDiagramSeries.js",[a["Series/ArcDiagram/ArcDiagramPoint.js"],
a["Series/Sankey/SankeyColumnComposition.js"],a["Core/Series/Series.js"],a["Core/Series/SeriesRegistry.js"],a["Core/Renderer/SVG/SVGRenderer.js"],a["Core/Utilities.js"]],function(a,e,u,t,q,b){var l=this&&this.__extends||function(){var a=function(b,d){a=Object.setPrototypeOf||{__proto__:[]}instanceof Array&&function(d,c){d.__proto__=c}||function(d,c){for(var a in c)c.hasOwnProperty(a)&&(d[a]=c[a])};return a(b,d)};return function(b,d){function g(){this.constructor=b}a(b,d);b.prototype=null===d?Object.create(d):
(g.prototype=d.prototype,new g)}}(),n=this&&this.__rest||function(a,b){var d={},g;for(g in a)Object.prototype.hasOwnProperty.call(a,g)&&0>b.indexOf(g)&&(d[g]=a[g]);if(null!=a&&"function"===typeof Object.getOwnPropertySymbols){var c=0;for(g=Object.getOwnPropertySymbols(a);c<g.length;c++)0>b.indexOf(g[c])&&Object.prototype.propertyIsEnumerable.call(a,g[c])&&(d[g[c]]=a[g[c]])}return d},z=q.prototype.symbols;q=t.seriesTypes;var x=q.column,v=q.sankey;q=b.extend;var y=b.merge,w=b.pick,A=b.relativeLength;
b=function(a){function b(){var d=null!==a&&a.apply(this,arguments)||this;d.data=void 0;d.options=void 0;d.nodeColumns=void 0;d.nodes=void 0;d.points=void 0;return d}l(b,a);b.prototype.createNodeColumns=function(){var d=this,a=this,c=a.chart,b=e.compose([],a);b.sankeyColumn.maxLength=c.inverted?c.plotHeight:c.plotWidth;b.sankeyColumn.getTranslationFactor=function(a){for(var g=b.slice(),f=d.options.minLinkWidth||0,r=0,k,p,h=0,e=1,l=0,n=(c.plotSizeX||0)-(a.options.marker&&a.options.marker.lineWidth||
0)-(b.length-1)*a.nodePadding;b.length;){r=n/b.sankeyColumn.sum();a=!1;for(k=b.length;k--;){p=b[k].getSum()*r*e;var q=Math.min(c.plotHeight,c.plotWidth);p>q?e=Math.min(q/p,e):p<f&&(b.splice(k,1),n-=f,p=f,a=!0);l+=p*(1-e)/2;h=Math.max(h,p)}if(!a)break}b.length=0;g.forEach(function(a){a.scale=e;b.push(a)});b.sankeyColumn.maxRadius=h;b.sankeyColumn.scale=e;b.sankeyColumn.additionalSpace=l;return r};b.sankeyColumn.offset=function(d,g){for(var f=d.series.options.equalNodes,e=b.sankeyColumn.additionalSpace||
0,k,r=a.nodePadding,h=Math.min(c.plotWidth,c.plotHeight,(b.sankeyColumn.maxLength||0)/a.nodes.length-r),p=0;p<b.length;p++){k=b[p].getSum()*(b.sankeyColumn.scale||0);var m=f?h:Math.max(k*g,a.options.minLinkWidth||0);k=k?m+r:0;if(b[p]===d)return{relativeLeft:e+A(d.options.offset||0,k)};e+=k}};a.nodes.forEach(function(a){a.column=0;b.push(a)});return[b]};b.prototype.translateLink=function(a){var b=a.fromNode;var c=a.toNode;var d=this.chart,e=this.translationFactor,m=this.options,f=w(a.options.linkWeight,
m.linkWeight,Math.max((a.weight||0)*e*b.scale,this.options.minLinkWidth||0)),l=a.series.options.centeredLinks,k=b.nodeY,n=function(b,d){d=(b.offset(a,d)||0)*e;return Math.min(b.nodeX+d,b.nodeX+(b.shapeArgs&&b.shapeArgs.height||0)-f)},h=l?b.nodeX+((b.shapeArgs.height||0)-f)/2:n(b,"linksFrom");c=l?c.nodeX+((c.shapeArgs.height||0)-f)/2:n(c,"linksTo");h>c&&(c=[c,h],h=c[0],c=c[1]);m.reversed&&(c=[c,h],h=c[0],c=c[1],k=(d.plotSizeY||0)-k);a.shapeType="path";a.linkBase=[h,h+f,c,c+f];m=(c+f-h)/Math.abs(c+
f-h)*w(m.linkRadius,Math.min(Math.abs(c+f-h)/2,b.nodeY-Math.abs(f)));a.shapeArgs={d:[["M",h,k],["A",(c+f-h)/2,m,0,0,1,c+f,k],["L",c,k],["A",(c-h-f)/2,m-f,0,0,0,h+f,k],["Z"]]};a.dlBox={x:h+(c-h)/2,y:k-m,height:f,width:0};a.tooltipPos=d.inverted?[(d.plotSizeY||0)-a.dlBox.y-f/2,(d.plotSizeX||0)-a.dlBox.x]:[a.dlBox.x,a.dlBox.y+f/2];a.y=a.plotY=1;a.x=a.plotX=1;a.color||(a.color=b.color)};b.prototype.translateNode=function(a,b){var c=this.translationFactor,d=this.chart,e=this.options,m=Math.min(d.plotWidth,
d.plotHeight,(d.inverted?d.plotWidth:d.plotHeight)/a.series.nodes.length-this.nodePadding),f=a.getSum()*(b.sankeyColumn.scale||0);m=e.equalNodes?m:Math.max(f*c,this.options.minLinkWidth||0);var g=Math.round(e.marker&&e.marker.lineWidth||0)%2/2,k=b.sankeyColumn.offset(a,c);c=Math.floor(w(k&&k.absoluteLeft,(b.sankeyColumn.left(c)||0)+(k&&k.relativeLeft||0)))+g;var l=y(e.marker,a.options.marker);k=l.symbol;var h=l.radius;b=parseInt(e.offset,10)*((d.inverted?d.plotWidth:d.plotHeight)-(Math.floor(this.colDistance*
(a.column||0)+(l.lineWidth||0)/2)+g+(b.sankeyColumn.scale||0)*(b.sankeyColumn.maxRadius||0)/2))/100;(a.sum=f)?(a.nodeX=c,a.nodeY=b,f=a.options.width||e.width||m,m=a.options.height||e.height||m,g=b,e.reversed&&(g=(d.plotSizeY||0)-b,d.inverted&&(g=(d.plotSizeY||0)-b)),this.mapOptionsToLevel&&(a.dlOptions=v.getDLOptions({level:this.mapOptionsToLevel[a.level],optionsPoint:a.options})),a.plotX=1,a.plotY=1,a.tooltipPos=d.inverted?[(d.plotSizeY||0)-g-m/2,(d.plotSizeX||0)-c-f/2]:[c+f/2,g+m/2],a.shapeType=
"path",a.shapeArgs={d:z[k||"circle"](c,g-(h||m)/2,h||f,h||m),width:h||f,height:h||m},a.dlBox={x:c+f/2,y:g,height:0,width:0}):a.dlOptions={enabled:!1}};b.prototype.drawDataLabels=function(){if(this.options.dataLabels){var a=this.options.dataLabels.textPath;x.prototype.drawDataLabels.call(this,this.nodes);this.options.dataLabels.textPath=this.options.dataLabels.linkTextPath;x.prototype.drawDataLabels.call(this,this.data);this.options.dataLabels.textPath=a}};b.prototype.pointAttribs=function(b,e){if(b&&
b.isNode){var c=u.prototype.pointAttribs.apply(this,arguments);return n(c,["opacity"])}return a.prototype.pointAttribs.apply(this,arguments)};b.prototype.markerAttribs=function(b){return b.isNode?a.prototype.markerAttribs.apply(this,arguments):{}};b.defaultOptions=y(v.defaultOptions,{centeredLinks:!1,offset:"100%",equalNodes:!1,reversed:!1,dataLabels:{linkTextPath:{attributes:{startOffset:"25%"}}},marker:{symbol:"circle",fillOpacity:1,states:{}}});return b}(v);q(b.prototype,{orderNodes:!1});b.prototype.pointClass=
a;t.registerSeriesType("arcdiagram",b);"";return b});e(a,"masters/modules/arc-diagram.src.js",[],function(){})});
//# sourceMappingURL=arc-diagram.js.map