FROM odoo:17.0
USER root
COPY ./custom_addons /mnt/extra-addons
COPY ./odoo.conf /etc/odoo/odoo.conf
USER odoo