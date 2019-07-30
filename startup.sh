#!/bin/sh
sleep 4
echo "##################################"
echo "##### EXECUTANDO O MIGRATE  ######"
echo "##################################"
python /app/manage.py migrate

sleep 4
echo "#######################################"
echo "##### EXECUTANDO O COLLECTSTATIC ######"
echo "#######################################"
python /app/manage.py collectstatic --noinput

#sleep 4 
#echo "##################################"
#echo "##### CRIANDO USUARIO DJANGO #####"
#echo "##################################"
#script="
#from django.contrib.auth.models import User;
#username = 'admin';
#password = 'admin';
#email = 'admin@teste.com';
#if User.objects.filter(username=username).count()==0:
#    User.objects.create_superuser(username, email, password);
#    print('Admin criado!.');
#else:
#    print('Admin ja exite!');
#"
#printf "$script" | python celery_portal/manage.py shell

echo "##################################"
echo "##### INICIANDO O WSGI #####"
echo "##################################"
uwsgi --ini /app/wsgi.ini
