# RegReport
Создание регламентного отчета на основе входных данных (excel файл)

# Внешняя обработка для создания в 1С:БП регламентного отчета "реестр для налоговых вычетов по акцизам на виноград" из входных данных (excel).

#ВСЕГДА:

    1. Необходимо заполнить соответствие возвращаемое функцией "ПравилаГруппировкиРазделаОтчета_Реестр". Где мы указываем с какой по какую колонку таблицы значений надо группировать (не индекс а имя заголовка колонки (которое является числом в формате строка) это нумерация колонок (просто не всегда нумерация начинается с 1).

ВНИМАНИЕ группировка для вывода РАЗЛИЧНЫХ (она ничего не ссумирует, используется в соответствии с задачей для вывода РАЗЛИЧНЫХ записей и формирования ступенек).

#Если работаем с таб. док.:

    1. На форме должен быть добавлен ТабДок (имя: "ИТ_ТД", видимость: Ложь)
    2. Заполняем Соответствие в функции "ОписаниеЗаголовкаДанныхВРазделеОтчета_Реестр", Ключ - это номер колонки в рег. отчете, Знч - пустая строка ("").
    3 Вызвать метод "ПрочитатьДанныеИзФайлаЭкселВТабДок" затем ДобавитьДанныеТабДокВРазделеОтчета_Реестр_НеСервере(ТабличныйДокумент, ОписаниеЗаголовкаДанныхВРазделеОтчета_Реестр) (см. в коде процедуру "ЗаполнитьВнешнимиДанными" и "ПолучитьТестовыйНаборДанных").

*Комментарий:

    Процедура "ЗаполнитьВнешнимиДанными" читает данные внешнего файла excel в (скрытый) на форма табличный документ (файл должен содержать заголовок данных в том же      порядки и иметь такие же знч что рег. отчет (на данный момент поддерживается нумерация колонок цифрой Строка(НомерКолонки), это значит что заголовок данных пронумеровон от 1 до N). С какой строки в файле начинается заголовок данных НЕ ВАЖНО главное что он есть, а функция ПолучитьИзТабДокНомерСтрокиСодержащегоЗаголовокДанных получит нужный индекс начала заголовка данных.

#Если у нас уже есть таб. знач.:

    1. Инициализируем правила группировки (постраения ступенчатой структуры в рег. отчете) _ПравилаГруппировки	= ПравилаГруппировкиРазделаОтчета_Реестр();
    2. Имея таблицу значений вызываем метод ДобавитьДанныеВРазделеОтчета_Реестр_НеСервере(_ТабЗначений, _ПравилаГруппировки);

*ВНИМАНИЕ: Колонки таблицы должны именоваться строго в формате "TableColumn" + НомерКолонки (в рег. отчете колонки пронумерованы 4,5,6,7,8 ,а тут "TableColumn4" ...)
Также таблица значений должна содержать колонки с уменем "GroupLevel" + Уровень и содержать склеенные значения с колонки А до N (см. ПравилаГруппировкиРазделаОтчета_Реестр)

#Комментарий:

    Данный рег. отчет имеет "ступенчатую" структуру по этому нам необходимо описать правило вывода данных:
    Сколько уровней ("ступеней") в каждой строке макета рег. отчета.
    С какой по какую колонку какой уровень ("ступенька")

Пример:

    "Портвейн", "ЗГУ", "2001", "0,75"
    "Портвейн", "ЗГУ", "2001", "0,80"
    "Портвейн", "ЗГУ", "2002", "0,80"
    "Портвейн", "ЗГУ", "2001", "0,75"
    По правилу: с 1 по 2 = Уровень0, с 3 по 3 = Уровень1, с 4 по 4 = Уровень2
    даст результат:
    Стр1 "Портвейн", "ЗГУ", "2001", "0,75"
                                    "0,80"
                            "2002", "0,80"
                     
*Как мы видим получены только различные записи и отчет содержит только одну строку (но три ступени)
Уровень0 одна запись, Уровень1 две записи, Уровень2 для одной записи Уровня3 - две записи, а для другой записи Уровня2 - одна запись!
*Правила группировки при этом ожидают таблизу с данными в колонках Уровень:
    
    Уровень0        Уровень1    Уровень2
    "ПортвейнЗГУ",  "2001",     "0,75"
    "ПортвейнЗГУ",  "2001",     "0,80"
    "ПортвейнЗГУ",  "2002",     "0,80"
    "ПортвейнЗГУ",  "2001",     "0,75"
    
что позволит свернуть таблицу и заполнить отчет в нужной структуре!
