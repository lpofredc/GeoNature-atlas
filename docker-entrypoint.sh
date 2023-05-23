if [ ! -f ./atlas/configuration/settings.ini ]; then
    cp ./atlas/configuration/settings.ini.sample ./atlas/configuration/settings.ini
fi

. atlas/configuration/settings.ini

echo "Creating configuration files if they dont already exist"
if [ ! -f ./atlas/configuration/config.py ]; then
    cp ./atlas/configuration/config.py.sample ./atlas/configuration/config.py
fi

sudo sed -i "s/database_connection = .*$/database_connection = \"postgresql:\/\/$user_pg:$user_pg_pass@$db_host:$db_port\/$db_name\"/" ./atlas/configuration/config.py
sed -i "s/GUNICORN_PORT = .*$/GUNICORN_PORT = '${gun_port}'/g" ./atlas/configuration/config.py


echo "Creating custom images folder if it doesnt already exist"
if [ ! -d ./atlas/static/custom/images/ ]; then
  mkdir -p ./atlas/static/custom/images/
fi



echo "Creating customisation files if they dont already exist"
if [ ! -f ./atlas/static/custom/templates/footer.html ]; then
  cp ./atlas/static/custom/templates/footer.html.sample ./atlas/static/custom/templates/footer.html
fi
if [ ! -f ./atlas/static/custom/templates/introduction.html ]; then
  cp ./atlas/static/custom/templates/introduction.html.sample ./atlas/static/custom/templates/introduction.html
fi
if [ ! -f ./atlas/static/custom/templates/presentation.html ]; then
  cp ./atlas/static/custom/templates/presentation.html.sample ./atlas/static/custom/templates/presentation.html
fi
if [ ! -f ./atlas/static/custom/templates/credits.html ]; then
  cp ./atlas/static/custom/templates/credits.html.sample ./atlas/static/custom/templates/credits.html
fi
if [ ! -f ./atlas/static/custom/templates/mentions-legales.html ]; then
  cp ./atlas/static/custom/templates/mentions-legales.html.sample ./atlas/static/custom/templates/mentions-legales.html
fi
if [ ! -f ./atlas/static/custom/templates/bandeaulogoshome.html ]; then
  cp ./atlas/static/custom/templates/bandeaulogoshome.html.sample ./atlas/static/custom/templates/bandeaulogoshome.html
fi
if [ ! -f ./atlas/static/custom/templates/robots.txt ]; then
  cp ./atlas/static/custom/templates/robots.txt.sample  ./atlas/static/custom/templates/robots.txt 
fi

if [ ! -f ./atlas/static/custom/custom.css ]; then
  cp ./atlas/static/custom/custom.css.sample ./atlas/static/custom/custom.css
fi
if [ ! -f ./atlas/static/custom/glossaire.json ]; then
  cp ./atlas/static/custom/glossaire.json.sample ./atlas/static/custom/glossaire.json
fi
if [ ! -f ./atlas/static/custom/images/favicon.ico ]; then
  cp ./atlas/static/images/sample.favicon.ico ./atlas/static/custom/images/favicon.ico
fi
if [ ! -f ./atlas/static/custom/images/accueil-intro.jpg ]; then
  cp ./atlas/static/images/sample.accueil-intro.jpg ./atlas/static/custom/images/accueil-intro.jpg
fi
if [ ! -f ./atlas/static/custom/images/logo-structure.png ]; then
  cp ./atlas/static/images/sample.logo-structure.png ./atlas/static/custom/images/logo-structure.png
fi
if [ ! -f ./atlas/static/custom/images/logo_patrimonial.png ]; then
  cp ./atlas/static/images/sample.logo_patrimonial.png ./atlas/static/custom/images/logo_patrimonial.png
fi
if [ ! -f ./atlas/static/custom/maps-custom.js ]; then
  cp ./atlas/static/custom/maps-custom.js.sample ./atlas/static/custom/maps-custom.js
fi

FLASKDIR=$(readlink -e "${0%/*}")

. "$FLASKDIR"/atlas/configuration/settings.ini

echo "Starting $app_name"
echo "$FLASKDIR"

export PYTHONPATH=$FLASKDIR:$PYTHONPATH

cp .flaskenv.sample .flaskenv
echo "FLASK_RUN_HOST=0.0.0.0" >> .flaskenv

# Start your unicorn
flask run
