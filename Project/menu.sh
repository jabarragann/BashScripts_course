
#!/bin/bash
trap 'echo -e "\nLa funciÃ³n [Ctrl + C] estÃ¡ desactivada. Presione ENTER\n"' SIGINT ## Deshabilita CTRL+C
trap 'echo -e "\nLa funciÃ³n [Ctrl + Z] estÃ¡ desactivada. Presione ENTER\n"' SIGTSTP ## Deshabilita CTRL+Z
DIRECTORY="/export/home/conexion"
logs_path="$DIRECTORY/.logs_conexiones"
mysql_user="root"
mysql_pass="Proyecto"
DB="heimdall"
pass_aes="heimdall"
IP_Origen=`echo $SSH_CLIENT | awk '{print $1}'`
intentos=0

if [ ! -d "$logs_path" ]; then
mkdir $logs_path
fi

menu1 () {
PS3="Digite una opciÃ³n: "
tipos=`/usr/bin/mysql --defaults-file=<(printf "[client]\nuser = %s\npassword = %s" "$mysql_user" "$mysql_pass") $DB -e "select Nombre from tipos_plat
where idTipo_Plat in (select distinct idTipo_Plat from plataformas where idPlataforma in (select distinct idPlataforma from permisos where
idUsuario='$idUsuario' and Activo = true));" | awk 'NR>=2{print}'`
tipos="$tipos"$'\n'"Cambiar contraseÃ±a"
tipos="$tipos"$'\n'"Salir del programa"
count=0
unset tipo
while read line; do
  tipo[$count]="$line"
  count=$(( $count + 1 ))
done <<< "$tipos"
numero_tipos=`echo "$tipos" | wc -l`
salir_menu1="no"
while [ "$salir_menu1" = "no" ]; do
  clear
  echo -e "\nSeleccione el tipo al que pertenece la plataforma a la que desea ingresar o digite la Ãºltima opciÃ³n para salir: \n"
  select eleccion1 in "${tipo[@]}"; do
   if [ $REPLY -lt $numero_tipos ];then
    idTipo_Plat=`/usr/bin/mysql --defaults-file=<(printf "[client]\nuser = %s\npassword = %s" "$mysql_user" "$mysql_pass") $DB -e "select idTipo_Plat from
tipos_plat where Nombre='$eleccion1';" | awk NR==2'{print}'`
    menu2
    clear; break
   elif [ $REPLY -eq $numero_tipos ];then
    /usr/bin/mysql --defaults-file=<(printf "[client]\nuser = %s\npassword = %s" "$mysql_user" "$mysql_pass") $DB -e "update LOG_General set Conectado =
false where idLOG_General='$idLOG_General';"
    echo "`date +%F" "%T` - [INFO] [`echo $idLOG_General`]: El usuario $script_user cerrÃ³ el programa" >> $logs_path/log_general.log
    salir_menu1="yes";clear;break
   else
    clear;break
   fi
  done
done
}

menu2 () {
PS3="Digite una opciÃ³n: "
  plataformas=`/usr/bin/mysql --defaults-file=<(printf "[client]\nuser = %s\npassword = %s" "$mysql_user" "$mysql_pass") $DB -e "select Nombre from
plataformas where idTipo_Plat='$idTipo_Plat' and idPlataforma in (select distinct idPlataforma from permisos where idUsuario='$idUsuario' and Activo =
true) and Activo = true;" | awk 'NR>=2{print}'`
plataformas="$plataformas"$'\n'"Ir al menÃº anterior"
unset plataforma

while read line; do
  plataforma[$count]="$line"
  count=$(( $count + 1 ))
done <<< "$plataformas"
numero_salir2=`echo "$plataformas" | wc -l`
salir_menu2="no"
while [ "$salir_menu2" = "no" ]; do
  clear
  echo -e "\nDigite el nÃºmero de la plataforma a la que pertenece el servidor al cual desea ingresar o digite la Ãºltima opciÃ³n para ir al menÃº anterior:\n"
  select eleccion2 in "${plataforma[@]}"; do
   if [ $REPLY -lt $numero_salir2 ];then
    idPlataforma=`/usr/bin/mysql --defaults-file=<(printf "[client]\nuser = %s\npassword = %s" "$mysql_user" "$mysql_pass") $DB -e "select idPlataforma
from plataformas where Nombre='$eleccion2';" | awk NR==2'{print}'`
    menu3
    clear;break
   elif [ $REPLY -eq $numero_salir2 ];then
    salir_menu2="yes";clear;break
   else
    clear;break
   fi
  done
done
}

