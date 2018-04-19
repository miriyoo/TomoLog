<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>MAKE COVER</title>

		<meta name="viewport" content="width=device-width, initial-scale=1">
		<script type="text/javascript" src="<c:url value="/resources/js/fabric.min.js" />"></script>
		<script type="text/javascript" src="<c:url value="/resources/js/fabric.js" />"></script>
		<script type="text/javascript" src="<c:url value="/resources/js/jquery-3.2.1.js" />"></script>

		<script type="text/javascript" src="<c:url value="/resources/js/html2canvas.min.js" />"></script>
		<script type="text/javascript" src="<c:url value="/resources/js/html2canvas.js" />"></script>

		<script src="http://hongru.github.io/proj/canvas2image/canvas2image.js"></script>
		
		<style>
			#div_root{
				width: 100%;
				height:50px;
				float:left;
				background-color:#ff9999;
			}
					
			#div_top{
				width:100%;
				height:100px;
				float:left;
				background-color:#ffe699;
			}
					
			#div_menu{
				width:20%;
				height:600px;
				float:left;
				background-color:#99ffb3;
			}
					
			#div_con{
				width:80%;
				height:600px;
				float:left;
			}
		</style>
		
		<script type="text/javascript">
			function changeBackground(img){
				if(img == 'delete'){
					document.getElementById("c").style.background = "";
				}
				if(img == 'cd'){
					document.getElementById("c").style.background = "url(../resources/img/cd.jpg)";
				}
				if(img == 'christmas'){
					document.getElementById("c").style.background = "url(../resources/img/christmas.jpg)";
				}
				if(img == 'diary'){
					document.getElementById("c").style.background = "url(../resources/img/diary.jpg)";
				}
				if(img == 'label'){
					document.getElementById("c").style.background = "url(../resources/img/label.jpg)";
				}
				if(img == 'menu'){
					document.getElementById("c").style.background = "url(../resources/img/menu.jpg)";
				}
				if(img == 'paper'){
					document.getElementById("c").style.background = "url(../resources/img/paper.jpg)";
				}
				if(img == 'poster'){
					document.getElementById("c").style.background = "url(../resources/img/poster.jpg)";
				}
			}

	    	  function download(){
    			var download = document.getElementById("download");
    			var image = document.getElementById("finalCover").toDataURL("image/png")
    	                    .replace("image/png", "image/octet-stream");
    				  download.setAttribute("href", image);
    		}

		  	$(function(){
		    	  var $ = function(id){return document.getElementById(id)};

		    	  var canvas = this.__canvas = new fabric.Canvas('c', {
		    	    isDrawingMode: true
		    	  });

		    	  fabric.Object.prototype.transparentCorners = false;

		    	  var drawingModeEl = $('drawing-mode'),
		    	      drawingOptionsEl = $('drawing-mode-options'),
		    	      drawingColorEl = $('drawing-color'),
		    	      drawingShadowColorEl = $('drawing-shadow-color'),
		    	      drawingLineWidthEl = $('drawing-line-width'),
		    	      drawingShadowWidth = $('drawing-shadow-width'),
		    	      drawingShadowOffset = $('drawing-shadow-offset'),
		    	      clearEl = $('clear-canvas');
		    	  
		    	  var text = $('insertText');
		    	  var uploadImage = $('imageLoader');
		    	  var tMenu = $('textmenu');
		    	  
		    	  clearEl.onclick = function() { canvas.clear() };
		    	  
		    	  var n;

		    	  drawingModeEl.onclick = function() {
		    	    canvas.isDrawingMode = !canvas.isDrawingMode;
		    	    if (canvas.isDrawingMode) {
		    	      drawingModeEl.innerHTML = '드로잉 모드 OFF';
		    	      drawingOptionsEl.style.display = '';
		    	      text.style.display = 'none';
		    	      tMenu.style.display = 'none';
		    	      uploadImage.style.display = 'none';
		    	    }
		    	    else {
		    	      drawingModeEl.innerHTML = '드로잉 모드 ON';
		    	      drawingOptionsEl.style.display = 'none';
		    	      text.style.display = '';
		  	  	    tMenu.style.display = '';
		  	 	   uploadImage.style.display = '';
		    	    }
		    	  };

		    	  if (fabric.PatternBrush) {
		    	    var vLinePatternBrush = new fabric.PatternBrush(canvas);
		    	    vLinePatternBrush.getPatternSrc = function() {

		    	      var patternCanvas = fabric.document.createElement('canvas');
		    	      patternCanvas.width = patternCanvas.height = 10;
		    	      var ctx = patternCanvas.getContext('2d');

		    	      ctx.strokeStyle = this.color;
		    	      ctx.lineWidth = 5;
		    	      ctx.beginPath();
		    	      ctx.moveTo(0, 5);
		    	      ctx.lineTo(10, 5);
		    	      ctx.closePath();
		    	      ctx.stroke();

		    	      return patternCanvas;
		    	    };

		    	    var hLinePatternBrush = new fabric.PatternBrush(canvas);
		    	    hLinePatternBrush.getPatternSrc = function() {

		    	      var patternCanvas = fabric.document.createElement('canvas');
		    	      patternCanvas.width = patternCanvas.height = 10;
		    	      var ctx = patternCanvas.getContext('2d');

		    	      ctx.strokeStyle = this.color;
		    	      ctx.lineWidth = 5;
		    	      ctx.beginPath();
		    	      ctx.moveTo(5, 0);
		    	      ctx.lineTo(5, 10);
		    	      ctx.closePath();
		    	      ctx.stroke();

		    	      return patternCanvas;
		    	    };

		    	    var squarePatternBrush = new fabric.PatternBrush(canvas);
		    	    squarePatternBrush.getPatternSrc = function() {

		    	      var squareWidth = 10, squareDistance = 2;

		    	      var patternCanvas = fabric.document.createElement('canvas');
		    	      patternCanvas.width = patternCanvas.height = squareWidth + squareDistance;
		    	      var ctx = patternCanvas.getContext('2d');

		    	      ctx.fillStyle = this.color;
		    	      ctx.fillRect(0, 0, squareWidth, squareWidth);

		    	      return patternCanvas;
		    	    };

		    	    var diamondPatternBrush = new fabric.PatternBrush(canvas);
		    	    diamondPatternBrush.getPatternSrc = function() {

		    	      var squareWidth = 10, squareDistance = 5;
		    	      var patternCanvas = fabric.document.createElement('canvas');
		    	      var rect = new fabric.Rect({
		    	        width: squareWidth,
		    	        height: squareWidth,
		    	        angle: 45,
		    	        fill: this.color
		    	      });

		    	      var canvasWidth = rect.getBoundingRect().width;

		    	      patternCanvas.width = patternCanvas.height = canvasWidth + squareDistance;
		    	      rect.set({ left: canvasWidth / 2, top: canvasWidth / 2 });

		    	      var ctx = patternCanvas.getContext('2d');
		    	      rect.render(ctx);

		    	      return patternCanvas;
		    	    };

		    	    var img = new Image();
		    	    img.src = '../resources/img/honey_im_subtle.jpg';

		    	    var texturePatternBrush = new fabric.PatternBrush(canvas);
		    	    texturePatternBrush.source = img;
		    	  }

		    	  $('drawing-mode-selector').onchange = function() {

		    	    if (this.value === 'hline') {
		    	      canvas.freeDrawingBrush = vLinePatternBrush;
		    	    }
		    	    else if (this.value === 'vline') {
		    	      canvas.freeDrawingBrush = hLinePatternBrush;
		    	    }
		    	    else if (this.value === 'square') {
		    	      canvas.freeDrawingBrush = squarePatternBrush;
		    	    }
		    	    else if (this.value === 'diamond') {
		    	      canvas.freeDrawingBrush = diamondPatternBrush;
		    	    }
		    	    else if (this.value === 'texture') {
		    	      canvas.freeDrawingBrush = texturePatternBrush;
		    	    }
		    	    else {
		    	      canvas.freeDrawingBrush = new fabric[this.value + 'Brush'](canvas);
		    	    }

		    	    if (canvas.freeDrawingBrush) {
		    	      canvas.freeDrawingBrush.color = drawingColorEl.value;
		    	      canvas.freeDrawingBrush.width = parseInt(drawingLineWidthEl.value, 10) || 1;
		    	      canvas.freeDrawingBrush.shadow = new fabric.Shadow({
		    	        blur: parseInt(drawingShadowWidth.value, 10) || 0,
		    	        offsetX: 0,
		    	        offsetY: 0,
		    	        affectStroke: true,
		    	        color: drawingShadowColorEl.value,
		    	      });
		    	    }
		    	  };

		    	  drawingColorEl.onchange = function() {
		    	    canvas.freeDrawingBrush.color = this.value;
		    	  };
		    	  drawingShadowColorEl.onchange = function() {
		    	    canvas.freeDrawingBrush.shadow.color = this.value;
		    	  };
		    	  drawingLineWidthEl.onchange = function() {
		    	    canvas.freeDrawingBrush.width = parseInt(this.value, 10) || 1;
		    	    this.previousSibling.innerHTML = this.value;
		    	  };
		    	  drawingShadowWidth.onchange = function() {
		    	    canvas.freeDrawingBrush.shadow.blur = parseInt(this.value, 10) || 0;
		    	    this.previousSibling.innerHTML = this.value;
		    	  };
		    	  drawingShadowOffset.onchange = function() {
		    	    canvas.freeDrawingBrush.shadow.offsetX = parseInt(this.value, 10) || 0;
		    	    canvas.freeDrawingBrush.shadow.offsetY = parseInt(this.value, 10) || 0;
		    	    this.previousSibling.innerHTML = this.value;
		    	  };

		    	  if (canvas.freeDrawingBrush) {
		    	    canvas.freeDrawingBrush.color = drawingColorEl.value;
		    	    canvas.freeDrawingBrush.width = parseInt(drawingLineWidthEl.value, 10) || 1;
		    	    canvas.freeDrawingBrush.shadow = new fabric.Shadow({
		    	      blur: parseInt(drawingShadowWidth.value, 10) || 0,
		    	      offsetX: 0,
		    	      offsetY: 0,
		    	      affectStroke: true,
		    	      color: drawingShadowColorEl.value,
		    	    });
		    	  }
		    	  
		    	  //뒤로가기
		    	 $('roll-back').onclick = function() {
		    		 n = canvas.getObjects().length;
		    		 alert(n);
		    		 
		    		 canvas.remove(canvas.item(n-1));
		    		 n--;
				  }
		    	  
		    	  //복사
		    	  $('copy').onclick = function() {
				  		canvas.getActiveObject().clone(function(cloned) {
				  			_clipboard = cloned;
				  		});
				  	}

		    	 //붙여넣기
				 $('paste').onclick = function(){
				  		_clipboard.clone(function(clonedObj) {
				  			canvas.discardActiveObject();
				  			clonedObj.set({
				  				left: clonedObj.left + 10,
				  				top: clonedObj.top + 10,
				  				evented: true,
				  			});
				  			if (clonedObj.type === 'activeSelection') {
				  				clonedObj.canvas = canvas;
				  				clonedObj.forEachObject(function(obj) {
				  					canvas.add(obj);
				  				});
				  				clonedObj.setCoords();
				  			} else {
				  				canvas.add(clonedObj);
				  			}
				  			_clipboard.top += 10;
				  			_clipboard.left += 10;
				  			canvas.setActiveObject(clonedObj);
				  			canvas.requestRenderAll();
				  		});
				  	}
		    	  
		    	  //insertText
		    	  $('insertText').onclick = function() {

		    		var fonts = ["Pacifico", "VT323", "Quicksand", "Inconsolata"];

		    		var textbox = new fabric.Textbox('글자를 입력하세요.', {
		    		  left: 50,
		    		  top: 50,
		    		  width: 150,
		    		  fontSize: 20
		    		});
		    		canvas.add(textbox).setActiveObject(textbox);
		    		fonts.unshift('Times New Roman');
		    		// Populate the fontFamily select
		    		var select = document.getElementById("font-family");
		    		fonts.forEach(function(font) {
		    		  var option = document.createElement('option');
		    		  option.innerHTML = font;
		    		  option.value = font;
		    		  select.appendChild(option);
		    		});

		    		// Apply selected font on change
		    		document.getElementById('font-family').onchange = function() {
		    		  if (this.value !== 'Times New Roman') {
		    		    loadAndUse(this.value);
		    		  } else {
		    		    canvas.getActiveObject().set("fontFamily", this.value);
		    		    canvas.requestRenderAll();
		    		  }
		    		};

		    		function loadAndUse(font) {
		    		  var myfont = new FontFaceObserver(font)
		    		  myfont.load()
		    		    .then(function() {
		    		      // when font is loaded, use it.
		    		      canvas.getActiveObject().set("fontFamily", font);
		    		      canvas.requestRenderAll();
		    		    }).catch(function(e) {
		    		      console.log(e)
		    		      alert('font loading failed ' + font);
		    		    });
		    		}
		    	  }
		    	  
		    	  
		    	  $('btnComplete').onclick = function(){

		    		    var finalCover = document.getElementById("finalCover");
		    		    
		    		    if(finalCover != null){
		    		    	finalCover.outerHTML='';
		    		    }
		    		  
			    	html2canvas(document.querySelector("#div_con")).then(canvas => {
				    		    document.body.appendChild(canvas).setAttribute("id", "finalCover");
				    	});
		    	  }
		    	  

		    	  	 //upload Image
		    		 var imageLoader = document.getElementById('imageLoader');
		    	     imageLoader.addEventListener('change', handleImage, false);
		    	 
		    	     function handleImage(e){
		    	         var reader = new FileReader();
		    	         reader.onload = function(event){
		    	        	 var img = new Image();
		    	        	 img.onload = function(){
		    	        		 var imgInstance = new fabric.Image(img)
		    	        		 canvas.add(imgInstance);
		    	        	 }
		    	        	 img.src = event.target.result;
		    	         }
		    	         reader.readAsDataURL(e.target.files[0]);
		    	     }		  
		  	});
		</script>
	</head>
	
	<body>
		<!-- 맨 위 메뉴 바 부분 -->
		<div id="div_root" style="text-align: center;">
			<h3>나만의 표지를 꾸며봅시다.</h3>
		</div>
		
		<!-- 편집 메뉴 영역 -->
		<div id="div_top">
				Background
				<button type="button" onClick="changeBackground('delete')">배경 삭제</button>
			    <button type="button" onClick="changeBackground('cd')">CD</button>
			    <button type="button" onClick="changeBackground('christmas')">Christmas</button>
			    <button type="button" onClick="changeBackground('diary')">Diary</button>
			    <button type="button" onClick="changeBackground('label')">Label</button>
			    <button type="button" onClick="changeBackground('menu')">Menu</button>
			    <button type="button" onClick="changeBackground('paper')">Paper</button>
			    <button type="button" onClick="changeBackground('poster')">Poster</button>
			    <br>
				
