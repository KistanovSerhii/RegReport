
#Область ОписаниеВнешнейОбработки

Функция ПолучитьТаблицуКоманд()
	
	Команды = Новый ТаблицаЗначений;
	Команды.Колонки.Добавить("Представление", Новый ОписаниеТипов("Строка"));
	Команды.Колонки.Добавить("Идентификатор", Новый ОписаниеТипов("Строка"));
	Команды.Колонки.Добавить("Использование", Новый ОписаниеТипов("Строка"));
	Команды.Колонки.Добавить("ПоказыватьОповещение", Новый ОписаниеТипов("Булево"));
	Команды.Колонки.Добавить("Модификатор", Новый ОписаниеТипов("Строка"));
	
	Возврат Команды;
	
КонецФункции

Процедура ДобавитьКоманду(ТаблицаКоманд, Представление, Идентификатор, Использование, ПоказыватьОповещение = Ложь, Модификатор = "")
	
	НоваяКоманда = ТаблицаКоманд.Добавить();
	НоваяКоманда.Представление = Представление; 
	НоваяКоманда.Идентификатор = Идентификатор;
	НоваяКоманда.Использование = Использование;
	НоваяКоманда.ПоказыватьОповещение = ПоказыватьОповещение;
	НоваяКоманда.Модификатор = Модификатор;
	
КонецПроцедуры

Функция СведенияОВнешнейОбработке()  Экспорт
	
	ПараметрыРегистрации = Новый Структура;
	МассивНазначений = Новый Массив;
	ПараметрыРегистрации.Вставить("Вид", "ДополнительныйОтчет");
	ПараметрыРегистрации.Вставить("Назначение", МассивНазначений);
	ПараметрыРегистрации.Вставить("Наименование", "РегламентированныйОтчетРеестрАкцизыВычетыВиноград");
	ПараметрыРегистрации.Вставить("БезопасныйРежим", ЛОЖЬ);
	ПараметрыРегистрации.Вставить("Версия", "1.0.0"); 
	ПараметрыРегистрации.Вставить("Информация", "Декларация по акцизам на этиловый спирт, алкогольную и (или) подакцизную спиртосодержащую продукцию"); 
	ТаблицаКоманд = ПолучитьТаблицуКоманд();
	ДобавитьКоманду(ТаблицаКоманд, "Декларация по акцизам на этиловый спирт, алкогольную и (или) подакцизную спиртосодержащую продукцию",
	"РегламентированныйОтчетРеестрАкцизыВычетыВиноград",
	"ОткрытиеФормы",
	Истина,
	"");
	ПараметрыРегистрации.Вставить("Команды", ТаблицаКоманд);

	Возврат ПараметрыРегистрации;
	
КонецФункции

#КонецОбласти