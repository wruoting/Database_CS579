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
    uuid_header = []
    card_name_header = []
    color_header = []
    loyalty_header = []
    mana_cost_header = []
    name_header = []
    original_text_header = []
    original_type_header = []
    power_header = []
    toughness_header = []

    # prices_header = []
    with open("insert_card_query.sql", 'wb') as file_2:
        for name in json_data:
            card_name_header.append(name)
            card_data = json_data[name]
            uuid_header.append(card_data['uuid']) if card_data.get('uuid') else uuid_header.append('')
            color_header.append(card_data['colors']) if card_data.get('colors') else color_header.append('')
            loyalty_header.append(card_data['loyalty']) if card_data.get('loyalty') else loyalty_header.append('')
            mana_cost_header.append(card_data['manaCost']) if card_data.get('manaCost') else mana_cost_header.append('')
            original_text_header.append(card_data['text']) if card_data.get('text') else original_text_header.append('')
            original_type_header.append(card_data['originalType']) if card_data.get('originalType') else original_type_header.append('')
            power_header.append(card_data['power']) if card_data.get('power') else power_header.append('')
            toughness_header.append(card_data['toughness']) if card_data.get('toughness') else toughness_header.append('')
            uuid = card_data['uuid'] if card_data.get('uuid') else ''
            colors = card_data['colors'] if card_data.get('colors') else ''
            loyalty = card_data['loyalty'] if card_data.get('loyalty') else ''
            manaCost = card_data['manaCost'] if card_data.get('manaCost') else ''
            text = card_data['text'] if card_data.get('text') else ''
            originalType = card_data['originalType'] if card_data.get('originalType') else ''
            power = card_data['power'] if card_data.get('power') else ''
            toughness = card_data['toughness'] if card_data.get('toughness') else ''
            str = "INSERT INTO CARDS (uuid, name, color, loyalty, mana_cost, text, type, power, toughness) VALUES ({},{},{},{},{},{},{},{},{});\n".format(uuid, name, colors, loyalty, manaCost, text, originalType, power, toughness)
            file_2.write(str.encode('utf-8'))
        data = {
            'name' : card_name_header,
            'uuid' : uuid_header,
            'color': color_header,
            'loyalty': loyalty_header,
            'mana_cost': mana_cost_header,
            'text': original_text_header,
            'type': original_type_header,
            'power': power_header,
            'toughness': toughness_header
        }

        
    s = pd.DataFrame(data)
    s.to_csv('Card_Table.csv', sep='\t', index=False, encoding='utf-8')
    