#!/bin/bash
# цветовые настройки для "echo -e"
#30 Чёрный	#31 Красный
#32 Зелёный	#33 Жёлтый
#34 Синий	#35 Фиолетовый
#36 Бирюзовый	#37 Белый
defaultcolor="\033[0m"
colorboldyellow="\e[1;33m"
colorboldred="\e[1;31m"
colorboldgreen="\e[1;32m"

echo " "
echo "-------------------------------------------------------------------"
echo "Примеры команд работы с подстроками"
mystring="one two three four five six seven eight nine ten eleven twelve"
echo -e "Переменная  mysring=$colorboldyellow$mystring $defaultcolor"
echo " "
echo "-------------------------------------------------------------------"
echo "-----------поиск позиции вхождения подстроки в строке--------------"
echo " "
mysubstring1="one"
mysubstring2="two"
mysubstring3="white"
mysubstring4="five"

echo "---ВАРИАНТ 1 - использование доп. функции, -1 если не найдено, но можно вернуть другое значение, см. код"
strindex() { x="${1%%"$2"*}"; [[ "$x" = "$1" ]] && echo -1 || echo "${#x}";} #функция
position=$(strindex "$mystring" "$mysubstring1")
echo "подстрока ($mysubstring1) найдена на позиции $position"
position=$(strindex "$mystring" "$mysubstring2")
echo "подстрока ($mysubstring2) найдена на позиции $position"
position=$(strindex "$mystring" "$mysubstring3")
echo "подстрока ($mysubstring3) найдена на позиции $position"
position=$(strindex "$mystring" "$mysubstring4")
echo "подстрока ($mysubstring4) найдена на позиции $position"
echo " "
echo "---ВАРИАНТ 2 - использование grep, пустое значение если не найдено!!!"
position=$(echo $mystring | grep -b -o $mysubstring1 | awk -F":" '{print $1}')
echo "подстрока ($mysubstring1) найдена на позиции ($position)"
position=$(echo $mystring | grep -b -o $mysubstring2 | awk -F":" '{print $1}')
echo "подстрока ($mysubstring2) найдена на позиции ($position)"
position=$(echo $mystring | grep -b -o $mysubstring3 | awk -F":" '{print $1}')
if [[ $position == "" ]]; then position=-1; fi
echo "подстрока ($mysubstring3) найдена на позиции ($position)"
position=$(echo $mystring | grep -b -o $mysubstring4 | awk -F":" '{print $1}')
echo "подстрока ($mysubstring4) найдена на позиции ($position)"

echo " "
echo "-------------------------------------------------------------------"
echo "проверка вхождения подстроки в строке------------------------------"
echo " "
if [[  $mystring == *$mysubstring1*  ]]; then
    echo -e "$mysubstring1 $colorboldgreenесть$defaultcolor в строке $colorboldyellow$mystring$defaultcolor"
else
    echo -e "$mysubstring1 $colorboldredне найдено$defaultcolor в строке $colorboldyellow$mystring$defaultcolor"
fi
if [[  $mystring == *$mysubstring3*  ]]; then
    echo -e "$mysubstring3 $colorboldgreenесть$defaultcolor в строке $colorboldyellow$mystring$defaultcolor"
else
    echo -e "$mysubstring3 $colorboldredне найдено$defaultcolor в строке $colorboldyellow$mystring$defaultcolor"
fi


