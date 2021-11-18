#!/bin/bash
set -e

if psql -h test --username postgres -lqt | cut -d \| -f 1 | grep -qw simplcommerce; then
    echo "simplcommerce database existed"
else
    echo "create new database simplcommerce"
	psql -h test --username postgres -c "CREATE DATABASE simplcommerce WITH ENCODING 'UTF8'"
	psql -h test --username postgres -d simplcommerce -a -f /app/dbscript.sql
fi

cd /app && dotnet SimplCommerce.WebHost.dll 