menu3 () {
PS3="Digite una opciÃ³n: "
servidores=`/usr/bin/mysql --defaults-file=<(printf "[client]\nuser = %s\npassword = %s" "$mysql_user" "$mysql_pass") $DB -e "select Hostname,
inet_ntoa(IP) from servidores where idPlataforma='$idPlataforma' and Activo = true order by Hostname;" | awk 'NR>=2{print}'`
servidores="$servidores"$'\n'"Ir al menÃº anterior"
unset servidor
while read line; do
  servidor[$count]="$line"
  count=$(( $count + 1 ))
done <<< "$servidores"
numero_salir3=`echo "$servidores" | wc -l`
salir_menu3="no"
while [ "$salir_menu3" = "no" ]; do
  clear
  echo -e "\nDigite el nÃºmero del servidor al cual desea ingresar o digite la Ãºltima opciÃ³n para ir al menÃº anterior:\n"
  select eleccion3 in "${servidor[@]}"; do
   if [ $REPLY -lt $numero_salir3 ];then
    IP_seleccionada=`echo $eleccion3 | awk '{print $2}'`
    idServidor=`/usr/bin/mysql --defaults-file=<(printf "[client]\nuser = %s\npassword = %s" "$mysql_user" "$mysql_pass") $DB -e "select idServidor from
servidores where IP=inet_aton('$IP_seleccionada');" | awk NR==2'{print}'`
    conectar
    clear;break
   elif [ $REPLY -eq $numero_salir3 ];then
    salir_menu3="yes";clear;break
   else
    clear;break
   fi
  done
done
}

conectar () {
Super_Usuario=`/usr/bin/mysql --defaults-file=<(printf "[client]\nuser = %s\npassword = %s" "$mysql_user" "$mysql_pass") $DB -e "select Super_Usuario from
permisos where idUsuario='$idUsuario' and idPlataforma='$idPlataforma';" | awk NR==2'{print}'`
if [ "$Super_Usuario" = "1" ]; then

  user=`/usr/bin/mysql --defaults-file=<(printf "[client]\nuser = %s\npassword = %s" "$mysql_user" "$mysql_pass") $DB -e "select User_SU from servidores
where idServidor='$idServidor';" | awk NR==2'{print}'`
  ipass=`/usr/bin/mysql --defaults-file=<(printf "[client]\nuser = %s\npassword = %s" "$mysql_user" "$mysql_pass") $DB -e "select
AES_DECRYPT(Password_SU,'$pass_aes') from servidores where idServidor='$idServidor';" | awk NR==2'{print}'`
else
  user=`/usr/bin/mysql --defaults-file=<(printf "[client]\nuser = %s\npassword = %s" "$mysql_user" "$mysql_pass") $DB -e "select User_NU from servidores
where idServidor='$idServidor';" | awk NR==2'{print}'`
  ipass=`/usr/bin/mysql --defaults-file=<(printf "[client]\nuser = %s\npassword = %s" "$mysql_user" "$mysql_pass") $DB -e "select
AES_DECRYPT(Password_NU,'$pass_aes') from servidores where idServidor='$idServidor';" | awk NR==2'{print}'`
fi
clear
/usr/bin/mysql --defaults-file=<(printf "[client]\nuser = %s\npassword = %s" "$mysql_user" "$mysql_pass") $DB -e "insert into LOG_Acceso_Srv
(idLOG_General, idServidor) values ('$idLOG_General','$idServidor');"
idLOG_Acceso_Srv=`/usr/bin/mysql --defaults-file=<(printf "[client]\nuser = %s\npassword = %s" "$mysql_user" "$mysql_pass") $DB -e "select
idLOG_Acceso_Srv from LOG_Acceso_Srv where idLOG_General='$idLOG_General' and idServidor='$idServidor' and Fecha_LogIn>=now() - interval 1 second;" | awk
NR==2'{print}'`
echo "`date +%F" "%T` - [INFO] [`echo $idLOG_General`]: El usuario $script_user iniciÃ³ sesiÃ³n en la IP $IP_seleccionada de la plataforma $eleccion2. El
log queda en $logs_path/$script_user/$idLOG_General-$idLOG_Acceso_Srv.log" >> $logs_path/log_general.log


$DIRECTORY/./conexion.exp $user $ipass $IP_seleccionada | tee -a -i $logs_path/$script_user/$idLOG_General-$idLOG_Acceso_Srv.log

/usr/bin/mysql --defaults-file=<(printf "[client]\nuser = %s\npassword = %s" "$mysql_user" "$mysql_pass") $DB -e "update LOG_Acceso_Srv set Conectado =
false where idLOG_Acceso_Srv='$idLOG_Acceso_Srv';"
echo "`date +%F" "%T` - [INFO] [`echo $idLOG_General`]: El usuario $script_user cerrÃ³ la sesiÃ³n $idLOG_General-$idLOG_Acceso_Srv" >>
$logs_path/log_general.log
}

