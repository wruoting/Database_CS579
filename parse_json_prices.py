import json
import numpy as np
import pandas as pd

# At some fucking point when I get tired of using that stuff below I'll grab this
def append_objects(keys, arrays):
    for array in arrays:
        array.append(array[keys]) if array.get(keys) else array.append('')
    return arrays

with open("AllCards.json", encoding='utf-8') as file:
    data = file.read()
    json_data = json.loads(data)
    with open("insert_price_query.sql", 'wb') as file_2:
        for name in json_data:
            card_data = json_data[name]
            uuid = str(card_data['uuid']).replace("'", '"') if card_data.get('uuid') else ''
            paper = card_data.get('prices')
            if paper is not None:
                if paper.get('paper') is not None:
                    paper_price = paper.get('paper')
                    for listing_date in paper_price:
                        price = paper_price[listing_date]
                        string = "INSERT INTO PRICE (uuid, price, listing_date) VALUES ('{}','{}',TO_DATE('{}', 'yyyy-mm-dd'));\n".format(uuid, price, listing_date)
                        file_2.write(string.encode('utf-8'))
