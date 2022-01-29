package com.illuzor {
	
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import elements.AlbumPage;
	import elements.ArticlePage;
	import elements.MenuButton;
	
	/**
	 * Сайт для урока для demiart.ru
	 * Создан с помощью flashDevelop 4.0.1 и FlexSDK 4.6
	 * с использованием бибилиотеки от greensock http://www.greensock.com/
	 * 
	 * Основной класс сайта. Выполняет загрузку xml  фона, управляется страницами сайта.
	 * 
	 */
	
	[Frame(factoryClass = "Preloader")] // цепляем прелоадер.
	
	public class Main extends Sprite {
		/** @private путь к xml файлу */
		private const XML_PATH:String = "data.xml";
		/** @private сам xml */
		private var xml:XML;
		/** @private фон в виде битмапа, загруженного извне */
		private var background:Bitmap;
		/** @private текстовый объект копирайта */
		private var copyright:TextObject;
		/** @private контейнер для кнопок галереи */
		private var galeryButtonsContainer:Sprite;
		/** @private контейнер для кнопок статей */
		private var articlesButtonsContainer:Sprite;
		/** @private контейнер для страниц. статей и галерей */
		private var pageContainer:Sprite;
		
		/**  основной конструктор */
		public function Main():void {
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		/** @private инициализация срабатывает после добавления на сцену */
		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			loadXML(); // запускаем загрузку xml
		}
		/** @private грузим xml */
		private function loadXML():void {
			var xmlLoader:URLLoader = new URLLoader();
			xmlLoader.load(new URLRequest(XML_PATH));
			xmlLoader.addEventListener(Event.COMPLETE, xmlLoaded);
			xmlLoader.addEventListener(IOErrorEvent.IO_ERROR, xmlLoadingIOError);
		}
		/** @private на всякий случай обрабатываем ошибку загрузки xml */
		private function xmlLoadingIOError(e:IOErrorEvent):void {
			trace("xml loading io error");
		}
		/**
		 * xml загружен корректно, грузим фон
		 * 
		 * @param	e событие окончания загрузки xml
		 */
		private function xmlLoaded(e:Event):void {
			e.target.removeEventListener(Event.COMPLETE, xmlLoaded); // удаляем ненужные больше листенеры
			e.target.removeEventListener(IOErrorEvent.IO_ERROR, xmlLoadingIOError);
			
			xml = new XML(e.target.data); // создаём xml из загруженных данных
			
			// случайное значение для загрузки фона
			var randomValue:uint = random(0, xml.settings.backgrounds.children().length() - 1);
			
			var backgroundLoader:Loader = new Loader(); // загрузчик фона.
			backgroundLoader.load(new URLRequest(xml.settings.backgrounds.children()[randomValue].@url));
			backgroundLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, backgroundLoaded);
		}
		/**
		 * @private фон загружен, помешаем его на сцену, запускаем создание интерфейса.
		 * 
		 * @param	e событие окончания загрузки фона
		 */
		private function backgroundLoaded(e:Event):void {
			e.target.removeEventListener(Event.COMPLETE, backgroundLoaded); // удаляем слушатель
			(this.parent as Preloader).removeRotator(); // удаляем крутилку из прелоадера. именно тогда, когда загружен фон
			
			background = e.target.content as Bitmap; // создаём битмап фона и добавляем на сцену
			background.smoothing = true;
			addChild(background);
			createUI(); // запускаем создание интерфейса.
		}
		/**
		 * @private создание графического интерфейса.
		 * создаём надписи копирайта и названия сайта, также создаём кнопки
		 */
		private function createUI():void {
			pageContainer = new Sprite(); // контейнер для страниц. нужен для удобства.
			addChild(pageContainer);
			
			var siteName:TextObject = new TextObject(); // текстовый объект имени сайта
			siteName.x = siteName.y = 5;
			siteName.tf.text = xml.settings.siteName; // задаём текст из xml
			siteName.tf.width = siteName.tf.textWidth + 4; // задаём ширину на основе ширины текста
			addChild(siteName);
			
			copyright = new TextObject(); // текстовый объект копирайта, аналогично с названием сайта
			copyright.tf.text = xml.settings.copyright;
			copyright.tf.width = copyright.tf.textWidth + 4;
			addChild(copyright);
			
			articlesButtonsContainer = new Sprite(); // контейнер для кнопок статей
			articlesButtonsContainer.x = 8;
			articlesButtonsContainer.y = 45;
			addChild(articlesButtonsContainer);
			
			for (var i:int = 0; i < xml.articles.children().length(); i++) { // добавляем кнопки в их контейнер (articlesButtonsContainer)
				// создаём кнопку. передаём ей номер цикла, соответсвующее имя и тип страницы (статья(article))
				// MenuButon берётся из нашего TheSite_lib.swc
				var articleButton:MenuButton = new MenuButton(i, xml.articles.children()[i].@name, PageType.ARTICLE_PAGE);
				if(i != 0)articleButton.x = articlesButtonsContainer.width + 10; // задаём координату на основе ширины контейнера
				articlesButtonsContainer.addChild(articleButton); // добавляем в контейнер
				articleButton.addEventListener(MouseEvent.CLICK, createPage); // вешаем слушатель клика
			}
			
			galeryButtonsContainer = new Sprite(); // контейнер для кнопок галерей. всё по аналогии со кнопками статей
			galeryButtonsContainer.y = 45;
			addChild(galeryButtonsContainer);
			
			for (var j:int = 0; j < xml.albums.children().length(); j++) {
				var albumButton:MenuButton = new MenuButton(j, xml.albums.children()[j].@name, PageType.ALBUM_PAGE);
				if (j != 0) albumButton.x = galeryButtonsContainer.width + 10;
				galeryButtonsContainer.addChild(albumButton);
				albumButton.addEventListener(MouseEvent.CLICK, createPage);
			}
			
			// чтобы при запуске сайта не было слишком пусто, добавляем на сцену первую галерею
			pageContainer.addChild(new AlbumPage(xml.albums.children()[0].children()));
			(galeryButtonsContainer.getChildAt(0) as MenuButton).activate(); // и активируем соответствующую ей кнопку
			
			resize(); // вызов функции resize сразу выровняет все объекты на сцене, как нужно.
			stage.addEventListener(Event.RESIZE, resize); // вешаем на сцену слушатель ресайза
		}
		/**
		 * @private создаём страницу.
		 * галерею или статью, в зависимости от нажатой кнопки
		 * 
		 * @param	e событие клика по кнопке
		 */
		private function createPage(e:MouseEvent):void {
			while (pageContainer.numChildren) pageContainer.removeChildAt(0); // на всякий случай удаляем всё из контейнера страниц
			if (e.currentTarget.pageType == PageType.ARTICLE_PAGE) { // если кликнули по кнопку статьи...
				// в конструктор передаём текст из соответствующего нода xml
				pageContainer.addChild(new ArticlePage(xml.articles.children()[e.currentTarget.number]));//... то добавляем в контейнер страницу статьи
			} else if (e.currentTarget.pageType == PageType.ALBUM_PAGE) { // аналогично с галереей
				// в конструктор передаём XMLList из соответствующего нода xml, состояший из нодов отдельных фотографий данной галереи
				pageContainer.addChild(new AlbumPage(xml.albums.children()[e.currentTarget.number].children()));
			}
			deactivateButtons(); // деактивируем все кнопки
			(e.currentTarget as MenuButton).activate(); // и активируем нажатую кнопку
		}
		/**
		 * @private сбрасываем активацию всех кнопок
		 * Тут всё просто. через цикл прогоняются все кнопки, если кнопка активирована, она деактивируется
		 */
		private function deactivateButtons():void {
			for (var i:int = 0; i < articlesButtonsContainer.numChildren; i++) {
				var tempArticleButton:MenuButton = articlesButtonsContainer.getChildAt(i) as MenuButton;
				if (tempArticleButton.activated) tempArticleButton.deactivate();
			}
			for (var j:int = 0; j < galeryButtonsContainer.numChildren; j++) {
				var tempAlbumButton:MenuButton = galeryButtonsContainer.getChildAt(j) as MenuButton;
				if (tempAlbumButton.activated) tempAlbumButton.deactivate();
			}
		}
		/**
		 * @private генератор случайных чисел в заданном диапазоне
		 * 
		 * @param	minNum минимальное значение
		 * @param	maxNum максимальное значение
		 * @return результат - случайное число
		 */
		private function random(minNum:Number, maxNum:Number):Number {
            return (Math.floor(Math.random() * (maxNum - minNum + 1)) + minNum);
        }
		/**
		 * @private функция делает так, чтобы переданный ей DisplayObject перекрывал сцену
		 * В нашем случае - это фон
		 * @param	scaledObject изображение или другой DisplayObject
		 */
		private function placeBackground(scaledObject:DisplayObject):void {
			scaledObject.scaleX = scaledObject.scaleY = 1;

			var scale:Number;

			if (scaledObject.width / scaledObject.height > stage.stageWidth / stage.stageHeight){
				scale = stage.stageHeight / scaledObject.height;
			} else {
				scale = stage.stageWidth / scaledObject.width;
			}
			
			scaledObject.scaleX = scaledObject.scaleY = scale;
			scaledObject.x = (stage.stageWidth - scaledObject.width) / 2;
			scaledObject.y = (stage.stageHeight - scaledObject.height) / 2;
		}
		/**
		 * Функция ресайза сцены. Выравнивает нужные объекты
		 * 
		 * @param	e событие ресайза сцены.
		 */
		private function resize(e:Event = null):void {
			placeBackground(background); // размещаем наш фон через специальную функцию
			copyright.x = (stage.stageWidth - copyright.width) / 2; // позиционируем тект копирайта...
			copyright.y = stage.stageHeight - copyright.height - 5;
			galeryButtonsContainer.x = stage.stageWidth - galeryButtonsContainer.width - 5; // ... и контейнер кнопок галерей
		}

	}
}