log_general () {
if [ ! -d "$logs_path/$script_user" ]; then
mkdir $logs_path/$script_user
fi
/usr/bin/mysql --defaults-file=<(printf "[client]\nuser = %s\npassword = %s" "$mysql_user" "$mysql_pass") $DB -e "insert into LOG_General
(idUsuario,IP_Origen) values ('$idUsuario',inet_aton('$IP_Origen'));"
idLOG_General=`/usr/bin/mysql --defaults-file=<(printf "[client]\nuser = %s\npassword = %s" "$mysql_user" "$mysql_pass") $DB -e "select idLOG_General from
LOG_General where idUsuario='$idUsuario' and IP_Origen=inet_aton('$IP_Origen') and Fecha_LogIn>=now() - interval 1 second;" | awk NR==2'{print}'`
echo "`date +%F" "%T` - [INFO] [`echo $idLOG_General`]: El usuario $script_user abriÃ³ el programa desde la IP $IP_Origen" >> $logs_path/log_general.log
}

main () {
clear
echo -e "Bienvenido al programa de conexiones\n"
if [ -z "$1" ]; then
echo -e "\nPor favor ingrese su usuario a continuaciÃ³n \n"
read -p "Usuario: " script_user
else
script_user=$1
fi
idUsuario=`/usr/bin/mysql --defaults-file=<(printf "[client]\nuser = %s\npassword = %s" "$mysql_user" "$mysql_pass") $DB -e "select idUsuario from
usuarios where Username='$script_user';" | awk NR==2'{print}'`
Estado=`/usr/bin/mysql --defaults-file=<(printf "[client]\nuser = %s\npassword = %s" "$mysql_user" "$mysql_pass") $DB -e "select Estado from usuarios
where Username='$script_user';" | awk NR==2'{print}'`
if [ -z "$idUsuario" ]; then
echo -e "El usuario ingresado no existe\n"
echo "`date +%F" "%T` - [INFO]: Desde la IP $IP_Origen se intentÃ³ ingresar con el usuario $script_user el cual no existe" >> $logs_path/log_general.log
elif [ "$Estado" -eq 1 ]; then
password_guardado=`/usr/bin/mysql --defaults-file=<(printf "[client]\nuser = %s\npassword = %s" "$mysql_user" "$mysql_pass") $DB -e "select
AES_DECRYPT(Password,'$pass_aes') from usuarios where idUsuario='$idUsuario';" | awk NR==2'{print}'`
echo -e "\nUsted estÃ¡ intentando ingresar con el usuario $script_user. Por favor ingrese su contraseÃ±a a continuaciÃ³n\n"
read -s -p "Password: " password_ingresado
echo
if [ "$password_ingresado" = "$password_guardado" ]; then
  log_general
  menu1
else
  echo -e "\nContraseÃ±a incorrecta. Por favor vuelva a intentar\n\n"
  echo "`date +%F" "%T` - [INFO]: Password incorrecto usuario $script_user desde la IP $IP_Origen" >> $logs_path/log_general.log
        if [$intentos!=3]; then
        main $1
        intentos=intentos+1
        else
        intentos=0
        main $1
        kill -9 -1
        fi
fi
else
echo "El usuario $script_user se encuentra desactivado."
echo "`date +%F" "%T` - [WARN]: Desde la IP IP_Origen se intentÃ³ ingresar con el usuario $script_user el cual se encuentra desactivado" >>
$logs_path/log_general.log
fi
}

main $1
kill -9 -1


