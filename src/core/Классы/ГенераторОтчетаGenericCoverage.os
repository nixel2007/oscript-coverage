
// Выполняет формирование отчета
//
// Параметры:
//   ТаблицаСтатистикиПокрытия - ТаблицаЗначений - Прочитанные данные статистики OScript
//   ПутьКВыходномуФайлу - Строка - Путь к файлу отчета
//
Процедура Сформировать(Знач ТаблицаСтатистикиПокрытия, Знач ПутьКВыходномуФайлу) Экспорт

	ТаблицаСтатистикиПокрытия.Сортировать("ПутьКФайлу, ИмяМетода, СтрокаМодуля");

	ЗаписьXML = Новый ЗаписьXML;
	ЗаписьXML.ОткрытьФайл(ПутьКВыходномуФайлу);
	ЗаписьXML.ЗаписатьОбъявлениеXML();
	ЗаписьXML.ЗаписатьНачалоЭлемента("coverage");
	ЗаписьXML.ЗаписатьАтрибут("version", "1");

	ТекущийПутьКФайлу = "";

	Для Каждого СтрокаПокрытия Из ТаблицаСтатистикиПокрытия Цикл
		
		ПутьКФайлу = СтрокаПокрытия.ПутьКФайлу;

		Если Не ПутьКФайлу = ТекущийПутьКФайлу Тогда
			
			Если Не ПустаяСтрока(ТекущийПутьКФайлу) Тогда
				ЗаписьXML.ЗаписатьКонецЭлемента();
			КонецЕсли;

			ЗаписьXML.ЗаписатьНачалоЭлемента("file");
			ЗаписьXML.ЗаписатьАтрибут("path", ПутьКФайлу);
			ТекущийПутьКФайлу = ПутьКФайлу;
			
		КонецЕсли;
	
		ЗаписьXML.ЗаписатьНачалоЭлемента("lineToCover");
		
		ЗаписьXML.ЗаписатьАтрибут("lineNumber", СтрокаПокрытия.СтрокаМодуля);
		Покрыто = СтрокаПокрытия.КоличествоВызовов > 0;
		ЗаписьXML.ЗаписатьАтрибут("covered", Формат(Покрыто, "БИ=true; БЛ=false"));
		
		ЗаписьXML.ЗаписатьКонецЭлемента(); // lineToCover
		
	КонецЦикла;

	Если Не ПустаяСтрока(ТекущийПутьКФайлу) Тогда
		ЗаписьXML.ЗаписатьКонецЭлемента(); // file
	КонецЕсли;

	ЗаписьXML.ЗаписатьКонецЭлемента(); // coverage
	ЗаписьXML.Закрыть();
	
КонецПроцедуры