<!-- 			<div class="buttons">
				    <input type="button" class="BOLD" value="B" onclick="document.execCommand('bold')" />
				    <input type="button" class="ITALIC" value="Italic" onclick="document.execCommand('Italic')" />
				    <input type="button" class="UNDERBAR" value="밑줄" onclick="document.execCommand('Underline')" />
				    <input type="button" class="BAR" value="취소선" onclick="document.execCommand('StrikeThrough')" />
				    <input type="button" class="aignLeft" value="왼쪽 정렬" onclick="document.execCommand('justifyleft')" />
				    <input type="button" class="aignCenter" value="가운데 정렬" onclick="document.execCommand('justifycenter')" />
				    <input type="button" class="aignRight" value="오른쪽 정렬" onclick="document.execCommand('justifyright')" />
				</div> -->
				
		</div>
		
		<!-- 왼쪽 도구 영역 -->
		<div id="div_menu" class="div_menu">

			<!-- 캔버스 버튼들 -->
			<div style="display: inline-block; margin-left: 10px">
			  	<button id="drawing-mode" class="btn btn-info">드로잉 모드 OFF</button><br>
			  	<input type="file" id="imageLoader" name="imageLoader" style="display: none;"><br>
			  	<button id="insertText" class="btn btn-info" style="display: none;">글씨 쓰기</button>
			  	<div id="textmenu" class="controls" style="display: none;">
					<p>
						Font-family: <select id="font-family"><option value="Times New Roman">Times New Roman</option><option value="Pacifico">Pacifico</option><option value="VT323">VT323</option><option value="Quicksand">Quicksand</option><option value="Inconsolata">Inconsolata</option></select>
					</p>
				</div>
			  	<br>
			  	<div class="controls">
						<button id="copy">복사</button>
						<button id="paste">붙여넣기</button>
						<button id="clear-canvas" class="btn btn-info">전체 삭제</button>
						<button id="roll-back" class="btn btn-info">뒤로가기</button>
				</div>
		 		<div id="drawing-mode-options" style="">
		   			<label for="drawing-mode-selector">Mode:</label>
		   			<select id="drawing-mode-selector">
					     <option>Pencil</option>
					     <option>Circle</option>
					     <option>Spray</option>
					     <option>Pattern</option>
					     <option>hline</option>
					     <option>vline</option>
					     <option>square</option>
					     <option>diamond</option>
					     <option>texture</option>
		    		</select><br>
		
				    <label for="drawing-line-width">Line width:</label>
				    <span class="info">30</span><input type="range" value="30" min="0" max="150" id="drawing-line-width"><br>
				
				    <label for="drawing-color">Line color:</label>
				    <input type="color" value="#005E7A" id="drawing-color"><br>
		
				    <label for="drawing-shadow-color">Shadow color:</label>
				    <input type="color" value="#005E7A" id="drawing-shadow-color"><br>
				
				    <label for="drawing-shadow-width">Shadow width:</label>
				    <span class="info">0</span><input type="range" value="0" min="0" max="50" id="drawing-shadow-width"><br>
				
				    <label for="drawing-shadow-offset">Shadow offset:</label>
				    <span class="info">0</span><input type="range" value="0" min="0" max="50" id="drawing-shadow-offset"><br>
		 	 </div>
			</div>
			
			<hr>
			<button id="btnComplete" onclick="btnComplete()">완성</button>
			<a id="download" download="post_cover.png"><button type="button" onClick="download()">저장</button></a>
		</div>
		
		<!-- 내용(표지 부분) 영역 -->
		<div id="div_con" class="div_con">
		
			<!-- 캔버스 -->
			<canvas id="c" width="1200" height="600"></canvas>

		</div>

	</body>
</html>