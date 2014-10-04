# Function for generating proper anonymize SQL statements.
#
# @author    Oktay Acikalin <oktay.acikalin@gmail.com>
# @copyright Oktay Acikalin
# @license   MIT (LICENSE.txt)

function magento.gen_anon_sql_statements () {
    # First gather all necessary vars. (The IFS= later on does not allow us to do inline requests.)
    local eav_customer_firstname_id=$(magento.get_eav_attribute_id customer firstname)
    local eav_customer_lastname_id=$(magento.get_eav_attribute_id customer lastname)
    local eav_customer_email_id=$(magento.get_eav_attribute_id customer email)
    local eav_customer_company_id=$(magento.get_eav_attribute_id customer company)
    local eav_customer_password_hash_id=$(magento.get_eav_attribute_id customer password_hash)
    local eav_customer_dob_id=$(magento.get_eav_attribute_id customer dob)
    local eav_customer_address_firstname_id=$(magento.get_eav_attribute_id customer_address firstname)
    local eav_customer_address_lastname_id=$(magento.get_eav_attribute_id customer_address lastname)
    local eav_customer_address_telephone_id=$(magento.get_eav_attribute_id customer_address telephone)
    local eav_customer_address_company_id=$(magento.get_eav_attribute_id customer_address company)
    local eav_customer_address_street_id=$(magento.get_eav_attribute_id customer_address street)
    # Now temporarily change rules and gather all statements.
    local IFS=
    statements=(
        "UPDATE admin_user SET email=CONCAT(REPLACE(email, '@', '+'),'@${BASE_DOMAIN}') WHERE email not like '%@${BASE_DOMAIN}';"
        "UPDATE admin_user SET password=md5('${MP_ANON_ADMIN_PASSWORD}');"

        "UPDATE customer_entity SET email=CONCAT('customer+',entity_id,'@${BASE_DOMAIN}');"
        "UPDATE customer_entity_varchar SET value=CONCAT('firstname_',entity_id) WHERE attribute_id=${eav_customer_firstname_id};"
        "UPDATE customer_entity_varchar SET value=CONCAT('lastname_',entity_id) WHERE attribute_id=${eav_customer_lastname_id};"
        "UPDATE customer_entity_varchar SET value=CONCAT('customer+',entity_id,'@${BASE_DOMAIN}') WHERE attribute_id=${eav_customer_email_id};"
        "UPDATE customer_entity_varchar SET value='Anon Inc.' WHERE attribute_id=${eav_customer_company_id};"
        "UPDATE customer_entity_varchar SET value=md5('${MP_ANON_CUSTOMER_PASSWORD}') WHERE attribute_id=${eav_customer_password_hash_id};"
        "UPDATE customer_entity_datetime SET value='1980-08-09 00:00:00' WHERE attribute_id=${eav_customer_dob_id};"

        "UPDATE customer_address_entity_varchar SET value=CONCAT('firstname_',entity_id) WHERE attribute_id=${eav_customer_address_firstname_id};"
        "UPDATE customer_address_entity_varchar SET value=CONCAT('lastname_',entity_id) WHERE attribute_id=${eav_customer_address_lastname_id};"
        "UPDATE customer_address_entity_varchar SET value='+49 511 87654321' WHERE attribute_id=${eav_customer_address_telephone_id};"
        "UPDATE customer_address_entity_varchar SET value='Anon Inc.' WHERE attribute_id=${eav_customer_address_company_id};"
        "UPDATE customer_address_entity_text SET value='Fakestreet' WHERE attribute_id=${eav_customer_address_telephone_id};"

        "UPDATE sales_flat_quote SET
            customer_email=CONCAT('customer+',entity_id,'@${BASE_DOMAIN}'),
            customer_firstname=CONCAT('firstname_',entity_id),
            customer_lastname=CONCAT('lastname_',entity_id),
            remote_ip='${MP_BASE_DOMAIN_IP}';"

        "UPDATE sales_flat_quote_address SET
            firstname=CONCAT('firstname_',address_id),
            lastname=CONCAT('lastname_',address_id),
            telephone='+49 511 87654321',
            fax='+49 511 87654321',
            street='Fakestreet';"

        "UPDATE sales_flat_order SET
            customer_email=CONCAT('customer+',entity_id,'@${BASE_DOMAIN}'),
            customer_firstname=CONCAT('firstname_',entity_id),
            customer_lastname=CONCAT('lastname_',entity_id),
            remote_ip='${MP_BASE_DOMAIN_IP}';"

        "UPDATE sales_flat_order_grid SET
            shipping_name=CONCAT('firstname_lastname_',customer_id),
            billing_name=CONCAT('firstname_lastname_',customer_id);"

        "UPDATE sales_flat_order_address SET
            firstname=CONCAT('firstname_',customer_id),
            lastname=CONCAT('lastname_',customer_id),
            telephone='+49 511 87654321',
            street='Fakestreet',
            email=CONCAT('customer+',customer_id,'@${BASE_DOMAIN}'),
            company='Anon Inc.';"

        "UPDATE sales_flat_shipment_grid SET shipping_name=CONCAT('firstname_lastname_',order_increment_id);"

        "UPDATE sales_flat_invoice_grid SET billing_name=CONCAT('firstname_lastname_',order_increment_id);"

        "UPDATE newsletter_subscriber SET subscriber_email=CONCAT('nl_subscriber+',subscriber_id,'@${BASE_DOMAIN}');"

        "UPDATE enterprise_invitation SET email=CONCAT('invitation_',customer_id,'@${BASE_DOMAIN}');"
    )
}
