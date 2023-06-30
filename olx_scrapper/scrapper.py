from time import sleep
from db_connection import insert_place, insert_vehicle, insert_advertiser, insert_date, insert_fact_ads, insert_TPM_ETL, close_db_connection
from chrome_driver import get_driver, find_element_by_xpath, wait_element_load
driver = get_driver()

for page in range(1):
    driver.get(f'https://al.olx.com.br/autos-e-pecas/carros-vans-e-utilitarios?o={str(page + 1)}')
    wait_element_load('ad-list')

    for item in range(55):
        try:
            link_base_xpath = '//*[@id="ad-list"]/li[' + str(item + 1) + ']'
            product_link_xpath = f'{link_base_xpath}/div'
            product_link_element = find_element_by_xpath(xpath=product_link_xpath)

            product_link_element_class = product_link_element.get_attribute('class')
            pub_classes = ['yap-gemini-pub-item', 'listing-native-list-item-1-pub']
            if product_link_element_class in pub_classes:
                continue

            product_link_element.click()
            driver.switch_to.window(driver.window_handles[-1])

            wait_element_load('content')

            content_base_xpath = '//*[@id="content"]/div[2]/div/div[2]/div[1]/'
            brand = find_element_by_xpath(content_base_xpath + 'div[34]/div/div/div/div[4]/div[3]/div/div[2]/a').text.upper()
            model = find_element_by_xpath(content_base_xpath + 'div[34]/div/div/div/div[4]/div[2]/div/div[2]/a').text.upper()
            vehicle_year = find_element_by_xpath(content_base_xpath + 'div[34]/div/div/div/div[4]/div[5]/div/div[2]/a').text.upper()
            vehicle_power = 'unknown'            
            km = find_element_by_xpath(content_base_xpath + 'div[34]/div/div/div/div[4]/div[6]/div/div[2]/span[2]').text
            print(brand)
            print(model)
            print(vehicle_year)
            print(vehicle_power)
            print(km)
            
            publication_data = find_element_by_xpath(content_base_xpath + 'div[38]/div/div/div/span[1]').text.upper()
            print(publication_data)

            #wait_element_load('miniprofile')
            sleep(10)
            advertiser_name = find_element_by_xpath("//span[@class='sc-fBuWsC sc-kkwfeq fPNDcX sc-jQMNup hDdGUP sc-ifAKCX cmFKIN']").text
            if advertiser_name == '':
                advertiser_name = 'Não Informado'                
            print(advertiser_name)

            list_str_date = publication_data.split()
            hour = list_str_date[4]
            list_month_day = list_str_date[2].split('/')
            day = int(list_month_day[0])
            moth = int(list_month_day[1])

            driver.close()
            driver.switch_to.window(driver.window_handles[0])

            product_text_xpath = 'a/div/div[2]'
            product_text_element = find_element_by_xpath(
                xpath=product_text_xpath,
                base_element=product_link_element
            )

            row_arr = product_text_element.text.replace('\n', '|').split('|')

            for term in ['Online', 'ONLINE', 'de R$']:
                row_arr = [el for el in row_arr if term not in el]

            print(row_arr)
            
            if len(row_arr) < 8:
                title, _, transmission, fuel, price, where, when = row_arr
                advertiser_type = 'unknown'
            else:
                title, _, transmission, fuel, price, advertiser_type, where, when = row_arr

            

            if ',' in where:
                city, district = where.split(' - ')[0].split(', ')
            else:
                city, _ = where.split(' - ')
                district = 'unknown'

            _, amount = price.split(' ')

            for i in amount:
                amount = amount.replace('.','')
            print(city)
            print(district)
            print(moth)
            print(day)
            print(hour)
            print(amount)

            insert_TPM_ETL(brand, model, vehicle_year, km, advertiser_name, advertiser_type, city, district, moth, day, hour, amount)
        except Exception as e:
            if len(driver.window_handles) > 1:
                driver.close()
                driver.switch_to.window(driver.window_handles[0])

            print(e)
            continue

insert_place()
insert_vehicle()
insert_advertiser()
insert_date()
insert_fact_ads()

close_db_connection()
driver.quit()
